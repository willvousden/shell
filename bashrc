#!/bin/bash

GIT_PS1=true
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
	for i in $(ls -A $HOME/.bashrc.d); do
		. $HOME/.bashrc.d/$i
	done
fi

alias ls='ls -G'
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'

alias mvim='mvim --remote-tab-silent'

alias stat='stat -x'

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
