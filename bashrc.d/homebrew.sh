#!/usr/bin/env bash
if [[ -x $(which brew) ]]; then
    # Set up virtualenv stuff.
    . $(brew --prefix)/bin/virtualenvwrapper.sh &> /dev/null

    # Source bash completion.
    . $(brew --prefix)/etc/bash_completion &> /dev/null

    # List outdated Homebrew formulae
    brew outdated
fi
