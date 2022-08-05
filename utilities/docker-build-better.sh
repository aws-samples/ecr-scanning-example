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

# find the directory where the script was run and then change directory to the directory
# where the Dockerfile is found.  This is done because the Dockerfile references
# a sub-folder to copy a file into the working directory of the docker image.

sourceDir=$(dirname "$0")
dockerfileDir="$sourceDir/../ubuntu-vulnerable"

if ! cd "$dockerfileDir" ; then
    echo "unable to change to $dockerfileDir, check configuration"
    exit 1
fi

# build the image using the name and tag provided with the Dockerfile in the current folder

docker build -t "$repositoryName":"$repositoryTag" -f "$dockerfileDir"/better.Dockerfile .
