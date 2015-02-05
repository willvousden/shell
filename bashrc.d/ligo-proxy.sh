#!/usr/bin/env bash

export LIGO_USER=will.vousden

ligo-proxy() {
    alias ssh=gsissh
    alias scp=gsiscp
    export GIT_SSH=gsissh
    if ! grid-proxy-info &> /dev/null; then
        ligo-proxy-init $LIGO_USER
    fi
}
