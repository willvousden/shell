export SSH_AGENT_FILE=$HOME/.ssh-agent/$(hostname -s)
export SSH_AGENT_CONTENT=
[[ -d $HOME/.ssh-agent ]] || mkdir $HOME/.ssh-agent
if [[ ! -f $SSH_AGENT_FILE ]]; then
    # The file doesn't exist, so kill any existing ssh-agent and start a new one,
    # creating a new file.
    killall ssh-agent 2> /dev/null
    SSH_AGENT_CONTENT=$(ssh-agent)
    eval "$SSH_AGENT_CONTENT"
else
    # Evaluate the file contents.
    SSH_AGENT_CONTENT=$(<$SSH_AGENT_FILE)
    eval "$(<<<"$SSH_AGENT_CONTENT" grep -v echo)"

    # Is there an existing ssh-agent with the specified PID?
    _existing=1
    _ps_output=$(ps -p "$SSH_AGENT_PID" -o comm= -o user= 2>/dev/null)
    if [[ $? == 0 ]]; then
        read -r _comm _user <<<"$_ps_output"
        if [[ $_comm != ssh-agent || $_user != $USER ]]; then
            _existing=
        fi
    else
        # Assume that we're on Cygwin; can't use -o.
        _ps_output=$(ps -s -p "$SSH_AGENT_PID" -u "$UID" | awk '{print $(NF)}')
        if [[ -z $_ps_output || $(basename "$_ps_output") != ssh-agent ]]; then
            _existing=
        fi
    fi
    if [[ -z $_existing ]]; then
        # No, so create a new one.
        killall ssh-agent 2> /dev/null
        SSH_AGENT_CONTENT=$(ssh-agent)
        eval "$SSH_AGENT_CONTENT"
    fi
fi

# Update this host's ssh-agent file.
echo "$SSH_AGENT_CONTENT" > $SSH_AGENT_FILE
