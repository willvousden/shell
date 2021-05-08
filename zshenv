if [[ $(which nvim 2> /dev/null) ]]; then
    export EDITOR="/usr/bin/env nvim"
else
    export EDITOR="/usr/bin/env vim"
fi
export GIT_EDITOR=$EDITOR

path=(~/.bin $path)
export PATH

for file in ~/.zshenv.d/*(.N); do
    . "$file"
done
