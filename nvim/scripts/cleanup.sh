#!/bin/bash

set -e

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}[RUNNING NEOVIM CLEANUP SCRIPT - ARCH LINUX]${NC}"

packages=(
    neovim
    base-devel
    clang
    jdk17-openjdk
    lua
    go
    python
    python-pip
    nodejs
    npm
    git
    ripgrep
)

for pkg in "${packages[@]}"; do
    echo -e "${YELLOW}== REMOVING $pkg ==${NC}"
    if ! sudo pacman -Rns "$pkg"; then
        echo -e "${YELLOW}== SKIPPING $pkg, IT MAY BE REQUIRED BY OTHER PACKAGES ==${NC}"
    fi
done

if [ -d "$HOME/.cargo" ] || [ -d "$HOME/.rustup" ]; then
    echo -e "${YELLOW}== REMOVING RUST (RUSTUP, CARGO) ==${NC}"
    rustup self uninstall -y || true
    rm -rf "$HOME/.cargo" "$HOME/.rustup"
fi

echo -e "${YELLOW}== CLEANING NODE.JS GLOBAL MODULES ==${NC}"
rm -rf "$HOME/.npm"
sudo rm -rf /usr/lib/node_modules

echo -e "${YELLOW}== CLEANING UNUSED DEPENDENCIES ==${NC}"
if pacman -Qdtq &>/dev/null; then
    sudo pacman -Rns $(pacman -Qdtq) || echo "== NO ORPHANED PACKAGES TO REMOVE =="
fi

echo -e "${YELLOW}== CLEANING PACKAGE CACHE ==${NC}"
sudo pacman -Sc

echo -e "${YELLOW}== REMOVING NEOVIM CONFIGURATION ==${NC}"
rm -rf "$HOME/.cache/nvim"
rm -rf "$HOME/.local/share/nvim"

echo -e "${GREEN}[CLEANUP COMPLETE]${NC}"
