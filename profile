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

SSH_AGENT_FILE=$HOME/.ssh-agent/$(hostname -s)
SSH_AGENT_CONTENT=
if [[ ! -e $HOME/.ssh-agent ]]; then
    # Make sure the directory exists.
    mkdir $HOME/.ssh-agent
fi
if [[ ! -e $SSH_AGENT_FILE ]]; then
    # The file doesn't exist, so kill any existing ssh-agent and start a new one,
    # creating a new file.
    killall ssh-agent 2> /dev/null
    SSH_AGENT_CONTENT=$(ssh-agent)
elif [[ -z $(ps -u $USER | grep ssh-agent) ]]; then
    # The file does exist, but there's no process, so start a new one and create a new file.
    SSH_AGENT_CONTENT=$(ssh-agent)
fi
if [[ -n $SSH_AGENT_CONTENT ]]; then
    echo -n "New ssh-agent: "
    eval $(echo "$SSH_AGENT_CONTENT" | grep echo)
    echo "$SSH_AGENT_CONTENT" > $SSH_AGENT_FILE
fi

# Evaluate the file contents and add the unlocked RSA key if it exists.
eval $(cat $SSH_AGENT_FILE | grep -v echo)
if [[ -f $HOME/.keys/id_rsa-open ]]; then
	ssh-add $HOME/.keys/id_rsa-open 2> /dev/null
fi

# Initialize an LSC grid proxy.
grid-proxy-init > /dev/null
alias ssh=gsissh
export GIT_SSH=gsissh

# Set up some SSH tunnel stuff.
export SSH_TUNNEL_COMMAND_PREFIX='ssh -fC2qTN -D'
SSH_TUNNEL_PORT=10241
SSH_TUNNEL_HOST=localhost
SSH_TUNNEL_PID=$(ps aux | grep "$SSH_TUNNEL_COMMAND_PREFIX" | grep -v grep | awk '{ print $2 }')
if [[ $LOCAL_SSH_TUNNEL == true ]] && [[ -z $SSH_TUNNEL_PID ]]; then
	$SSH_TUNNEL_COMMAND_PREFIX $SSH_TUNNEL_PORT $SSH_TUNNEL_HOST
fi
