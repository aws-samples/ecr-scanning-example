#!/bin/bash
# (c) 2022 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.

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

# build the image using the name and tag provided with the Dockerfile in the current folder

docker build -t "$repositoryName":"$repositoryTag" -f ./bad.Dockerfile .
