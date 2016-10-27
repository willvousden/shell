# An alias to "restart" the shell as a login shell.
alias bash_new='exec env - HOME=$HOME TERM=$TERM bash -l'

alias ls="ls $LS_OPTIONS -h"
alias ll="ls $LS_OPTIONS -lhF"
alias la="ls $LS_OPTIONS -Ah"
alias ..='cd ..'

if hash pbcopy 2> /dev/null; then
    # Remove trailing new line before piping to pbcopy.
    alias pbcopy='xargs echo -n | pbcopy'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pf='ps aux | grep -v grep | grep'
alias du='du -sh'
alias lc='wc -l'
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
        --color-match '30;43' \
        --color-path 32 \
        --color-line-number 33 \
        --group \
        $color \
        "$@" | less -RS
}

alias pip-upgrade='pip install --upgrade $(pip list -o | grep -oP "^\S+")'
