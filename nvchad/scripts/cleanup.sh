#!/bin/bash

rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim

orphans=$(pacman -Qdtq)

if [ -n "$orphans" ]; then
    sudo pacman -Rns $orphans
else
    echo "No orphan packages found."
fi

sudo pacman -Sc
