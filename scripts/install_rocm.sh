#!/bin/bash
set -euo pipefail

# ROCm Installation Script for Ubuntu 22.04/24.04
# Supports: MI300X, MI250X, MI210, RX 7900 series

echo "=== ROCm Installation Script ==="
echo "Detected OS: $(lsb_release -ds 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME)"

# Check for existing ROCm
if command -v rocm-smi &> /dev/null; then
    echo "ROCm already installed: $(rocm-smi --version 2>/dev/null || echo 'unknown version')"
    read -p "Reinstall? (y/n) " -n 1 -r
    echo
    [[ ! $REPLY =~ ^[Yy]$ ]] && exit 0
fi

# Add ROCm repository
sudo mkdir -p --mode=0755 /etc/apt/keyrings
wget -q -O - https://repo.radeon.com/rocm/rocm.gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/rocm.gpg > /dev/null

CODENAME=$(lsb_release -cs)
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/rocm/apt/6.2 ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/rocm.list

sudo apt update
sudo apt install -y rocm-hip-sdk rocm-libs rocm-dev rocm-utils

# Add user to render and video groups
sudo usermod -aG render,video $USER

# Set environment
echo 'export PATH=/opt/rocm/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/opt/rocm/lib:$LD_LIBRARY_PATH' >> ~/.bashrc

echo ""
echo "=== Installation Complete ==="
echo "Please reboot or run: newgrp render"
echo "Verify: rocm-smi"
