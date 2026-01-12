#!/bin/bash

GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

# NOTE: After running this clean.sh, manually run `source ~/.bashrc` 
# to apply the updated shell configuration in the current session.

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

targets=(
    ~/.gitconfig
    ~/.vimrc
    ~/.ssh/config
    ~/.ssh/id_rsa_github
)

for t in "${targets[@]}"; do
    delete_file_or_dir "$t"
done

# Restoring previous bashrc
[ -f ~/.previous-bashrc ] && mv ~/.previous-bashrc ~/.bashrc
echo -e "${GREEN}Restored:${NC} ~/.previous-bashrc"
