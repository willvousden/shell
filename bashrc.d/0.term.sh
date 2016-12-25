# Set term type.
if [[ $COLORTERM = "gnome-terminal" ]] || \
   [[ $COLORTERM = "xfce4-terminal" ]] || \
   [[ $COLORTERM = "mate-terminal" ]]; then
    export TERM=xterm-256color
elif [[ $COLORTERM = "rxvt-xpm" ]]; then
    export TERM=rxvt-256color
fi
