if [[ -x $(which brew 2> /dev/null) ]]; then
    prefix=$(brew --prefix)

    if [[ -f $prefix/share/bash-completion/bash_completion ]]; then
        . $prefix/share/bash-completion/bash_completion
    elif [[ -f $prefix/etc/bash_completion ]]; then
        . $prefix/etc/bash_completion
    fi
fi
