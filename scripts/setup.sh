#!/bin/bash

GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

if [ -f "$HOME/.dotfiles/scripts/cleanup.sh" ]; then
    bash "$HOME/.dotfiles/scripts/cleanup.sh"
    echo ""
else
    echo -e "${RED}Cleanup script not found${NC}"
    echo ""
fi

copy_file_or_dir() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ]; then
        echo -e "${RED}Source not found:${NC} $src"
        return 1
    fi

    if [ -d "$src" ]; then
        cp -r "$src" "$dest"
    else
        cp "$src" "$dest"
    fi

    echo -e "${GREEN}Copied:${NC} $src → $dest"
}

mkdir -p "$HOME/.ssh"

echo -e "${GREEN}[SETTING UP CONFIGURATION FILES AND FOLDERS]${NC}"

copy_file_or_dir "$HOME/.dotfiles/git/.gitconfig" "$HOME/.gitconfig"
copy_file_or_dir "$HOME/.dotfiles/vim/.vimrc" "$HOME/.vimrc"
copy_file_or_dir "$HOME/.dotfiles/ssh/config" "$HOME/.ssh/config"
copy_file_or_dir "$HOME/.dotfiles/ssh/id_rsa_github" "$HOME/.ssh/id_rsa_github"

chmod 600 "$HOME/.ssh/id_rsa_github"

if [ -f "$HOME/.bashrc" ]; then
    mv "$HOME/.bashrc" "$HOME/.previous-bashrc"
    echo -e "${GREEN}Backed up:${NC} ~/.bashrc → ~/.previous-bashrc"
fi

cp "$HOME/.dotfiles/bash/.bashrc" "$HOME/.bashrc"

if [ -f "$HOME/.previous-bashrc" ]; then
    echo "" >> "$HOME/.bashrc"
    cat "$HOME/.previous-bashrc" >> "$HOME/.bashrc"
fi

echo -e "${GREEN}Configured:${NC} ~/.bashrc"
