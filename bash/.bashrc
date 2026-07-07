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
gclcd() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a repository URL."
        return 1
    fi

    # Clone the repository
    git clone "$1" || return 1

    # Extract the directory name from the URL
    local repo_dir
    repo_dir=$(basename "$1" .git)

    # Change into the directory
    cd "$repo_dir" || return 1
}
grao() {
    if [ -z "$1" ]; then
        echo "Usage: grao <repository-url>"
        return 1
    fi

    git remote add origin "$1"
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
