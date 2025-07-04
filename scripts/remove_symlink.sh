#!/bin/bash

echo "[🧹 Removing symlinks...]"

# Remove bashrc block
BASHRC_FILE=~/.bashrc
START_MARKER="# >>> dotfiles bashrc config start >>>"
END_MARKER="# <<< dotfiles bashrc config end <<<"

if [ -f "$BASHRC_FILE" ]; then
    if grep -q "$START_MARKER" "$BASHRC_FILE"; then
        sed -i "/$START_MARKER/,/$END_MARKER/d" "$BASHRC_FILE"
        echo "✅ Removed dotfiles bashrc config block from ~/.bashrc"
    else
        echo "ℹ️ Dotfiles bashrc config block not found in ~/.bashrc"
    fi
fi

# Function to remove symlink if it exists
remove_if_symlink() {
    local file=$1
    if [ -L "$file" ]; then
        rm -f "$file" && echo "Removed $file"
    else
        echo "ℹ️ Skipped $file (not a symlink or does not exist)"
    fi
}

# Run Neovim cleanup script if it exists before removing config
if [ -f ~/.config/nvim/scripts/clean.sh ]; then
    echo "🧹 Running Neovim cleanup script before removing config..."
    bash ~/.config/nvim/scripts/clean.sh
else
    echo "⚠️ Neovim cleanup script not found, skipping."
fi

remove_if_symlink ~/.config/nvim

remove_if_symlink ~/.gitconfig
remove_if_symlink ~/.gitignore_global
remove_if_symlink ~/.vimrc
remove_if_symlink ~/.ssh/config
remove_if_symlink ~/.ssh/id_rsa_github

echo "[✅ Removal complete!]"
