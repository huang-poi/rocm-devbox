#!/bin/bash
echo "=== ROCm Installation Verification ==="
echo ""

echo "1. ROCm Version:"
rocm-smi --version 2>/dev/null || echo "  rocm-smi not found"

echo ""
echo "2. GPU Detection:"
rocm-smi --showproductname 2>/dev/null || echo "  No GPUs detected"

echo ""
echo "3. HIP Compiler:"
hipcc --version 2>/dev/null || echo "  hipcc not found"

echo ""
echo "4. Kernel Module:"
lsmod | grep -i amdgpu || echo "  amdgpu module not loaded"

echo ""
echo "5. Device Files:"
ls -la /dev/kfd /dev/dri/ 2>/dev/null || echo "  Device files not found"

echo ""
echo "6. Python + PyTorch:"
python3 -c "import torch; print(f'  PyTorch {torch.__version__}, GPU: {torch.cuda.is_available()}')" 2>/dev/null || echo "  PyTorch not installed"

echo ""
echo "7. Environment:"
echo "  ROCM_PATH=$ROCM_PATH"
echo "  PATH includes: $(echo $PATH | tr ':' '\n' | grep -i rocm)"
