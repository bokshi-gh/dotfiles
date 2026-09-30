# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR='nvim'
export VISUAL="$EDITOR"
export PATH="$HOME/.local/bin:$PATH"

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \[\e[34m\]\W\[\e[0m\]]\$ '
