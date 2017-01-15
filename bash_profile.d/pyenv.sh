if [[ -z $PYENV_ROOT ]] && [[ -d $HOME/.pyenv ]]; then
    export PYENV_ROOT=$HOME/.pyenv
fi

if [[ -n $PYENV_ROOT ]]; then
    if ! hash pyenv 2> /dev/null; then
        # Wasn't in path.
        if [[ -x $PYENV_ROOT/bin/pyenv ]]; then
            # But we've found it anyway.
            export PATH="$PYENV_ROOT/bin:$PATH"
        fi
    fi
fi
