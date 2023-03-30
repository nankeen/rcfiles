#!/bin/bash

CUR_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DIR=$HOME/.rcfiles
INSTALL_COLEMAK=true

# Link script dir to home directory
ln -s $CUR_DIR $SCRIPT_DIR

# Install bashrc
if [ -f $HOME/.bashrc ]; then
	mv $HOME/.bashrc $HOME/.bashrc.bak
fi
ln -s $SCRIPT_DIR/.bashrc $HOME/.bashrc 

# Install zshrc
if [ -f $HOME/.zshrc ]; then
	mv $HOME/.zshrc $HOME/.zshrc.bak
fi
ln -s $SCRIPT_DIR/.zshrc $HOME/.zshrc

# Install tmux configs
if [ -f $HOME/.tmux.conf ]; then
	mv $HOME/.tmux.conf $HOME/.tmux.conf.bak
fi
ln -s $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf

# Install spacemacs
if [ ! -d $HOME/.emacs.d ]; then
	git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d
fi

# Install spacemacs configs
if [ -f $HOME/.spacemacs ]; then
	mv $HOME/.spacemacs $HOME/.spacemacs.bak
fi
ln -s $SCRIPT_DIR/.spacemacs $HOME/.spacemacs

# Install VIM plug for NeoVIM
if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]; then
	curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p $HOME/.config/nvim/
fi

# Install neovim configs
if [ -f $HOME/.config/nvim/init.vim ]; then
	mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.bak
fi
ln -s $SCRIPT_DIR/.config/nvim/init.vim $HOME/.config/nvim/init.vim

# Configure git
git config --global init.defaultBranch main
git config --global user.email "nankeen@users.noreply.github.com"
git config --global user.name "Kai"
