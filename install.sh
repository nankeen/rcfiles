#!/bin/bash

CUR_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DIR=$HOME/.rcfiles
INSTALL_COLEMAK=true

# Link script dir to home directory
ln -s $CUR_DIR $SCRIPT_DIR

# Install zshrc
if [ -f $HOME/.zshrc ]; then
	cp $HOME/.zshrc $HOME/.zshrc.bak
fi
echo "source $SCRIPT_DIR/zsh/oh-my-zsh-basic" > $HOME/.zshrc

# Install tmux configs
if [ -f $HOME/.tmux.conf ]; then
	cp $HOME/.tmux.conf $HOME/.tmux.conf.bak
fi
echo "source $SCRIPT_DIR/tmux/minimal-status-middle" > $HOME/.tmux.conf

# Install VIM plug for NeoVIM
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p $HOME/.config/nvim/
echo "source $SCRIPT_DIR/nvim/init.vim" > $HOME/.config/nvim/init.vim

# Optional Colemak bindings
if $INSTALL_COLEMAK; then
	echo "source $SCRIPT_DIR/zsh/colemak-bindings" >> $HOME/.zshrc
	echo "source $SCRIPT_DIR/tmux/colemak-bindings" >> $HOME/.tmux.conf
	echo "source $SCRIPT_DIR/nvim/colemak.vim" >> $HOME/.config/nvim/init.vim
fi

# Configure git
git config --global init.defaultBranch main
git config --global user.email "nankeen@users.noreply.github.com"
git config --global user.name "Kai"
