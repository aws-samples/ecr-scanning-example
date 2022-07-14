# (c) 2022 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
FROM ubuntu:18.04

#
# Install, intentionally, FOR DEMONSTRATION PURPOSES ONLY!!! a vulnerable version of log4j
#
RUN apt-get update -qq \
    && apt-get -y install \
    liblog4j2-java=2.10.0-2

#
# Insert a step here to upgrade all packages that might be upgradable
#
# RUN apt upgrade -y
RUN apt-get upgrade -y

#
# copy a file into workdir and set this as the starting folder
#
WORKDIR /workdir
COPY ./files /workdir

#
# create a non-root user to run as
#
RUN useradd --shell /bin/bash user01 --create-home
USER user01

#
# no HEALTHCHECK
#
HEALTHCHECK NONE

#
# just start a interactive shell
#
ENTRYPOINT [ "bash" ]
