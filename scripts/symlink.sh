#!/bin/bash

# Run cleanup script first
if [ -f ~/.dotfiles/scripts/remove_symlink.sh ]; then
    echo "[🧹 Clearing older symlinks...]"
    bash ~/.dotfiles/scripts/remove_symlink.sh
else
    echo "⚠️remove_symlink.sh not found. Skipping cleanup."
fi

# Function to create symlink safely
symlink() {
    local src=$1
    local dest=$2

    if [ ! -e "$src" ]; then
        echo "❌ Source not found: $src"
        return 1
    fi

    ln -sf "$src" "$dest"
    echo "✅ Symlinked $src → $dest"
}

# Ensure base directories exist
mkdir -p ~/.config
mkdir -p ~/.ssh

echo ""
echo "[🔗 Setting up symlinks...]"

# Bash config
symlink ~/.dotfiles/bash/.bashrc ~/.bashrc
source ~/.bashrc

# Git config
symlink ~/.dotfiles/git/.gitconfig ~/.gitconfig
symlink ~/.dotfiles/git/.gitignore_global ~/.gitignore_global

# Vim config
symlink ~/.dotfiles/vim/.vimrc ~/.vimrc

# Neovim config
symlink ~/.dotfiles/config/nvim ~/.config/nvim

# SSH config
symlink ~/.dotfiles/ssh/config ~/.ssh/config
symlink ~/.dotfiles/ssh/id_rsa_github ~/.ssh/id_rsa_github

echo "[🎉 All done!]"

