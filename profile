#!/usr/bin/env bash

export PYTHONSTARTUP=$HOME/.profile.d/python-startup.py
export EDITOR="/usr/bin/env vim"
export PATH="$HOME/.bin:$PATH"

# Source additional profile scripts.
if [[ -d $HOME/.profile.d ]]; then
    for file in $HOME/.profile.d/*.sh; do
        [[ ! -f $file ]] || . $file
	done
fi

# If running bash...
if [[ $BASH_VERSION && -f $HOME/.bashrc ]]; then
    # ...then include .bashrc.
    . $HOME/.bashrc
fi
