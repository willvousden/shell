if [[ -z $PYENV_ROOT ]] && [[ -d $HOME/.pyenv ]]; then
    export PYENV_ROOT=$HOME/.pyenv
fi

if [[ -n $PYENV_ROOT ]] && [[ -x $(which pyenv 2> /dev/null) ]]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    #eval "$(pyenv virtualenv-init -)"
fi
