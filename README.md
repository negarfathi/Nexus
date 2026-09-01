# Nexus

Nexus is an LLM-guided framework for automated termination and non-termination analysis of C programs. It extracts loop-level information from LLVM IR, asks a large language model to synthesize a structured proof candidate, checks the candidate against a fixed grammar, validates it semantically, and uses validation feedback to refine unsuccessful candidates.

For each target loop, Nexus can synthesize one of three outcomes:

- **terminating** – an inductive invariant together with a ranking function
- **non-terminating** – a recurrent set
- **unknown** – no valid termination or non-termination witness was obtained

Nexus analyzes candidate expressions over mathematical integers and represents them as JSON abstract-syntax trees constrained by `candidate_grammar.txt`.

The framework supports the following LLM backends:

- **GPT-5.6-Terra** through the OpenAI API
- **GPT-OSS-20B** through a local vLLM server
- **Qwen3-8B** through a local vLLM server
- **CodeLlama-7B-Instruct** through a local vLLM server

## Requirements

The provided installation workflow targets Ubuntu/Debian-based Linux systems with an NVIDIA CUDA-capable GPU.

The main requirements are:

- C/C++ compiler with C++23 support
- LLVM and Clang development packages (tested with LLVM/Clang 18, including `libclang-18-dev`)
- nlohmann JSON development package (`nlohmann-json3-dev`)
- libcurl development package (`libcurl4-openssl-dev`)
- CMake 4.0 or later
- Ninja
- Git
- Curl
- Python 3.12
- NVIDIA GPU available to PyTorch
- Sufficient disk space for the local language models

The installation script uses `uv` for Python environment management and installs vLLM 0.28.0 with CUDA 12.9 support.

## Installation

Clone the repository:

```bash
git clone https://github.com/negarfathi/Nexus.git
cd Nexus
```

Run the installation script from the repository root:

```bash
./install_Nexus.sh
```

The script:

- installs the required system packages,
- installs `uv` if needed,
- creates a Python 3.12 virtual environment under `.venv/`,
- installs CMake,
- builds the Nexus executable under `cmake-build-debug/`,
- installs vLLM,
- verifies PyTorch/CUDA availability, and
- downloads GPT-OSS-20B, Qwen3-8B, and CodeLlama-7B-Instruct under `models/`.

The resulting executable is:

```text
cmake-build-debug/Nexus
```

## Execution

The repository includes C termination benchmarks from the [TermCOMP TPDB](https://github.com/TermCOMP/TPDB/tree/master/C) benchmark collection under:

```text
benchmarks/
	TPDB-master/
    	C/
    	C_Integer/
    	Complexity_C_Integer/
```

These directories contain the TermCOMP C benchmark programs used for the Nexus experiments.

Run the complete local-model evaluation from the repository root:

```bash
./run_Nexus.sh
```

The script recursively processes all `.c` files under `benchmarks/` using the three local models:

- `gpt-oss-20b`
- `Qwen3-8B`
- `CodeLlama-7B-Instruct`

For each model, `run_Nexus.sh`:

- creates a model-specific copy of the benchmark hierarchy under `experiment_results/`,
- starts the corresponding local vLLM server,
- runs Nexus on every `.c` benchmark file,
- stores the generated analysis artifacts next to each copied benchmark,
- records experiment data in `experiment_results.xlsx`,
- stops the current vLLM server, and
- continues with the next model.

The models are therefore executed one at a time rather than simultaneously.

The default experiment configuration is:

```text
timeout = 600 seconds
max syntactic refinements = 10
max semantic refinements = 10
```

Before starting a new full run, `run_Nexus.sh` recreates `experiment_results/` and removes the previous root-level `experiment_results.xlsx`.

## Custom Input Usage

Nexus can also be invoked directly on a user-provided C program:

```bash
<path/to/Nexus> <path/to/SourceCode.c> \
    llm-model=<gpt-5.6-terra|gpt-oss-20b|Qwen3-8B|CodeLlama-7B-Instruct> \
    max-syntactic-refinements=<integer> \
    max-semantic-refinements=<integer> \
    timeout=<seconds>
```

Arguments:

- `<path/to/Nexus>`: path to the Nexus executable
- `<path/to/SourceCode.c>`: path to the C source file to analyze
- `llm-model`: LLM backend used for candidate synthesis and refinement
- `max-syntactic-refinements`: maximum number of parser-feedback refinement attempts for a candidate
- `max-semantic-refinements`: maximum number of validator-feedback refinement attempts for a candidate
- `timeout`: analysis time limit in seconds

### Local Models

For local models, activate the virtual environment:

```bash
source .venv/bin/activate
```

Start exactly one vLLM server at a time.

For GPT-OSS-20B:

```bash
VLLM_USE_FLASHINFER_SAMPLER=0 \
vllm serve models/gpt-oss-20b \
    --served-model-name gpt-oss-20b \
    --reasoning-parser openai_gptoss \
    --host 127.0.0.1 \
    --port 8000
```

For Qwen3-8B:

```bash
VLLM_USE_FLASHINFER_SAMPLER=0 \
vllm serve models/Qwen3-8B \
    --served-model-name Qwen3-8B \
    --host 127.0.0.1 \
    --port 8000
```

For CodeLlama-7B-Instruct:

```bash
VLLM_USE_FLASHINFER_SAMPLER=0 \
vllm serve models/CodeLlama-7B-Instruct \
    --served-model-name CodeLlama-7B-Instruct \
    --host 127.0.0.1 \
    --port 8000
```

Then, in another terminal, set the vLLM endpoint and run Nexus:

```bash
VLLM_BASE_URL=http://127.0.0.1:8000 \
./cmake-build-debug/Nexus <path/to/SourceCode.c> \
    llm-model=gpt-oss-20b \
    max-syntactic-refinements=5 \
    max-semantic-refinements=5 \
    timeout=600
```

Replace `gpt-oss-20b` with `Qwen3-8B` or `CodeLlama-7B-Instruct` when using another local model.

### OpenAI API Model

To use `gpt-5.6-terra`, set the OpenAI API key:

```bash
export OPENAI_API_KEY=<your-api-key>
```

Then run:

```bash
./cmake-build-debug/Nexus <path/to/SourceCode.c> \
    llm-model=gpt-5.6-terra \
    max-syntactic-refinements=5 \
    max-semantic-refinements=5 \
    timeout=600
```

A local vLLM server is not required for this configuration.

## Output

Nexus produces generated analysis artifacts and an Excel summary.

### Generated Program Artifacts

For a directly analyzed program, Nexus creates a `generated/` directory next to the input source file:

```text
generated/
    <program>.inline.c
    <program>.inline.bc
    <program>.inline.ll

    loop_information/
        <loop-id>_loop_information.json

    candidates/
        <loop-id>_candidate.json

    validators/
        validate_<loop-id>.py

    refinement_feedback/
        <loop-id>_refinement_feedback.txt
```

The generated files contain the transformed source, LLVM representations, extracted loop information, synthesized candidates, validator scripts, and refinement feedback.

### Full-Run Results

When `run_Nexus.sh` is used, reproduced benchmark trees are written under:

```text
experiment_results/
    gpt-oss-20b/
    Qwen3-8B/
    CodeLlama-7B-Instruct/
```

Each model directory contains a copy of the benchmark hierarchy together with the generated Nexus artifacts for the analyzed programs.

### Excel Summary

Nexus writes the experiment summary to:

```text
experiment_results.xlsx
```

The workbook contains a separate worksheet for each LLM model.

Recorded information includes:

- program path
- total and analyzed loops
- initial verdict
- final verdict
- initial and total analysis time
- initial synthesis calls, latency, input tokens, output tokens, and cost
- syntactic-refinement calls, latency, input tokens, output tokens, and cost
- semantic-refinement calls, latency, input tokens, output tokens, and cost

The final verdict is one of:

- `terminating`
- `non-terminating`
- `unknown`
- `timeout`
- `error`

Runtime values may vary across machines and models.

## Baseline Evaluation

The repository also includes installation and execution support for the termination-analysis baselines used for comparison:

- [Athena](https://github.com/negarfathi/Athena)
- [Proton](https://github.com/kumarmadhukar/term/tree/main/proton)
- [UAutomizer](https://www.ultimate-pa.org/automizer/)
- [AProVE](https://aprove.informatik.rwth-aachen.de/)
- [CPAchecker](https://cpachecker.sosy-lab.org/)
- [2LS](https://github.com/diffblue/2LS)

Install the baselines from the repository root:

```bash
./install_baselines.sh
```

Run the baseline experiments with:

```bash
./run_baselines.sh
```

The baseline setup is isolated under `baselines/`, with per-tool installation scripts and Docker-based environments where required.