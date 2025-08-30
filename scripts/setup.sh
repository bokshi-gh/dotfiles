#!/bin/bash

GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

copy_file_or_dir() {
    local src=$1
    local dest=$2

    if [ ! -e "$src" ]; then
        echo -e "${RED}Source not found:${NC} $src"
        return 1
    fi

    if [ -d "$src" ]; then
        cp -r "$src" "$dest"
    else
        cp "$src" "$dest"
    fi

    echo -e "${GREEN}Copied:${NC} $src → $dest"
}

mkdir -p ~/.config
mkdir -p ~/.ssh

echo -e "${GREEN}[SETTING UP CONFIGURATION FILES AND FOLDERS]${NC}"

copy_file_or_dir ~/.dotfiles/git/.gitconfig ~/.gitconfig
copy_file_or_dir ~/.dotfiles/vim/.vimrc ~/.vimrc
copy_file_or_dir ~/.dotfiles/nvim ~/.config/nvim
copy_file_or_dir ~/.dotfiles/ssh/config ~/.ssh/config
copy_file_or_dir ~/.dotfiles/ssh/id_rsa_github ~/.ssh/id_rsa_github

chmod 600 ~/.ssh/id_rsa_github
