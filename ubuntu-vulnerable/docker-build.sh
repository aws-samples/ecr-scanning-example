#!/bin/sh
# (c) 2020 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.

repositoryName=$1
repositoryTag=$2

# build the image using the name and tag provided with the Dockerfile in the current folder

docker build -t "$repositoryName":"$repositoryTag" .
