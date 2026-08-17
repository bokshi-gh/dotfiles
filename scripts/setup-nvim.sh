#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm git
sudo pacman -S --needed --noconfirm neovim
sudo pacman -S --needed --noconfirm tree-sitter-cli
sudo pacman -S --needed --noconfirm ripgrep
sudo pacman -S --needed --noconfirm base-devel gcc make

git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
