#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

function usage {
    echo "Usage: $1 <repositoryName> <repositoryTag>"
}

command=$0
# region=$1
# accountID=$2
repositoryName=$1
repositoryTag=$2

# check input parameters
if [[ -z "$repositoryName" || -z "$repositoryTag" ]]; then
    usage "$command"
    exit 1
fi

# Use the repository name to get the imageTag and imageDigest values

imageList=$(aws ecr describe-images --repository-name "$repositoryName")

# parse out the imageTag and imageDigest value(s)

imageTag=$repositoryTag
imageDigest=$(echo "$imageList" | jq ".imageDetails[] | select(.imageTags[0]==\"$imageTag\") | .imageDigest")

# Use query the scan findings using the CLI, supplying the imageTag and image Digest values

findings=$( aws ecr describe-image-scan-findings --repository-name "$repositoryName" \
    --image-id imageTag="$imageTag",imageDigest="$imageDigest" \
    | jq '.imageScanFindings' )

#
# The output from describe-image-scan-findings is quite different between BASIC and ENHANCED
# scanning.  The parsing done below approximates similar output from BASIC scanning results
# that are displayed using the show-scan-results.sh script.
#
# Notably, the imageScanStatus field/structure is not provided in describe-images output nor
# the describe-image-scan-findings output
#

echo "Scan summary:"
echo "$findings" | jq "{ repositoryName: \"$repositoryName\", \
                          summary: { imageScanCompletedAt, \
                                     vulnerabilitySourceUpdatedAt,
                                     findingSeverityCounts } }"

echo -e "\nScan findings (CSV format):"
echo "cve-name,severity,pkg-name,type"
echo "$findings" | jq ".enhancedFindings[] \
                       | { title, \
                           severity, \
                           \"package\": .title, \
                           type } \
                       | walk( if type==\"object\" and has(\"title\") then .title |= sub(\"(?<first>^[^ ]*) - .*$\";.first) else . end) \
                       | walk( if type==\"object\" and has(\"package\") then .package |= sub(\"^.* - (?<second>.*$)\";.second) else . end) \
                       | walk( if type==\"object\" and has(\"package\") then .package |= sub(\",\";\";\") else . end) \
                       | join(\",\")" \
                 | sed -e 's/"//g'
