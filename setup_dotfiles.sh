#!/bin/sh

# define paths
DOTFILES_DIR=$(dirname "$(realpath "$0")")
CONFIG_DIR="$HOME/.config"

# function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# check if stow is installed
if ! command_exists stow; then
    echo "stow is not installed. please install it and try again"
    exit 1
fi

# create necessary directories inside .config based on dotfiles repo structure
echo "creating necessary directories inside .config..."
for dir in "$DOTFILES_DIR"/pkgs/home/.config/*; do
    if [ -d "$dir" ]; then
        mkdir -p "$CONFIG_DIR/$(basename "$dir")"
    fi
done

# create plugins directory for tmux config (to avoid symlink the directory)
mkdir -p "$CONFIG_DIR/tmux/plugins"

# use stow to manage the config directory
echo "stowing config..."
stow -d "$DOTFILES_DIR/pkgs" -t "$HOME" home
stow -d "$DOTFILES_DIR/pkgs" -t "$CONFIG_DIR/zsh/oh-my-zsh/custom" zsh-custom

# clone the kickstart.nvim repository for neovim configuration
echo "cloning kickstart.nvim..."
git clone https://github.com/joaco-1321/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

echo "dotfiles have been set up."
