# install essential
sudo pacman -S --noconfirm stow unzip curl

# create XDG config
mkdir -p ~/.config/{zsh,tmux,nvim,vim}

# set ZDOTDIR variable
sudo cp ./misc/zshenv /etc/zsh/

# stow zsh stuff
sudo stow -t ~/.config/zsh/ ./zsh/

# source necessary
. /etc/zsh/zshenv
. ~/.config/zsh/.zshenv

# install omz
ZSH="$ZDOTDIR/oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unatended


# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

