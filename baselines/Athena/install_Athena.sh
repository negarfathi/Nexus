#!/usr/bin/env bash

set -Eeuo pipefail

echo "Installing Athena (CoAR / SV-COMP)..."

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_directory="$script_directory/coar"

if [[ ! -d "$source_directory" ]]; then
    git clone --depth 1 https://github.com/hiroshi-unno/coar.git "$source_directory"
else
    git -C "$source_directory" pull --ff-only
fi

git -C "$source_directory" submodule update --init --recursive -- script/llvm2kittel_route/llvm2kittel script/svcomp/sv-witness

cd "$source_directory"

docker buildx build \
    --platform linux/amd64 \
    --progress=plain \
    -f Dockerfile \
    -t coar:latest \
    --load .

docker buildx build \
    --platform linux/amd64 \
    --progress=plain \
    -f script/svcomp/Dockerfile \
    -t coar:svcomp \
    --load .

echo "Athena Docker images built successfully."