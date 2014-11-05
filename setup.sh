#!/user/bin/env bash

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
linkfile()
{
    source=.$1
    if [[ -e $source || -L $source ]]; then
        echo "$source exists; skipping."
        return 1
    else
        if [[ -n $2 ]]; then
            target=$(realpath $dir/$2)
        else
            target=$dir/$1
        fi

        ln -s $target $source
        return 0
    fi
}

pushd ~ > /dev/null

linkfile bashrc
linkfile bashrc.d

linkfile profile
linkfile profile.d

linkfile inputrc
linkfile bin

linkfile gitconfig
linkfile gitignore

linkfile tmux.conf
linkfile tmux.conf.d

linkfile dircolors.d

popd > /dev/null
