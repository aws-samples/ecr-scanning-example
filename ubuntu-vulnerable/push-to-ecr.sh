#!/bin/bash

region=$1
accountID=$2
repositoryName=$3
repositoryTag=$4

# now tag the existing (local) image

docker tag "$repositoryName":"$repositoryTag" "$accountID".dkr.ecr."$region".amazonaws.com/"$repositoryName":"$repositoryTag"

# now push the docker image

docker push  "$accountID".dkr.ecr."$region".amazonaws.com/"$repositoryName":"$repositoryTag"

#  Note - the output (JSON) from this command is displayed on stdout
