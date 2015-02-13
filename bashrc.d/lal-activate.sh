#!/usr/bin/env bash

lal-activate() {
    if [[ ! -d $LALDIR ]]; then
        echo "\$LALDIR not found."
        return 1
    fi

    local branch=$1
    local branches=$(find $LALDIR -mindepth 1 -maxdepth 1 -type d -print0 | xargs -0 -n 1 basename)

    if [[ -z $branch ]]; then
        echo "$branches" | tr " " "\n"
    elif [[ $branches =~ (^|[[:space:]])$branch($|[[:space:]]) ]]; then
        if [[ -n $LALBRANCH ]]; then
            PATH=$(echo $PATH | sed "s%:$LALDIR/$LALBRANCH:")
            MANPATH=$(echo $MANPATH | sed "s%:$LALDIR/$LALBRANCH:")
        fi

        . $LALDIR/$branch/etc/lscsoftrc.sh

        local result=$?
        echo "Activating $LALDIR/$branch..."
        if [[ $result == 0 ]]; then
            echo "Activated \"$branch\"."
            export LALBRANCH=$branch
        else
            echo "Something went wrong."
        fi
        return $result
    else
        echo "Branch \"$branch\" not found.  Available branches:"
        echo "$branches" | tr " " "\n"
        return 1
    fi

    return 0
}
