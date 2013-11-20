#!/usr/bin/env bash

# If Homebrew is installed...
if [[ -x /usr/local/bin/brew ]]; then
    # Then set the relevant paths.
    prefix=/usr/local
    export PATH="$prefix/bin:$PATH"
    export MANPATH="$prefix/share/man:$MANPATH"
    if [[ -d $prefix/opt/coreutils ]]; then
        export PATH="$prefix/opt/coreutils/libexec/gnubin:$PATH"
        export MANPATH="$prefix/opt/coreutils/libexec/gnuman:$MANPATH"
    fi
fi

export PYTHONSTARTUP=$HOME/.profile.d/python-startup.py
export EDITOR="/usr/bin/env vim"
export PATH="$HOME/.bin:$PATH"

# Source additional profile scripts.
if [[ -d $HOME/.profile.d ]]; then
    for file in $HOME/.profile.d/*; do
        [[ ! -f $file ]] || . $file
	done
fi

# If running bash...
if [[ $BASH_VERSION && -f $HOME/.bashrc ]]; then
    # ...then include .bashrc.
    . $HOME/.bashrc
fi
