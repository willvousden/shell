# If Homebrew is installed...
if [[ -x /usr/local/bin/brew ]]; then
    # ...then set the relevant paths.
    prefix=/usr/local
    export PATH="$prefix/bin:$PATH"
    export PATH="$prefix/sbin:$PATH"
    export MANPATH="$prefix/share/man:$MANPATH"
fi
