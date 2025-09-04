#!/bin/bash

# ANSI color codes
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}[DELETING CONFIGURATION FILES AND FOLDERS]${NC}"

delete_file_or_dir() {
    local target=$1
    if [ -e "$target" ]; then
        rm -rf "$target"
        echo -e "${GREEN}Deleted:${NC} $target"
    else
        echo -e "${RED}Skipped:${NC} $target does not exist"
    fi
}

# List of files/folders to delete
targets=(
    ~/.gitconfig
    ~/.vimrc
    ~/.config/nvim
    ~/.ssh/config
    ~/.ssh/id_rsa_github
)

for t in "${targets[@]}"; do
    delete_file_or_dir "$t"
done

# Restoring previous bashrc
[ -f ~/.previous-bashrc ] && mv ~/.previous-bashrc ~/.bashrc
