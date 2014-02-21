#!/usr/bin/env bash
SSH_AGENT_FILE=$HOME/.ssh-agent/$(hostname -s)
SSH_AGENT_CONTENT=
[[ -d $HOME/.ssh-agent ]] || mkdir $HOME/.ssh-agent
if [[ ! -f $SSH_AGENT_FILE ]]; then
    # The file doesn't exist, so kill any existing ssh-agent and start a new one,
    # creating a new file.
    killall ssh-agent 2> /dev/null
    SSH_AGENT_CONTENT=$(ssh-agent)
elif [[ ! $(ps -u $USER | grep ssh-agent | grep -v grep) ]]; then
    # The file does exist, but there's no process, so start a new one and create a new file.
    SSH_AGENT_CONTENT=$(ssh-agent)
fi
if [[ $SSH_AGENT_CONTENT ]]; then
    echo -n "New ssh-agent: "
    eval $(echo "$SSH_AGENT_CONTENT" | grep echo)
    echo "$SSH_AGENT_CONTENT" > $SSH_AGENT_FILE
fi

# Evaluate the file contents and add the unlocked RSA key if it exists.
eval $(cat $SSH_AGENT_FILE | grep -v echo)
if [[ -f $HOME/.keys/id_rsa-open ]]; then
	ssh-add $HOME/.keys/id_rsa-open 2> /dev/null
fi
