#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Install zshrc
cp $HOME/.zshrc $HOME/.zshrc.bak
echo "source $SCRIPT_DIR/zsh/oh-my-zsh-basic" > $HOME/.zshrc

cp $HOME/.tmux.conf $HOME/.tmux.conf.bak
echo "source $SCRIPT_DIR/tmux/minimal-status-middle" > $HOME/.tmux.conf

# Install VIM plug for NeoVIM
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p $HOME/.config/nvim/
echo "source $SCRIPT_DIR/nvim/init.vim" > $HOME/.config/nvim/init.vim

# Configure git
git config --global init.defaultBranch main
