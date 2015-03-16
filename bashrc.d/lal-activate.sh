lal-activate() {
    if [[ ! -d $LAL_DIR ]]; then
        echo "\$LAL_DIR not found."
        return 1
    fi

    local branch=$1
    local branches=$(find $LAL_DIR -mindepth 1 -maxdepth 1 -type d -print0 | xargs -0 -n 1 basename)

    if [[ -z $branch ]]; then
        for b in $branches; do
            if [[ $b == $LAL_BRANCH ]]; then
                echo "$b (active)"
            else
                echo $b
            fi
        done
    elif [[ $branches =~ (^|[[:space:]])$branch($|[[:space:]]) ]]; then
        if [[ -n $LAL_BRANCH ]]; then
            echo "Branch $LAL_BRANCH already active."
            return 1
        fi

        echo "Activating $LAL_DIR/$branch..."
        . $LAL_DIR/$branch/etc/lalsuiterc

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
