GLOBUS_LOCATION=/opt/ldg
export GLOBUS_LOCATION
if [ -f ${GLOBUS_LOCATION}/etc/globus-user-env.sh ] ; then
	. ${GLOBUS_LOCATION}/etc/globus-user-env.sh
fi
