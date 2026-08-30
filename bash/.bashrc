#
# ~/.bashrc
#

# Exit if not running interactively
[[ $- != *i* ]] && return


# GENERAL CONFIGURATION
# =====================

# Prompt
PS1='\[\e[1;34m\][\[\e[1;32m\]\u@\h \[\e[1;34m\]\W\[\e[1;34m\]]\[\e[0m\]\$ '

# Editor
export EDITOR='nvim'
export VISUAL="$EDITOR"

# PATH
export PATH="$HOME/.local/bin:$PATH"


# SHELL ALIASES
# =============

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
alias ...='cd ../..'


# SHELL FUNCTIONS
# ===============

# Clear the current directory
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

# Create a directory and enter it
mdcd() {
    if [[ -z "$1" ]]; then
        echo "Usage: mdcd <directory>"
        return 1
    fi

    mkdir -p -- "$1" && cd -- "$1"
}

# Remove the current directory and move to its parent
cdrd() {
    local dir
    dir="$(pwd)"

    cd .. || return 1
    rm -rf -- "$dir"
}

# Run an executable from the current directory
r() {
    if [[ -z "$1" ]]; then
        echo "Usage: r <executable> [arguments...]"
        return 1
    fi

    "./$1" "${@:2}"
}

# Free one or more ports
fp() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: fp <port1> [port2] [port3] ..."
        return 1
    fi

    for port in "$@"; do
        local pid
        pid="$(lsof -t -i :"$port")"

        if [[ -z "$pid" ]]; then
            echo "Port $port is already free"
            continue
        fi

        echo "Killing process $pid using port $port..."
        kill "$pid"

        echo "Port $port freed"
    done
}


# LOAD ADDITIONAL CONFIGURATION
# =============================

# Git
if [[ -f "$HOME/dotfiles/bash/git.sh" ]]; then
    source "$HOME/dotfiles/bash/git.sh"
fi

# Codeforces
if [[ -f "$HOME/dotfiles/bash/codeforces.sh" ]]; then
    source "$HOME/dotfiles/bash/codeforces.sh"
fi
