#/usr/bin/env bash

set -euo pipefail

DOTFILES=(
    zshrc zshrc.d
    zshenv zshenv.d
    bashrc bashrc.d
    bash_logout
    bash_profile
    bash_profile.d
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
    ripgreprc
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

install_ipython_profile()
{
    if ! hash ipython &> /dev/null; then
        return
    fi

    local dir=$(ipython locate profile)
    [[ -d $dir/startup ]] || mkdir -p "$dir/startup"

    (
    cd ipython || return 1

    local f
    while read f; do
        f=$(basename "$f")
        ln -snfv "$(pwd)/$f" "$dir/$f"
    done < <(find . -maxdepth 1 -type f)

    while read f; do
        f=$(basename f)
        ln -snfv "$(pwd)/$f" "$dir/$f"
    done < <(find startup -maxdepth 1 -type f)
    )
}

install_dotfiles
install_ssh
install_ipython_profile
