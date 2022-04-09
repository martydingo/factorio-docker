# Use Alpine Linux as the base container
FROM debian:stable-slim

# Environment variables lie here

ENV FACTORIO_VERSION="latest"
ENV FACTORIO_ENVIRONMENT="stable"

# Install wget & tar
RUN /usr/bin/apt update -y && /usr/bin/apt install wget xz-utils -y

# Fetch Factorio headless server tarball
RUN if [[ $FACTORIO_VERSION  == "latest" ]]; then wget https://factorio.com/get-download/stable/headless/linux64 -O /tmp/factorio.tar.xz ; else wget https://factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 -O /tmp/factorio.tar.xz ; fi  
WORKDIR /tmp
RUN xz -d /tmp/factorio.tar.xz && tar xvf /tmp/factorio.tar && mv /tmp/factorio /opt/factorio
RUN chmod +x /opt/factorio/bin/x64/factorio
RUN rm -f /tmp/*

WORKDIR /
RUN mkdir /config
ADD entrypoint.sh entrypoint.sh
RUN chmod +x /entrypoint.sh

SHELL [ "/bin/bash" ]

