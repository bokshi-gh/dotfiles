#!/bin/bash

# Symlink function
function symlink() {
    ln -sf "$1" "$2"
    echo "Symlinked $1 to $2"
}

# Ensure all necessary directories in home exist
mkdir -p ~/.vim
mkdir -p ~/.config
mkdir -p ~/.ssh

if [ -d ~/.vim ]; then
    echo "Directory ~/.vim is created"
fi

if [ -d ~/.config/nvim ]; then
    echo "Directory ~/.config/nvim is created"
fi

if [ -d ~/.ssh ]; then
    echo "Directory ~/.ssh is created"
fi

echo ""

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
symlink ~/.dotfiles/git/ ~/

# Create symlinks for Vim
symlink ~/.dotfiles/vim/.vimrc ~/

# Create symlinks for Neovim
symlink ~/.dotfiles/config/ ~/.config/

# Create symlink for SSH
symlink ~/.dotfiles/ssh/ ~/.ssh/
