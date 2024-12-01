#!/bin/bash

SCRIPT_DIR="${HOME}/projects/dotfiles"

# Vim setup
[ -d "$HOME/.vim" ] || mkdir ~/.vim
[ -e "$HOME/.vimrc" ] || ln -s "$SCRIPT_DIR/.vimrc" ~/.vimrc

# Tmux setup
[ -e "$HOME/.tmux.conf" ] || ln -s "$SCRIPT_DIR/.tmux.conf" ~/.tmux.conf

# Zsh setup
[ -e "$HOME/.zshrc" ] || ln -s "$SCRIPT_DIR/.zshrc" ~/.zshrc
if [ ! -d "$HOME/.antigen" ]
then
    mkdir ~/.antigen
    curl -L git.io/antigen > ~/.antigen/antigen.zsh
fi

# Nix setup
if [ ! -d "/nix" ]; then
    sh <(curl -L https://nixos.org/nix/install) --daemon
fi

if ! $(cat /etc/nix/nix.conf | grep -q "experimental-features"); then
    echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
    sudo systemctl restart nix-daemon.service
fi

if [ ! -d "$HOME/.config/home-manager" ]; then
# Home-manager setup - todo: figure out if the following three lines are needed once I have another machine to test
#nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
#nix-channel --update
#nix-shell '<home-manager>' -A install
nix run home-manager/master -- init --switch
fi

[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"
[ -e "$HOME/bin/starship" ] || curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir "$HOME/bin"
[ -e "${HOME}/.config/starship.toml" ] || ln -s ${SCRIPT_DIR}/starship.toml ~/.config/starship.toml


# Alacritty setup
if [ ! -d "$HOME/.config/alacritty" ]; then
    mkdir -p "$HOME/.config/alacritty/themes"
    git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
fi
[ -e "$HOME/.config/alacritty/alacritty.toml" ] || ln -s "$SCRIPT_DIR/alacritty.toml" ~/.config/alacritty/alacritty.toml

