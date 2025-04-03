#!/bin/bash

# Symlink function
function symlink() {
    ln -sf "$1" "$2"
    echo "Symlinked $1 to $2"
}

# Check if .bashrc exists
if [ -f ~/.bashrc ]; then
    echo ".bashrc exists, appending content..."
    echo "source ~/.dotfiles/bash/.bashrc" >> ~/.bashrc
else
    echo ".bashrc does not exist, creating and adding content..."
    touch ~/.bashrc
    echo "source ~/.dotfiles/bash/.bashrc" > ~/.bashrc
fi

echo ""

# Create symlinks for Git
symlink ~/.dotfiles/git/.gitconfig ~/.gitconfig
symlink ~/.dotfiles/git/.gitignore_global ~/.gitignore_global

# Create symlinks for Vim
symlink ~/.dotfiles/vim/.vimrc ~/.vimrc

# Create symlinks for Neovim
mkdir ~/.config
symlink ~/.dotfiles/config/ ~/config/

# Create symlink for SSH
mkdir ~/.ssh
symlink ~/.dotfiles/ssh/config ~/.ssh/config
symlink ~/.dotfiles/ssh/id_rsa_github ~/.ssh/id_rsa_github
