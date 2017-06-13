#!/usr/bin/env bash
if vercomp "$TMUX_VERSION" '<' 2.1; then
    tmux source-file ~/.tmux.conf.d/old
elif vercomp "$TMUX_VERSION" '>=' 2.1 && vercomp "$TMUX_VERSION" '<' 2.4; then
    tmux source-file ~/.tmux.conf.d/2.1
elif vercomp "$TMUX_VERSION" '>=' 2.4; then
    tmux source-file ~/.tmux.conf.d/2.4
fi
