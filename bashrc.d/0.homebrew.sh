if ! hash brew 2> /dev/null; then
    return
fi

prefix=$(brew --prefix)

# Set up aliases for GNU coreutils and findutils.  Must be careful when redefining
# these!
declare -A GNU_COMMANDS
GNU_COMMANDS=()
packages=(coreutils findutils)
for p in "${packages[@]}"; do
    package_prefix=$(brew --prefix "$p")
    for f in "$package_prefix/libexec/gnubin/"*; do
        # Register this command replacement (but only if the thing we're shadowing is just
        # a regular file; not, e.g., a builtin).
        if [[ -f $f && -x $f ]]; then
            n=$(basename "$f")
            t=$(type -p "$n")
            if [[ $? != 0 || $t ]]; then
                f=$(basename "$(\readlink "$f")")
                GNU_COMMANDS["$n"]="$f"
                eval "alias $n=$f"
            fi
        fi
    done

    # Add MANPATH explicitly.
    export MANPATH=$package_prefix/libexec/gnuman:${MANPATH-/usr/share/man}
done

# Set up Bash completion.
if [[ -f $prefix/etc/bash_completion ]]; then
    BASH_COMPLETION=$prefix/etc/bash_completion
fi
