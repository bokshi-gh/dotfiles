#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# GENERAL CONFIGURATION
# =====================

# Prompt
PS1='[\u@\h \W]\$ '

# Editor
export EDITOR='nvim'
export VISUAL="$EDITOR"

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Bash completion
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
fi


# BASH COMMAND ALIASES AND SHELL FUNCTIONS
# =========================================

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
alias ...='cd ../..'

# Functions
clrdir() {
    echo "Current directory: $(pwd)"
    echo "This will delete files and directories in the current directory."

    read -r -p "Are you sure you want to continue? [y/N] " confirm

    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        return
    fi

    read -r -p "Include hidden files and directories? [y/N] " hidden

    if [[ "$hidden" =~ ^[Yy]$ ]]; then
        rm -rf -- ./* ./.??*
        echo "All files and directories deleted, including hidden files."
    else
        rm -rf -- ./*
        echo "Non-hidden files and directories deleted."
    fi
}

mdcd() {
    mkdir "$*" && cd "$*"
}

cdrd() {
    local dir
    dir="$(pwd)"

    cd .. || return 1
    rm -rf -- "$dir"
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
        local pid
        pid="$(lsof -t -i :"$port")"

        if [ -z "$pid" ]; then
            echo "Port $port is already free"
            continue
        fi

        echo "Killing process $pid using port $port..."
        kill "$pid"

        echo "Port $port freed"
    done
}


# GIT COMMAND ALIASES AND SHELL FUNCTIONS
# ========================================

gcl() {
    git clone "$1"
}

gclcd() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a repository URL."
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
