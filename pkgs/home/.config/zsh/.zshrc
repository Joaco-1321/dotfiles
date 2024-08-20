# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/oh-my-zsh"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# unset autocd
unsetopt autocd

# change where stores history
HISTFILE=$ZDOTDIR/.zsh_history

# omp init
eval "$(oh-my-posh init zsh --config ~/.config/zsh/koki-theme.toml)"

# ssh-agent stuff
# eval `keychain --eval -q joaco_key koki_key`

# start a tmux session if not already in one
if [ -z "$TMUX" ]; then
  if tmux has -t main 2>/dev/null; then
      tmux a -t main
  else
      tmux new -s main -n shell
  fi
fi

