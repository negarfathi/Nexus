#!/bin/bash

set -Eeuo pipefail

root_directory="$(cd "$(dirname "$0")" && pwd)"
baselines_directory="$root_directory/baselines"

echo "Installing baselines..."

bash "$baselines_directory/Athena/install_llvm2KITTeL.sh"
bash "$baselines_directory/Athena/install_MuVal.sh"
bash "$baselines_directory/PROTON/install_PROTON.sh"
bash "$baselines_directory/UAutomizer/install_UAutomizer.sh"
bash "$baselines_directory/AProVE/install_AProVE.sh"
bash "$baselines_directory/CPAchecker/install_CPAchecker.sh"
bash "$baselines_directory/2LS/install_2LS.sh"

echo
echo "All baselines successfully installed."