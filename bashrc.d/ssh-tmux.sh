ssht() {
    if [[ $2 ]]; then
        command="tmux a -t $2 || tmux new -s $2"
    else
        command="tmux a || tmux new"
    fi

    ssh -Xt $1 "$command"
}
