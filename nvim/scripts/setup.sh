#!/bin/bash

set -e

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}[RUNNING NEOVIM SETUP SCRIPT - ARCH LINUX]${NC}"

echo -e "${YELLOW}=== UPDATING SYSTEM ===${NC}"
sudo pacman -Syu --noconfirm

echo -e "${YELLOW}=== INSTALLING NEOVIM ===${NC}"
sudo pacman -S --noconfirm neovim

echo -e "${YELLOW}=== INSTALLING BUILD TOOLS (C/C++) ===${NC}"
sudo pacman -S --noconfirm base-devel clang

echo -e "${YELLOW}=== INSTALLING JAVA (JDK 17) ===${NC}"
sudo pacman -S --noconfirm jdk17-openjdk

echo -e "${YELLOW}=== INSTALLING LUA ===${NC}"
sudo pacman -S --noconfirm lua

echo -e "${YELLOW}=== INSTALLING GO ===${NC}"
sudo pacman -S --noconfirm go

echo -e "${YELLOW}=== INSTALLING PYTHON ===${NC}"
sudo pacman -S --noconfirm python python-pip

echo -e "${YELLOW}=== INSTALLING RUST (VIA RUSTUP) ===${NC}"
if ! command -v rustc &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

echo -e "${YELLOW}=== INSTALLING NODE.JS AND NPM ===${NC}"
sudo pacman -S --noconfirm nodejs npm
sudo npm install -g eslint_d

echo -e "${YELLOW}=== INSTALLING GIT (REQUIRED FOR LAZY.NVIM) ===${NC}"
sudo pacman -S --noconfirm git

echo -e "${YELLOW}=== INSTALLING RIPGREP (REQUIRED FOR TELESCOPE FUZZY FINDING) ===${NC}"
sudo pacman -S --noconfirm ripgrep

echo -e "${GREEN}[SETUP COMPLETE]${NC}"
