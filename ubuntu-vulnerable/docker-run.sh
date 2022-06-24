#!/bin/sh
# (c) 2020 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.

repositoryName=$1
repositoryTag=$2

# run the image in a container running on the local system

docker run --rm -it "$repositoryName":"$repositoryTag"
