# If pyenv exists as an executable file, but isn't yet a shell function...
if hash pyenv 2> /dev/null && [[ $(type -t pyenv) != function ]]; then
    # ... then initialise pyenv.
    eval "$(pyenv init -)"
    #eval "$(pyenv virtualenv-init -)"
fi
