GIT_PS1=true

if [ -f $HOME/.bashrc_default ]; then
	. $HOME/.bashrc_default
fi
. /etc/.bashrc_common

if [ -f $HOME/.keys/id_rsa-open ]; then
	ssh-add $HOME/.keys/id_rsa-open 2> /dev/null
fi

export EDITOR=/usr/bin/vim
export PATH=$HOME/.bin:$PATH

alias ls='ls --color=auto'
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
