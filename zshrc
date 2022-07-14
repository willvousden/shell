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

path=(/usr/local/opt/coreutils/libexec/gnubin $path)
path=(/usr/local/opt/findutils/libexec/gnubin $path)
export PATH

for file in ~/.zshrc.d/*(.N); do
    . "$file"
done

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
