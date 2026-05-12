# BASH COMMAND ALIASES AND SHELL FUNCTION START
alias clrdir='rm -rf ./* ./.??*'
run() {
    "./$1" "${@:2}"
}
freeport() {
    pid=$(lsof -t -i :"$1")

    if [ -z "$pid" ]; then
        echo "No process using port $1"
        return 1
    fi

    read -p "Kill process $pid on port $1? [y/N] " ans

    if [[ "$ans" =~ ^[Yy]$ ]]; then
        kill "$pid"
        echo "Killed."
    else
        echo "Cancelled."
    fi
}
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
gs() {
  git status
}
ga() {
	git add .
}
gac() {
    git add .
    git commit -m "$*"
}
gps() {
	git push -u origin main
}
gpl() {
	git pull origin main
}
gacps() {
	git add .
	git commit -m "$*"
	git push -u origin main
}
# GIT COMMAND ALIASES AND SHELL FUNCTION END
