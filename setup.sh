#!/bin/bash

SCRIPT_DIR="${HOME}/projects/dotfiles"

# Nix setup
if [ ! -d "/nix" ]; then
    sh <(curl -L https://nixos.org/nix/install) --daemon
fi

if ! $(cat /etc/nix/nix.conf | grep -q "experimental-features"); then
    echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
    sudo systemctl restart nix-daemon.service
fi

if [ ! -d "$HOME/.config/home-manager" ]; then
    ln -s "$SCRIPT_DIR/home-manager" "$HOME/.config/"
    nix run home-manager/master -- init --switch
fi

[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"
