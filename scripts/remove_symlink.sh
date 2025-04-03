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

echo ""

# Ensure all necessary directories are removed after all the symlinks are removed
rm -rf ~/.config

if [ ! -d ~/.config ]
then
    dir_name="~/.config"
    echo "Directory $dir_name is removed"
fi

remove_symlink ~/.ssh/config
remove_symlink ~/.ssh/id_rsa_github
