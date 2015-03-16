lal-activate-dir()
{
    #if [[ ! -d $1/etc ]]; then
        #echo "Couldn't find $1/etc."
        #return 1
    #fi
    if [[ ! -f $1/etc/lscsoftrc ]]; then
        lal-activate-emit $1 || return 1
    fi

    . $1/etc/lscsoftrc
}

lal-activate-emit() {
    if [[ ! -d $1/etc ]]; then
        echo "Couldn't find $1/etc."
        return 1
    fi

    cat << EOF > $1/etc/lscsoftrc
export LAL_LOCATION=$1
for script in $1/etc/*-user-env.sh; do
    . \$script &> /dev/null || true
done
EOF
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
