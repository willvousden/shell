# An alias to "restart" the shell as a login shell.
bash_new() {
    exec env - HOME="$HOME" TERM="$TERM" DISPLAY="$DISPLAY" TMUX="$TMUX" TMUX_PANE="$TMUX_PANE" bash -l
}

export LS_OPTIONS='-h'
LS_OPTIONS="$LS_OPTIONS --color=auto"
alias ls="ls $LS_OPTIONS"
alias ll="ls $LS_OPTIONS -lF"
alias la="ls $LS_OPTIONS -A"

# Set up grep aliases.
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Use Neovim if it's available.
if hash nvim 2> /dev/null; then
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

if hash pbcopy 2> /dev/null; then
    # Remove a single trailing new line before piping to pbcopy.
    alias npbcopy="perl -pe 'chomp if eof' | pbcopy"
fi

# Docker things.
alias dc=docker-compose
alias d=docker
alias dri='docker run --rm -it'

if hash kubectl 2> /dev/null; then
    kubectl completion bash > /tmp/kubectl-completion.bash
    . /tmp/kubectl-completion.bash
    alias k=kubectl
    complete -F __start_kubectl k
fi

alias du="du -sh"
alias lc="wc -l"
alias ..='cd ..'
alias pf='ps aux | grep -v grep | grep'
if hash xdg-open 2> /dev/null; then
    alias open=xdg-open
fi
if hash htop 2> /dev/null; then
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

# Make ag look a bit nicer.
ag() {
    if [[ -t 1 ]]; then
        local color=--color
    else
        local color=--nocolor
    fi

    command ag \
        --color-match 91 \
        --color-path 32 \
        --color-line-number 33 \
        --group \
        $color \
        "$@" | less -FRS
}

# A function to refresh an existing shell's environment variables from the hosting tmux session.
tmux-env() {
    local i
    while read i; do
        if [[ $i == -* ]]; then
            unset ${i/#-/}
        else
            local n=${i%%=*}
            local v=${i#*=}
            eval "export $n=$(printf '%q\n' "$v")"
        fi
    done < <(tmux show-environment)
}

alias pip-upgrade='pip install --upgrade $(pip list -o --format=freeze | grep -oP "^[^\s=]+")'

if [[ $TERM != 'dumb' ]] && type dircolors > /dev/null 2> /dev/null && [[ -r $HOME/.dir_colors ]]; then
    eval $(dircolors -b $HOME/.dir_colors)
fi
