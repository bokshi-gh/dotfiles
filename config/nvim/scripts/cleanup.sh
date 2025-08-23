#!/bin/bash

set -e

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${GREEN}[RUNNING NEOVIM CLEANUP SCRIPT - ARCH LINUX]${NC}"
echo -e "${YELLOW}=== SELECTIVELY REMOVING PACKAGES INSTALLED FOR NEOVIM ===${NC}"

confirm() {
    read -p "Remove $1? [y/n]: " choice
    case "$choice" in
        y|Y ) return 0 ;;
        * ) return 1 ;;
    esac
}

if confirm "Neovim"; then
    sudo pacman -Rns --noconfirm neovim
fi

if confirm "C/C++ tools (base-devel, clang)"; then
    sudo pacman -Rns --noconfirm base-devel clang
fi

if confirm "Java (jdk17-openjdk)"; then
    sudo pacman -Rns --noconfirm jdk17-openjdk
fi

if confirm "Lua"; then
    sudo pacman -Rns --noconfirm lua
fi

if confirm "Go"; then
    sudo pacman -Rns --noconfirm go
fi

if confirm "Python (python, pip)"; then
    sudo pacman -Rns --noconfirm python python-pip
fi

if confirm "Node.js and npm"; then
    sudo pacman -Rns --noconfirm nodejs npm
fi

if confirm "Git"; then
    sudo pacman -Rns --noconfirm git
fi

if [ -d "$HOME/.cargo" ] || [ -d "$HOME/.rustup" ]; then
    if confirm "Rust (rustup, cargo)"; then
        rustup self uninstall -y || true
        rm -rf "$HOME/.cargo" "$HOME/.rustup"
    fi
fi

echo -e "${YELLOW}=== CLEANING UNUSED DEPENDENCIES ===${NC}"
sudo pacman -Rns $(pacman -Qdtq) --noconfirm || true

echo -e "${YELLOW}=== CLEANING PACKAGE CACHE ===${NC}"
sudo pacman -Sc --noconfirm

echo -e "${YELLOW}=== REMOVING NEOVIM CONFIGURATION ===${NC}"
rm -rf "$HOME/.cache/nvim"
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.config/nvim"

echo -e "${GREEN}[CLEANUP COMPLETE]${NC}"
