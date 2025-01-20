function remove_symlink() {
    rm -rf "$1"
    echo "Symlink $1 is removed"
}

# Remove symlinks for Bash
remove_symlink ~/.bashrc
remove_symlink ~/.bash_profile
remove_symlink ~/.aliases.bash

# Remove symlinks for Git
remove_symlink ~/.gitconfig
remove_symlink ~/.gitignore_global

# Remove symlinks for Vim
remove_symlink ~/.vimrc
remove_symlink ~/.vim/plugins.vim

# Remove symlinks for Neovim
remove_symlink ~/.config/nvim/init.vim

echo ""

# Ensure all necessary directories is removed after all the symlinks are removed
rm -rf ~/.vim
rm -rf ~/.config

if [ ! -d ~/.vim ]
then
	dir_name="~/.vim"
	echo "Directory $dir_name is removed"
fi

if [ ! -d ~/.config/nvim ]
then
	dir_name="~/.config/nvim"
	echo "Directory $dir_name is removed"
fi
