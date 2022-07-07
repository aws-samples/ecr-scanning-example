#!/bin/bash
# (c) 2022 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.

region=$1
accountID=$2
repositoryName=$3
repositoryTag=$4

# get docker logged into ECR

aws ecr get-login-password --region "$region" \
    | docker login --username AWS --password-stdin "$accountID".dkr.ecr."$region".amazonaws.com
