#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

function usage {
    echo "Usage: $1 <repositoryName> <repositoryTag>"
}

command=$0
repositoryName=$1
repositoryTag=$2

# check input parameters
if [[ -z "$repositoryName" || -z "$repositoryTag" ]]; then
    usage "$command"
    exit 1
fi

# Use the repository name to get the imageTag and imageDigest values

imagesList=$(aws ecr describe-images --repository-name "$repositoryName")

# parse out the imageTag and imageDigest value(s)

imageTag=$repositoryTag
imageDigest=$(echo "$imagesList" | jq ".imageDetails[] | select(.imageTags[0]==\"$imageTag\") | .imageDigest")

echo "Scan summary:"
echo "$imagesList" | jq ".imageDetails[] \
                        | select(.imageTags[0]==\"$imageTag\") \
                        | { repositoryName, imageScanStatus, summary: .imageScanFindingsSummary }"

# Use query the scan findings using the CLI, supplying the imageTag and image Digest values

findings=$(aws ecr describe-image-scan-findings --repository-name "$repositoryName" \
            --image-id imageTag="$imageTag",imageDigest="$imageDigest" \
            | jq '.imageScanFindings.findings')

echo -e "\nScan findings (CSV format):"
echo "cve-name,severity,pkg-name,pkg-version"
echo "$findings" | jq ".[] | { name, \
                                              severity, \
                                              pkgname: (.attributes[] | select(.key==\"package_name\") | .value ), \
                                              pkgver: (.attributes[] | select(.key==\"package_version\") | .value ) } \
                                          | join(\",\")" \
                 | sed -e 's/"//g'
