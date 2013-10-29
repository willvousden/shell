BETTER_PS1=true
LIVE_TERM_TITLE=true

if [[ -f $HOME/.bashrc_default ]]; then
	. $HOME/.bashrc_default
fi

if [[ -f $HOME/.bashrc_common ]]; then
	. $HOME/.bashrc_common
elif [[ -f /etc/.bashrc_common ]]; then
	. /etc/.bashrc_common
fi

if [[ -d $HOME/.bashrc.d ]]; then
    for file in $HOME/.bashrc.d/*; do
        if [[ -f $file ]]; then
            . "$file"
        fi
	done
fi

if [[ $TERM != 'dumb' ]]; then
    export LS_OPTIONS='--color=auto'
    if [[ -f $HOME/.dir_colors ]]; then
        eval $(dircolors $HOME/.dir_colors)
    fi
fi

alias ls='ls $LS_OPTIONS -h'
alias ll='ls --color=auto -AlhF'
alias la='ls --color=auto -Ah'
alias ..='cd ..'

alias pbcopy='xargs echo -n | pbcopy'
function mvim {
    local mvim_bin=$(which mvim)
    if [[ $1 ]]; then
        $mvim_bin --remote-silent "$1"
    else
        $mvim_bin
    fi
}

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pf='ps aux | grep -v grep | grep'

# If there's a .bashrc_local (untracked by git), source it.
if [[ -f $HOME/.bashrc_local ]]; then
	. $HOME/.bashrc_local
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# List outdated Homebrew formulae
brew outdated
