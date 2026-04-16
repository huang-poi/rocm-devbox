# rocm-devbox

ROCm development environment setup, container configs, and tooling for AMD GPU development.

## What's Included

### Container Configs
- `docker/` — Dockerfiles for ROCm 6.0, 6.1, 6.2
- `singularity/` — HPC container definitions
- `devcontainer/` — VS Code devcontainer configs

### Setup Scripts
- `scripts/install_rocm.sh` — ROCm installation for Ubuntu/RHEL
- `scripts/install_hip.sh` — HIP SDK setup
- `scripts/setup_pytorch.sh` — PyTorch + ROCm
- `scripts/setup_tensorflow.sh` — TensorFlow + ROCm
- `scripts/setup_jax.sh` — JAX + ROCm

### Development Tools
- `dotfiles/` — Editor configs, clang-format, shell profiles
- `vscode/` — VS Code settings for HIP/CUDA development
- `clang-tidy/` — Custom checks for HIP code patterns

### CI/CD
- `.github/workflows/` — GitHub Actions for ROCm builds
- `jenkins/` — Jenkins pipeline templates

## Quick Start

```bash
# One-liner ROCm + tools install for Ubuntu 22.04
curl -sSL https://raw.githubusercontent.com/huang-poi/rocm-devbox/main/scripts/install_rocm.sh | bash

# Docker development environment
docker build -t rocm-dev -f docker/Dockerfile.rocm6.2 .
docker run --device=/dev/kfd --device=/dev/dri --group-add video rocm-dev

# VS Code devcontainer
code --folder-uri vscode-remote://devcontainer+$(pwd)/devcontainer
```

## ROCm Version Matrix

| ROCm | Ubuntu | Kernel | GPU Support |
|------|--------|--------|-------------|
| 6.2  | 22.04/24.04 | 6.5+ | MI300X, MI250X, MI210 |
| 6.1  | 22.04 | 6.2+ | MI300X, MI250X, MI210, RX7900 |
| 6.0  | 22.04 | 5.19+ | MI250X, MI210, RX7900 |

## Related Projects

Part of the [ROCm Developer Toolkit](https://github.com/huang-poi) ecosystem.

## License

MIT
