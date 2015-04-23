# Generate dirty status flag for Git.
__git_status () {
    if [[ $(type -t git) ]] && git status --porcelain 2> /dev/null | grep -q '^\s*[ACDMRU]'; then
		# Generate Git output for PS1.
        echo -n $1
	fi
}

__git_stash_flag () {
    [[ $(git stash list 2> /dev/null) ]] && echo -n $1
}

__git_added_flag () {
    git status --porcelain 2> /dev/null | grep -q '^\s*??' && echo -n $1
}

# Generate branch/location information for Git repositories.
__git_tag () {
	local tag=
    if [[ $(type -t git) ]] && [[ $(type -t __git_ps1) ]]; then
        # Generate Git output using standard completion function.
        tag=$(__git_ps1 '%s')
    elif [[ $(type -t git) ]] && git status --porcelain &> /dev/null; then
        tag=?
	fi

	if [[ $tag ]]; then
		printf "${1:- (%s)}" $tag
	fi
}

# Encase non-printing characters.
c()
{
    echo '\['$1'\]'
}

export PROMPT_COMMAND="__prompt_command"
__prompt_command() {
    # What was the exit code of the last command the user ran?
    local exit_code="$?"
    PS1=

    # Decide on a colour for the user name (are we root?).
    if [[ $EUID == 0 ]]; then
        local user_color=$red
    else
        local user_color=$green
    fi

    # Set a standard PS1 contents: user@host:dir (with colours).
    local ps1_inner="$(c $user_color)\u@\h$(c $off):$(c $blue)\W$(c $off)"

    # If "better PS1" is asked for, augment this with (coloured) Git information.
    if [[ $BETTER_PS1 == true ]]; then
        local dirty_flag='*'
        local stash_flag='+'
        local added_flag='?'

        ps1_inner+='$(__git_tag "|'$(c $yellow)'%s")'
        ps1_inner+='$(__git_stash_flag "'$(c $yellow)$stash_flag'")'
        ps1_inner+='$(__git_status "'$(c $red)$dirty_flag'")'
        ps1_inner+='$(__git_added_flag "'$(c $purple)$added_flag'")'$(c $off)
    fi

    # What prompt symbol shall we use?
    local prompt_symbol='\$'
    if [[ $exit_code != 0 ]]; then
        # Last command failed; spruce it up a bit.
        prompt_symbol="$(c $red)!$(c $off)"
    fi

    # Now wrap the contents in some decoration and export.
    export PS1="$(c $off)[$ps1_inner]$prompt_symbol "
}

# Set PS2 (secondary prompt) as well.
export PS2="$(c $blue)>$(c $off) "
