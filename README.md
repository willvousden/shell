My shell environment
====================

All my shell environment stuff. Use/abuse as you like.

Setup
-----

On macOS, remember to edit `/etc/profile` to prevent `path_helper` from ruining our day:

```sh
if [ -z "$PROFILE_SOURCED" ]; then
    # path_helper stuff
fi
```

For Neovim, don't forget to add `~/.config/nvim/init.vim`. Something like this:

```
let g:python3_host_prog = '~/.python3-neovim/bin/python3'
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/git/vim/vimrc
```

Make a Python venv in `~/.python3-neovim` and install `pip install pynvim` there.
