#!/usr/bin/zsh

# install essential
sudo pacman -S --noconfirm stow unzip base-devel

# create XDG config
mkdir -p ~/.config/{zsh,tmux,nvim,vim}

# set ZDOTDIR variable
sudo cp ./misc/zshenv /etc/zsh/

# stow zsh stuff
stow -t ~/.config/zsh/ zsh

# source environment variables
. /etc/zsh/zshenv
. ~/.config/zsh/.zshenv

# install omz
git clone https://github.com/ohmyzsh/ohmyzsh.git $ZDOTDIR/oh-my-zsh

# set aliases
cp ./misc/aliases.zsh "$ZDOTDIR/oh-my-zsh/custom/"

# local bin
mkdir -p ~/.local/bin

# install omp
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

# install nice stuff
sudo pacman -S -q --noconfirm openssh tmux neovim keychain bat tree 

# create tmux plugins dir
mkdir -p ~/.config/tmux/plugins/

# stow tmux stuff
stow -t ~/.config/tmux/ tmux

# set up nvim config
git clone https://github.com/Joaco-1321/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

# finally source rc
. $ZDOTDIR/.zshrc

