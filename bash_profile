# vim: set ft=sh:

# Don't run any of this if we're starting a desktop environment (and non-interactive and login
# shell)
if [[ $- != *i* ]] && shopt -q login_shell && [[ $DESKTOP_SESSION ]]; then
    return
fi

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

export PYTHONSTARTUP=$HOME/.python-startup.py
export EDITOR="/usr/bin/env vim"
export PATH="$HOME/.bin:$HOME/.bin.local:$PATH"

# Make a list of files from ~/.bashrc.d{,.local}
files=$(find -H ~/.bash_profile.d{,.local} -mindepth 1 -type f 2> /dev/null)
lines=$(paste <(<<<"$files" xargs -n1 basename) - <<<"$files" | sort -k1,1)
while read name path; do
    [[ ! -f $path ]] || . $path
done <<<"$lines"

# If we haven't already sourced .bashrc, source it.
if [[ -z $BASHRC_SOURCED ]]; then
    . $HOME/.bashrc
fi

export TZ=Europe/London
