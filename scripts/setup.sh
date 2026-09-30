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


# Create required directories
mkdir -p "$HOME/.ssh"
mkdir -p "$HOME/.config/sway"
mkdir -p "$HOME/Pictures/wallpapers"


# Link a dotfiles file
link_file() {
    local src="$1"
    local dest="$2"

    if [[ -L "$dest" ]]; then
        local target
        target="$(readlink "$dest")"

        if [[ "$target" == "$src" ]]; then
            echo -e "${GREEN}Already linked:${NC} $dest"
        else
            echo -e "${YELLOW}Skipped:${NC} $dest points to another location"
        fi

    elif [[ -e "$dest" ]]; then
        echo -e "${YELLOW}Skipped:${NC} $dest already exists"

    else
        ln -s "$src" "$dest"
        echo -e "${GREEN}Linked:${NC} $src → $dest"
    fi
}


# Backup and link Bash files
setup_bash() {
    local src="$1"
    local dest="$2"
    local backup="$3"

    if [[ -L "$dest" ]]; then
        local target
        target="$(readlink "$dest")"

        if [[ "$target" == "$src" ]]; then
            echo -e "${GREEN}Already linked:${NC} $dest"
        else
            echo -e "${YELLOW}Skipped:${NC} $dest points to another location"
        fi

    elif [[ -e "$dest" ]]; then
        if [[ -e "$backup" ]]; then
            echo -e "${YELLOW}Skipped:${NC} $dest already exists"
            echo -e "${YELLOW}Backup already exists:${NC} $backup"
        else
            mv "$dest" "$backup"
            echo -e "${YELLOW}Backed up:${NC} $dest → $backup"

            ln -s "$src" "$dest"
            echo -e "${GREEN}Linked:${NC} $src → $dest"
        fi

    else
        ln -s "$src" "$dest"
        echo -e "${GREEN}Linked:${NC} $src → $dest"
    fi
}


# SETTING UP DOTFILES
# ===================

echo -e "${GREEN}[Setting up dotfiles]${NC}"
echo ""


# Bash
setup_bash \
    "$DOTFILES/bash/.bash_profile" \
    "$HOME/.bash_profile" \
    "$HOME/.bash_profile.backup"

setup_bash \
    "$DOTFILES/bash/.bashrc" \
    "$HOME/.bashrc" \
    "$HOME/.bashrc.backup"


# Git
link_file \
    "$DOTFILES/git/.gitconfig" \
    "$HOME/.gitconfig"


# Vim
link_file \
    "$DOTFILES/vim/.vimrc" \
    "$HOME/.vimrc"


# SSH
link_file \
    "$DOTFILES/ssh/config" \
    "$HOME/.ssh/config"

chmod 700 "$HOME/.ssh"

if [[ -f "$HOME/.ssh/config" ]]; then
    chmod 600 "$HOME/.ssh/config"
fi


# Sway
link_file \
    "$DOTFILES/sway/config" \
    "$HOME/.config/sway/config"

link_file \
    "$DOTFILES/sway/status.sh" \
    "$HOME/.config/sway/status.sh"

link_file \
    "$DOTFILES/sway/wifi-notify.sh" \
    "$HOME/.config/sway/wifi-notify.sh"

link_file \
    "$DOTFILES/sway/battery-notify.sh" \
    "$HOME/.config/sway/battery-notify.sh"

chmod +x "$DOTFILES/sway/status.sh"


# Wallpaper
cp "$DOTFILES/assets/images/death-of-socrates.png" \
    "$HOME/Pictures/wallpapers/wallpaper.png"

echo -e "${GREEN}Wallpaper copied:${NC} ~/Pictures/wallpapers/wallpaper.png"


echo ""
echo -e "${GREEN}Dotfiles setup complete.${NC}"
echo "Open a new terminal, run 'source ~/.bashrc', or log in again to apply the changes."
