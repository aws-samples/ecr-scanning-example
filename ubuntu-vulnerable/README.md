# Description of files in this folder

## Introduction

The files in this folder are used to build two docker different docker images in order to
show how to use the docker image scanning capabilities of the
AWS Elastic Container Registry (ECR).  The docker images created include vulnerabilities
in order to who how the image scanner identifies these vulnerabilities.

**NOTE: These docker images should not be used for any other purpose than to have them scanned by AWS ECR.**

## Dependencies

The Dockerfile files have no dependencies.

## Dockerfile descriptions

The following shell scripts are provided, in the rough order in which the are expected to be invoked.

- `bad.Dockerfile`

    This Dockerfile will build a docker image based on an Ubuntu 18.04 operating system and add in
    a Java package with known vulnerabilities.

- `better.Dockerfile`

    This Dockerfile will build a docker image based on an Ubuntu 18.04 operating system and add in
    a Java package with known vulnerabilities.

    There is one added step in the Dockerfile which updates the installed packages during the build of the
    docker image.  This reduces, but does not eliminate all, the vulnerabilities in the image.

## Summary

The files in this folder are used to build two docker different docker images in order to
show how to use the docker image scanning capabilities of the
AWS Elastic Container Registry (ECR).

Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: MIT-0
