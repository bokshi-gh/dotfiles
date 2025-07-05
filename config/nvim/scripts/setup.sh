#!/bin/bash
set -e

# ANSI color codes
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}[🔄 Updating package list...]${NC}"
sudo apt update

echo -e "${GREEN}[📦 Installing system packages...]${NC}"
sudo apt install -y \
  curl unzip \
  clang-format clang-tools clang clang-tidy \
  nodejs npm openjdk-11-jdk shellcheck chktex python3 python3-pip flake8 ripgrep golang-go

echo -e "${GREEN}[🦀 Installing Rust toolchain...]${NC}"
if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi
rustup default stable
rustup component add rustfmt

echo -e "${GREEN}[📦 Installing npm packages: prettier, eslint]${NC}"
npm install -g prettier eslint

echo -e "${GREEN}[🐍 Installing Python packages: black]${NC}"
pip3 install --user black

echo -e "${GREEN}[☕ Installing Java language server (Eclipse JDT LS)]${NC}"
JDTLS_DIR="$HOME/.local/share/eclipse.jdt.ls"
if [ ! -d "$JDTLS_DIR" ]; then
  mkdir -p "$JDTLS_DIR"
  curl -L -o /tmp/jdtls.tar.gz https://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz
  tar -xzf /tmp/jdtls.tar.gz -C "$JDTLS_DIR" --strip-components=1
  rm /tmp/jdtls.tar.gz
fi

echo -e "${GREEN}[✅ All tools installed!]${NC}"
