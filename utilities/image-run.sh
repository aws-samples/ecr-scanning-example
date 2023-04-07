#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

function usage {
    echo "Usage: $1 <repositoryName> <repositoryTag>"
}

command=$0
repositoryName=$1
repositoryTag=$2

# check input parameters
if [[ -z "$repositoryName" || -z "$repositoryTag" ]]; then
    usage "$command"
    exit 1
fi

#
# if finch is found as a command, use it.
# if nerdctl is found as a command, use it.
# if docker is found as a command, use it.
# if none are found, fail the script
#

containerCommand=''
if [ "$(which finch)" != 'finch not found' ]; then
        containerCommand='finch'
elif [ "$(which nerdctl)" != 'nerdctl not found' ]; then
        containerCommand='nerdctl'
elif [ "$(which docker)" != 'docker not found' ]; then
        containerCommand='docker'
else
        containerCommand=''
fi

if [ "${containerCommand}" == '' ]; then
        echo "no container commands (finch, nerdctl, docker) found - exiting"
        exit 255
fi

# run the image in a container running on the local system

"${containerCommand}" run --rm -it "$repositoryName":"$repositoryTag"
