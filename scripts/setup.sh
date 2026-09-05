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
mkdir -p "$HOME/.local/bin"


# SETTING UP DOTFILES
# ===================

echo -e "${GREEN}[Setting up dotfiles]${NC}"
echo ""


# Backup existing .bashrc
if [[ -L "$HOME/.bashrc" ]]; then
    echo -e "${GREEN}Already linked:${NC} ~/.bashrc"
elif [[ -f "$HOME/.bashrc" ]]; then
    rm -f "$HOME/.bashrc.backup"
    mv "$HOME/.bashrc" "$HOME/.bashrc.backup"

    echo -e "${YELLOW}Backed up:${NC} ~/.bashrc → ~/.bashrc.backup"
fi


# Link Bash configuration
ln -sfn "$DOTFILES/bash/.bashrc" "$HOME/.bashrc"

echo -e "${GREEN}Linked:${NC} $DOTFILES/bash/.bashrc → ~/.bashrc"


# Link Git configuration
ln -sfn "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"

echo -e "${GREEN}Linked:${NC} $DOTFILES/git/.gitconfig → ~/.gitconfig"


# Link Vim configuration
ln -sfn "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"

echo -e "${GREEN}Linked:${NC} $DOTFILES/vim/.vimrc → ~/.vimrc"


# Link SSH configuration
ln -sfn "$DOTFILES/ssh/config" "$HOME/.ssh/config"

echo -e "${GREEN}Linked:${NC} $DOTFILES/ssh/config → ~/.ssh/config"


# SSH permissions
chmod 700 "$HOME/.ssh"
chmod 600 "$HOME/.ssh/config"


# Link cproj
chmod +x "$DOTFILES/bash/bin/cproj"
ln -sfn "$DOTFILES/bash/bin/cproj" "$HOME/.local/bin/cproj"

echo -e "${GREEN}Linked:${NC} $DOTFILES/bash/bin/cproj → ~/.local/bin/cproj"


echo ""
echo -e "${GREEN}Dotfiles setup complete.${NC}"
echo "Run 'source ~/.bashrc' or open a new terminal to apply Bash changes."
