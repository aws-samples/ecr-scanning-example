#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

function usage {
    echo "Usage: $1 <region> <accountID>"
}

command=$0
region=$1
accountID=$2
# repositoryName=$3
# repositoryTag=$4

# check input parameters
if [[ -z "$region" || -z "$accountID" ]]; then
    usage "$command"
    exit 1
fi

# get docker logged into ECR

aws ecr get-login-password --region "$region" \
    | docker login --username AWS --password-stdin "$accountID".dkr.ecr."$region".amazonaws.com
