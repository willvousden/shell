# If running bash...
if [ -n "$BASH_VERSION" ]; then
	# ...and .bashrc exists...
	if [ -f "$HOME/.bashrc" ]; then
		# ...then include it!
		source "$HOME/.bashrc"
	fi
fi

if [ -f $HOME/.keys/id_rsa-open ]; then
	ssh-add $HOME/.keys/id_rsa-open 2> /dev/null
fi

export EDITOR=/usr/bin/vim
export PATH="$HOME/.bin:$PATH"

# Set up some SSH tunnel stuff.
export SSH_TUNNEL_COMMAND_PREFIX='ssh -fC2qTN -D'
SSH_TUNNEL_PORT=10241
SSH_TUNNEL_HOST=localhost
SSH_TUNNEL_PID=$(ps aux | grep "$SSH_TUNNEL_COMMAND_PREFIX" | grep -v grep | awk '{ print $2 }')
if [[ -z $SSH_TUNNEL_PID ]]; then
	$SSH_TUNNEL_COMMAND_PREFIX $SSH_TUNNEL_PORT $SSH_TUNNEL_HOST
fi
