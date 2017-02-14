if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion 2> /dev/null
elif [[ -d /etc/bash_completion.d ]]; then
    for file in /etc/bash_completion.d/*; do
        . $file 2> /dev/null
    done
fi

# Pip bash completion.
if hash pip 2> /dev/null; then
    eval "$(pip completion --bash)" 2> /dev/null
fi

if [[ $BASH_COMPLETION ]]; then
    . "$BASH_COMPLETION"
elif [[ -f /etc/bash_completion ]]; then
    # Source completion from default directory.
    . /etc/bash_completion
elif [[ -d /etc/bash_completion.d ]]; then
    # Couldn't find the file, but did find directory, so source all of the files therein.
    for file in /etc/bash_completion.d/*; do
        [[ ! -f $file ]] || . "$file" 2> /dev/null
    done
fi

if [[ $GIT_COMPLETION ]]; then
    . "$GIT_COMPLETION/git-completion.bash"
    . "$GIT_COMPLETION/git-prompt.sh"
fi