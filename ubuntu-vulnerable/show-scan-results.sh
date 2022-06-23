#!/bin/bash

region=$1
accountID=$2
repositoryName=$3
repositoryTag=$4

# Use the repository name to get the imageTag and imageDigest values

aws ecr describe-images --repository-name "$repositoryName" >tmpfile

# parse out the imageTag and imageDigest value(s)

imageTag=$repositoryTag
imageDigest=$(cat tmpfile | jq ".imageDetails[] | select(.imageTags[0]==\"$imageTag\") | .imageDigest")

echo "Scan summary:"
cat tmpfile | jq ".imageDetails[] \
                    | select(.imageTags[0]==\"$imageTag\") \
                    | { repositoryName, imageScanStatus, summary: .imageScanFindingsSummary }"

# cat tmpfile | jq '.imageDetails[0] | { repositoryName, imageScanStatus, summary: .imageScanFindingsSummary }'

rm tmpfile

# Use query the scan findings using the CLI, supplying the imageTag and image Digest values

aws ecr describe-image-scan-findings --repository-name "$repositoryName" \
    --image-id imageTag="$imageTag",imageDigest="$imageDigest" \
    | jq '.imageScanFindings.findings' >findings.json

echo -e "\nScan findings:"
cat findings.json | jq ".[] | { name, \
                                severity, \
                                pkgname: (.attributes[] | select(.key==\"package_name\") | .value ), \
                                pkgver: (.attributes[] | select(.key==\"package_version\") | .value ) } \
                            | join(\" \")"

rm findings.json
