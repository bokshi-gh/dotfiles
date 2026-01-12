#!/bin/bash

# NOTE: After running clean.sh, manually run `source ~/.bashrc` so the updated shell configuration takes effect in the current session.

GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${GREEN}[DELETING CONFIGURATION FILES AND FOLDERS]${NC}"

delete_file_or_dir() {
    local target="$1"
    if [ -e "$target" ]; then
        rm -rf "$target"
        echo -e "${GREEN}Deleted:${NC} $target"
    else
        echo -e "${RED}Skipped:${NC} $target does not exist"
    fi
}

targets=(
    "$HOME/.gitconfig"
    "$HOME/.vimrc"
    "$HOME/.ssh/config"
    "$HOME/.ssh/id_rsa_github"
)

for t in "${targets[@]}"; do
    delete_file_or_dir "$t"
done

if [ -f "$HOME/.previous-bashrc" ]; then
    rm -f "$HOME/.bashrc"
    mv "$HOME/.previous-bashrc" "$HOME/.bashrc"
    echo -e "${GREEN}Restored:${NC} ~/.bashrc from ~/.previous-bashrc"
else
    echo -e "${RED}No backup found:${NC} ~/.previous-bashrc"
fi

