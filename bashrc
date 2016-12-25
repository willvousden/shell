# vim: set ft=sh:

# If bash_profile isn't yet sourced, that has to be done first.
if [[ -z $PROFILE_SOURCED ]]; then
    . ~/.bash_profile
fi

BSD_STYLE=true
if ls --color -d /dev/null &> /dev/null; then
    BSD_STYLE=
fi

GIT_PS1=${GIT_PS1-true}
GIT_PS1_BETTER=${GIT_PS1_BETTER-true}
LIVE_TERM_TITLE=${LIVE_TERM_TITLE-true}

if [[ $TERM != 'dumb' ]]; then
    if [[ $BSD_STYLE ]]; then
        export LS_OPTIONS='-G'
    else
        export LS_OPTIONS='--color=auto'
    fi

    if hash dircolors 2> /dev/null && [[ -r $HOME/.dir_colors ]]; then
        eval $(dircolors -b $HOME/.dir_colors)
    fi
fi

# Make a list of files from ~/.bashrc.d{,.local}
files=$(find -H ~/.bashrc.d{,.local} -mindepth 1 -type f 2> /dev/null)
files=$(paste <(<<<"$files" xargs -n1 basename) - <<<"$files" | sort -k1,1 | cut -f 2)
while read file; do
    [[ ! -f $file ]] || . $file
done <<<"$files"

if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion 2> /dev/null
elif [[ -d /etc/bash_completion.d ]]; then
    for file in /etc/bash_completion.d/*; do
        . $file 2> /dev/null
    done
fi

# Pip bash completion.
if hash pip 2> /dev/null; then
    eval $(pip completion --bash) 2> /dev/null
fi

# Check window size after each command and update LINES and COLUMNS.
shopt -s checkwinsize

if [[ -n $PROFILING ]] && shopt -q login_shell; then
    # Disable profiling code.
    set +x
    exec 2>&3 3>&-
fi
