#!/usr/bin/env bash
if [[ -x $(which brew) ]]; then
    prefix=$(brew --prefix)

    # Source bash completion and virtualenvwrapper.
    files="share/bash-completion/bash_completion bin/virtualenvwrapper.sh"
    for file in $files; do
        if [[ -f $prefix/$file ]]; then
            . $prefix/$file
        fi
    done
fi
