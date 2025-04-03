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
symlink ~/.dotfiles/git/.gitconfig ~/
symlink ~/.dotfiles/git/.gitignore_global ~/

# Create symlinks for Vim
symlink ~/.dotfiles/vim/.vimrc ~/

# Create symlinks for Neovim
symlink ~/.dotfiles/config ~/

# Create symlink for SSH
symlink ~/.dotfiles/ssh ~/
