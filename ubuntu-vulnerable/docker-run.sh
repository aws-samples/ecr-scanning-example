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

# run the image in a container running on the local system

docker run --rm -it "$repositoryName":"$repositoryTag"
