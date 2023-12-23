# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

shopt -s histappend

# Colours and prompt
PS1='\[\033[0;33m\]\u\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\]:\[\033[0;34m\]\W \[\033[0;35m\]λ\[\033[0m\] '
case "$TERM" in
	xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\]$PS1" ;; *) ;; esac

if [ -x /usr/bin/dircolors ]; then
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
else
	alias ls='ls -G'
fi

# vi-mode
set -o vi

# fzf bash
if [ -f ~/.fzf.bash ]; then 
	source ~/.fzf.bash 
elif [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
	source /usr/share/doc/fzf/examples/key-bindings.bash
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
. "$HOME/.cargo/env"

[ -f "/home/kai/.ghcup/env" ] && source "/home/kai/.ghcup/env" # ghcup-env

[ -f "/home/kai/.opam/opam-init/init.sh" ] && source "/home/kai/.opam/opam-init/init.sh" # Opam
