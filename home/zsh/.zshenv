# local
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# system
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

# custom
export EDITOR="nvim"
export VISUAL="nvim"

export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

export TMUX_TMPDIR=$HOME/.local/socket/tmux

export MANPAGER="nvim +Man!"

export FZF_DEFAULT_COMMAND="fd -Ht f -E '.git'"
export FZF_DEFAULT_OPTS="--height ~60% --cycle --layout reverse"

export VCPKG_ROOT="/home/joaco/third-party/vcpkg"

# path
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH:$VCPKG_ROOT"
