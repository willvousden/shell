export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
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
