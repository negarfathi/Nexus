#!/bin/bash

set -Eeuo pipefail

root_directory="$(cd "$(dirname "$0")" && pwd)"

twols_directory="$root_directory/2ls"
twols_repository="https://github.com/diffblue/2ls.git"
twols_image="2ls"

echo "Installing 2LS..."

if ! command -v git >/dev/null 2>&1; then
    echo "Git is not installed. Please install Git first."
    exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

rm -rf "$twols_directory"

git clone --recursive \
    "$twols_repository" \
    "$twols_directory"

docker build \
    -t "$twols_image" \
    "$root_directory"

rm -rf "$twols_directory"

echo "2LS successfully installed."