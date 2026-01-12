# BASH COMMAND ALIASES AND SHELL FUNCTION START
alias clrdir='rm -rf ./* ./.??*'
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
