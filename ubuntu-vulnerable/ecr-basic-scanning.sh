#!/bin/bash
# (c) 2022 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.

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
    --scan-type BASIC \
    --rules 'scanFrequency=SCAN_ON_PUSH,repositoryFilters=[{filter='$repositoryName'*,filterType=WILDCARD}]'
