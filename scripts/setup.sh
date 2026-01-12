#!/bin/bash

# NOTE: After running this setup.sh, manually run `source ~/.bashrc` 
# to apply the updated shell configuration in the current session.

GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

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

mkdir -p ~/.ssh

echo -e "${GREEN}[SETTING UP CONFIGURATION FILES AND FOLDERS]${NC}"

copy_file_or_dir ~/.dotfiles/git/.gitconfig ~/.gitconfig
copy_file_or_dir ~/.dotfiles/vim/.vimrc ~/.vimrc
copy_file_or_dir ~/.dotfiles/ssh/config ~/.ssh/config
copy_file_or_dir ~/.dotfiles/ssh/id_rsa_github ~/.ssh/id_rsa_github
chmod 600 ~/.ssh/id_rsa_github

# Setting up bashrc
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.previous-bashrc # Backup existing bashrc
cp ~/.dotfiles/bash/.bashrc ~/.bashrc
echo " " >> ~/.bashrc
[ -f ~/.previous-bashrc ] && cat ~/.previous-bashrc >> ~/.bashrc
echo -e "${GREEN}Configured:${NC} ~/.bashrc"
