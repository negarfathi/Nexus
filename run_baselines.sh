#!/bin/bash

root_directory="$(cd "$(dirname "$0")" && pwd)"

baselines_directory="$root_directory/baselines"
benchmarks_directory="$root_directory/benchmarks"
results_directory="$root_directory/experiment_results_baselines"
excel_file="$root_directory/experiment_results_baselines.xlsx"

timeout=600

llvm2kittel_image="llvm2kittel"
llvm2kittel_directory="$baselines_directory/Athena/llvm2kittel"
muval_image="coar"
proton_image="proton"
uautomizer_image="uautomizer"
aprove_image="aprove"
cpachecker_image="cpachecker"
twols_image="2ls"

if [[ ! -d "$benchmarks_directory" ]]; then
    echo "Benchmarks folder not found: $benchmarks_directory"
    exit 1
fi

if [[ ! -d "$llvm2kittel_directory" ]]; then
    echo "llvm2KITTeL folder not found: $llvm2kittel_directory"
    exit 1
fi

if ! python3 -c "import openpyxl" >/dev/null 2>&1; then
    echo "Python package openpyxl is required."
    echo "Install it with: sudo apt install python3-openpyxl"
    exit 1
fi

rm -rf "$results_directory"

mkdir -p \
    "$results_directory/Athena" \
    "$results_directory/PROTON" \
    "$results_directory/UAutomizer" \
    "$results_directory/AProVE" \
    "$results_directory/CPAchecker" \
    "$results_directory/2LS"

cp -r "$benchmarks_directory"/. "$results_directory/Athena/"
cp -r "$benchmarks_directory"/. "$results_directory/PROTON/"
cp -r "$benchmarks_directory"/. "$results_directory/UAutomizer/"
cp -r "$benchmarks_directory"/. "$results_directory/AProVE/"
cp -r "$benchmarks_directory"/. "$results_directory/CPAchecker/"
cp -r "$benchmarks_directory"/. "$results_directory/2LS/"

python3 - "$excel_file" <<'PY'
import sys
from openpyxl import Workbook
from openpyxl.styles import Alignment, Font, PatternFill

excel_file = sys.argv[1]

baselines = ["Athena", "PROTON", "UAutomizer", "AProVE", "CPAchecker", "2LS"]

wb = Workbook()
wb.remove(wb.active)

for baseline in baselines:
    ws = wb.create_sheet(baseline)
    ws.append(["Program", "Output", "Runtime (ms)"])
    for cell in ws[1]:
        cell.font = Font(bold=True, color="FFFFFF")
        cell.fill = PatternFill("solid", fgColor="1F4E78")
        cell.alignment = Alignment(horizontal="center")
    ws.freeze_panes = "A2"
    ws.column_dimensions["A"].width = 70
    ws.column_dimensions["B"].width = 100
    ws.column_dimensions["C"].width = 18

wb.save(excel_file)
PY

update_excel() {
    relative_path="$1"
    python3 - "$results_directory" "$excel_file" "$relative_path" <<'PY'
import re
import sys
from pathlib import Path
from openpyxl import load_workbook
from openpyxl.styles import Alignment

results = Path(sys.argv[1])
excel_file = Path(sys.argv[2])
relative_path = Path(sys.argv[3])

baselines = ["Athena", "PROTON", "UAutomizer", "AProVE", "CPAchecker", "2LS"]

def parse_result(baseline, text):
    lines = [line.strip() for line in text.splitlines() if line.strip()]
    if any(line.upper() == "TIMEOUT" for line in lines):
        return "TIMEOUT"
    if baseline == "Athena":
        pattern = re.compile(r"^(YES|NO|MAYBE|TIMEOUT|ERROR)$", re.I)
        for line in reversed(lines):
            if pattern.fullmatch(line):
                return line
        return "ERROR"
    if baseline == "PROTON":
        pattern = re.compile(r"^(TRUE|FALSE\(termination\)|INCONCLUSIVE|Terminated|INTERNAL-ERROR)$", re.I)
        for line in reversed(lines):
            if pattern.fullmatch(line):
                return line
        return "ERROR"
    if baseline == "UAutomizer":
        result = ""
        for i in range(len(lines) - 1, -1, -1):
            if lines[i].startswith("Result:") and i + 1 < len(lines):
                result = lines[i + 1]
                break
        if result == "FALSE(TERM)":
            result = "FALSE"
        if not result or "ERROR" in result:
            result = "Error"
        return result
    if baseline == "AProVE":
        pattern = re.compile(r"^(YES|NO|MAYBE|TIMEOUT|ERROR)$", re.I)
        for line in lines:
            if pattern.fullmatch(line):
                return line
        return "ERROR"
    if baseline == "CPAchecker":
        pattern = re.compile(r"Verification result:\s*([^.,]+)[.,]", re.I)
        for line in reversed(lines):
            match = pattern.search(line)
            if match:
                return match.group(1).strip()
        return "ERROR"
    if baseline == "2LS":
        pattern = re.compile(r"\[main\]:\s*([A-Za-z]+)", re.I)
        for line in reversed(lines):
            match = pattern.search(line)
            if match:
                return match.group(1)
        return "error"
    return "ERROR"

def parse_runtime(text):
    lines = [line.strip() for line in text.splitlines() if line.strip()]
    for line in reversed(lines):
        if "Runtime:" in line:
            match = re.search(r"([0-9]+)", line)
            if match:
                return int(match.group(1))
            break
    return None

wb = load_workbook(excel_file)

for baseline in baselines:
    ws = wb[baseline]
    output_file = results / baseline / relative_path.parent / f"{relative_path.stem}.txt"
    if output_file.exists():
        text = output_file.read_text(encoding="utf-8", errors="replace")
        output = parse_result(baseline, text)
        runtime = parse_runtime(text)
    else:
        output = "MISSING OUTPUT"
        runtime = None
    ws.append([relative_path.as_posix(), output, runtime])
    row = ws.max_row
    ws.cell(row, 1).alignment = Alignment(vertical="top")
    ws.cell(row, 2).alignment = Alignment(vertical="top")
    ws.cell(row, 3).alignment = Alignment(vertical="top")

wb.save(excel_file)
PY
}

find "$benchmarks_directory" -type f -name "*.c" | sort | while read -r source_code; do
    relative_path="${source_code#$benchmarks_directory/}"
    relative_directory="$(dirname "$relative_path")"
    filename="$(basename "$relative_path")"
    stem="${filename%.c}"

    echo
    echo "$relative_path"

    echo "Athena is running..."
    result_directory="$results_directory/Athena/$relative_directory"
    output_file="$result_directory/${stem}.txt"
    start_time=$(date +%s%N)
    docker run --rm \
        -v "$result_directory:/liveness_analysis" \
        -v "$llvm2kittel_directory:/liveness_analysis/llvm2kittel" \
        "$llvm2kittel_image" \
        /bin/bash -c "
            cd /liveness_analysis &&
            clang -Wall -Wextra -g -c -emit-llvm -O0 '$filename' -o '${stem}.bc' &&
            /liveness_analysis/llvm2kittel/build/llvm2kittel \
                --signedness-info=false \
                --unreachable-exit=true \
                --dump-ll \
                --no-slicing \
                --eager-inline \
                --t2 '${stem}.bc' > '${stem}.t2'
        " > "$output_file" 2>&1
    llvm_exit=$?
    if [[ $llvm_exit -eq 0 && -s "$result_directory/${stem}.t2" ]]; then
        docker run --rm \
            -v "$result_directory:/liveness_analysis" \
            "$muval_image" \
            /bin/bash -c "
                cd /root/coar &&
                timeout $timeout ./main.exe \
                    -c ./config/solver/muval_parallel_exc_tbq_ar.json \
                    -p ltsterm \
                    '/liveness_analysis/${stem}.t2'
            " >> "$output_file" 2>&1
        exit_code=$?
    else
        echo "llvm2KITTeL failed." >> "$output_file"
        exit_code=$llvm_exit
    fi
    if [[ $exit_code -eq 124 ]]; then
        echo "TIMEOUT" >> "$output_file"
    fi
    end_time=$(date +%s%N)
    elapsed_time=$(((end_time - start_time) / 1000000))
    echo "Runtime: $elapsed_time milliseconds" >> "$output_file"

    echo "PROTON is running..."
    result_directory="$results_directory/PROTON/$relative_directory"
    output_file="$result_directory/${stem}.txt"
    start_time=$(date +%s%N)
    docker run --rm --platform linux/amd64 \
        -v "$result_directory:/WORK" \
        -w /opt/term/proton \
        "$proton_image" \
        bash -lc "
            timeout $timeout ./proton --64 \
                --propertyFile /opt/term/proton/termination.prp \
                --graphml-witness 'witness.graphml' \
                '/WORK/$filename'
        " > "$output_file" 2>&1
    exit_code=$?
    if [[ $exit_code -eq 124 ]]; then
        echo "TIMEOUT" >> "$output_file"
    fi
    end_time=$(date +%s%N)
    elapsed_time=$(((end_time - start_time) / 1000000))
    echo "Runtime: $elapsed_time milliseconds" >> "$output_file"

    echo "UAutomizer is running..."
    result_directory="$results_directory/UAutomizer/$relative_directory"
    output_file="$result_directory/${stem}.txt"
    start_time=$(date +%s%N)
    docker run --rm \
        -v "$baselines_directory:/BASELINE_DIR" \
        -v "$result_directory:/FILES_DIR" \
        -w /opt/uautomizer/UAutomizer-linux \
        "$uautomizer_image" \
        /bin/bash -c "
            timeout $timeout \
                python3 ./Ultimate.py \
                --spec /BASELINE_DIR/UAutomizer/termination.prp \
                --file '/FILES_DIR/$filename' \
                --architecture 64bit
        " > "$output_file" 2>&1
    exit_code=$?
    if [[ $exit_code -eq 124 ]]; then
        echo "TIMEOUT" >> "$output_file"
    fi
    end_time=$(date +%s%N)
    elapsed_time=$(((end_time - start_time) / 1000000))
    echo "Runtime: $elapsed_time milliseconds" >> "$output_file"

    echo "AProVE is running..."
    result_directory="$results_directory/AProVE/$relative_directory"
    output_file="$result_directory/${stem}.txt"
    start_time=$(date +%s%N)
    docker run --rm --platform linux/amd64 \
        --entrypoint /bin/bash \
        -v "$result_directory:/liveness_analysis" \
        "$aprove_image" \
        -c "
            cd /liveness_analysis &&
            timeout $timeout \
                /aprove/AProVE.sh \
                -m wst \
                --bit-width 64 \
                '$filename'
        " > "$output_file" 2>&1
    exit_code=$?
    if [[ $exit_code -eq 124 ]]; then
        echo "TIMEOUT" >> "$output_file"
    fi
    end_time=$(date +%s%N)
    elapsed_time=$(((end_time - start_time) / 1000000))
    echo "Runtime: $elapsed_time milliseconds" >> "$output_file"

    echo "CPAchecker is running..."
    result_directory="$results_directory/CPAchecker/$relative_directory"
    output_file="$result_directory/${stem}.txt"
    start_time=$(date +%s%N)
    docker run --rm \
        --entrypoint /bin/bash \
        -v "$result_directory:/liveness_analysis" \
        "$cpachecker_image" \
        -c "
            cd /liveness_analysis &&
            timeout $timeout \
                /cpachecker/scripts/cpa.sh \
                --config /cpachecker/config/terminationAnalysis.properties \
                --preprocess \
                --heap 10000M \
                --64 \
                --stats \
                '$filename'
        " > "$output_file" 2>&1
    exit_code=$?
    if [[ $exit_code -eq 124 ]]; then
        echo "TIMEOUT" >> "$output_file"
    fi
    end_time=$(date +%s%N)
    elapsed_time=$(((end_time - start_time) / 1000000))
    echo "Runtime: $elapsed_time milliseconds" >> "$output_file"

    echo "2LS is running..."
    result_directory="$results_directory/2LS/$relative_directory"
    output_file="$result_directory/${stem}.txt"
    start_time=$(date +%s%N)
    docker run --rm \
        -v "$result_directory:/liveness_analysis" \
        "$twols_image" \
        /bin/bash -c "
            cd /liveness_analysis &&
            timeout $timeout \
                /root/2ls/src/2ls/2ls \
                --graphml-witness '${filename}.witness.graphml' \
                --termination \
                --64 \
                '$filename'
        " > "$output_file" 2>&1
    exit_code=$?
    if [[ $exit_code -eq 124 ]]; then
        echo "TIMEOUT" >> "$output_file"
    fi
    end_time=$(date +%s%N)
    elapsed_time=$(((end_time - start_time) / 1000000))
    echo "Runtime: $elapsed_time milliseconds" >> "$output_file"

    update_excel "$relative_path"
    echo "Excel updated."
done

echo
echo "Finished."
echo "Results: $results_directory"
echo "Excel: $excel_file"