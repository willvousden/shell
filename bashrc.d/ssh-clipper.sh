export CLIPPER_PORT=8378

alias sshc="rm -f ~/.ssh/cm_socket/* 2> /dev/null"
alias ssh="ssh -R localhost:$CLIPPER_PORT:localhost:$CLIPPER_PORT"
