FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    python3 \
    bison \
    flex \
    libboost-all-dev \
    libgmp-dev \
    libmpfr-dev \
    zlib1g-dev \
    unzip \
    wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY 2ls /root/2ls

WORKDIR /root/2ls

RUN chmod +x build.sh && ./build.sh