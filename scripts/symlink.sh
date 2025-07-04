#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}[🧹 Starting cleanup of old symlinks...]${NC}"

if [ -f ~/.dotfiles/scripts/remove_symlink.sh ]; then
    bash ~/.dotfiles/scripts/remove_symlink.sh
else
    echo "⚠️ remove_symlink.sh not found. Skipping symlink cleanup."
fi

if [ -f ~/.config/nvim/scripts/clean.sh ]; then
    echo -e "${GREEN}[🧹 Running Neovim clean script...]${NC}"
    bash ~/.config/nvim/scripts/clean.sh
else
    echo "⚠️ Neovim clean.sh script not found. Skipping Neovim cleanup."
fi

symlink() {
    local src=$1
    local dest=$2

    if [ ! -e "$src" ]; then
        echo "❌ Source not found: $src"
        return 1
    fi

    ln -sf "$src" "$dest"
    echo "✅ Symlink created: $src → $dest"
}

mkdir -p ~/.config
mkdir -p ~/.ssh

echo ""
echo -e "${GREEN}[🔗 Setting up dotfiles symlinks...]${NC}"

symlink ~/.dotfiles/git/.gitconfig ~/.gitconfig
symlink ~/.dotfiles/git/.gitignore_global ~/.gitignore_global
symlink ~/.dotfiles/vim/.vimrc ~/.vimrc
symlink ~/.dotfiles/config/nvim ~/.config/nvim
symlink ~/.dotfiles/ssh/config ~/.ssh/config
symlink ~/.dotfiles/ssh/id_rsa_github ~/.ssh/id_rsa_github

chmod 600 ~/.dotfiles/ssh/id_rsa_github

echo ""
echo -e "${GREEN}[🚀 Running Neovim setup script...]${NC}"

if [ -f ~/.config/nvim/scripts/setup.sh ]; then
    bash ~/.config/nvim/scripts/setup.sh
else
    echo "⚠️ Neovim setup.sh script not found. Skipping Neovim setup."
fi

echo ""
echo -e "${GREEN}[🎉 All done! Dotfiles setup and configuration complete.]${NC}"
