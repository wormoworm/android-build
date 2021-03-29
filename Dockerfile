FROM ubuntu:20.04

# Ubuntu 20.04 has some BS timezone noncery during the setup that we need to skip.
ARG DEBIAN_FRONTEND=noninteractive

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Update apt and install the tools we need. We do this all in one step because we need to combine it with an apt-get update, else we can (and have) run into caching issues.
RUN apt update && apt install -y --no-install-recommends \
    nodejs \
    sudo \
    wget \
    unzip \
    git \
    openjdk-8-jdk \
    android-sdk

ENV ANDROID_HOME=/usr/lib/android-sdk
ENV PATH="${ANDROID_HOME}/cmdline-tools/tools/bin:$PATH"
ENV WORK_DIR=/work/

# Create the directory for our script(s) and work.
RUN mkdir /scripts $WORK_DIR
COPY build/setup-sdk.sh run/install-build-tools-platform-tools.sh run/entrypoint-devops-pipelines.sh run/entrypoint-local.sh /scripts/
RUN chmod 777 /scripts/*

# Run the SDK setup script
RUN /scripts/setup-sdk.sh

# This tells Azure DevOps Pipelines where to find the Node binary, which is used to execute pipeline step commands in this container.
LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/bin/node"