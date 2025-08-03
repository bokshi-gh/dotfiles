#!/bin/bash

# ANSI color codes
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}[REMOVING SYMLINKS]${NC}"

remove_symlink() {
    local target=$1
    if [ -L "$target" ]; then
        local dest
        dest=$(readlink "$target")
        if [[ "$dest" == ~/.dotfiles* ]]; then
            rm "$target"
            echo -e "${GREEN}Removed symlink:${NC} $target → $dest"
        fi
    fi
}

remove_symlink ~/.gitconfig
remove_symlink ~/.gitignore_global
remove_symlink ~/.vimrc
remove_symlink ~/.config/nvim
remove_symlink ~/.ssh/config
remove_symlink ~/.ssh/id_rsa_github

# Run cleanup script
if [ -f ~/.dotfiles/config/nvim/scripts/cleanup.sh ]; then
    echo ""
    echo -e "${GREEN}[RUNNING NEOVIM CLEANUP SCRIPT]${NC}"
    bash ~/.dotfiles/config/nvim/scripts/cleanup.sh
else
    echo -e "${RED}NEOVIM CLEANUP SCRIPT NOT FOUND:${NC} ~/.config/nvim/scripts/cleanup.sh"
fi
