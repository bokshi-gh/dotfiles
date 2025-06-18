#!/bin/bash

echo "[🧹 Removing symlinks...]"

rm -f ~/.bashrc && echo "Removed ~/.bashrc"
rm -f ~/.gitconfig && echo "Removed ~/.gitconfig"
rm -f ~/.gitignore_global && echo "Removed ~/.gitignore_global"
rm -f ~/.vimrc && echo "Removed ~/.vimrc"
rm -f ~/.config/nvim && echo "Removed ~/.config/nvim"
rm -f ~/.ssh/config && echo "Removed ~/.ssh/config"
rm -f ~/.ssh/id_rsa_github && echo "Removed ~/.ssh/id_rsa_github"

echo "[✅ Removal complete!]"

