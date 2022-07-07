#!/bin/bash
# (c) 2022 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.

function usage {
    echo "Usage: $1 <region> <accountID> <repositoryName>"
}

command=$0
region=$1
accountID=$2
repositoryName=$3
# repositoryTag=$4

# check input parameters
if [[ -z "$region" || -z "$accountID" || -z "$repositoryName" ]]; then
    usage "$command"
    exit 1
fi

# first, get docker logged into ECR

aws ecr get-login-password --region "$region" \
    | docker login --username AWS --password-stdin "$accountID".dkr.ecr."$region".amazonaws.com

# second, configure the ECR repository to be used

aws ecr create-repository --repository-name "$repositoryName" \
    --image-scanning-configuration scanOnPush=true \
    --encryption-configuration encryptionType=AES256

#  Note - the output (JSON) from this command is displayed on stdout
