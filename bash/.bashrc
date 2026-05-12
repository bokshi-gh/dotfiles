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
r() {
    "./$1" "${@:2}"
}
fp() {
    if [ $# -eq 0 ]; then
        echo "Usage: fp <port1> [port2] [port3] ..."
        return 1
    fi

    for port in "$@"; do
        pid=$(lsof -t -i :"$port")

        if [ -z "$pid" ]; then
            echo "Port $port is already free"
            continue
        fi

        echo "Killing process $pid using port $port..."
        kill "$pid"

        echo "Port $port freed"
    done
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
