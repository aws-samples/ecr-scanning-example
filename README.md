# example-ecr-scanning

Sample scripts and Docker container build instructions to show how to use AWS Elastic Container Registry (ECR) for scanning Docker images for vulnerabilities.

## Description
Building, running, and in general working with Docker images and containers requires using quite a few command-line
commands.  The same is true when using the AWS ECR to hold Docker images or retrieve them to run on a target
system.

This repository contains several short, useful, shell scripts to wrap around running `docker` and `aws` commands.
These scripts can be used separately or in combination to do various tasks when using these CLIs.

## Badges
None.

## Visuals
None.  The tools are meant to be run from a Linux or MacOS command-line.

## Installation
Since these are shell scripts, no installation other than cloning the repository is required.

To install, run:

    git clone git@ssh.gitlab.aws.dev:timhahn/example-ecr-scanning.git

The scripts are meant to run with `bash` and the she-bang comment at the top of each script references
either `/bin/bash` or `/bin/sh`.

## Usage
The shell scripts are small enough that viewing the first couple of lines of the script should
provide enough information for how to use the script.

## Support
Support is provided on a case-by-case basis.  If you find a problem, open an issue to report it.

If you have a suggestion, open an issue to suggest it.  Better yet, [fork this repo](https://gitlab.aws.dev/timhahn/example-ecr-scanning/-/forks/new), create the enhancement,
and submit a merge request!  Also, see [Contributing](#contributing).

## Project status
The project is active.

## Roadmap
None planned.  We're open to suggestions!

## Contributing
[Fork me](https://gitlab.aws.dev/timhahn/example-ecr-scanning/-/forks/new)! Feel free to fork this repository and suggest updates and enhancements.

Also, see [CONTRIBUTING](./CONTRIBUTING.md)

## Authors and acknowledgment

Thanks to:
 - Tim Hahn (@timhahn, timhahn@amazon.com) - original author
 - Swati Priya (@priyaswa, priyaswa@amazon.com) - reviewer, contributor

## License
see [LICENSE](./LICENSE).

Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: MIT-0
