#!/bin/bash

set -Eeuo pipefail

root_directory="$(cd "$(dirname "$0")" && pwd)"

base_image="sosylab/cpachecker:dev"
cpachecker_image="cpachecker"

echo "Installing CPAchecker..."

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

docker pull "$base_image"

docker build \
    -t "$cpachecker_image" \
    "$root_directory"

docker run --rm \
    --entrypoint /bin/bash \
    "$cpachecker_image" \
    -c 'test -f /usr/include/stdlib.h && /cpachecker/scripts/cpa.sh -help >/dev/null'

docker image rm "$base_image"

echo "CPAchecker successfully installed."