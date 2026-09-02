#!/bin/bash

set -Eeuo pipefail

root_directory="$(cd "$(dirname "$0")" && pwd)"

muval_directory="$root_directory/coar"
muval_repository="https://github.com/hiroshi-unno/coar.git"
muval_dockerfile="$root_directory/Dockerfile_MuVal"
muval_image="coar"

echo "Installing MuVal..."

if ! command -v git >/dev/null 2>&1; then
    echo "Git is not installed. Please install Git first."
    exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

if [[ ! -f "$muval_dockerfile" ]]; then
    echo "MuVal Dockerfile not found: $muval_dockerfile"
    exit 1
fi

rm -rf "$muval_directory"

git clone \
    "$muval_repository" \
    "$muval_directory"

docker build \
    -f "$muval_dockerfile" \
    -t "$muval_image" \
    "$muval_directory"

docker run --rm \
    "$muval_image" \
    /bin/bash -c 'test -x /root/coar/main.exe'

rm -rf "$muval_directory"

echo "MuVal successfully installed."