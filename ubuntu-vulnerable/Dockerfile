FROM ubuntu:18.04

#
# Install, intentionally, FOR DEMONSTRATION PURPOSES ONLY!!! a vulnerable version of log4j
#
RUN apt-get update -qq \
    && apt-get -y install \
    liblog4j2-java=2.10.0-2

#
# copy a file into workdir and set this as the starting folder
#
WORKDIR /workdir
COPY ./files /workdir

#
# just start a interactive shell
#
ENTRYPOINT [ "bash" ]
