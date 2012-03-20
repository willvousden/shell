#!/bin/bash

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

SSH_AGENT_FILE=$HOME/.ssh-agent/$(hostname -s)
if [[ ! -e $SSH_AGENT_FILE ]]; then
    # The file doesn't exist, so kill any existing ssh-agent and start a new one,
    # creating a new file.
    killall ssh-agent 2> /dev/null
    ssh-agent > $SSH_AGENT_FILE
elif [[ -z $(ps -u $USER | grep ssh-agent) ]]; then
    # The file does exist, but there's no process, so start a new one and create a new file.
    ssh-agent > $SSH_AGENT_FILE
fi

# Evaluate the file contents and add the unlocked RSA key if it exists.
eval $(cat $SSH_AGENT_FILE)
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
