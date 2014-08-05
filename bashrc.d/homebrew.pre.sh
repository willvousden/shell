#!/usr/bin/env bash
if [[ -x $(which brew) ]]; then
    # Set up virtualenv stuff.
    . $(brew --prefix)/bin/virtualenvwrapper.sh

    # Source bash completion.
    . $(brew --prefix)/etc/bash_completion
fi
