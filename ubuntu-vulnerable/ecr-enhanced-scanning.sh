#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

function usage {
    echo "Usage: $1 <repositoryName>"
}

command=$0
# region=$1
# accountID=$2
repositoryName=$1
# repositoryTag=$4

# check input parameters
if [[ -z "$repositoryName" ]]; then
    usage "$command"
    exit 1
fi

aws ecr put-registry-scanning-configuration \
    --scan-type ENHANCED \
    --rules '[{"scanFrequency": "SCAN_ON_PUSH","repositoryFilters": [{"filter": "'$repositoryName'*","filterType": "WILDCARD"}]},{"scanFrequency": "CONTINUOUS_SCAN","repositoryFilters": [{"filter": "'$repositoryName'*","filterType": "WILDCARD"}]}]'
