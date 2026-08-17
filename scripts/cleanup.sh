#!/bin/bash

readonly DOTFILES="$HOME/dotfiles"

GREEN='\033[1;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ ! -d "$DOTFILES" ]; then
    echo -e "${RED}Dotfiles directory not found:${NC} $DOTFILES"
    exit 1
fi

cleanup_link() {
    local src="$1"
    local dest="$2"
    local backup="${dest}.backup"

    if [ -L "$dest" ]; then
        local target
        target=$(readlink "$dest")

        if [ "$target" = "$src" ]; then
            rm "$dest"
            echo -e "${GREEN}Removed:${NC} $dest"
        else
            echo -e "${YELLOW}Skipped:${NC} $dest points to another location"
            return
        fi
    elif [ -e "$dest" ]; then
        echo -e "${YELLOW}Skipped:${NC} $dest is not a dotfiles symlink"
        return
    fi

    if [ -e "$backup" ]; then
        mv "$backup" "$dest"
        echo -e "${GREEN}Restored:${NC} $backup → $dest"
    fi
}

echo -e "${GREEN}[Cleaning up dotfiles]${NC}"
echo ""

cleanup_link "$DOTFILES/bash/.bashrc" "$HOME/.bashrc"
cleanup_link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
cleanup_link "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"
cleanup_link "$DOTFILES/ssh/config" "$HOME/.ssh/config"

echo ""
echo -e "${GREEN}Dotfiles cleanup complete.${NC}"
echo "Open a new terminal to apply the changes to your shell."
