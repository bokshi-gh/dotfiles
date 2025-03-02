#!/bin/bash

# Symlink function
function symlink() {
    ln -sf "$1" "$2"
    echo "Symlinked $1 to $2"
}

# Ensure all necessary directories in home exist
mkdir -p ~/.vim
mkdir -p ~/.config/nvim
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

# Create symlinks for Git
symlink ~/.dotfiles/git/.gitconfig ~/.gitconfig
symlink ~/.dotfiles/git/.gitignore_global ~/.gitignore_global

# Create symlinks for Vim
symlink ~/.dotfiles/vim/.vimrc ~/.vimrc
symlink ~/.dotfiles/vim/plugins.vim ~/.vim/plugin.vim

# Create symlinks for Neovim
symlink ~/.dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim

# Create symlink for SSH
symlink ~/.dotfiles/ssh/config ~/.ssh/config
symlink ~/.dotfiles/ssh/id_rsa_github ~/.ssh/id_rsa_github
