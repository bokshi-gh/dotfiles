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


# Restore Bash file
cleanup_bash() {
    local src="$1"
    local dest="$2"
    local backup="$3"

    if [[ -L "$dest" ]]; then
        local target
        target="$(readlink "$dest")"

        if [[ "$target" == "$src" ]]; then
            rm "$dest"
            echo -e "${GREEN}Removed:${NC} $dest"

            if [[ -e "$backup" ]]; then
                mv "$backup" "$dest"
                echo -e "${GREEN}Restored:${NC} $backup → $dest"
            fi
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
cleanup_bash \
    "$DOTFILES/bash/.bash_profile" \
    "$HOME/.bash_profile" \
    "$HOME/.bash_profile.backup"

cleanup_bash \
    "$DOTFILES/bash/.bashrc" \
    "$HOME/.bashrc" \
    "$HOME/.bashrc.backup"


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


# Sway
remove_link \
    "$DOTFILES/sway/config" \
    "$HOME/.config/sway/config"

remove_link \
    "$DOTFILES/sway/status.sh" \
    "$HOME/.config/sway/status.sh"

remove_link \
    "$DOTFILES/sway/wifi-notify.sh" \
    "$HOME/.config/sway/wifi-notify.sh"

remove_link \
    "$DOTFILES/sway/battery-notify.sh" \
    "$HOME/.config/sway/battery-notify.sh"

remove_link \
    "$DOTFILES/sway/ac-notify.sh" \
    "$HOME/.config/sway/ac-notify.sh"


# Wallpaper
if [[ -f "$HOME/Pictures/wallpapers/wallpaper.png" ]] &&
   cmp -s "$DOTFILES/assets/images/death-of-socrates.png" \
          "$HOME/Pictures/wallpapers/wallpaper.png"; then
    rm "$HOME/Pictures/wallpapers/wallpaper.png"
    echo -e "${GREEN}Removed:${NC} ~/Pictures/wallpapers/wallpaper.png"
fi


echo ""
echo -e "${GREEN}Dotfiles cleanup complete.${NC}"
echo "Open a new terminal, run 'source ~/.bashrc', or log in again to apply the changes."
