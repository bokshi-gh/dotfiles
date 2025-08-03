#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Remove older symlinks
if [ -f ~/.dotfiles/scripts/remove_symlink.sh ]; then
    bash ~/.dotfiles/scripts/remove_symlink.sh
fi

symlink() {
    local src=$1
    local dest=$2

    if [ ! -e "$src" ]; then
        echo "❌ Source not found: $src"
        return 1
    fi

    ln -sf "$src" "$dest"
    echo -e "${GREEN}Symlink created:${NC} $src → $dest"
}

mkdir -p ~/.config
mkdir -p ~/.ssh

echo ""
echo -e "${GREEN}[SETTING UP SYMLINKS]${NC}"

symlink ~/.dotfiles/git/.gitconfig ~/.gitconfig
symlink ~/.dotfiles/git/.gitignore_global ~/.gitignore_global
symlink ~/.dotfiles/vim/.vimrc ~/.vimrc
symlink ~/.dotfiles/config/nvim ~/.config/nvim
symlink ~/.dotfiles/ssh/config ~/.ssh/config
symlink ~/.dotfiles/ssh/id_rsa_github ~/.ssh/id_rsa_github

chmod 600 ~/.dotfiles/ssh/id_rsa_github

echo -e "${GREEN}[All done! Dotfiles setup and configuration complete]${NC}"
