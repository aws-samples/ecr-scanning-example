#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

function usage {
    echo "Usage: $1"
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

# check input parameters
if [[ -z "$region" || -z "$accountID" ]]; then
    usage "$command"
    exit 1
fi

# get docker logged into ECR

aws ecr get-login-password --region "$region" \
    | docker login --username AWS --password-stdin "$accountID".dkr.ecr."$region".amazonaws.com
