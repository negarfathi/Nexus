#!/bin/bash

set -u

root_directory="$(cd "$(dirname "$0")" && pwd)"

nexus_binary="${NEXUS_BIN:-$root_directory/cmake-build-debug/Nexus}"
models_directory="$root_directory/models"

venv_directory="$root_directory/.venv"
benchmarks_directory="$root_directory/Benchmarks"
results_directory="$root_directory/ExperimentResults"

excel_file="$root_directory/experiment_results.xlsx"

host="127.0.0.1"
port=8000

timeout=600
max_syntactic_refinements=5
max_semantic_refinements=5

if [[ ! -d "$benchmarks_directory" ]]; then
    echo "Benchmarks folder not found: $benchmarks_directory"
    exit 1
fi

if [[ ! -x "$nexus_binary" ]]; then
    echo "Nexus executable not found: $nexus_binary"
    exit 1
fi

if [[ ! -x "$venv_directory/bin/vllm" ]]; then
    echo "vLLM not found: $venv_directory/bin/vllm"
    exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
    echo "curl is required."
    exit 1
fi

if curl -sf "http://$host:$port/v1/models" >/dev/null 2>&1; then
    echo "A vLLM server is already running on port $port."
    echo "Stop it before running this script."
    exit 1
fi

rm -rf "$results_directory"
rm -f "$excel_file"

mkdir -p \
    "$results_directory/gpt-oss-20b" \
    "$results_directory/Qwen3-8B" \
    "$results_directory/CodeLlama-7B-Instruct"

cp -r "$benchmarks_directory"/. "$results_directory/gpt-oss-20b/"
cp -r "$benchmarks_directory"/. "$results_directory/Qwen3-8B/"
cp -r "$benchmarks_directory"/. "$results_directory/CodeLlama-7B-Instruct/"

server_pid=""

stop_server() {
    if [[ -n "$server_pid" ]] && kill -0 "$server_pid" 2>/dev/null; then
        kill "$server_pid" 2>/dev/null || true
        wait "$server_pid" 2>/dev/null || true
    fi
    server_pid=""
}

trap stop_server EXIT
trap 'stop_server; exit 130' INT TERM

start_server() {
    local model_directory="$1"
    local llm_model="$2"
    local reasoning_parser="$3"
    local server_log="/tmp/nexus_${llm_model}_vllm.log"
    if [[ ! -f "$model_directory/config.json" ]]; then
        echo "Model not found: $model_directory"
        exit 1
    fi
    local command=(
        "$venv_directory/bin/vllm" serve "$model_directory"
        --served-model-name "$llm_model"
        --host "$host"
        --port "$port"
    )
    if [[ -n "$reasoning_parser" ]]; then
        command+=(--reasoning-parser "$reasoning_parser")
    fi
    VLLM_USE_FLASHINFER_SAMPLER=0 "${command[@]}" > "$server_log" 2>&1 &
    server_pid=$!
    local waited=0
    while ! curl -sf "http://$host:$port/v1/models" >/dev/null 2>&1; do
        if ! kill -0 "$server_pid" 2>/dev/null; then
            echo "vLLM failed to start. See: $server_log"
            exit 1
        fi
        if (( waited >= 900 )); then
            echo "Timed out waiting for vLLM. See: $server_log"
            exit 1
        fi
        sleep 5
        waited=$((waited + 5))
    done
}

run_model() {
    local model_directory="$1"
    local llm_model="$2"
    local reasoning_parser="$3"
    local model_benchmarks_directory="$results_directory/$llm_model"
    echo
    echo "Starting model: $llm_model"
    start_server "$model_directory" "$llm_model" "$reasoning_parser"
    while IFS= read -r -d '' source_code; do
        if ! kill -0 "$server_pid" 2>/dev/null; then
            echo "vLLM stopped unexpectedly for $llm_model."
            exit 1
        fi
        relative_path="${source_code#$model_benchmarks_directory/}"
        source_directory="$(dirname "$source_code")"
        rm -rf "$source_directory/generated"
        echo "$llm_model -> $relative_path"
        VLLM_BASE_URL="http://$host:$port" \
        "$nexus_binary" \
            "$source_code" \
            "llm-model=$llm_model" \
            "max-syntactic-refinements=$max_syntactic_refinements" \
            "max-semantic-refinements=$max_semantic_refinements" \
            "timeout=$timeout"
    done < <(
        find "$model_benchmarks_directory" \
            -type d -name generated -prune -o \
            -type f -name "*.c" -print0 | sort -z
    )
    stop_server
    sleep 5

    echo "Finished model: $llm_model"
}

run_model "$models_directory/gpt-oss-20b" "gpt-oss-20b" "openai_gptoss"
run_model "$models_directory/Qwen3-8B" "Qwen3-8B" "qwen3"
run_model "$models_directory/CodeLlama-7B-Instruct" "CodeLlama-7B-Instruct" ""

echo
echo "Finished."
echo "Results: $results_directory"
echo "Nexus Excel: $excel_file"