#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

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

# delete the ECR repository, forcing the deletion (any images in the repository will be deleted!!)

aws ecr delete-repository --repository-name "$repositoryName" \
    --force
