#/usr/bin/env bash

set -euo pipefail

DOTFILES=(
    bashrc bashrc.d
    bash_logout
    bash_profile
    bash_profile.d
    python-startup.py
    inputrc
    latexmkrc
    gitignore
    tmux.conf
    tmux.conf.d
    screenrc
    minttyrc
    dircolors.d
    gdbinit
    gdbinit.d
    bin
)
DIRCOLORS=solarized.ansi-dark

install_dotfiles()
{
    ln -svf ~/.dircolors.d/"${DIRCOLORS}" ~/.dir_colors

    for file in "${DOTFILES[@]}"; do
        ln -snfv "$(pwd)/$file" ~/".$file"
    done

    cp "$(pwd)/gitconfig" ~/.gitconfig
    . ./gitconfig.sh
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

install_dotfiles
install_ssh
