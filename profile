# vim: set ft=sh:

PROFILE_SOURCED=true

#export PROFILING=true
if [[ $PROFILING == true ]]; then
    # Add profiling code.
    PS4='+ $(date "+%s.%N")\011 '
    exec 3>&2 2>/tmp/bashstart.$$.log
    set -x
fi

export PYTHONSTARTUP=$HOME/.profile.d/python-startup.py
export EDITOR="/usr/bin/env vim"
export PATH="$HOME/.bin:$HOME/.bin.local:$PATH"

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

# If we haven't already sourced .bashrc...
if [[ -z $BASHRC_SORUCED ]]; then
    # and we're running bash...
    if [[ $BASH_VERSION ]]; then
        # ...then source it.
        . $HOME/.bashrc
    fi
fi

export TZ=Europe/London
