#!/usr/bin/env bash

set -euo pipefail


# Symlink to files only; create directories as necessary.
symlink_tree() {
    local source_prefix
    local target_prefix
    local mode
    source_prefix=${1%/}
    target_prefix=${2}
    mode=${3-ln}

    shopt -s globstar
    for item in "$source_prefix"/**/*; do
        if [[ -f $item ]]; then
            relative_path=${item#"$source_prefix/"}
            target_path="${target_prefix}${relative_path}"
            mkdir -p "$(dirname "$target_path")"
            if [[ $mode == cp ]]; then
                echo cp "$item" "$target_path"
                cp "$item" "$target_path"
            else
                ln -snfv "$(readlink -f "$item")" "$target_path"
            fi
        fi
    done
}


DIRCOLORS=solarized.ansi-dark

# Install regular dotfiles.
symlink_tree dotfiles/ ~/.
ln -svf ~/.dircolors.d/"${DIRCOLORS}" ~/.dir_colors
ln -snfv "$(readlink -f bin)" ~/.bin

# Install IPython stuff.
if command -v ipython &> /dev/null; then
    symlink_tree ipython/ "$(ipython locate profile)/"
fi

# Install SSH config.
symlink_tree ssh/ ~/.ssh/ cp
[[ -d ~/.ssh/cm_socket ]] || mkdir -p ~/.ssh/cm_socket
[[ ! -f ~/.ssh/config.local ]] || cat ~/.ssh/config.local >> ~/.ssh/config
chmod -R og-rxw ~/.ssh
