#!/bin/bash

# Symlink removal function
function remove_symlink() {
    rm -rf "$1"
    echo "Symlink $1 is removed"
}

# Remove symlinks for Bash
remove_symlink ~/.bashrc

# Remove symlinks for Git
remove_symlink ~/.gitconfig
remove_symlink ~/.gitignore_global

# Remove symlinks for Vim
remove_symlink ~/.vimrc

rm -rf ~/.config
if [ ! -d ~/.config ]
then
    dir_name="~/.config"
    echo "Directory $dir_name is removed"
fi

echo ""

rm -rf ~/.ssh
if [ ! -d ~/.ssh ]
then
    dir_name="~/.config"
    echo "Directory $dir_name is removed"
fi
