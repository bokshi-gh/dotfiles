#!/bin/bash
set -e

# ANSI colors
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${YELLOW}[🧹 Cleaning up installed tools...]${NC}"

echo -e "${YELLOW}Removing Rust toolchain...${NC}"
if command -v rustup &>/dev/null; then
  rustup self uninstall -y || true
fi
rm -rf "$HOME/.cargo" "$HOME/.rustup"

echo -e "${YELLOW}Removing npm global packages prettier and eslint...${NC}"
npm uninstall -g prettier eslint || true

echo -e "${YELLOW}Removing Python user package black...${NC}"
pip3 uninstall -y black || true

echo -e "${YELLOW}Removing Neovim config, cache, and data directories...${NC}"
rm -rf "$HOME/.config/nvim"
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.cache/nvim"

echo -e "${YELLOW}Removing Java language server...${NC}"
rm -rf "$HOME/.local/share/eclipse.jdt.ls"


echo -e "${YELLOW}Removing system packages...${NC}"
sudo apt remove --purge -y \
  curl wget unzip software-properties-common \
  clang-format clang-tools clang clang-tidy \
  nodejs npm openjdk-11-jdk shellcheck chktex python3-pip flake8 ripgrep golang-go || true

echo -e "${YELLOW}Removing orphaned packages...${NC}"
sudo apt autoremove

# Be cautious removing python3 itself; usually not recommended
# echo -e "${YELLOW}Removing python3 (not recommended)...${NC}"
# sudo apt remove --purge -y python3 || true


echo -e "${GREEN}[✅ Cleanup complete!]${NC}"
