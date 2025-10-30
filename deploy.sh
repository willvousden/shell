#!/usr/bin/env bash

set -euo pipefail

DIRCOLORS=solarized.ansi-dark

install_dotfiles()
{
    # Symlink to files only; create directories as necessary.
    shopt -s globstar
    for item in dotfiles/**/*; do
        target_path=~/."${item#dotfiles/}"
        mkdir -p "$(dirname "$target_path")"
        if [[ -f $item ]]; then
            ln -snfv "$(readlink -f "$item")" "$target_path"
        fi
    done

    ln -svf ~/.dircolors.d/"${DIRCOLORS}" ~/.dir_colors
}

install_ssh()
{
    [[ -d ~/.ssh ]] || mkdir ~/.ssh
    [[ -d ~/.ssh/cm_socket ]] || mkdir -p ~/.ssh/cm_socket
    cp "$(pwd)/ssh/authorized_keys" ~/.ssh/authorized_keys
    cp "$(pwd)/ssh/config" ~/.ssh/config
    [[ ! -f ~/.ssh/config.local ]] || cat ~/.ssh/config.local >> ~/.ssh/config
    chmod -R og-rxw ~/.ssh
}

install_ipython_profile()
{
    if ! hash ipython &> /dev/null; then
        return
    fi

    local dir
    dir=$(ipython locate profile)
    [[ -d $dir/startup ]] || mkdir -p "$dir/startup"

    (
    cd ipython || return 1

    local f
    while read -r f; do
        f=$(basename "$f")
        ln -snfv "$(pwd)/$f" "$dir/$f"
    done < <(find . -maxdepth 1 -type f)

    while read -r f; do
        f=$(basename f)
        ln -snfv "$(pwd)/$f" "$dir/$f"
    done < <(find startup -maxdepth 1 -type f)
    )
}

install_dotfiles
install_ssh
install_ipython_profile

ln -snfv "$(readlink -f bin)" ~/.bin
