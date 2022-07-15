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

# build the image using the name and tag provided with the Dockerfile in the current folder

docker build -t "$repositoryName":"$repositoryTag" -f ./bad.Dockerfile .
