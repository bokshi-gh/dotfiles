rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim

sudo pacman -Rns $(pacman -Qdtq)
sudo pacman -Sc
