if [[ -d /opt/homebrew ]]; then
    export BREW_PREFIX=/opt/homebrew
    path=($BREW_PREFIX/bin $path)
else
    export BREW_PREFIX=/usr/local
fi

unsetopt BEEP

bindkey -e
bindkey "\e[3~" delete-char

# I want to treat path components as separate words, but I want ^W to kill the whole shell
# parameter. This means bash word style, except when killing words.
autoload -U select-word-style
select-word-style bash
zle -N backward-kill-shell-word backward-kill-word-match
zstyle :zle:backward-kill-shell-word word-style shell
bindkey '^w'  backward-kill-shell-word

setopt AUTO_CD

path=($BREW_PREFIX/opt/coreutils/libexec/gnubin $path)
path=($BREW_PREFIX/opt/findutils/libexec/gnubin $path)
export PATH

export RIPGREP_CONFIG_PATH=~/.ripgreprc

autoload -U +X bashcompinit && bashcompinit

for file in ~/.zshrc.d/*(.N); do
    . "$file"
done
