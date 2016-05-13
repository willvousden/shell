if [[ -z $PYENV_ROOT ]] && [[ -d $HOME/.pyenv ]]; then
    export PYENV_ROOT=$HOME/.pyenv
fi

if [[ -n $PYENV_ROOT ]]; then
    hash pyenv 2> /dev/null
    found=$?
    if [[ $found != 0 ]]; then
        # Wasn't in path.
        if [[ -x $PYENV_ROOT/bin/pyenv ]]; then
            # But we've found it anyway.
            export PATH="$PYENV_ROOT/bin:$PATH"
            found=0
        fi
    fi

    if [[ $found == 0 ]]; then
        eval "$(pyenv init -)"
        #eval "$(pyenv virtualenv-init -)"
    fi
fi
