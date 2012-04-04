#!/bin/bash

BETTER_PS1=true
LIVE_TERM_TITLE=true

if [[ -f $HOME/.bashrc_default ]]; then
	. $HOME/.bashrc_default
fi

if [[ -f $HOME/.bashrc_common ]]; then
	. $HOME/.bashrc_common
elif [[ -f /etc/.bashrc_common ]]; then
	. /etc/.bashrc_common
fi

if [[ -d $HOME/.bashrc.d ]]; then
	for i in $(\ls -A $HOME/.bashrc.d); do
		. $HOME/.bashrc.d/$i
	done
fi

if [[ $TERM != 'dumb' ]]; then
    export LS_OPTIONS='--color=auto'
    if [[ -f $HOME/.dir_colors ]]; then
        eval $(dircolors $HOME/.dir_colors)
    fi
fi

alias ls='ls $LS_OPTIONS -h'
alias ll='ls --color=auto -AlhF'
alias la='ls --color=auto -Ah'
alias ..='cd ..'

alias pbcopy='xargs echo -n | pbcopy'
function mvim {
    local mvim_bin=$(which mvim)
    if [[ $1 ]]; then
        $mvim_bin --remote-silent "$1"
    else
        $mvim_bin
    fi
}

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias pf='ps aux | grep -v grep | grep'

if [[ -f $HOME/.bashrc_local ]]; then
	. $HOME/.bashrc_local
fi

if [[ -f /opt/local/etc/bash_completion ]]; then
	. /opt/local/etc/bash_completion
fi
