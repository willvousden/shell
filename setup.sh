dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
linkfile()
{
    if [[ -e .$1 ]]; then
        echo ".$1 exists; skipping."
        return 1
    else
        ln -s $dir/$1 .$1
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
