#!/usr/bin/env bash

git_version=$(git --version | cut -d' ' -f 3)

if vercomp "$git_version" '<' 1.7.11; then
    git config --global push.default nothing
else
    git config --global push.default simple
fi

if vercomp "$git_version" '<' 1.7.2; then
    git config --global alias.s "status --short"
else
    git config --global alias.s "status --short --branch"
fi
