#!/bin/bash

sudo pacman -Syu --noconfirm

# Basic tools
sudo pacman -S --needed --noconfirm \
    git \
    neovim \
    tree-sitter-cli \
    ripgrep \
    base-devel

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

# JavaScript / TypeScript
sudo pacman -S --needed --noconfirm \
    nodejs \
    npm

# Python
sudo pacman -S --needed --noconfirm \
    python \
    python-pip

# NvChad
git clone https://github.com/NvChad/starter ~/.config/nvim

nvim

# After running this setup, check:
# ../docs/nvchad.md
