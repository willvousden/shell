if [[ -z $RBENV_ROOT ]] && [[ -d $HOME/.rbenv ]]; then
    export RBENV_ROOT=$HOME/.rbenv
fi

if [[ -n $RBENV_ROOT ]]; then
    which rbenv 2> /dev/null > /dev/null
    found=$?
    if [[ $found != 0 ]]; then
        # Wasn't in path.
        if [[ -x $RBENV_ROOT/bin/rbenv ]]; then
            # But we've found it anyway.
            export PATH="$RBENV_ROOT/bin:$PATH"
            found=0
        fi
    fi

    if [[ $found == 0 ]]; then
        eval "$(rbenv init -)"
    fi
fi
