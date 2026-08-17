gcl() {
    if [ -z "$1" ]; then
        echo "Usage: gcl <repository-url>"
        return 1
    fi

    git clone "$1"
}

gclcd() {
    if [ -z "$1" ]; then
        echo "Usage: gclcd <repository-url>"
        return 1
    fi

    git clone "$1" || return 1

    local repo_dir
    repo_dir="$(basename "$1" .git)"

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
    if [ -z "$*" ]; then
        echo "Usage: gac <commit-message>"
        return 1
    fi

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
    if [ -z "$*" ]; then
        echo "Usage: gacps <commit-message>"
        return 1
    fi

    git add .
    git commit -m "$*"
    git push -u origin main
}
