#!/bin/bash

GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

symlink() {
    local src=$1
    local dest=$2

    if [ ! -e "$src" ]; then
        echo -e "${RED}Source not found:${NC} $src"
        return 1
    fi

    ln -sf "$src" "$dest"
    echo -e "${GREEN}Symlink created:${NC} $src → $dest"
}

mkdir -p ~/.config
mkdir -p ~/.ssh

echo -e "${GREEN}[SETTING UP SYMLINKS]${NC}"

symlink ~/.dotfiles/git/.gitconfig ~/.gitconfig
symlink ~/.dotfiles/vim/.vimrc ~/.vimrc
symlink ~/.dotfiles/config/nvim ~/.config/nvim
symlink ~/.dotfiles/ssh/config ~/.ssh/config
symlink ~/.dotfiles/ssh/id_rsa_github ~/.ssh/id_rsa_github

chmod 600 ~/.dotfiles/ssh/id_rsa_github
