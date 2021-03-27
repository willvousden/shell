export LS_OPTIONS='-h'
LS_OPTIONS="$LS_OPTIONS --color=auto"
alias ls="ls $LS_OPTIONS"
alias la="ls $LS_OPTIONS -A"
alias ll="ls $LS_OPTIONS -lF"
alias lla="ls $LS_OPTIONS -lFA"

# Set up grep aliases.
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Use Neovim if it's available.
if command -v nvim > /dev/null; then
    alias vim=nvim
fi

# Colours for man pages (via less).
export LESS_TERMCAP_mb=$'\E[01;31m'       # Begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # Begin bold (headings)
export LESS_TERMCAP_me=$'\E[0m'           # End mode
export LESS_TERMCAP_so=$'\E[0;34;107m'    # Begin standout-mode (search results)
export LESS_TERMCAP_se=$'\E[0m'           # End standout-mode
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # Begin underline
export LESS_TERMCAP_ue=$'\E[0m'           # End underline

if command -v pbcopy > /dev/null; then
    # Remove a single trailing new line before piping to pbcopy.
    alias npbcopy="perl -pe 'chomp if eof' | pbcopy"
fi

alias du="du -sh"
alias lc="wc -l"
alias pf='ps aux | grep -v grep | grep'
if command -v htop > /dev/null; then
    alias htop="htop -u $USER"
fi

# Echo path list on separate lines.
echp() {
    echo $1 | tr : '\n'
}

# Helpful alias for adding new paths.
pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="${PATH:+"$PATH:"}$1"
    fi
}

# Make ordered list of item frequencies.
sortu() {
    local input=${1:-}
    if [[ $input ]]; then
        sort -- "$input" | uniq -c | sort -nr
    else
        sort | uniq -c | sort -nr
    fi
}

if [[ $TERM != 'dumb' ]] && type dircolors > /dev/null 2> /dev/null && [[ -r $HOME/.dir_colors ]]; then
    eval $(dircolors -b "$HOME/.dir_colors")
fi
