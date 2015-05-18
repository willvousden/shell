if [[ -z $PYENV_ROOT ]] && [[ -d $HOME/.pyenv ]]; then
    export PYENV_ROOT=$HOME/.pyenv
fi

if [[ -n $PYENV_ROOT ]] && [[ -x $PYENV_ROOT/bin/pyenv ]]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    #eval "$(pyenv virtualenv-init -)"
fi
