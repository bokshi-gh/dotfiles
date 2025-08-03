#!/bin/bash

set -e

echo "=== Updating system ==="
sudo apt update && sudo apt upgrade -y

echo "=== Installing build tools (C/C++) ==="
sudo apt install -y build-essential clang

echo "=== Installing Java (JDK 17) ==="
sudo apt install -y openjdk-17-jdk

echo "=== Installing Lua ==="
sudo apt install -y lua5.4

echo "=== Installing Go ==="
sudo apt install -y golang

echo "=== Installing Python ==="
sudo apt install -y python3 python3-pip

echo "=== Installing Rust (via rustup) ==="
if ! command -v rustc &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

echo "=== Installing Node.js and npm ==="
sudo apt install -y nodejs npm
# Ensure latest Node if distro version is old
if [ "$(node -v | cut -d. -f1 | tr -d v)" -lt 18 ]; then
  echo "Node.js is old, installing latest via NodeSource..."
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt install -y nodejs
fi

echo "=== Installing Git (required for Lazy.nvim) ==="
sudo apt install -y git

echo "=== Installing Neovim (stable) ==="
sudo apt install -y neovim

echo "=== All dependencies installed! ==="
echo "Next steps:"
echo "1. Open Neovim and run :Lazy sync"
echo "2. Run :Mason to confirm LSP servers & formatters installed"
