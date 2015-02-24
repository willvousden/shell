#!/usr/bin/env bash

lal-activate-dir()
{
    if [[ ! -d $1/etc ]]; then
        echo "Couldn't find $1/etc."
        return 1
    fi
    export LAL_LOCATION=$1

    local modules=(lal lalframe lalmetaio lalsimulation lalburst lalinspiral lalstochastic lalpulsar lalinference lalapps pylal glue)
    for m in $modules; do
        script=$LAL_LOCATION/etc/$m-user-env.sh
        if [[ -r $script ]]; then
            . $script &> /dev/null || true
        fi
    done
}

lal-activate-current() {
    echo $LAL_BRANCH
}

lal-activate() {
    if [[ ! -d $LAL_DIR ]]; then
        echo "\$LAL_DIR not found."
        return 1
    fi

    local branch=$1
    local branches=$(find $LAL_DIR -mindepth 1 -maxdepth 1 -type d -print0 | xargs -0 -n 1 basename)

    if [[ -z $branch ]]; then
        echo "$branches" | tr " " "\n"
    elif [[ $branches =~ (^|[[:space:]])$branch($|[[:space:]]) ]]; then
        if [[ -n $LAL_BRANCH ]]; then
            echo "Branch $LAL_BRANCH already active."
            return 1
        fi

        echo "Activating $LAL_DIR/$branch..."
        lal-activate-dir $LAL_DIR/$branch

        local result=$?
        if [[ $result == 0 ]]; then
            echo "Activated \"$branch\"."
            export LAL_BRANCH=$branch
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
