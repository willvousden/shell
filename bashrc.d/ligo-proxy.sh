#!/usr/bin/env bash

export LIGO_USER=will.vousden

ligo-proxy() {
    alias ssh=gsissh
    alias scp=gsiscp
    export GIT_SSH=gsissh
    local proxy_info=$(grid-proxy-info 2> /dev/null)
    if [[ -z $proxy_info ]] || [[ $proxy_info =~ timeleft\ *:\ *0:00:00 ]]; then
        ligo-proxy-init $LIGO_USER
    fi
}
