if [[ $(which nvim 2> /dev/null) ]]; then
    export EDITOR="/usr/bin/env nvim"
else
    export EDITOR="/usr/bin/env vim"
fi
export GIT_EDITOR=$EDITOR

for file in ~/.zshenv.d/*(.N); do
    . "$file"
done
