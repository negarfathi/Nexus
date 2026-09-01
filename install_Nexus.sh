#!/bin/bash

set -Eeuo pipefail

root_directory="$(cd "$(dirname "$0")" && pwd)"

repo_url="https://github.com/negarfathi/Nexus.git"

nexus_directory="$root_directory/Nexus"
venv_directory="$nexus_directory/.venv"
models_directory="$nexus_directory/models"

vllm_version="0.28.0"
vllm_wheel="https://github.com/vllm-project/vllm/releases/download/v0.28.0/vllm-0.28.0%2Bcu129-cp38-abi3-manylinux_2_28_x86_64.whl"
pytorch_index="https://download.pytorch.org/whl/cu129"

gpt_oss_repo="openai/gpt-oss-20b"
qwen_repo="Qwen/Qwen3-8B"
codellama_repo="codellama/CodeLlama-7b-Instruct-hf"

gpt_oss_directory="$models_directory/gpt-oss-20b"
qwen_directory="$models_directory/Qwen3-8B"
codellama_directory="$models_directory/CodeLlama-7B-Instruct"

info() {
    echo
    echo "============================================================"
    echo "$*"
    echo "============================================================"
}

die() {
    echo "ERROR: $*" >&2
    exit 1
}

on_error() {
    echo
    echo "Installation stopped because of an error."
    echo "Fix the error shown above, then run the script again."
}

trap on_error ERR

ensure_system_tools() {
    local missing=()
    command -v git >/dev/null 2>&1 || missing+=("git")
    command -v curl >/dev/null 2>&1 || missing+=("curl")
    if ((${#missing[@]} == 0)); then
        return
    fi
    info "Installing required packages: ${missing[*]}"
    if command -v sudo >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y "${missing[@]}"
    elif [[ "$(id -u)" -eq 0 ]]; then
        apt-get update
        apt-get install -y "${missing[@]}"
    else
        die "Please install these packages first: ${missing[*]}"
    fi
}

ensure_uv() {
    if command -v uv >/dev/null 2>&1; then
        echo "uv already installed: $(uv --version)"
        return
    fi
    if [[ -x "$HOME/.local/bin/uv" ]]; then
        export PATH="$HOME/.local/bin:$PATH"
        echo "uv found: $(uv --version)"
        return
    fi
    info "Installing uv"
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
    if [[ -f "$HOME/.local/bin/env" ]]; then
        source "$HOME/.local/bin/env"
    fi
    command -v uv >/dev/null 2>&1 || die "uv installation failed."
}

clone_nexus() {
    if [[ -d "$nexus_directory/.git" ]]; then
        echo "Nexus already exists:"
        echo "  $nexus_directory"
        return
    fi
    if [[ -e "$nexus_directory" ]]; then
        die "$nexus_directory exists but is not a Git repository."
    fi
    info "Cloning Nexus"
    git clone "$repo_url" "$nexus_directory"
    echo "Nexus cloned to:"
    echo "  $nexus_directory"
}

create_venv() {
    cd "$nexus_directory"
    if [[ ! -d "$venv_directory" ]]; then
        info "Creating Python 3.12 virtual environment"
        uv venv \
            --python 3.12 \
            --seed \
            --managed-python \
            "$venv_directory"
    else
        echo "Virtual environment already exists:"
        echo "  $venv_directory"
    fi
    source "$venv_directory/bin/activate"
    mkdir -p "$models_directory"
}

install_vllm() {
    source "$venv_directory/bin/activate"
    if python - <<PY >/dev/null 2>&1
import vllm
raise SystemExit(0 if vllm.__version__ == "$vllm_version" else 1)
PY
    then
        echo "vLLM $vllm_version already installed."
        return
    fi
    info "Installing vLLM $vllm_version with CUDA 12.9"
    uv pip install \
        "$vllm_wheel" \
        --extra-index-url "$pytorch_index" \
        --index-strategy unsafe-best-match
}

verify_installation() {
    source "$venv_directory/bin/activate"
    info "Checking Python / PyTorch / CUDA / vLLM"
    python - <<'PY'
import torch
import vllm
print("Torch:", torch.__version__)
print("CUDA:", torch.version.cuda)
print("GPU available:", torch.cuda.is_available())
print("vLLM:", vllm.__version__)
if not torch.cuda.is_available():
    raise SystemExit("ERROR: CUDA GPU is not available to PyTorch.")
PY
    if command -v nvidia-smi >/dev/null 2>&1; then
        echo
        nvidia-smi
    fi
}

download_model() {
    local repo="$1"
    local destination="$2"
    source "$venv_directory/bin/activate"
    if [[ -f "$destination/config.json" ]]; then
        echo
        echo "$repo already appears to be downloaded."
        echo "  $destination"
        return
    fi
    info "Downloading $repo"
    model_repo="$repo" model_destination="$destination" python - <<'PY'
import os
from huggingface_hub import snapshot_download
repo = os.environ["model_repo"]
destination = os.environ["model_destination"]
token = os.environ.get("HF_TOKEN") or None
snapshot_download(
    repo_id=repo,
    local_dir=destination,
    token=token,
)
print()
print("Downloaded:")
print(" ", repo)
print("to:")
print(" ", destination)
PY
}

download_all_models() {
    mkdir -p "$models_directory"
    info "Disk space before model downloads"
    df -h "$models_directory" || true
    echo
    echo "Models will be downloaded one by one:"
    echo "  1. $gpt_oss_repo"
    echo "  2. $qwen_repo"
    echo "  3. $codellama_repo"
    echo
    download_model "$gpt_oss_repo" "$gpt_oss_directory"
    download_model "$qwen_repo" "$qwen_directory"
    download_model "$codellama_repo" "$codellama_directory"
    info "All models are ready"
    du -sh \
        "$gpt_oss_directory" \
        "$qwen_directory" \
        "$codellama_directory" \
        2>/dev/null || true
}

ensure_system_tools
ensure_uv
clone_nexus
create_venv
install_vllm
verify_installation
download_all_models

info "NEXUS INSTALLATION COMPLETE"

echo "Nexus:"
echo "  $nexus_directory"
echo
echo "Virtual environment:"
echo "  $venv_directory"
echo
echo "Models:"
echo "  $gpt_oss_directory"
echo "  $qwen_directory"
echo "  $codellama_directory"