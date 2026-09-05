#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo pacman -Syu --noconfirm

# Basic tools
sudo pacman -S --needed --noconfirm \
    git \
    neovim \
    tree-sitter-cli \
    ripgrep \
    base-devel \
    make \
    unzip

# C/C++
sudo pacman -S --needed --noconfirm \
    gcc \
    gdb \
    clang \
    cmake

# Assembly
sudo pacman -S --needed --noconfirm \
    nasm

# Rust
sudo pacman -S --needed --noconfirm \
    rustup

rustup default stable

# Java
sudo pacman -S --needed --noconfirm \
    jdk-openjdk

# JavaScript / TypeScript / React
sudo pacman -S --needed --noconfirm \
    nodejs \
    npm

# Python
sudo pacman -S --needed --noconfirm \
    python \
    python-pip

# Clean existing NvChad
"$SCRIPT_DIR/cleanup-nvchad.sh"

# NvChad
git clone https://github.com/NvChad/starter "$HOME/.config/nvim"
rm -rf "$HOME/.config/nvim/.git"

nvim

# After running this setup, check:
# ../docs/nvchad.md
