ssht() {
    local detach=
    if [[ $1 == '-d' ]]; then
        detach='-d'
        shift
    fi

    if [[ -z $1 ]]; then
        echo "No hostname."
        return 1
    fi

    if [[ $2 ]]; then
        local tmux_command="tmux a $detach -t $2 || tmux new -s $2"
    else
        local tmux_command="tmux a $detach || tmux new"
    fi
    
    local ssh_command=ssh
    if [[ $(type -t ssh) == alias ]]; then
        ssh_command=$(alias ssh | sed -Ee "s/^alias ssh='(.+)'$/\1/")
    fi
    local command="$ssh_command -Xt $1 \"$tmux_command\""
    eval $command
}
