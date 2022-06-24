#!/bin/bash
# (c) 2020 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.

region=$1
accountID=$2
repositoryName=$3
repositoryTag=$4

# delete the ECR repository, forcing the deletion (any images in the repository will be deleted!!)

aws ecr delete-repository --repository-name "$repositoryName" \
    --force
