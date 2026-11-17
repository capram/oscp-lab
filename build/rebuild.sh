#!/usr/bin/env bash

###############################################################################
# rebuild.sh
#
# Purpose:
#   Master OSCP workstation deployment script.
#
# Executes:
#       01-bootstrap.sh
#       02-toolkit.sh
#       03-python-toolkit.sh
#
# This script should be the only script a user needs to run after
# cloning the repository.
#
###############################################################################

set -euo pipefail

###############################################################################
# Variables
###############################################################################

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LOG_FILE="$HOME/oscp-rebuild.log"

FAILED=()

###############################################################################
# Logging
###############################################################################

exec > >(tee -a "$LOG_FILE") 2>&1

echo
echo "============================================================"
echo "OSCP LAB WORKSTATION BUILD"
echo "============================================================"
echo

echo "Start Time:"
date

echo
echo "Build Directory:"
echo "$BUILD_DIR"

###############################################################################
# Validation
###############################################################################

echo
echo "[+] Validating required scripts"

REQUIRED_SCRIPTS=(
    "01-bootstrap.sh"
    "02-toolkit.sh"
    "03-python-toolkit.sh"
)

for script in "${REQUIRED_SCRIPTS[@]}"
do

    if [ -f "$BUILD_DIR/$script" ]
    then
        echo "[PASS] $script found"
    else
        echo "[FAIL] $script missing"
        exit 1
    fi

done

###############################################################################
# Ensure executable permissions
###############################################################################

echo
echo "[+] Setting executable permissions"

chmod +x "$BUILD_DIR"/*.sh

###############################################################################
# Execution Helper
###############################################################################

run_stage() {

    local script="$1"

    echo
    echo "============================================================"
    echo "RUNNING: $script"
    echo "============================================================"

    if bash "$BUILD_DIR/$script"
    then

        echo
        echo "[PASS] $script completed"

    else

        echo
        echo "[FAIL] $script"

        FAILED+=("$script")

    fi
}

###############################################################################
# Run Stages
###############################################################################

run_stage "01-bootstrap.sh"

run_stage "02-toolkit.sh"

run_stage "03-python-toolkit.sh"

###############################################################################
# Summary
###############################################################################

echo
echo "============================================================"
echo "BUILD SUMMARY"
echo "============================================================"

if [ ${#FAILED[@]} -eq 0 ]
then

    echo
    echo "[SUCCESS] OSCP workstation build complete."

else

    echo
    echo "[WARNING] Some stages failed."

    printf ' - %s\n' "${FAILED[@]}"

fi

echo
echo "Completion Time:"
date

echo
echo "Build Log:"
echo "$LOG_FILE"

echo
echo "Next Steps:"
echo
echo "1. Open a new terminal"
echo "2. Run: source ~/.bashrc"
echo "3. Run: oscpad"
echo "4. Verify nxc works"
echo

echo "[BUILD COMPLETE]"
