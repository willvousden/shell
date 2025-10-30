#!/usr/bin/env bash

set -euo pipefail

DOTFILES=(
    zshrc zshrc.d
    zshenv zshenv.d
    bashrc bashrc.d
    bash_profile
    bash_profile.d
    inputrc
    gitconfig
    gitignore
    tmux.conf
    tmux.conf.d
    dircolors.d
    gdbinit
    gdbinit.d
    bin
    ripgreprc
)
DIRCOLORS=solarized.ansi-dark

install_dotfiles()
{
    ln -svf ~/.dircolors.d/"${DIRCOLORS}" ~/.dir_colors

    for file in "${DOTFILES[@]}"; do
        if [[ -f $file || -d $file ]]; then
            ln -snfv "$(readlink -f "$file")" ~/."$file"
        else
            printf 'File not found: %s\n' "$file"
        fi
    done
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
