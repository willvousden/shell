BSD_STYLE=true
if ls --color -d /dev/null &> /dev/null; then
    BSD_STYLE=
fi

BETTER_PS1=${BETTER_PS1:-true}
LIVE_TERM_TITLE=${LIVE_TERM_TITLE:-true}

# First execute "one-off" local (untracked) scripts.  These are ignored by Git.
if [[ -d $HOME/.bashrc.d.local ]]; then
    for file in $HOME/.bashrc.d.local/*; do
        [[ ! -f $file ]] || . $file
	done
fi

# Now execute global (tracked) scripts.
if [[ -d $HOME/.bashrc.d ]]; then
    # N.B. Any file in .bashrc.d matching *.local.sh is also ignored by Git.
    for file in $HOME/.bashrc.d/*; do
        [[ ! -f $file ]] || . $file
	done
fi

if [[ $TERM != 'dumb' ]]; then
    if [[ $BSD_STYLE ]]; then
        export LS_OPTIONS='-G'
    else
        export LS_OPTIONS='--color=auto'
    fi

    if [[ -f $HOME/.dir_colors ]]; then
        eval $(dircolors $HOME/.dir_colors)
    fi
fi

alias ls="ls $LS_OPTIONS -h"
alias ll="ls $LS_OPTIONS -AlhF"
alias la="ls $LS_OPTIONS -Ah"
alias ..='cd ..'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pf='ps aux | grep -v grep | grep'

# If there's a .bashrc_local (untracked by git), source it.
if [[ -f $HOME/.bashrc_local ]]; then
	. $HOME/.bashrc_local
fi

# Colours for man pages (via less)
export LESS_TERMCAP_mb=$'\E[01;31m'       # Begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # Begin bold
export LESS_TERMCAP_me=$'\E[0m'           # End mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # Begin standout-mode
export LESS_TERMCAP_se=$'\E[0m'           # End standout-mode
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # Begin underline
export LESS_TERMCAP_ue=$'\E[0m'           # End underline
