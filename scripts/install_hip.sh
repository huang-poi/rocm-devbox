#!/bin/bash
set -euo pipefail
echo "=== HIP SDK Setup ==="

# Check ROCm
if ! command -v hipcc &> /dev/null; then
    echo "ROCm not found. Run install_rocm.sh first."
    exit 1
fi

# Install HIP development tools
sudo apt install -y hip-dev hip-doc hip-samples

# Set HIP platform
export HIP_PLATFORM=amd
echo 'export HIP_PLATFORM=amd' >> ~/.bashrc

# Verify
echo "HIP version: $(hipcc --version 2>/dev/null || echo 'unknown')"
echo "HIP path: $(which hipcc)"
echo "=== HIP SDK Ready ==="
