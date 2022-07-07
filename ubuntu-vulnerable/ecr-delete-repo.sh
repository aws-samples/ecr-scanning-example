#!/bin/bash
# (c) 2022 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.

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
