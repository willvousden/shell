# vim: set ft=sh:

# Sort a list of files by base name.
sort_files()
{
    printf "%s\n" "$@" | paste <(printf "%s\n" "$@" | awk -F/ '{print $NF}') - | sort -k1,1 | cut -f2
}

# If bash_profile isn't yet sourced, that has to be done first.
if [[ -z $PROFILE_SOURCED ]]; then
    . ~/.bash_profile
fi

GIT_PS1=${GIT_PS1-true}
GIT_PS1_BETTER=${GIT_PS1_BETTER-true}
LIVE_TERM_TITLE=${LIVE_TERM_TITLE-true}

# Source files from ~/.bashrc.d{,.local}.
for file in $(sort_files ~/.bashrc.d/* ~/.bashrc.d.local/*); do
    [[ ! -f $file ]] || . $file
done

# Check window size after each command and update LINES and COLUMNS.
shopt -s checkwinsize

if [[ -n $PROFILING ]] && shopt -q login_shell; then
    # Disable profiling code.
    set +x
    exec 2>&3 3>&-
fi
