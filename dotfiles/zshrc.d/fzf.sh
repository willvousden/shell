if [[ -f ~/.fzf.zsh ]]; then
    # Use ripgrep if it's available, to benefit from its ignore behaviour.
    if command -v rg > /dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='rg --files'
        export FZF_CTRL_T_COMMAND='rg --files'
    fi

    if command -v rg > /dev/null 2>&1; then
        FZF_PREVIEW=" --preview 'bat -n --color=always {}'"
    else
        FZF_PREVIEW=" --preview 'fzf-preview.sh {}'"
    fi
    export FZF_CTRL_T_OPTS="${FZF_PREVIEW}"

    . ~/.fzf.zsh
fi
