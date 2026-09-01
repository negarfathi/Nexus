#!/bin/bash

set -Eeuo pipefail

root_directory="$(cd "$(dirname "$0")" && pwd)"

proton_directory="$root_directory/term"
proton_repository="https://github.com/kumarmadhukar/term.git"
proton_image="proton"

echo "Installing PROTON..."

if ! command -v git >/dev/null 2>&1; then
    echo "Git is not installed. Please install Git first."
    exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

rm -rf "$proton_directory"

git clone \
    "$proton_repository" \
    "$proton_directory"

docker buildx build \
    --platform linux/amd64 \
    -t "$proton_image" \
    --load \
    "$root_directory"

docker run --rm \
    --platform linux/amd64 \
    --entrypoint /bin/bash \
    "$proton_image" \
    -c 'test -x /opt/term/proton/proton && test -f /opt/term/proton/termination.prp'

rm -rf "$proton_directory"

echo "PROTON successfully installed."