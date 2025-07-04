#!/bin/bash

set -e  # Exit immediately on error

echo "🔧 Updating package list..."
sudo apt update

echo "📦 Installing system dependencies..."
sudo apt install -y unzip curl wget git software-properties-common \
  clang-format clang-tools clang clang-tidy \
  nodejs npm openjdk-11-jdk shellcheck chktex python3 flake8 ripgrep

# ------------------------------------
# 📝 Install Neovim (AppImage method)
# ------------------------------------
echo "📝 Installing Neovim..."
if ! command -v nvim &>/dev/null; then
  mkdir -p ~/.local/bin
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  mv nvim.appimage ~/.local/bin/nvim

  # Add to PATH if not already
  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.profile
  fi
else
  echo "✅ Neovim is already installed"
fi

# ------------------------------------
# 📦 Fix npm global install permissions
# ------------------------------------
echo "📦 Fixing npm global install permissions..."
mkdir -p "$HOME/.npm-global"
npm config set prefix "$HOME/.npm-global"
export PATH="$HOME/.npm-global/bin:$PATH"
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.profile

echo "🧹 Installing JavaScript/TypeScript formatters and linters..."
npm install -g eslint prettier

# ------------------------------------
# 🦀 Install Rust toolchain
# ------------------------------------
echo "🦀 Installing Rust toolchain..."
if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

# Ensure cargo bin is in PATH
export PATH="$HOME/.cargo/bin:$PATH"
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.profile

# Set default toolchain to stable
rustup default stable

echo "🧰 Adding rustfmt..."
rustup component add rustfmt

# ------------------------------------
# ✅ Finalization
# ------------------------------------
echo "✅ All development tools and dependencies installed successfully."

# Load updated paths for this session
source ~/.profile || true
