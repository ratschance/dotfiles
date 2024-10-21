#!/bin/bash

SCRIPT_DIR="${HOME}/projects/dotfiles"

# Vim setup
[ -d "${HOME}/.vim" ] || mkdir ~/.vim
[ -e "${HOME}/.vimrc" ] || ln -s ${SCRIPT_DIR}/.vimrc ~/.vimrc

# Tmux setup
[ -e "${HOME}/.tmux.conf" ] || ln -s ${SCRIPT_DIR}/.tmux.conf ~/.tmux.conf

# Zsh setup
[ -e "${HOME}/.zshrc" ] || ln -s ${SCRIPT_DIR}/.zshrc ~/.zshrc
if [ ! -d "${HOME}/.antigen" ]
then
    mkdir ~/.antigen
    curl -L git.io/antigen > ~/.antigen/antigen.zsh
fi

[ -e "$HOME/bin" ] || mkdir -p "$HOME/bin"
[ -e "$HOME/bin/starship" ] || curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir "$HOME/bin"
[ -e "${HOME}/.config/starship.toml" ] || ln -s ${SCRIPT_DIR}/starship.toml ~/.config/starship.toml

# NeoVim setup
[ -e "${HOME}/.vim/init.vim" ] || ln -s ${SCRIPT_DIR}/.vimrc ~/.vim/init.vim
[ -d "${HOME}/.config/nvim" ] || ln -s ~/.vim ~/.config/nvim

