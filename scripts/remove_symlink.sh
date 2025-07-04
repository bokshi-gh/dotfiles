#!/bin/bash

echo "[🧹 Removing symlinks...]"

# Only remove the specific line added to ~/.bashrc
BASHRC_LINE="source ~/.dotfiles/bash/.bashrc"
BASHRC_FILE=~/.bashrc

if [ -f "$BASHRC_FILE" ]; then
    if grep -Fxq "$BASHRC_LINE" "$BASHRC_FILE"; then
        sed -i "\|$BASHRC_LINE|d" "$BASHRC_FILE"
        echo "Cleaned line from ~/.bashrc"
    else
        echo "Line not found in ~/.bashrc — nothing to clean"
    fi
fi

# Remove symlinks (ignore if not symlink or not exist)
remove_if_symlink() {
    local file=$1
    if [ -L "$file" ]; then
        rm -f "$file" && echo "Removed $file"
    fi
}

remove_if_symlink ~/.gitconfig
remove_if_symlink ~/.gitignore_global
remove_if_symlink ~/.vimrc
remove_if_symlink ~/.config/nvim
remove_if_symlink ~/.ssh/config
remove_if_symlink ~/.ssh/id_rsa_github

echo "[✅ Removal complete!]"
