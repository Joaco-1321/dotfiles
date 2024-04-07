alias cl='clear'
alias ll='ls -lhAF'
alias la='ls -AF'

alias v='vim'

# util functions
mkcd () { [ ! -z "$1" ] && mkdir -p "$1" && cd "$1"; }
