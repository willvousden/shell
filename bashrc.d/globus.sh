if [[ -x $(which gsissh) ]]; then
    # GSI binaries found, so set up Globus stuff.

    # If expected environment variables aren't set, run set-up script.
    if [[ -z $GLOBUS_PATH ]]; then
        GLOBUS_LOCATION=/opt/ldg
        export GLOBUS_LOCATION
        if [ -f ${GLOBUS_LOCATION}/etc/globus-user-env.sh ] ; then
            . ${GLOBUS_LOCATION}/etc/globus-user-env.sh
        fi
    fi

    # Set the default SSH client to use the "Grid".
    alias ssh=gsissh
    GIT_SSH=gsissh
    export GIT_SSH
fi
