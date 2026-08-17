#!/bin/bash

readonly DOTFILES="$HOME/dotfiles"

GREEN='\033[1;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'


# Check dotfiles directory
if [[ ! -d "$DOTFILES" ]]; then
    echo -e "${RED}Dotfiles directory not found:${NC} $DOTFILES"
    exit 1
fi


# Remove a dotfiles symlink
remove_link() {
    local src="$1"
    local dest="$2"

    if [[ -L "$dest" ]]; then
        local target
        target="$(readlink "$dest")"

        if [[ "$target" == "$src" ]]; then
            rm "$dest"
            echo -e "${GREEN}Removed:${NC} $dest"
        else
            echo -e "${YELLOW}Skipped:${NC} $dest points to another location"
        fi

    elif [[ -e "$dest" ]]; then
        echo -e "${YELLOW}Skipped:${NC} $dest is not a dotfiles symlink"
    fi
}


# CLEANING UP DOTFILES
# ====================

echo -e "${GREEN}[Cleaning up dotfiles]${NC}"
echo ""


# Bash
if [[ -L "$HOME/.bashrc" ]]; then
    target="$(readlink "$HOME/.bashrc")"

    if [[ "$target" == "$DOTFILES/bash/.bashrc" ]]; then
        rm "$HOME/.bashrc"
        echo -e "${GREEN}Removed:${NC} ~/.bashrc"

        if [[ -f "$HOME/.bashrc.backup" ]]; then
            mv "$HOME/.bashrc.backup" "$HOME/.bashrc"
            echo -e "${GREEN}Restored:${NC} ~/.bashrc.backup → ~/.bashrc"
        fi
    else
        echo -e "${YELLOW}Skipped:${NC} ~/.bashrc points to another location"
    fi

elif [[ -e "$HOME/.bashrc" ]]; then
    echo -e "${YELLOW}Skipped:${NC} ~/.bashrc is not a dotfiles symlink"
fi


# Git
remove_link \
    "$DOTFILES/git/.gitconfig" \
    "$HOME/.gitconfig"


# Vim
remove_link \
    "$DOTFILES/vim/.vimrc" \
    "$HOME/.vimrc"


# SSH
remove_link \
    "$DOTFILES/ssh/config" \
    "$HOME/.ssh/config"


echo ""
echo -e "${GREEN}Dotfiles cleanup complete.${NC}"
echo "Open a new terminal to apply the changes to your shell."
