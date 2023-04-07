#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

function usage {
    echo "Usage: $1 <repositoryName>"
}

command=$0
repositoryName=$1

# check input parameters
if [[ -z "$repositoryName" ]]; then
    usage "$command"
    exit 1
fi

# configure the ECR repository to be used

aws ecr create-repository --repository-name "$repositoryName" \
    --image-scanning-configuration scanOnPush=true \
    --encryption-configuration encryptionType=AES256

#  Note - the output (JSON) from this command is displayed on stdout
