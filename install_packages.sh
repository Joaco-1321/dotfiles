#!/bin/sh

# define paths
DOTFILES_DIR=$(dirname "$(realpath "$0")")

# function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# update and install essential packages
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm zsh docker docker-compose openssh stow unzip man-db base-devel tmux neovim keychain bat tree

# create the zshenv file in /etc/zsh/ using a heredoc
sudo tee /etc/zsh/zshenv > /dev/null << 'EOF'
if [[ ! -o norcs ]]; then
  export ZDOTDIR="$HOME/.config/zsh"
fi
EOF

# source the zshenv file
echo "sourcing /etc/zsh/zshenv..."
. /etc/zsh/zshenv

# change the user's shell to Zsh if it's not already Zsh
if [ "$SHELL" != "/bin/zsh" ]; then
    echo "changing the default shell to zsh for the current user..."
    chsh -s /bin/zsh
    echo "default shell changed to zsh. please log out and log back in for the change to take effect."
fi

# ensure ZDOTDIR exists
if [ ! -d "$ZDOTDIR" ]; then
    echo "creating $ZDOTDIR..."
    mkdir -p "$ZDOTDIR"
fi

# install oh-my-zsh
if [ ! -d "$ZDOTDIR/oh-my-zsh" ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $ZDOTDIR/oh-my-zsh
fi

# ensure ~/.local/bin exists
if [ ! -d ~/.local/bin ]; then
    echo "creating ~/.local/bin directory..."
    mkdir -p ~/.local/bin
fi

# install oh-my-posh
if [ ! -f ~/.local/bin/oh-my-posh ]; then
    curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
fi

# create docker group if not exist
if ! getent group docker > /dev/null 2>&1; then
    echo "docker group does not exist. creating the group..."
    sudo groupadd docker
fi

# add user to docker group
sudo usermod -aG docker "$USER"
echo "$USER has been added to the docker group"

# enable docker service
sudo systemctl docker.socket enable --now

echo "packages installed."

