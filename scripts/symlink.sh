#!/bin/bash

echo ""
echo "[🧹 Clearing older symlinks...]"

# Run cleanup script first
if [ -f ~/.dotfiles/scripts/remove_symlink.sh ]; then
    bash ~/.dotfiles/scripts/remove_symlink.sh
else
    echo "⚠️  remove_symlink.sh not found. Skipping cleanup."
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

# Bash config setup
echo ""
echo "[⚙️  Setting up Bash config...]"

BASHRC_LINE="source ~/.dotfiles/bash/.bashrc"
BASHRC_FILE=~/.bashrc

if [ -f "$BASHRC_FILE" ]; then
    if ! grep -Fxq "$BASHRC_LINE" "$BASHRC_FILE"; then
        echo "$BASHRC_LINE" >> "$BASHRC_FILE"
        echo "✅ Appended bash config sourcing to ~/.bashrc"
    else
        echo "ℹ️ Bash config sourcing already present in ~/.bashrc"
    fi
else
    echo "$BASHRC_LINE" > "$BASHRC_FILE"
    echo "✅ Created ~/.bashrc and added bash config sourcing"
fi

# Optional: Source the bashrc to apply immediately
source ~/.bashrc

echo ""
echo "[🎉 All done! Dotfiles setup complete.]"
