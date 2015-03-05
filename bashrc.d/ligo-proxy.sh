#!/usr/bin/env bash

export LIGO_USER=will.vousden

ligo-proxy-test() {
    local proxy_info=$(grid-proxy-info 2> /dev/null)
    if [[ -z $proxy_info ]] || [[ $proxy_info =~ timeleft\ *:\ *0:00:00 ]]; then
        return 1
    else
        return 0
    fi
}

ligo-proxy() {
    # Set up GSI aliases.
    export GIT_SSH=gsissh
    alias scp=gsiscp
    alias rsync='rsync --rsh=gsissh'

    # If SSH is already aliased, just replace the binary name with gsissh.
    local ssh_old=$(alias ssh 2> /dev/null)
    if [[ -n $ssh_old ]]; then
        eval $(echo $ssh_old | sed -e "s/alias ssh='ssh/alias ssh='gsissh/")
    else
        alias ssh=gsissh
    fi

    if ! ligo-proxy-test; then
        ligo-proxy-init $LIGO_USER
    fi
}

# If there's one available, set up aliases, etc.
if ligo-proxy-test; then
    ligo-proxy
fi
