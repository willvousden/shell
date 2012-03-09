#!/bin/bash

export PATH=/opt/local/apache2/bin:/opt/local/bin:/opt/local/sbin:/opt/local/libexec/gnubin:$PATH
export MANPATH=/opt/local/libexec/gnubin/man:/opt/local/man:/usr/share/man:$MANPATH
export PYTHONSTARTUP=$HOME/.profile-aux/python-startup.py

export EDITOR=/usr/bin/vim
export PATH="$HOME/.bin:$PATH"

# If running bash...
if [[ -n $BASH_VERSION ]]; then
	# ...and .bashrc exists...
	if [ -f $HOME/.bashrc ]; then
		# ...then include it!
		. $HOME/.bashrc
	fi
fi

if [[ -z $(ps -u $USER | grep ssh-agent) ]]; then
	eval $(ssh-agent) > /dev/null
fi
if [[ -f $HOME/.keys/id_rsa-open ]]; then
	ssh-add $HOME/.keys/id_rsa-open 2> /dev/null
fi

# Set up some SSH tunnel stuff.
export SSH_TUNNEL_COMMAND_PREFIX='ssh -fC2qTN -D'
SSH_TUNNEL_PORT=10241
SSH_TUNNEL_HOST=localhost
SSH_TUNNEL_PID=$(ps aux | grep "$SSH_TUNNEL_COMMAND_PREFIX" | grep -v grep | awk '{ print $2 }')
if [[ $LOCAL_SSH_TUNNEL == true ]] && [[ -z $SSH_TUNNEL_PID ]]; then
	$SSH_TUNNEL_COMMAND_PREFIX $SSH_TUNNEL_PORT $SSH_TUNNEL_HOST
fi
