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
    alias ssh=gsissh
    alias scp=gsiscp
    export GIT_SSH=gsissh
    if ! ligo-proxy-test; then
        ligo-proxy-init $LIGO_USER
    fi
}

# If there's one available, set up aliases, etc.
if ligo-proxy-test; then
    ligo-proxy
fi
