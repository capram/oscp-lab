#!/usr/bin/env bash

###############################################################################
# 03-python-toolkit.sh
#
# Purpose:
#   Create the primary Active Directory Python environment used for:
#
#   - NetExec
#   - Impacket
#   - BloodHound
#   - Certipy
#   - LDAP enumeration
#
###############################################################################

set -euo pipefail

VENV_DIR="$HOME/OSCP/venvs/ad"

FAILED=()

###############################################################################
# Helper Functions
###############################################################################

check_tool() {

    local tool="$1"

    if command -v "$tool" >/dev/null 2>&1
    then
        echo "[PASS] $tool"
    else
        echo "[FAIL] $tool"
        FAILED+=("$tool")
    fi
}

###############################################################################
# Install Dependencies
###############################################################################

echo
echo "[+] Installing Python requirements"

sudo apt update

sudo apt install -y \
    python3 \
    python3-pip \
    python3-venv

###############################################################################
# Create Venv
###############################################################################

if [ ! -d "$VENV_DIR" ]
then

    echo
    echo "[+] Creating AD virtual environment"

    python3 -m venv "$VENV_DIR"

else

    echo
    echo "[*] Existing AD environment found"

fi

###############################################################################
# Activate Venv
###############################################################################

echo
echo "[+] Activating environment"

# shellcheck disable=SC1091

source "$VENV_DIR/bin/activate"

###############################################################################
# Upgrade Pip
###############################################################################

echo
echo "[+] Upgrading pip"

python -m pip install --upgrade \
    pip \
    setuptools \
    wheel

###############################################################################
# Install Toolset
###############################################################################

echo
echo "[+] Installing Active Directory tools"

TOOLS=(
    netexec
    impacket
    bloodhound-python
    certipy-ad
    ldapdomaindump
    coercer
    pypykatz
)

for tool in "${TOOLS[@]}"
do

    echo
    echo "[*] Installing $tool"

    if ! pip install "$tool"
    then
        FAILED+=("$tool")
    fi

done

###############################################################################
# Configure Aliases
###############################################################################

echo
echo "[+] Configuring shell aliases"

ALIASES_FILE="$HOME/.bash_aliases"

touch "$ALIASES_FILE"

grep -q "alias oscpad=" "$ALIASES_FILE" || \
echo "alias oscpad='source ~/OSCP/venvs/ad/bin/activate'" \
>> "$ALIASES_FILE"

grep -q "alias oscpexit=" "$ALIASES_FILE" || \
echo "alias oscpexit='deactivate'" \
>> "$ALIASES_FILE"

grep -q "alias update-oscp-tools=" "$ALIASES_FILE" || \
echo "alias update-oscp-tools='source ~/OSCP/venvs/ad/bin/activate && pip install --upgrade netexec impacket bloodhound-python certipy-ad ldapdomaindump coercer pypykatz'" \
>> "$ALIASES_FILE"

###############################################################################
# Validation
###############################################################################

echo
echo "========================================================"
echo "VALIDATION"
echo "========================================================"

check_tool python

check_tool pip

check_tool nxc

check_tool certipy

check_tool bloodhound-python

###############################################################################
# Summary
###############################################################################

echo
echo "========================================================"
echo "SUMMARY"
echo "========================================================"

if [ ${#FAILED[@]} -eq 0 ]
then

    echo
    echo "[SUCCESS] Python AD environment ready."

else

    echo
    echo "[WARNING] Some components require attention:"

    printf ' - %s\n' "${FAILED[@]}"

fi

echo
echo "Environment location:"
echo "    $VENV_DIR"

echo
echo "Activate using:"
echo
echo "    oscpad"

echo
echo "Deactivate using:"
echo
echo "    oscpexit"

echo
echo "Update tools later with:"
echo
echo "    update-oscp-tools"

echo
echo "Next step:"
echo "    ./build/04-obsidian.sh"

echo
