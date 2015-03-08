# If expected environment variables aren't set, run set-up script.
if [[ -z $GLOBUS_PATH ]] && [[ -d /opt/ldg ]]; then
    export GLOBUS_LOCATION=/opt/ldg
    if [[ -f $GLOBUS_LOCATION/etc/globus-user-env.sh ]] ; then
        . $GLOBUS_LOCATION/etc/globus-user-env.sh
    fi
fi
