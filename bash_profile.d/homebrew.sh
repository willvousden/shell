# If Homebrew is installed...
if [[ -x /usr/local/bin/brew ]]; then
    # ...then set the relevant paths.
    prefix=/usr/local
    export PATH="$prefix/bin:$PATH"
    export PATH="$prefix/sbin:$PATH"
    export MANPATH="$prefix/share/man:$MANPATH"

    # TODO Think about how to make this safe for Homebrew.
    if [[ -d $prefix/opt/coreutils ]]; then
        export PATH="$prefix/opt/coreutils/libexec/gnubin:$PATH"
        export MANPATH="$prefix/opt/coreutils/libexec/gnuman:$MANPATH"
    fi
    if [[ -d $prefix/opt/findutils ]]; then
        export PATH="$prefix/opt/findutils/libexec/gnubin:$PATH"
        export MANPATH="$prefix/opt/findutils/libexec/gnuman:$MANPATH"
    fi
fi
