#!/bin/bash

set -Eeuo pipefail

root_directory="$(cd "$(dirname "$0")" && pwd)"

source_image="nlommen/aprove_koat_loat:578822"
aprove_image="aprove"

echo "Installing AProVE..."

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

docker pull \
    --platform linux/amd64 \
    "$source_image"

docker tag \
    "$source_image" \
    "$aprove_image"

docker run --rm \
    --platform linux/amd64 \
    --entrypoint /bin/bash \
    "$aprove_image" \
    -c 'test -x /aprove/AProVE.sh'

docker image rm "$source_image"

echo "AProVE successfully installed."