# Use Alpine Linux as the base container
FROM debian:stable-slim
SHELL ["/bin/bash", "-c"]

# Argument definitions lies here

ARG FACTORIO_VERSION
ARG FACTORIO_ENVIRONMENT
# Environment variables lie here
ENV FACTORIO_ENVIRONMENT=${FACTORIO_ENVIRONMENT:-"stable"}

# Install wget & tar
RUN /usr/bin/apt update -y && /usr/bin/apt install wget xz-utils -y

# Fetch Factorio headless server tarball
RUN if [[ -z $FACTORIO_VERSION  ]]; then wget https://factorio.com/get-download/stable/headless/linux64 -O /tmp/factorio.tar.xz ; else wget https://factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 -O /tmp/factorio.tar.xz ; fi  
WORKDIR /tmp
RUN xz -d /tmp/factorio.tar.xz && tar xvf /tmp/factorio.tar && mv /tmp/factorio /opt/factorio
RUN chmod +x /opt/factorio/bin/x64/factorio
RUN ln -s /opt/factorio/bin/x64/factorio /usr/bin/factorio

RUN rm -f /tmp/*

WORKDIR /opt/factorio
RUN mkdir mods
RUN mkdir saves

ENTRYPOINT ["/bin/bash", "-c"]
WORKDIR /opt/factorio/bin/x64
CMD  [ "factorio -h" ]