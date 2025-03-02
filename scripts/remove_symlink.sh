#!/bin/bash

# Symlink removal function
function remove_symlink() {
    rm -rf "$1"
    echo "Symlink $1 is removed"
}

# Remove symlinks for Git
remove_symlink ~/.gitconfig
remove_symlink ~/.gitignore_global

# Remove symlinks for Vim
remove_symlink ~/.vimrc
remove_symlink ~/.config/vim/plugin.vim

# Remove symlinks for Neovim
remove_symlink ~/.config/nvim/init.vim

# Remove symlink for SSH
remove_symlink ~/.ssh/config
remove_symlink ~/.ssh/id_rsa_github

echo ""

# Ensure all necessary directories are removed after all the symlinks are removed
rm -rf ~/.vim
rm -rf ~/.config
rm -rf ~/.ssh

if [ ! -d ~/.vim ]
then
    dir_name="~/.vim"
    echo "Directory $dir_name is removed"
fi

if [ ! -d ~/.config ]
then
    dir_name="~/.config"
    echo "Directory $dir_name is removed"
fi

if [ ! -d ~/.ssh ]
then
    dir_name="~/.ssh"
    echo "Directory $dir_name is removed"
fi
