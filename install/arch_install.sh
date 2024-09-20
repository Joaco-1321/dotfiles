#!/bin/sh

# define paths
DOTFILES_DIR=$(realpath "$0" | xargs dirname)

ensure_directory_exists() {
    local dir_path=$1

    if [ ! -d "dir_path" ]; then
        echo "creating $dir_path directory..."
        mkdir -p "$dir_path"
    fi
}

# update and install essential packages
sudo pacman -Syu -q --noconfirm
sudo pacman -S -q --noconfirm zsh docker docker-compose openssh stow unzip fd ripgrep man-db base-devel tmux neovim keychain bat tree fzf

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

# ensure respective directories exist
ensure_directory_exists "$ZDOTDIR"
ensure_directory_exists ~/.local/bin
ensure_directory_exists ~/.cache

# install oh-my-zsh
if [ ! -d "$ZDOTDIR/oh-my-zsh" ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $ZDOTDIR/oh-my-zsh
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
sudo systemctl enable --now docker.socket

echo "packages installed."

