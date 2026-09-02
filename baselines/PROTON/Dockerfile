FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TOOL_ROOT=/opt/term/proton

WORKDIR ${TOOL_ROOT}

RUN dpkg --add-architecture i386 \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    git \
    unzip \
    gnupg \
    dirmngr \
    gcc \
    g++-12 \
    clang-14 \
    llvm-14 \
    libc6-dev-i386 \
    libz3-4 \
    libz3-dev \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    build-essential \
    cmake \
    pkg-config \
 && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 120 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 120 \
 && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-14 120

ENV PATH="${TOOL_ROOT}/bin:${PATH}"

COPY term/proton/ ${TOOL_ROOT}/
COPY termination.prp ${TOOL_ROOT}/termination.prp

RUN chmod +x proton bracer/bracer cbmc/cbmc run-*.sh || true \
 && mkdir -p logs tmp

CMD ["/bin/bash"]