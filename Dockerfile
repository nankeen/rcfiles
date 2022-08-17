FROM rockylinux:9

COPY . /rcfiles

RUN dnf install -y epel-release \
 && dnf install -y neovim zsh tmux git \
 && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
