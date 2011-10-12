GIT_PS1=true

if [ -f $HOME/.bashrc_default ]; then
	. $HOME/.bashrc_default
fi
. /etc/.bashrc_common

alias ls='ls --color=auto'
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias pf='ps aux | grep -v grep | grep'

if [ -f $HOME/.bashrc_local ]; then
	. $HOME/.bashrc_local
fi
