#!/usr/bin/env bash

#export PROFILING=true
if [[ $PROFILING == true ]]; then
    # Add profiling code.
    PS4='+ $(date "+%s.%N")\011 '
    exec 3>&2 2>/tmp/bashstart.$$.log
    set -x
fi

export PYTHONSTARTUP=$HOME/.profile.d/python-startup.py
export EDITOR="/usr/bin/env vim"
export PATH="$HOME/.bin:$PATH"

# Source local profile scripts.
if [[ -d $HOME/.profile.d.local ]]; then
    for file in $HOME/.profile.d.local/*.sh; do
        [[ ! -f $file ]] || . $file
    done
fi

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

# Dissallow write access to terminal.
mesg n
