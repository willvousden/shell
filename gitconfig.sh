#!/usr/bin/env bash

verlte() {
    [ "$1" = "$(echo -e "$1\n$2" | sort -V | head -n1)" ]
}

verlt() {
    [ "$1" = "$2" ] && return 1 || verlte $1 $2
}

git_version=$(git --version)
git_version=${git_version#'git version'}

if verlt "$git_version" 1.7.11; then
    git config --global push.default nothing
else
    git config --global push.default simple
fi

if verlt "$git_version" 1.7.2; then
    git config --global alias.s "status --short"
else
    git config --global alias.s "status --short --branch"
fi
