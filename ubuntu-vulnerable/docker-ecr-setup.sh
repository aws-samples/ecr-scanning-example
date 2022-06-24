#!/bin/bash
# (c) 2020 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.

region=$1
accountID=$2
repositoryName=$3
repositoryTag=$4

# first, get docker logged into ECR

aws ecr get-login-password --region "$region" \
    | docker login --username AWS --password-stdin "$accountID".dkr.ecr."$region".amazonaws.com

# second, configure the ECR repository to be used

aws ecr create-repository --repository-name "$repositoryName" \
    --image-scanning-configuration scanOnPush=true \
    --encryption-configuration encryptionType=AES256

#  Note - the output (JSON) from this command is displayed on stdout
