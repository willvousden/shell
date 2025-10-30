# If Homebrew is installed...
if [[ -x /usr/local/bin/brew ]]; then
    # ...then set the relevant paths.
    BREW_PREFIX=/usr/local
    export PATH="$BREW_PREFIX/bin:$PATH"
    export PATH="$BREW_PREFIX/sbin:$PATH"
    export MANPATH="$BREW_PREFIX/share/man:$MANPATH"

    # Set up aliases for GNU coreutils and findutils.
    for _p in coreutils findutils; do
        # Add MANPATH explicitly.
        export PATH=$BREW_PREFIX/opt/$_p/libexec/gnubin:${PATH-/usr/share/man}
        export MANPATH=$BREW_PREFIX/opt/$_p/libexec/gnuman:${MANPATH-/usr/share/man}
    done
fi
