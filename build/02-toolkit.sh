#!/usr/bin/env bash

###############################################################################
# 02-toolkit.sh
#
# Purpose:
#   Install common OSCP tooling and repositories.
#
# Safe to run multiple times.
#
###############################################################################

set -euo pipefail

TOOLS_DIR="$HOME/OSCP/Tools"

FAILED=()

###############################################################################
# Helper Functions
###############################################################################

check_binary() {

    local binary="$1"

    if command -v "$binary" >/dev/null 2>&1
    then
        echo "[PASS] $binary"
    else
        echo "[FAIL] $binary"
        FAILED+=("$binary")
    fi
}

check_directory() {

    local dir="$1"

    if [ -d "$dir" ]
    then
        echo "[PASS] $(basename "$dir")"
    else
        echo "[FAIL] $(basename "$dir")"
        FAILED+=("$(basename "$dir")")
    fi
}

clone_repo() {

    local repo="$1"
    local name="$2"

    if [ -d "$TOOLS_DIR/$name" ]
    then
        echo "[*] $name already exists"

        git -C "$TOOLS_DIR/$name" pull || true
    else
        git clone "$repo" "$TOOLS_DIR/$name"
    fi
}

###############################################################################
# Tool Directories
###############################################################################

echo
echo "[+] Creating tool directories"

mkdir -p "$TOOLS_DIR"

###############################################################################
# Package Installation
###############################################################################

echo
echo "[+] Installing packages"

sudo apt update

sudo apt install -y \
    feroxbuster \
    ffuf \
    gobuster \
    enum4linux-ng \
    responder \
    seclists \
    autorecon

###############################################################################
# Clone Repositories
###############################################################################

echo
echo "[+] Cloning repositories"

clone_repo \
https://github.com/carlospolop/PEASS-ng.git \
PEASS-ng

clone_repo \
https://github.com/swisskyrepo/PayloadsAllTheThings.git \
PayloadsAllTheThings

clone_repo \
https://github.com/HackTricks-wiki/hacktricks.git \
HackTricks

clone_repo \
https://github.com/DominicBreuker/pspy.git \
pspy

clone_repo \
https://github.com/rebootuser/LinEnum.git \
LinEnum

###############################################################################
# Wordlists
###############################################################################

echo
echo "[+] Creating SecLists symlink"

mkdir -p "$HOME/OSCP/Wordlists"

if [ -d "/usr/share/seclists" ]
then

    ln -snf \
    /usr/share/seclists \
    "$HOME/OSCP/Wordlists/SecLists"

fi

###############################################################################
# Validation
###############################################################################

echo
echo "============================================================"
echo "VALIDATION"
echo "============================================================"

check_binary feroxbuster

check_binary ffuf

check_binary gobuster

check_binary responder

check_binary autorecon

check_directory "$TOOLS_DIR/PEASS-ng"

check_directory "$TOOLS_DIR/PayloadsAllTheThings"

check_directory "$TOOLS_DIR/HackTricks"

check_directory "$TOOLS_DIR/pspy"

check_directory "$TOOLS_DIR/LinEnum"

###############################################################################
# Summary
###############################################################################

echo
echo "============================================================"
echo "SUMMARY"
echo "============================================================"

if [ ${#FAILED[@]} -eq 0 ]
then

    echo
    echo "[SUCCESS] Toolkit installation complete."

else

    echo
    echo "[WARNING] The following items require attention:"

    printf ' - %s\n' "${FAILED[@]}"

fi

echo
echo "Tools installed to:"
echo "    $TOOLS_DIR"

echo
echo "Next step:"
echo "    ./build/03-python-toolkit.sh"

echo
