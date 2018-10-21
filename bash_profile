# vim: set ft=sh:

# Don't run any of this if we're starting a desktop environment (and non-interactive and login
# shell)
if [[ $- != *i* ]] && shopt -q login_shell && [[ $DESKTOP_SESSION ]]; then
    return
fi

# Sort a list of files by base name.
sort_files()
{
    printf "%s\n" "$@" | paste <(printf "%s\n" "$@" | awk -F/ '{print $NF}') - | sort -k1,1 | cut -f2
}

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

export PATH="$HOME/.bin:$HOME/.bin.local:$PATH"
if hash nvim 2> /dev/null; then
    export EDITOR="/usr/bin/env nvim"
else
    export EDITOR="/usr/bin/env vim"
fi

# Source fiels files from ~/.bashrc.d{,.local}.
for file in $(sort_files ~/.bash_profile.d/* ~/.bash_profile.d.local/*); do
    [[ ! -f $file ]] || . $file
done

# If we haven't already sourced .bashrc, source it.
if [[ -z $BASHRC_SOURCED ]]; then
    . $HOME/.bashrc
fi

export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export TZ=Europe/London

# Must be at the end of the file to work.
if [[ -d ~/.sdkman ]]; then
    export SDKMAN_DIR=~/.sdkman
    [[ -s $SDKMAN_DIR/bin/sdkman-init.sh ]] && . "$SDKMAN_DIR/bin/sdkman-init.sh"
fi
