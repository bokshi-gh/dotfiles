#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm git
sudo pacman -S --needed --noconfirm neovim
sudo pacman -S --needed --noconfirm tree-sitter-cli
sudo pacman -S --needed --noconfirm ripgrep
sudo pacman -S --needed --noconfirm base-devel gcc make

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim

# After running this setup, check:
# ../docs/nvchad.md
