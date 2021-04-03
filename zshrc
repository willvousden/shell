bindkey -e
bindkey "\e[3~" delete-char

setopt AUTO_CD

export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=/usr/local/opt/findutils/libexec/gnubin:$PATH

for file in ~/.zshrc.d/*(.N); do
    . "$file"
done
