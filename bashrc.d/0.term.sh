# Set term type.
if [[ $TERM == screen ]]; then
    # Ham-fisted fix.
    TERM=screen-256color
fi
# if [[ $COLORTERM = "gnome-terminal" ]] || \
   # [[ $COLORTERM = "xfce4-terminal" ]] || \
   # [[ $COLORTERM = "mate-terminal" ]]; then
    # export TERM=xterm-256color
# elif [[ $COLORTERM = "rxvt-xpm" ]]; then
    # export TERM=rxvt-256color
# fi
