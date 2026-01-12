rm -rf ~/.config/nvim \
       ~/.local/state/nvim \
       ~/.local/share/nvim

orphans=$(pacman -Qdtq)

if [ -n "$orphans" ]; then
    sudo pacman -Rns $orphans
else
    echo "No orphan packages found."
fi

sudo pacman -Sc
