#!/bin/bash

# Symlink removal function
function remove_symlink() {
    rm -rf "$1"
    echo "Symlink $1 is removed"
}

# Remove symlinks for Bash
remove_symlink ~/.bashrc
remove_symlink ~/.bash_profile
remove_symlink ~/.aliases.bash

# Remove symlinks for Git
remove_symlink ~/.gitconfig
remove_symlink ~/.gitignore_global

# Remove symlinks for Vim
remove_symlink ~/.config/vim/vimrc
remove_symlink ~/.config/vim/plugin.vim

# Remove symlinks for Neovim
remove_symlink ~/.config/nvim/init.vim

echo ""

# Ensure all necessary directories are removed after all the symlinks are removed
rm -rf ~/.config/vim
rm -rf ~/.config/nvim

if [ ! -d ~/.config/vim ]
then
    dir_name="~/.config/vim"
    echo "Directory $dir_name is removed"
fi

if [ ! -d ~/.config/nvim ]
then
    dir_name="~/.config/nvim"
    echo "Directory $dir_name is removed"
fi
