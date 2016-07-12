BASHRC_SOURCED=true
if [[ -z $PROFILE_SOURCED ]]; then
    . ~/.profile
fi

BSD_STYLE=true
if ls --color -d /dev/null &> /dev/null; then
    BSD_STYLE=
fi

GIT_PS1=${GIT_PS1-true}
GIT_PS1_BETTER=${GIT_PS1_BETTER-true}
LIVE_TERM_TITLE=${LIVE_TERM_TITLE-true}

# Set term type.
if [[ $COLORTERM = "gnome-terminal" ]] || [[ $COLORTERM = "xfce4-terminal" ]]; then
    export TERM=xterm-256color
elif [[ $COLORTERM = "rxvt-xpm" ]]; then
    export TERM=rxvt-256color
fi

# First execute "one-off" local (untracked) scripts.  These are ignored by Git.
if [[ -d $HOME/.bashrc.d.local ]]; then
    for file in $HOME/.bashrc.d.local/*; do
        if [[ ! $file =~ \.post(\.sh)?$ ]]; then
            [[ ! -f $file ]] || . $file
        fi
	done
fi

# Now execute global (tracked) scripts.
if [[ -d $HOME/.bashrc.d ]]; then
    # N.B. Any file in .bashrc.d matching *.local.sh is also ignored by Git.
    for file in $HOME/.bashrc.d/*; do
        if [[ ! $file =~ \.post(\.sh)?$ ]]; then
            [[ ! -f $file ]] || . $file
        fi
	done
fi

if [[ $TERM != 'dumb' ]]; then
    if [[ $BSD_STYLE ]]; then
        export LS_OPTIONS='-G'
    else
        export LS_OPTIONS='--color=auto'
    fi

    if hash dircolors 2> /dev/null && [[ -r $HOME/.dir_colors ]]; then
        eval $(dircolors -b $HOME/.dir_colors)
    fi
fi

# An alias to "restart" the shell as a login shell.
alias bash_new='exec env - HOME=$HOME TERM=$TERM bash -l'

alias ls="ls $LS_OPTIONS -h"
alias ll="ls $LS_OPTIONS -AlhF"
alias la="ls $LS_OPTIONS -Ah"
alias ..='cd ..'

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

alias pip-upgrade='pip install --upgrade $(pip list -o | grep -oP "^\S+")'

# Colours for man pages (via less).
export LESS_TERMCAP_mb=$'\E[01;31m'       # Begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # Begin bold (headings)
export LESS_TERMCAP_me=$'\E[0m'           # End mode
export LESS_TERMCAP_so=$'\E[0;34;107m'    # Begin standout-mode (search results)
export LESS_TERMCAP_se=$'\E[0m'           # End standout-mode
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # Begin underline
export LESS_TERMCAP_ue=$'\E[0m'           # End underline

# Now execute post-bashrc scripts.
if [[ -d $HOME/.bashrc.d ]]; then
    for file in $HOME/.bashrc.d/*; do
        if [[ $file =~ \.post(\.sh)?$ ]]; then
            [[ ! -f $file ]] || . $file
        fi
	done
fi

# ...and untracked ones.
if [[ -d $HOME/.bashrc.d.local ]]; then
    for file in $HOME/.bashrc.d.local/*; do
        if [[ $file =~ \.post(\.sh)?$ ]]; then
            [[ ! -f $file ]] || . $file
        fi
	done
fi

if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion 2> /dev/null
elif [[ -d /etc/bash_completion.d ]]; then
    for file in /etc/bash_completion.d/*; do
        . $file 2> /dev/null
    done
fi

# Pip bash completion.
if hash pip 2> /dev/null; then
    eval $(pip completion --bash) 2> /dev/null
fi

# Check window size after each command and update LINES and COLUMNS.
shopt -s checkwinsize

if [[ -n $PROFILING ]] && shopt -q login_shell; then
    # Disable profiling code.
    set +x
    exec 2>&3 3>&-
fi
