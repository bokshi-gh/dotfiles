#!/bin/bash

echo "[🧹 Clearing older symlinks...]"

if [ -f ~/.dotfiles/scripts/remove_symlink.sh ]; then
    bash ~/.dotfiles/scripts/remove_symlink.sh
else
    echo "⚠️ remove_symlink.sh not found. Skipping cleanup."
fi

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

mkdir -p ~/.config
mkdir -p ~/.ssh

echo ""
echo "[🔗 Setting up symlinks...]"

# Git
symlink ~/.dotfiles/git/.gitconfig ~/.gitconfig
symlink ~/.dotfiles/git/.gitignore_global ~/.gitignore_global

# Vim
symlink ~/.dotfiles/vim/.vimrc ~/.vimrc

# Neovim
symlink ~/.dotfiles/config/nvim ~/.config/nvim

# SSH
symlink ~/.dotfiles/ssh/config ~/.ssh/config
symlink ~/.dotfiles/ssh/id_rsa_github ~/.ssh/id_rsa_github

# Bash config block
echo ""
echo "[⚙️  Setting up Bash config block...]"

BASHRC_FILE=~/.bashrc
START_MARKER="# >>> dotfiles bashrc config start >>>"
END_MARKER="# <<< dotfiles bashrc config end <<<"

if [ ! -f "$BASHRC_FILE" ] || ! grep -Fxq "$START_MARKER" "$BASHRC_FILE"; then
    {
        echo ""
        echo "$START_MARKER"
        echo "source ~/.dotfiles/bash/.bashrc"
        echo "$END_MARKER"
    } >> "$BASHRC_FILE"
    echo "✅ Added dotfiles bashrc config block to ~/.bashrc"
else
    echo "ℹ️ Dotfiles bashrc config block already present in ~/.bashrc"
fi

# Optionally source immediately (comment if you prefer manual reload)
source ~/.bashrc

echo ""
echo "[🎉 All done! Dotfiles setup complete.]"
