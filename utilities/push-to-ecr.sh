#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

function usage {
    echo "Usage: $1 <repositoryName> <repositoryTag>"
}

function getAWSInfo {
    if ! aws sts get-caller-identity >/dev/null 2>&1; then
        echo "You must be logged into AWS in order to use the AWS CLI and this utility program."
        exit 1
    else
        accountID=$(aws sts get-caller-identity | jq .Account | sed -e 's/"//g')
        region=$(aws configure get region)
    fi
}

getAWSInfo

command=$0
repositoryName=$1
repositoryTag=$2

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
