#!/bin/bash

set -e

GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${GREEN}[RUNNING NEOVIM SETUP SCRIPT]${NC}"

echo -e "${YELLOW}=== INSTALLING NEOVIM (LATEST UNSTABLE) ===${NC}"
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim why two time update

echo -e "${YELLOW}=== UPDATING SYSTEM ===${NC}"
sudo apt update && sudo apt upgrade -y

echo -e "${YELLOW}=== INSTALLING BUILD TOOLS (C/C++) ===${NC}"
sudo apt install -y build-essential clang

echo -e "${YELLOW}=== INSTALLING JAVA (JDK 17) ===${NC}"
sudo apt install -y openjdk-17-jdk

echo -e "${YELLOW}=== INSTALLING LUA ===${NC}"
sudo apt install -y lua5.4

echo -e "${YELLOW}=== INSTALLING GO ===${NC}"
sudo apt install -y golang

echo -e "${YELLOW}=== INSTALLING PYTHON ===${NC}"
sudo apt install -y python3 python3-pip

echo -e "${YELLOW}=== INSTALLING RUST (VIA RUSTUP) ===${NC}"
if ! command -v rustc &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

echo -e "${YELLOW}=== INSTALLING NODE.JS AND NPM ===${NC}"
sudo apt install -y nodejs npm
# Ensure latest Node if distro version is old
if [ "$(node -v | cut -d. -f1 | tr -d v)" -lt 18 ]; then
  echo ""
  echo -e "${YELLOW}NODE.JS IS OLD, INSTALLING LATEST VIA NODESOURCE...${NC}"
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt install -y nodejs
fi

echo -e "${YELLOW}=== INSTALLING GIT (REQUIRED FOR LAZY.NVIM) ===${NC}"
sudo apt install -y git
