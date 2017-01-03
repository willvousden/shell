# An alias to "restart" the shell as a login shell.
bash_new() {
    exec env - HOME="$HOME" TERM="$TERM" DISPLAY="$DISPLAY" TMUX="$TMUX" TMUX_PANE="$TMUX_PANE" bash -l
}

# Emit the name of a GNU-prefixed command.
gcommand()
{
    echo "${GNU_COMMANDS["$1"]-$1}"
}

export LS_OPTIONS='-h'
if "$(gcommand ls)" --color -d /dev/null &> /dev/null; then
    LS_OPTIONS="$LS_OPTIONS --color=auto"
else
    LS_OPTIONS="$LS_OPTIONS -G"
fi
alias ls="$(gcommand ls) $LS_OPTIONS"
alias ll="$(gcommand ls) $LS_OPTIONS -lF"
alias la="$(gcommand ls) $LS_OPTIONS -A"

# Set up grep aliases.
alias grep="$(gcommand grep) --color=auto"
alias fgrep="$(gcommand fgrep) --color=auto"
alias egrep="$(gcommand egrep) --color=auto"

# Colours for man pages (via less).
export LESS_TERMCAP_mb=$'\E[01;31m'       # Begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # Begin bold (headings)
export LESS_TERMCAP_me=$'\E[0m'           # End mode
export LESS_TERMCAP_so=$'\E[0;34;107m'    # Begin standout-mode (search results)
export LESS_TERMCAP_se=$'\E[0m'           # End standout-mode
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # Begin underline
export LESS_TERMCAP_ue=$'\E[0m'           # End underline

if hash pbcopy 2> /dev/null; then
    # Remove trailing new line before piping to pbcopy.
    alias pbcopy='xargs echo -n | pbcopy'
fi

alias du="$(gcommand du) -sh"
alias lc="$(gcommand wc) -l"
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
        --color-match '30;43' \
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

alias pip-upgrade='pip install --upgrade $(pip list -o | grep -oP "^\S+")'

if [[ $TERM != 'dumb' ]] && type dircolors > /dev/null 2> /dev/null && [[ -r $HOME/.dir_colors ]]; then
    eval $(dircolors -b $HOME/.dir_colors)
fi
