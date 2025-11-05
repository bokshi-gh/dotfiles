# BASH COMMAND ALIASES START
alias clrdir='rm -rf ./* ./.??*'
mdcd() {
	mkdir "$*"
	cd "$*"
}
alias dotsu='~/.dotfiles/scripts/setup.sh'
alias dotcu='~/.dotfiles/scripts/cleanup.sh'
alias nvimsu='~/.dotfiles/nvim/scripts/setup.sh'
alias nvimcu='~/.dotfiles/nvim/scripts/cleanup.sh'
# BASH COMMAND ALIASES END

# GIT ALIASES START
gac() {
    git add .
    git commit -m "$*"
}
gacp() {
	git add .
	git commit -m "$*"
	git push -u origin main
}
# GIT ALIASES END
