#!/bin/sh
. /usr/syscfg/wan.comm.param.sh

ifrom=""
mbit=""
obit=""
ip6gw=""
prefixlist=""
dsnlist=""

for para in $*
do
	export $para
done

while [ -f ${raaction_lock_flag} ]
do
        usleep 100
done
#create lock flag
touch ${raaction_lock_flag}

do_action()
{
	local conn_dir=$1
	
	local ip6_dhcp_start_script=`expr ${conn_dir}/${IP6_DHCP_START_SCRIPT}`
	local ip6_auto_start_script=`expr ${conn_dir}/${IP6_AUTO_START_SCRIPT}`
	
	if [ -f ${ip6_auto_start_script} ]; then
		${ip6_auto_start_script}
		sleep 2
		rm -fr ${ip6_auto_start_script}
	fi

	if [ -f ${ip6_dhcp_start_script} ]; then
		${ip6_dhcp_start_script}
		sleep 2
		rm -fr ${ip6_dhcp_start_script}
	fi
}	

find_connection_by_ifname()
{
	local IPConn_folder=`expr "/tmp/IP_*"`
	local PPPConn_folder=`expr "/tmp/PPP_*"`
	
	if [ -z "${ifrom}" ]; then
		rm -f ${raaction_lock_flag}
		return;
	fi
	
	for conn_dir in ${IPConn_folder}; do
		local ifname_path=`expr ${conn_dir}"/ifname"`
		if [ -f ${ifname_path} ]; then
			local ifname=`cat ${ifname_path}`
			if [ -z "${ifname}" ]; then
				continue;
			fi

			if [ "${ifname}" == "${ifrom}" ]; then
				do_action ${conn_dir}	
				break;
			fi
		fi
	done
	for conn_dir in ${PPPConn_folder}; do
		local ifname_path=`expr ${conn_dir}"/ppp_ifname"`
		if [ -f ${ifname_path} ]; then
			local ifname=`cat ${ifname_path}`
			if [ -z "${ifname}" ]; then
				continue;
			fi

			if [ "${ifname}" == "${ifrom}" ]; then
				do_action ${conn_dir}	
				break;
			fi
		fi
	done
}

find_connection_by_ifname
rm -f ${raaction_lock_flag}
