#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

if [ -f "$HOME/.dotfiles/nvchad/scripts/cleanup.sh" ]; then
    bash "$HOME/.dotfiles/nvchad/scripts/cleanup.sh"
else
    echo -e "${RED}Cleanup script not found${NC}"
fi

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm git neovim ripgrep gcc

git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
