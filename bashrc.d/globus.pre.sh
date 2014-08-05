# If expected environment variables aren't set, run set-up script.
if [[ -z $GLOBUS_PATH ]] && [[ -d /opt/ldg ]]; then
    GLOBUS_LOCATION=/opt/ldg
    export GLOBUS_LOCATION
    if [ -f ${GLOBUS_LOCATION}/etc/globus-user-env.sh ] ; then
        . ${GLOBUS_LOCATION}/etc/globus-user-env.sh
    fi
fi

if [[ $GSI_ALIAS && -x $(which gsissh) ]]; then
    # Set the default SSH client to use the "Grid".
    alias ssh=gsissh
    alias scp=gsiscp
    GIT_SSH=gsissh
    export GIT_SSH
    
    # Short-cut alias.
    alias ligo-proxy-init="ligo-proxy-init will.vousden"
fi
