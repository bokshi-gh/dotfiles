# BASH COMMAND ALIASES AND SHELL FUNCTION START
alias clrdir='rm -rf ./* ./.??*'
alias dotsu='~/.dotfiles/scripts/setup.sh'
alias dotcu='~/.dotfiles/scripts/cleanup.sh'
alias nvimsu='~/.dotfiles/nvim/scripts/setup.sh'
alias nvimcu='~/.dotfiles/nvim/scripts/cleanup.sh'
mdcd() {
	mkdir "$*"
	cd "$*"
}
# BASH COMMAND ALIASES AND SHELL FUNCTION END

# GIT COMMAND ALIASES AND SHELL FUNCTION START
gac() {
    git add .
    git commit -m "$*"
}
gacp() {
	git add .
	git commit -m "$*"
	git push -u origin main
}
# GIT COMMAND ALIASES AND SHELL FUNCTION END
