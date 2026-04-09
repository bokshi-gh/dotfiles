# BASH COMMAND ALIASES AND SHELL FUNCTION START
alias clrdir='rm -rf ./* ./.??*'
mdcd() {
	mkdir "$*"
	cd "$*"
}
cdrd() {
    local dir
    dir="$(pwd)"
    cd .. || return 1
    rm -rf "$dir"
}
# BASH COMMAND ALIASES AND SHELL FUNCTION END

# GIT COMMAND ALIASES AND SHELL FUNCTION START
gcl() {
	git clone "$*"
}
ga() {
	git add .
}
gac() {
    git add .
    git commit -m "$*"
}
gph() {
	git push -u origin main
}
gpl() {
	git pull origin main
}
gacph() {
	git add .
	git commit -m "$*"
	git push -u origin main
}
# GIT COMMAND ALIASES AND SHELL FUNCTION END
