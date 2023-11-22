#!/bin/bash

CUR_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Install spacemacs
if [ ! -d $HOME/.emacs.d ]; then
	git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d
fi

# Install VIM plug for NeoVIM
if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]; then
	curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p $HOME/.config/nvim/
fi

# Configure git
git config --global init.defaultBranch main
git config --global user.email "nankeen@users.noreply.github.com"
git config --global user.name "Kai"

# Install rcfiles
stow --target $HOME home
stow --target $XDG_CONFIG_HOME
