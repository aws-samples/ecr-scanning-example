# Description of scripts in this folder

## Introduction

The scripts in this folder are used to ease working with the AWS CLI commands that interact with the
AWS Elastic Container Registry (ECR).  Many of these commands take multiple parameters or need to have
values substituted into multiple locations in the parameter lists when invoking the commands.

The shell scripts are meant to ease that burden and also provide instructions/examples on how to use
the AWS CLI commands for working with ECR.

## Dependencies

The shell scripts use `bash` language constructs.

The shell scripts depend on both the AWS CLI (`aws` command) and the `jq` command.

Installation instructions vary for how to install and configure these commands in the runtime environment
being used.

All AWS CLI commands are performed using the active AWS credentials in place on the system where the
commands are being run.  The shell scripts expect credentials to already be established.  The scripts
will fail if AWS credentials are not available.

The AWS CLI commands will also fail of the active user/role does not have appropriate permissions
to access or update information in the AWS ECR for the AWS account being used.

## Shell script descriptions

The following shell scripts are provided, in the rough order in which the are expected to be invoked.

- `docker-build-bad.sh`

    This script uses the `docker build` command to build a Docker image using the `bad.Dockerfile` Dockerfile.
    The resulting image is known to contain vulnerabilities!! This is done to show how the AWS ECR scans and finds
    vulnerabilities in Docker images that are pushed to ECR.

    usage: `docker-build-bad.sh <repositoryName> <repositoryTag>`

    Example invocation:

        docker-build.sh ub-vuln badImage

- `docker-build-better.sh`

    This script uses the `docker build` command to build a Docker image using the `better.Dockerfile` Dockerfile.
    The resulting image is known to contain vulnerabilities!! This is done to show how the AWS ECR scans and finds
    vulnerabilities in Docker images that are pushed to ECR.

    usage: `docker-build-better.sh <repositoryName> <repositoryTag>`

    Example invocation:

        docker-build.sh ub-vuln betterImage

- `docker-run.sh`

    This script uses the `docker run` command to run a Docker image that is expected to exist in the local
    image repository.  The Docker images built with the scripts above are configured to enter an interactive
    `bash` shell when started so the `docker-run.sh` script uses the `-it` and `--rm` options for `docker run`
    when starting the Docker container.

    To exit the running container type `exit` at the command prompt to exit the `bash` shell running in the
    container.  This will result in the container being stopped and removed.

    usage: `docker-run.sh <repositoryName> <repositoryTag>`

    Example invocation:

        docker-run.sh ub-vuln betterImage

- `docker-ecr-setup.sh`

    This script uses the `docker login` command to enable the local Docker environment to access the
    AWS ECR.  To do this, the script uses the `aws ecr get-login-password` command.

    The script also uses the `aws ecr create-repository` command to create/initialize a Docker container
    repository into which Docker images can be pushed or from which the images can be pulled.

    usage: `docker-ecr-setup.sh <region> <accountID> <repositoryName>`

    Example invocation (replace NNNNNNNNNNNN with the appropriate AWS AccountId):

        docker-ecr-setup.sh us-east-1 NNNNNNNNNNNN ub-vuln

- `push-to-ecr.sh`

    This script uses the `docker tag` and `docker push` commands to mark and then push a docker image in the local
    registry to the specified AWS ECR repository.

    The script presumes/expects that a Docker image exists in the local registry that has tag (full name)
    `repositoryName:repositoryTag`.

    usage: `push-to-ecr.sh <region> <accountID> <repositoryName> <repositoryTag>`

    Example invocation (replace NNNNNNNNNNNN with the appropriate AWS AccountId):

        push-to-ecr.sh us-east-1 NNNNNNNNNNNN ub-vuln badImage

- `show-scan-results.sh`

    This script uses the `aws ecr describe-images` and `aws ecr describe-image-scan-findings` commands
    to find, parse, and display selected information from the result of AWS ECR **Basic** image scanning
    having been performed on the specified image.

    The script uses the `jq` command to parse the JSON formatted output from the `aws ecr` commands.

    The script presumes/expects that a Docker image exists in the AWS ECR repository that has tag (full name)
    `repositoryName:repositoryTag`.

    **NOTE**: The script also creates (and then deletes) two temporary files which are placed in the current working
    directory where the script is run. The names of these files are `tmpfile` and `findings.json`.

    usage: `show-scan-results.sh <repositoryName> <repositoryTag>`

    Example invocation:

        show-scan-results.sh ub-vuln badImage

- `ecr-enhanced-scanning.sh`

    This script uses the `aws ecr put-registry-scanning-configuration` command
    to set up the repository for **Enhanced** image scanning.

    **NOTE**: **Enhanced** image scanning incurs additional charges for each scan performed.

    **WARNING**: This script may remove other registry scanning configuration that is set up for
    repositories in the registry!!  Do not use this command if there is other registry scanning
    configuration settings already in place!

    usage: `ecr-enhanced-scanning.sh <repositoryName>`

    Example invocation:

        ecr-enhanced-scanning.sh ub-vuln

- `show-enhanced-scan-results.sh`

    This script uses the `aws ecr describe-images` and `aws ecr describe-image-scan-findings` commands
    to find, parse, and display selected information from the result of AWS ECR **Enhanced** image scanning
    having been performed on the specified image.

    The script uses the `jq` command to parse the JSON formatted output from the `aws ecr` commands.

    The script presumes/expects that a Docker image exists in the AWS ECR repository that has tag (full name)
    `repositoryName:repositoryTag`.

    Because the output formats of the image scan findings differ between **Basic** and **Enhanced** scanning
    the information provided by the two scripts (`show-scan-results.sh` and `show-enhanced-scan-results.sh`)
    is slightly different.

    **NOTE**: The script also creates (and then deletes) two temporary files which are placed in the current working
    directory where the script is run. The names of these files are `tmpfile` and `findings.json`.

    usage: `show-scan-results.sh <repositoryName> <repositoryTag>`

    Example invocation:

        show-enhanced-scan-results.sh ub-vuln badImage

- `ecr-basic-scanning.sh`

    This script uses the `aws ecr put-registry-scanning-configuration` command
    to set up the repository for **Basic** image scanning.

    **Basic** image scanning is provided as an included feature in AWS ECR.

    **WARNING**: This script may remove other registry scanning configuration that is set up for
    repositories in the registry!!  Do not use this command if there is other registry scanning
    configuration settings already in place!

    usage: `ecr-basic-scanning.sh <repositoryName>`

    Example invocation:

        ecr-basic-scanning.sh ub-vuln

- `ecr-delete-repo.sh`

    This script uses the `aws ecr delete-repository` command
    to delete the AWS ECR repository that is specified.

    **WARNING**: This is a destructive operation and will delete any/all docker images that
    exist in the repository in AWS ECR!

    usage: `ecr-delete-repo.sh <repositoryName>`

    Example invocation:

        ecr-delete-repo.sh ub-vuln

- `docker-ecr-login.sh`

    This script uses the `docker login` command to enable the local Docker environment to access the
    AWS ECR.  To do this, the script uses the `aws ecr get-login-password` command.

    This script can be useful when re-visiting an already created AWS ECR repository after disconnecting
    or re-booting the local system.

    usage: `docker-ecr-login.sh <region> <accountID>`

    Example invocation (replace NNNNNNNNNNNN with the appropriate AWS AccountId):

        docker-ecr-login.sh us-east-1 NNNNNNNNNNNN

## Summary

The shell scripts in this folder can be used to ease the interaction with AWS ECR when using
command-line interfaces.  Users are encouraged to look at the scripts and understand the commands
which are used within the scripts so that they are familiar with what `docker`, `aws`, and `jq` commands
are being used.

(c) 2022 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
