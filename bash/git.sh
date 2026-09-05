#!/usr/bin/env bash

# Clone a repository
gcl() {
    if [[ -z "$1" ]]; then
        echo "Usage: gcl <repository-url>"
        return 1
    fi

    git clone "$1"
}

# Clone a repository and enter its directory
gclcd() {
    if [[ -z "$1" ]]; then
        echo "Usage: gclcd <repository-url>"
        return 1
    fi

    git clone "$1" || return 1

    local repo_dir
    repo_dir="$(basename -s .git "$1")"

    cd -- "$repo_dir" || return 1
}

# Add origin remote
grao() {
    if [[ -z "$1" ]]; then
        echo "Usage: grao <repository-url>"
        return 1
    fi

    git remote add origin "$1"
}

# Git status
gs() {
    git status
}

# Git log
glog() {
    git log --oneline --graph --decorate
}

# Stage all changes
ga() {
    git add -A
}

# Git commit
gc() {
    if [[ -z "$*" ]]; then
        echo "Usage: gc <commit-message>"
        return 1
    fi

    git commit -m "$*"
}

# Add and commit
gac() {
    if [[ -z "$*" ]]; then
        echo "Usage: gac <commit-message>"
        return 1
    fi

    git add -A || return 1
    git commit -m "$*" || return 1
}

# Push to configured upstream
gps() {
    git push
}

# Pull from configured upstream
gpl() {
    git pull
}

# Add, commit, and push
gacps() {
    if [[ -z "$*" ]]; then
        echo "Usage: gacps <commit-message>"
        return 1
    fi

    git add -A || return 1
    git commit -m "$*" || return 1
    git push || return 1
}
