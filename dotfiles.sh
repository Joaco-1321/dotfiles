#!/bin/sh

# Define paths
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DOTFILES_DIR="$SCRIPT_DIR"
CONFIG_DIR="$HOME/.config"
DOTFILES_CONFIG_DIR="$DOTFILES_DIR/.config"

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check if stow is installed
if ! command_exists stow; then
    echo "stow is not installed. please install it and try again"
    exit 1
fi

# Backup existing .config directory if it exists
if [ -d "$CONFIG_DIR" ]; then
    echo "backing up existing .config directory to .config.backup"
    mv "$CONFIG_DIR" "$CONFIG_DIR.backup"
fi

# Create necessary directories inside .config based on dotfiles repo structure
echo "Creating necessary directories inside .config..."
for dir in "$DOTFILES_CONFIG_DIR"/*; do
    if [ -d "$dir" ]; then
        mkdir -p "$CONFIG_DIR/$(basename "$dir")"
    fi
done

# Use stow to manage the config directory
echo "Stowing config..."
stow -d "$DOTFILES_DIR" -t "$HOME" --dotfiles .

# Clone the kickstart.nvim repository for Neovim configuration
echo "Cloning kickstart.nvim..."
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

echo "Dotfiles have been set up."
