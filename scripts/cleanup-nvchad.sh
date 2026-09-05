#!/bin/bash

rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim

orphans=$(pacman -Qdtq)

if [ -n "$orphans" ]; then
    sudo pacman -Rns $orphans
fi

sudo pacman -Sc
