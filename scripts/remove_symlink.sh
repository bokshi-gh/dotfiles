#!/bin/bash

# ANSI color codes
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
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
        else
            echo -e "${YELLOW}Skipping${NC} $target: not a symlink to ~/.dotfiles"
        fi
    else
        echo -e "${YELLOW}$target is not a symlink, skipping${NC}"
    fi
}

# Run cleanup script
if [ -f ~/.config/nvim/scripts/cleanup.sh ]; then
    echo -e "${GREEN}[RUNNING NEOVIM CLEANUP SCRIPT]${NC}"
    bash ~/.config/nvim/scripts/cleanup.sh
else
    echo -e "${RED}NEOVIM CLEANUP SCRIPT NOT FOUND:${NC} ~/.config/nvim/scripts/cleanup.sh"
fi

remove_symlink ~/.gitconfig
remove_symlink ~/.gitignore_global
remove_symlink ~/.vimrc
remove_symlink ~/.config/nvim
remove_symlink ~/.ssh/config
remove_symlink ~/.ssh/id_rsa_github

echo -e "${GREEN}[ALL DONE! SYMLINKS REMOVAL COMPLETE]${NC}"
