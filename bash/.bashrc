# GIT ALIASES START
alias gi='git init'
alias gcl='git clone'

alias ga='git add'
alias gc='git commit -m'
alias gca='git commit -m --amend'
gac() {
    git add .
    git commit -m "$*"
}
alias gl='git log'
alias gs='git status'

alias gb='git branch'
alias gco='git checkout'

alias gr='git remote'
alias gra='git remote add'

alias gpu='git push'
alias gpuom='git push -u origin main'
alias gpl='git pull'
alias gplom='git pull -u origin main'
# GIT ALIASES END

# BASH COMMAND ALIASES START
alias clrdir='rm -rf ./* ./.??*'
alias l='ls'
alias la='ls -a'
alias c='cd'
alias m='mkdir'
alias t='touch'
alias r='rm -rf'
alias e='echo'
alias cl='clear'
alias off='poweroff'
alias rb='reboot'
alias pi='sudo pacman -S'
alias pu='sudo pacman -R'

alias nv='nvim'

alias dotsu='~/.dotfiles/scripts/setup.sh'
alias dotcu='~/.dotfiles/scripts/cleanup.sh'
alias nvimsu='~/.dotfiles/nvim/scripts/setup.sh'
alias nvimcu='~/.dotfiles/nvim/scripts/cleanup.sh'

# BASH COMMAND ALIASES END
