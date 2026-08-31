#!/usr/bin/env bash
set -Eeuo pipefail

# ============================================================
# Nexus complete setup + vLLM launcher
#
# FIRST TIME:
#   chmod +x nexus_setup.sh
#   ./nexus_setup.sh
#
# NEXT TIMES:
#   ./nexus_setup.sh gpt-oss
#   ./nexus_setup.sh qwen
#   ./nexus_setup.sh codellama
#
# Nexus/CLion environment variable:
#   VLLM_BASE_URL=http://127.0.0.1:8000
# ============================================================

REPO_URL="https://github.com/negarfathi/Nexus.git"

NEXUS_DIR="${NEXUS_DIR:-$HOME/Documents/Nexus}"
VENV_DIR="$NEXUS_DIR/.venv"
MODELS_DIR="$NEXUS_DIR/models"

HOST="${HOST:-127.0.0.1}"
PORT="${PORT:-8000}"

VLLM_VERSION="0.28.0"
VLLM_WHEEL="https://github.com/vllm-project/vllm/releases/download/v0.28.0/vllm-0.28.0%2Bcu129-cp38-abi3-manylinux_2_28_x86_64.whl"
PYTORCH_INDEX="https://download.pytorch.org/whl/cu129"

GPT_OSS_REPO="openai/gpt-oss-20b"
QWEN_REPO="Qwen/Qwen3-8B"
CODELLAMA_REPO="codellama/CodeLlama-7b-Instruct-hf"

GPT_OSS_DIR="$MODELS_DIR/gpt-oss-20b"
QWEN_DIR="$MODELS_DIR/Qwen3-8B"
CODELLAMA_DIR="$MODELS_DIR/CodeLlama-7B-Instruct"

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
    echo "Setup stopped because of an error."
    echo "Fix the error shown above, then run the same command again."
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
        # shellcheck disable=SC1090
        source "$HOME/.local/bin/env"
    fi

    command -v uv >/dev/null 2>&1 || die "uv installation failed."
}

clone_nexus() {
    mkdir -p "$HOME/Documents"

    if [[ -d "$NEXUS_DIR/.git" ]]; then
        echo "Nexus already exists at:"
        echo "  $NEXUS_DIR"
        return
    fi

    if [[ -e "$NEXUS_DIR" ]]; then
        die "$NEXUS_DIR exists but is not a Git repository. Rename or remove it first."
    fi

    info "Cloning Nexus"

    git clone "$REPO_URL" "$NEXUS_DIR"

    echo "Nexus cloned to:"
    echo "  $NEXUS_DIR"
}

create_venv() {
    cd "$NEXUS_DIR"

    if [[ ! -d "$VENV_DIR" ]]; then
        info "Creating Python 3.12 virtual environment"

        uv venv \
            --python 3.12 \
            --seed \
            --managed-python \
            "$VENV_DIR"
    else
        echo "Virtual environment already exists:"
        echo "  $VENV_DIR"
    fi

    # shellcheck disable=SC1091
    source "$VENV_DIR/bin/activate"

    mkdir -p "$MODELS_DIR"
}

install_vllm() {
    # shellcheck disable=SC1091
    source "$VENV_DIR/bin/activate"

    if python - <<PY >/dev/null 2>&1
import vllm
raise SystemExit(0 if vllm.__version__ == "$VLLM_VERSION" else 1)
PY
    then
        echo "vLLM $VLLM_VERSION already installed."
        return
    fi

    info "Installing vLLM $VLLM_VERSION with CUDA 12.9"

    uv pip install \
        "$VLLM_WHEEL" \
        --extra-index-url "$PYTORCH_INDEX" \
        --index-strategy unsafe-best-match
}

verify_installation() {
    # shellcheck disable=SC1091
    source "$VENV_DIR/bin/activate"

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
    local dest="$2"

    # shellcheck disable=SC1091
    source "$VENV_DIR/bin/activate"

    if [[ -f "$dest/config.json" ]]; then
        echo
        echo "$repo already appears to be downloaded."
        echo "  $dest"
        return
    fi

    info "Downloading $repo"

    REPO="$repo" DEST="$dest" python - <<'PY'
import os
from huggingface_hub import snapshot_download

repo = os.environ["REPO"]
dest = os.environ["DEST"]
token = os.environ.get("HF_TOKEN") or None

snapshot_download(
    repo_id=repo,
    local_dir=dest,
    token=token,
)

print()
print("Downloaded:")
print(" ", repo)
print("to:")
print(" ", dest)
PY
}

download_all_models() {
    mkdir -p "$MODELS_DIR"

    info "Disk space before model downloads"
    df -h "$MODELS_DIR" || true

    echo
    echo "Models will be downloaded ONE BY ONE:"
    echo "  1. $GPT_OSS_REPO"
    echo "  2. $QWEN_REPO"
    echo "  3. $CODELLAMA_REPO"
    echo

    download_model "$GPT_OSS_REPO" "$GPT_OSS_DIR"
    download_model "$QWEN_REPO" "$QWEN_DIR"
    download_model "$CODELLAMA_REPO" "$CODELLAMA_DIR"

    info "All three models are ready"

    du -sh \
        "$GPT_OSS_DIR" \
        "$QWEN_DIR" \
        "$CODELLAMA_DIR" \
        2>/dev/null || true
}

full_setup() {
    ensure_system_tools
    ensure_uv
    clone_nexus
    create_venv
    install_vllm
    verify_installation
    download_all_models

    info "FIRST-TIME SETUP COMPLETE"

    cat <<EOF

Nexus:
  $NEXUS_DIR

Models:
  $GPT_OSS_DIR
  $QWEN_DIR
  $CODELLAMA_DIR


NEXT TIME — START ONE MODEL:

GPT-OSS:
  $0 gpt-oss

Qwen:
  $0 qwen

CodeLlama:
  $0 codellama


IN CLION:

Open:
  $NEXUS_DIR

Then add this to the Nexus Run Configuration:

  VLLM_BASE_URL=http://127.0.0.1:$PORT

Keep the model-server terminal open while Nexus is running.

EOF
}

prepare_runtime() {
    [[ -d "$NEXUS_DIR/.git" ]] || \
        die "Nexus is not installed. Run this script with no arguments first."

    [[ -d "$VENV_DIR" ]] || \
        die ".venv is missing. Run this script with no arguments first."

    # shellcheck disable=SC1091
    source "$VENV_DIR/bin/activate"

    export VLLM_USE_FLASHINFER_SAMPLER=0

    # Do NOT export VLLM_BASE_URL in the vLLM server process.
    # vLLM treats unknown VLLM_* variables as configuration variables
    # and prints a warning. VLLM_BASE_URL belongs in Nexus/CLion instead.
}

require_model() {
    local directory="$1"
    local name="$2"

    if [[ ! -f "$directory/config.json" ]]; then
        die "$name is not downloaded. Run the full setup first."
    fi
}

run_gpt_oss() {
    prepare_runtime
    require_model "$GPT_OSS_DIR" "$GPT_OSS_REPO"

    info "Starting GPT-OSS 20B"

    echo "Server:"
    echo "  http://$HOST:$PORT"
    echo
    echo "CLion/Nexus environment variable:"
    echo "  VLLM_BASE_URL=http://127.0.0.1:$PORT"
    echo

    exec vllm serve "$GPT_OSS_DIR" \
        --served-model-name gpt-oss-20b \
        --reasoning-parser openai_gptoss \
        --host "$HOST" \
        --port "$PORT"
}

run_qwen() {
    prepare_runtime
    require_model "$QWEN_DIR" "$QWEN_REPO"

    info "Starting Qwen3-8B"

    echo "Server:"
    echo "  http://$HOST:$PORT"
    echo
    echo "CLion/Nexus environment variable:"
    echo "  VLLM_BASE_URL=http://127.0.0.1:$PORT"
    echo

    exec vllm serve "$QWEN_DIR" \
        --served-model-name Qwen3-8B \
        --reasoning-parser qwen3 \
        --host "$HOST" \
        --port "$PORT"
}

run_codellama() {
    prepare_runtime
    require_model "$CODELLAMA_DIR" "$CODELLAMA_REPO"

    info "Starting CodeLlama-7B-Instruct"

    echo "Server:"
    echo "  http://$HOST:$PORT"
    echo
    echo "CLion/Nexus environment variable:"
    echo "  VLLM_BASE_URL=http://127.0.0.1:$PORT"
    echo

    exec vllm serve "$CODELLAMA_DIR" \
        --served-model-name CodeLlama-7B-Instruct \
        --host "$HOST" \
        --port "$PORT"
}

show_help() {
    cat <<EOF
Nexus setup / vLLM launcher

FIRST TIME:

  chmod +x $0
  $0

This performs:

  1. Clone:
       https://github.com/negarfathi/Nexus.git
     into:
       ~/Documents/Nexus

  2. Install uv

  3. Create:
       ~/Documents/Nexus/.venv

  4. Install:
       Python 3.12
       PyTorch CUDA 12.9
       vLLM $VLLM_VERSION

  5. Verify NVIDIA/CUDA

  6. Download models one by one:
       openai/gpt-oss-20b
       Qwen/Qwen3-8B
       codellama/CodeLlama-7b-Instruct-hf


NEXT TIMES:

  $0 gpt-oss

  $0 qwen

  $0 codellama


CLION:

  Open:
    ~/Documents/Nexus

  Add to Run -> Edit Configurations -> Environment variables:

    VLLM_BASE_URL=http://127.0.0.1:$PORT

Only run one model server on port $PORT at a time.

EOF
}

case "${1:-setup}" in
    setup)
        full_setup
        ;;

    gpt-oss|gptoss|oss)
        run_gpt_oss
        ;;

    qwen|qwen3)
        run_qwen
        ;;

    codellama|code-llama)
        run_codellama
        ;;

    help|-h|--help)
        show_help
        ;;

    *)
        show_help
        die "Unknown command: $1"
        ;;
esac
