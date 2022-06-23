#!/bin/sh

repositoryName=$1
repositoryTag=$2

# build the image using the name and tag provided with the Dockerfile in the current folder

docker build -t "$repositoryName":"$repositoryTag" .
