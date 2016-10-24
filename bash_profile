# vim: set ft=sh:

# This should only be sourced once.
if [[ $PROFILE_SOURCED ]]; then
    # But still we need to ensure that .bashrc is sourced.
    if [[ -z $BASHRC_SOURCED ]]; then
        . $HOME/.bashrc
    fi
    return
fi
export PROFILE_SOURCED=true

#export PROFILING=true
if [[ $PROFILING == true ]]; then
    # Add profiling code.
    PS4='+ $(date "+%s.%N")\011 '
    exec 3>&2 2>/tmp/bashstart.$$.log
    set -x
fi

export PYTHONSTARTUP=$HOME/.bash_profile.d/python-startup.py
export EDITOR="/usr/bin/env vim"
export PATH="$HOME/.bin:$HOME/.bin.local:$PATH"

# Source local profile scripts.
if [[ -d $HOME/.bash_profile.d.local ]]; then
    for file in $HOME/.bash_profile.d.local/*.sh; do
        [[ ! -f $file ]] || . $file
    done
fi

# Source additional profile scripts.
if [[ -d $HOME/.bash_profile.d ]]; then
    for file in $HOME/.bash_profile.d/*.sh; do
        [[ ! -f $file ]] || . $file
    done
fi

# If we haven't already sourced .bashrc, source it.
if [[ -z $BASHRC_SOURCED ]]; then
    . $HOME/.bashrc
fi

export TZ=Europe/London
export LD_LIBRARY_PATH=foo
