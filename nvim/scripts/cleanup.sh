#!/bin/bash

set -e

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}[RUNNING NEOVIM CLEANUP SCRIPT - ARCH LINUX]${NC}"
echo -e "${YELLOW}=== REMOVING PACKAGES INSTALLED FOR NEOVIM ===${NC}"

echo -e "${YELLOW}Removing Neovim...${NC}"
sudo pacman -Rns neovim

echo -e "${YELLOW}Removing C/C++ tools (base-devel, clang)...${NC}"
sudo pacman -Rns base-devel clang

echo -e "${YELLOW}Removing Java (jdk17-openjdk)...${NC}"
sudo pacman -Rns jdk17-openjdk

echo -e "${YELLOW}Removing Lua...${NC}"
sudo pacman -Rns lua

echo -e "${YELLOW}Removing Go...${NC}"
sudo pacman -Rns go

echo -e "${YELLOW}Removing Python (python, pip)...${NC}"
sudo pacman -Rns python python-pip

if [ -d "$HOME/.cargo" ] || [ -d "$HOME/.rustup" ]; then
    echo -e "${YELLOW}Removing Rust (rustup, cargo)...${NC}"
    rustup self uninstall -y || true
    rm -rf "$HOME/.cargo" "$HOME/.rustup"
fi

echo -e "${YELLOW}Removing Node.js and npm...${NC}"
sudo pacman -Rns nodejs npm
rm -rf ~/.npm
sudo rm -rf /usr/lib/node_modules

echo -e "${YELLOW}Removing Git...${NC}"
sudo pacman -Rns git

echo -e "${YELLOW}Removing Ripgrep...${NC}"
sudo pacman -Rns ripgrep

echo -e "${YELLOW}Cleaning unused dependencies...${NC}"
if pacman -Qdtq &>/dev/null; then
    sudo pacman -Rns $(pacman -Qdtq)
fi

echo -e "${YELLOW}Cleaning package cache...${NC}"
sudo pacman -Sc

echo -e "${YELLOW}Removing Neovim configuration...${NC}"
rm -rf "$HOME/.cache/nvim"
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.config/nvim"

echo -e "${GREEN}[CLEANUP COMPLETE]${NC}"
