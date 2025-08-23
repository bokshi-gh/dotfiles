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
        else
            echo -e "${RED}Skipped:${NC} $target is not pointing to ~/.dotfiles"
        fi
    else
        echo -e "${RED}Skipped:${NC} $target is not a symlink"
    fi
}

remove_symlink ~/.gitconfig
remove_symlink ~/.vimrc
remove_symlink ~/.config/nvim
remove_symlink ~/.ssh/config
remove_symlink ~/.ssh/id_rsa_github
