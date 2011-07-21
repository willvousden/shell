GIT_PS1=true

. $HOME/.bashrc_default
. /etc/common.bashrc

if [ -f $HOME/.keys/id_rsa-open ]; then
	ssh-add $HOME/.keys/id_rsa-open 2> /dev/null
fi

export EDITOR=/usr/bin/vim
export PATH=$HOME/.bin:$PATH
