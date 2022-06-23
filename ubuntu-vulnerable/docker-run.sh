#!/bin/sh

repositoryName=$1
repositoryTag=$2

# run the image in a container running on the local system

docker run --rm -it "$repositoryName":"$repositoryTag"
