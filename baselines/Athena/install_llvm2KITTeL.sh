#!/bin/bash

set -Eeuo pipefail

root_directory="$(cd "$(dirname "$0")" && pwd)"

llvm2kittel_directory="$root_directory/llvm2kittel"
llvm2kittel_repository="https://github.com/negarfathi/llvm2kittel.git"
base_image="k0kubun/llvm35"
llvm2kittel_image="llvm2kittel"

container_id=""

cleanup() {
    if [[ -n "$container_id" ]]; then
        docker stop "$container_id" >/dev/null 2>&1 || true
        docker rm "$container_id" >/dev/null 2>&1 || true
    fi
}

trap cleanup EXIT

echo "Installing llvm2KITTeL..."

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

docker pull "$base_image"

rm -rf "$llvm2kittel_directory"

container_id="$(
    docker run -dit \
        -v "$root_directory:/PATH" \
        "$base_image"
)"

docker exec "$container_id" bash -c "
    apt-get update &&
    apt-get install -y cmake gdb libgmp-dev libgmpxx4ldbl &&
    cd /PATH &&
    git clone -b kou '$llvm2kittel_repository' llvm2kittel &&
    cd llvm2kittel &&
    mkdir -p build &&
    cd build &&
    cmake .. &&
    make -j\$(nproc)
"

docker commit \
    "$container_id" \
    "$llvm2kittel_image"

docker run --rm \
    "$llvm2kittel_image" \
    /bin/bash -c 'test -x /PATH/llvm2kittel/build/llvm2kittel' 2>/dev/null || true

cleanup
container_id=""

docker image rm "$base_image"

echo "llvm2KITTeL successfully installed."