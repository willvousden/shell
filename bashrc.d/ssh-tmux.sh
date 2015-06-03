ssht() {
    if [[ -z $1 ]]; then
        echo "No hostname."
        return 1
    fi

    if [[ $2 ]]; then
        command="tmux a -t $2 || tmux new -s $2"
    else
        command="tmux a || tmux new"
    fi

    if [[ $1 == -d ]]; then
        command="tmux detach -a 2> /dev/null; $command"
    fi

    local ssh_command=ssh
    if [[ $(type -t ssh) == alias ]]; then
        ssh_command=$(alias ssh | sed -Ee "s/^alias ssh='(.+)'$/\1/")
    fi
    eval $ssh_command -Xt $1 \"$command\"
}
