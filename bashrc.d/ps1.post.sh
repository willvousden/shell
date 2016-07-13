PS1_USER_COLOUR=$green # User/host pair.
PS1_ROOT_COLOUR=$red # User/host (when root).
PS1_BRANCH_COLOUR=$yellow # Git branch name.
PS1_TIME_COLOUR=$base01 # The date/time pair.
PS1_DIR_COLOUR=$blue # The current directory.
PS1_DIRTY_COLOUR=$red # The "dirty" indicator for Git repos.
PS1_NEW_COLOUR=$violet # The "new files" indicator for Git repos.
PS1_SYMBOL_COLOUR=$base01 # The prompt symbol colour.
PS1_ERROR_COLOUR=$red # The prompt symbol colour (when the previous command failed).

__abbreviate() {
    length=${2:-6}
    if [[ $length == 1 ]]; then
        echo ${1:0:1}
    elif [[ ${#1} -gt $length ]]; then
        echo ${1:0:$(($length-2))}..
    else
        echo $1
    fi
}

__git_dirty () {
    (git diff --no-ext-diff --quiet --exit-code || \
     git diff --no-ext-diff --quiet --exit-code --cached) 2> /dev/null && \
        echo -n $1
}

__git_stash_flag () {
    [[ $(git stash list 2> /dev/null) ]] && echo -n $1
}

__git_added_flag () {
    git ls-files \
        --others \
        --exclude-standard \
        --error-unmatch \
        -- '*' > /dev/null 2> /dev/null && \
        echo -n "$1"
}

# Encase non-printing characters.
c()
{
    printf '\[%s\]' $1
}

export PROMPT_COMMAND="__prompt_command"
__prompt_command() {
    # What was the exit code of the last command the user ran?
    local exit_code="$?"
    PS1=

    # Decide on a colour for the user name (are we root?).
    if [[ $EUID == 0 ]]; then
        local user_color=$PS1_ROOT_COLOUR
    else
        local user_color=$PS1_USER_COLOUR
    fi

    # Set a standard PS1 contents: user@host:dir (with colours).
    local user=$(__abbreviate $USER 1)
    local host=$(__abbreviate $(hostname -s) 1)
    local ps1_inner="$(c $user_color)$user@$host$(c $base01):$(c $blue)\W$(c $reset)"

    # If "better PS1" is asked for, augment this with (coloured) Git information.
    if hash git 2> /dev/null && \
       hash __git_ps1 2> /dev/null && \
       [[ $GIT_PS1 || $GIT_PS1_BETTER ]]; then
        ps1_inner+='$(__git_ps1 " '$(c $PS1_BRANCH_COLOUR)'%s")'
        if [[ $GIT_PS1_BETTER ]]; then
            local dirty_flag=*
            local stash_flag=+
            local added_flag=?

            ps1_inner+='$(__git_stash_flag "'$(c $PS1_BRANCH_COLOUR)$stash_flag'")'
            ps1_inner+='$(__git_dirty "'$(c $PS1_DIRTY_COLOUR)$dirty_flag'")'
            ps1_inner+='$(__git_added_flag "'$(c $PS1_NEW_COLOUR)$added_flag'")'$(c $reset)
        fi
    fi

    # What prompt symbol shall we use?
    local prompt_symbol="$(c $PS1_SYMBOL_COLOUR)"'\$'"$(c $reset)"
    if [[ $exit_code != 0 ]]; then
        # Last command failed; spruce it up a bit.
        prompt_symbol="$(c $PS1_ERROR_COLOUR)!$(c $reset)"
    fi

    # Add the date.
    d=$(date '+%d/%m')
    t=$(date '+%H:%M')

    # Now wrap the contents in some decoration and export.
    export PS1="$(c $PS1_TIME_COLOUR)$d$(c $base02),$(c $PS1_TIME_COLOUR)$t $ps1_inner $prompt_symbol "
}

# Set PS2 (secondary prompt) as well.
export PS2="$(c $base01)>$(c $reset) "
