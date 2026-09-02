FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    python3 \
    z3 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY UAutomizer-linux /opt/uautomizer/UAutomizer-linux

WORKDIR /opt/uautomizer/UAutomizer-linux