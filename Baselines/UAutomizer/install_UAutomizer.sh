#!/bin/bash

set -Eeuo pipefail

root_directory="$(cd "$(dirname "$0")" && pwd)"

uautomizer_archive="$root_directory/UltimateAutomizer-linux.zip"
uautomizer_directory="$root_directory/UAutomizer-linux"
uautomizer_url="https://github.com/ultimate-pa/ultimate/releases/download/v0.2.2/UltimateAutomizer-linux.zip"
uautomizer_image="uautomizer"

echo "Installing UAutomizer..."

if ! command -v curl >/dev/null 2>&1; then
    echo "Curl is not installed. Please install curl first."
    exit 1
fi

if ! command -v unzip >/dev/null 2>&1; then
    echo "Unzip is not installed. Please install unzip first."
    exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

rm -f "$uautomizer_archive"
rm -rf "$uautomizer_directory"

curl -L \
    -o "$uautomizer_archive" \
    "$uautomizer_url"

unzip -q \
    "$uautomizer_archive" \
    -d "$root_directory"

docker build \
    -t "$uautomizer_image" \
    "$root_directory"

docker run --rm \
    --entrypoint /bin/bash \
    "$uautomizer_image" \
    -c 'test -f /opt/uautomizer/UAutomizer-linux/Ultimate.py'

rm -f "$uautomizer_archive"
rm -rf "$uautomizer_directory"

echo "UAutomizer successfully installed."