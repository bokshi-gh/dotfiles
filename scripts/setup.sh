#!/bin/bash

readonly DOTFILES="$HOME/.dotfiles"

GREEN='\033[1;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ ! -d "$DOTFILES" ]; then
    echo -e "${RED}Dotfiles directory not found:${NC} $DOTFILES"
    exit 1
fi

link_file() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ]; then
        echo -e "${RED}Source not found:${NC} $src"
        return 1
    fi

    if [ -L "$dest" ]; then
        rm "$dest"
    elif [ -e "$dest" ]; then
        local backup="${dest}.backup"

        if [ -e "$backup" ]; then
            backup="${dest}.backup.$(date +%Y%m%d%H%M%S)"
        fi

        mv "$dest" "$backup"
        echo -e "${YELLOW}Backed up:${NC} $dest → $backup"
    fi

    ln -s "$src" "$dest"
    echo -e "${GREEN}Linked:${NC} $src → $dest"
}

mkdir -p "$HOME/.ssh"

echo -e "${GREEN}[Setting up dotfiles]${NC}"
echo ""

link_file "$DOTFILES/bash/.bashrc" "$HOME/.bashrc"
link_file "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"
link_file "$DOTFILES/ssh/config" "$HOME/.ssh/config"

chmod 700 "$HOME/.ssh"
chmod 600 "$HOME/.ssh/config"

echo ""
echo -e "${GREEN}Dotfiles setup complete.${NC}"
echo "Run 'source ~/.bashrc' or open a new terminal to apply Bash changes."
