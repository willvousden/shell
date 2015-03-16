# If Homebrew is installed...
if [[ -x /usr/local/bin/brew ]]; then
    # ...then set the relevant paths.
    prefix=/usr/local
    export PATH="$prefix/bin:$PATH"
    export MANPATH="$prefix/share/man:$MANPATH"
    if [[ -d $prefix/opt/coreutils ]]; then
        export PATH="$prefix/opt/coreutils/libexec/gnubin:$PATH"
        export MANPATH="$prefix/opt/coreutils/libexec/gnuman:$MANPATH"
    fi
fi
