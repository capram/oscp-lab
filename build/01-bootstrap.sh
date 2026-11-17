#!/usr/bin/env bash

###############################################################################
# 01-bootstrap.sh
#
# Purpose:
#   Perform initial OSCP workstation setup.
#
# Responsibilities:
#   - Update and upgrade Kali
#   - Install core workstation software
#   - Create OSCP directory structure
#   - Verify installations
#
# Safe to re-run multiple times.
#
###############################################################################

set -euo pipefail

LOG_FILE="$HOME/oscp-bootstrap.log"

FAILED=()

###############################################################################
# Logging
###############################################################################

exec > >(tee -a "$LOG_FILE") 2>&1

echo
echo "============================================================"
echo "OSCP WORKSTATION BOOTSTRAP"
echo "============================================================"
echo

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

install_package() {

    local package="$1"

    echo
    echo "[+] Installing $package"

    if sudo apt install -y "$package"
    then
        echo "[PASS] $package installed"
    else
        echo "[FAIL] $package installation failed"
        FAILED+=("$package")
    fi
}

###############################################################################
# Update Kali
###############################################################################

echo
echo "[+] Updating package lists"

sudo apt update

echo
echo "[+] Upgrading installed packages"

sudo apt full-upgrade -y

echo
echo "[+] Cleaning unused packages"

sudo apt autoremove -y
sudo apt autoclean -y

###############################################################################
# Create OSCP Workspace
###############################################################################

echo
echo "[+] Creating OSCP workspace"

mkdir -p ~/OSCP/{

Active,

AD,

Linux,

Windows,

Scans,

Loot,

Exploits,

Tools,

Reports,

Screenshots,

Wordlists,

Notes,

venvs

}

###############################################################################
# Install Core Packages
###############################################################################

echo
echo "[+] Installing core workstation packages"

install_package git

install_package curl

install_package wget

install_package python3

install_package python3-pip

install_package python3-venv

install_package software-properties-common

install_package apt-transport-https

install_package gnupg

###############################################################################
# Install Terminator
###############################################################################

echo
echo "[+] Installing Terminator"

install_package terminator

###############################################################################
# Install Sublime Text
###############################################################################

echo
echo "[+] Installing Sublime Text"

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/sublimehq-archive.gpg >/dev/null

echo \
"deb [signed-by=/usr/share/keyrings/sublimehq-archive.gpg] https://download.sublimetext.com/ apt/stable/" | \
sudo tee /etc/apt/sources.list.d/sublime-text.list >/dev/null

sudo apt update

install_package sublime-text

###############################################################################
# Validation
###############################################################################

echo
echo "============================================================"
echo "VALIDATION"
echo "============================================================"

check_binary git

check_binary curl

check_binary wget

check_binary python3

check_binary pip3

check_binary terminator

check_binary subl

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
    echo "[SUCCESS] Bootstrap completed successfully."
else
    echo
    echo "[WARNING] Some items require attention:"
    printf ' - %s\n' "${FAILED[@]}"
fi

echo
echo "Workspace location:"
echo "    ~/OSCP"

echo
echo "Build log saved to:"
echo "    $LOG_FILE"

echo
echo "Next step:"
echo "    ./build/02-toolkit.sh"

echo
