RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
BROWN='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
PURPLE='\[\033[0;35m\]'
CYAN='\[\033[0;036m\]'

LIGHTRED='\[\033[1;31m\]'
LIGHTGREEN='\[\033[1;32m\]'
YELLOW='\[\033[1;33m\]'
LIGHTBLUE='\[\033[1;34m\]'
LIGHTPURPLE='\[\033[1;35m\]'
LIGHTCYAN='\[\033[1;036m\]'

BLACK='\[\033[0;30\]'
DARKGREY='\[\033[1;30\]'
LIGHTGREY='\[\033[0;37\]'
WHITE='\[\033[1;37\]'

BOLD=''
OFF='\[\033[m\]'

# Generate dirty status flag for Git and SVN.
__git_svn_status () {
	if git status --porcelain 2> /dev/null | grep -q '^\s*[AMD]'; then
		# Generate Git output for PS1.
        echo -n $1
	elif svn info &> /dev/null; then
		# Generate SVN output for PS1.
		svn status | grep -q '^\s*[?ACDMR?!]' && echo -n $1
	fi
}

__git_stash_flag () {
    [[ $(git stash list 2> /dev/null) ]] && echo -n $1
}

__git_added_flag () {
    git status --porcelain 2> /dev/null | grep -q '^\s*??' && echo -n $1
}

# Generate branch/location information for Git and SVN repositories.
__git_svn_info () {
	local tag=
    if [[ $(type -t __git_ps1) ]]; then
        # Generate Git output using standard completion function.
        tag=$(__git_ps1 '%s')
	elif git status &> /dev/null; then
        # Generate Git output for PS1.
        tag=$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/^refs\/heads\/\(.*\)/\1/')
	elif svn info 2> /dev/null; then
		# Generate SVN output for PS1.
		local url=`svn info | awk '/URL:/ {print $2}'`
		if [[ $url =~ trunk ]]; then
			tag=trunk
		elif [[ $url =~ /branches/ ]]; then
			tag=$(echo -n $url | sed -e 's#^.*/\(branches/.*\)/.*$#\1#')
		elif [[ $url =~ /tags/ ]]; then
			tag=$(echo -n $url | sed -e 's#^.*/\(tags/.*\)/.*$#\1#')
		else
			tag=..
		fi
	fi

	format=' (%s)'
	if [[ $1 ]]; then
		format=$1
	fi

	if [[ $tag ]]; then
		printf "$format" $tag
	fi
}

export PROMPT_COMMAND="__prompt_command"
__prompt_command() {
    # What was the exit code of the last command the user ran?
    local exit_code="$?"
    PS1=

    # Decide on a colour for the user name (are we root?).
    if [[ $EUID == 0 ]]; then
        local user_color=$LIGHTRED
    else
        local user_color=$LIGHTGREEN
    fi

    # Set a standard PS1 contents: user@host:dir (with colours).
    local ps1_inner="${user_color}\u@\h${OFF}:${LIGHTBLUE}\W${OFF}"

    # If "better PS1" is asked for, augment this with (coloured) Git/SVN
    # information.
    if [[ $BETTER_PS1 == true ]]; then
        local dirty_flag='*'
        local stash_flag='+'
        local added_flag='?'

        ps1_inner+='$(__git_svn_info "|'$BROWN'%s")'
        ps1_inner+='$(__git_stash_flag "'$BROWN$stash_flag'")'
        ps1_inner+='$(__git_svn_status "'$RED$dirty_flag'")'
        ps1_inner+='$(__git_added_flag "'$PURPLE$added_flag'")'$OFF
    fi

    # What prompt symbol shall we use?
    local prompt_symbol='\$'
    if [[ $exit_code != 0 ]]; then
        # Last command failed; spruce it up a bit.
        prompt_symbol="$RED!$OFF"
    fi

    # Now wrap the contents in some decoration and export.
    export PS1="[$ps1_inner]$prompt_symbol "
}
