#!/bin/bash
set -euo pipefail
echo "=== PyTorch + ROCm Setup ==="

# Install PyTorch with ROCm support
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.2

# Verify GPU
python3 -c "
import torch
print(f'PyTorch: {torch.__version__}')
print(f'ROCm: {torch.version.hip}')
print(f'GPU available: {torch.cuda.is_available()}')
if torch.cuda.is_available():
    print(f'GPU count: {torch.cuda.device_count()}')
    for i in range(torch.cuda.device_count()):
        print(f'GPU {i}: {torch.cuda.get_device_name(i)}')
    # Quick benchmark
    x = torch.randn(4096, 4096, device='cuda')
    y = torch.randn(4096, 4096, device='cuda')
    import time
    start = time.time()
    for _ in range(100):
        z = torch.mm(x, y)
    torch.cuda.synchronize()
    elapsed = time.time() - start
    flops = 2 * 4096**3 * 100 / elapsed
    print(f'GEMM perf: {flops/1e12:.1f} TFLOPS')
"
echo "=== PyTorch + ROCm Ready ==="
