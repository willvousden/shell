if [[ -d /opt/homebrew ]]; then
    export BREW_PREFIX=/opt/homebrew
    path=($BREW_PREFIX/bin $path)
else
    export BREW_PREFIX=/usr/local
fi

bindkey -e
bindkey "\e[3~" delete-char

# I want to treat path components as separate words, but I want ^W to kill back to the last space.
# This means bash word style, except when killing words.
autoload -U select-word-style
select-word-style bash
function kill-word() {
    select-word-style normal
    zle backward-kill-word
}
zle -N kill-word
bindkey '^W' kill-word

setopt AUTO_CD

path=($BREW_PREFIX/opt/coreutils/libexec/gnubin $path)
path=($BREW_PREFIX/opt/findutils/libexec/gnubin $path)
export PATH

for file in ~/.zshrc.d/*(.N); do
    . "$file"
done

autoload -U +X bashcompinit && bashcompinit
