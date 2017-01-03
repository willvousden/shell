# vim: set ft=sh:

# If bash_profile isn't yet sourced, that has to be done first.
if [[ -z $PROFILE_SOURCED ]]; then
    . ~/.bash_profile
fi

GIT_PS1=${GIT_PS1-true}
GIT_PS1_BETTER=${GIT_PS1_BETTER-true}
LIVE_TERM_TITLE=${LIVE_TERM_TITLE-true}

# Make a list of files from ~/.bashrc.d{,.local}, sorting them by basename.
files=$(find -H ~/.bashrc.d{,.local} -mindepth 1 -type f -o -type l 2> /dev/null)
files=$(paste <(<<<"$files" xargs -n1 basename) - <<<"$files" | sort -k1,1 | cut -f 2)
while read file; do
    [[ ! -f $file ]] || . $file
done <<<"$files"

# Check window size after each command and update LINES and COLUMNS.
shopt -s checkwinsize

if [[ -n $PROFILING ]] && shopt -q login_shell; then
    # Disable profiling code.
    set +x
    exec 2>&3 3>&-
fi
