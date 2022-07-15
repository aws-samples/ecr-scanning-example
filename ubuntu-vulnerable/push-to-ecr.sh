#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

function usage {
    echo "Usage: $1 <region> <accountID> <repositoryName> <repositoryTag>"
}

command=$0
region=$1
accountID=$2
repositoryName=$3
repositoryTag=$4

# check input parameters
if [[ -z "$region" || -z "$accountID" || -z "$repositoryName" || -z "$repositoryTag" ]]; then
    usage "$command"
    exit 1
fi

# now tag the existing (local) image

docker tag "$repositoryName":"$repositoryTag" "$accountID".dkr.ecr."$region".amazonaws.com/"$repositoryName":"$repositoryTag"

# now push the docker image

docker push  "$accountID".dkr.ecr."$region".amazonaws.com/"$repositoryName":"$repositoryTag"

#  Note - the output (JSON) from this command is displayed on stdout
