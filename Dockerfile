# Use Alpine Linux as the base container
FROM debian:stable-slim
SHELL ["/bin/bash", "-c"]

# Argument definitions lies here

ARG FACTORIO_VERSION
ARG FACTORIO_ENVIRONMENT
ARG FACTORIO_SERVER_LOAD_LATEST
ARG FACTORIO_SERVER_GEN_MAP
ARG FACTORIO_SERVER_GEN_CONFIG
ARG FACTORIO_SERVER_USE_SERVER_WHITELIST
ARG FACTORIO_SERVER_USE_ADMIN_WHITELIST
ARG FACTORIO_SERVER_USE_MAP_SETTINGS
ARG FACTORIO_SERVER_USE_MAPGEN_SETTINGS

# Environment variables lie here

ENV FACTORIO_ENVIRONMENT="stable"
ENV FACTORIO_SERVER_LOAD_LATEST=true
ENV FACTORIO_SERVER_GEN_MAP=false
ENV FACTORIO_SERVER_GEN_CONFIG=false
ENV FACTORIO_SERVER_USE_SERVER_WHITELIST=false
ENV FACTORIO_SERVER_USE_ADMIN_WHITELIST=false
ENV FACTORIO_SERVER_USE_MAP_SETTINGS=false
ENV FACTORIO_SERVER_USE_MAPGEN_SETTINGS=false

# Install wget & tar
RUN /usr/bin/apt update -y && /usr/bin/apt install wget xz-utils -y

# Fetch Factorio headless server tarball
RUN if [[ -z $FACTORIO_VERSION  ]]; then wget https://factorio.com/get-download/stable/headless/linux64 -O /tmp/factorio.tar.xz ; else wget https://factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 -O /tmp/factorio.tar.xz ; fi  
WORKDIR /tmp
RUN xz -d /tmp/factorio.tar.xz && tar xvf /tmp/factorio.tar && mv /tmp/factorio /opt/factorio
RUN chmod +x /opt/factorio/bin/x64/factorio
RUN rm -f /tmp/*

WORKDIR /
RUN mkdir /config
ADD docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]