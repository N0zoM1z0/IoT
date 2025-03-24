#!/bin/sh

. /usr/syscfg/wan.utils.sh

path=""

for para in $*
do
	export $para
done

if [ -z ${path} ]; then
	exit
fi


ip_mode=`cfgcmd get ${path}X_CT-COM_IPMode`
wan_folder=`gen_wanconn_folder ${path}`
addr_type=`cfgcmd get ${path}AddressingType`
dns_override=`cfgcmd get ${path}DNSOverrideAllowed`
ipv6addr_type=`cfgcmd get ${path}X_CT-COM_IPv6IPAddressOrigin`
ipv6dnsaddr_type=`cfgcmd get ${path}X_CT-COM_IPv6DNSAddressSource`
ConnectionType=`cfgcmd get ${path}ConnectionType`

is_wan_ppp="1"
if [ "${wan_folder:0:2}" == "IP" ]; then
	is_wan_ppp="0"
fi

update_uptime()
{
    uptime=`cat /tmp/${wan_folder}/uptime | awk '{print $1}'`
    currenttime=`date | awk '{print $4}'`
    if [ "$uptime" == "" ];then
        time=0
    else
        sec_up=`echo $uptime | cut -d : -f 3`
	    min_up=`echo $uptime | cut -d : -f 2`
	    hour_up=`echo $uptime | cut -d : -f 1`

	    sec_cur=`echo $currenttime | cut -d : -f 3`
	    min_cur=`echo $currenttime | cut -d : -f 2`
	    hour_cur=`echo $currenttime | cut -d : -f 1`
	
	    hour_delta=`expr ${hour_cur} - ${hour_up}`
	    min_delta=`expr ${min_cur} - ${min_up}`
	    sec_delta=`expr ${sec_cur} - ${sec_up}`
	    time=`expr ${hour_delta} \* 3600 + ${min_delta} \* 60 + ${sec_delta}`
    fi
	
	cfgcmd sset ${path}Uptime ${time}
}

if [ ${is_wan_ppp} == "1" ]; then

	session_id=`cat /tmp/${wan_folder}/ppp_sessionid`
	cfgcmd sset ${path}PPPoESessionID ${session_id}

	ppp_gw=`cat /tmp/${wan_folder}/ppp_ipremote`
	cfgcmd sset ${path}DefaultGateway ${ppp_gw}

	update_uptime

	link_type_path=`cat /tmp/${wan_folder}/dsllinktype_path`
	link_type=`cfgcmd get ${link_type_path}`
	tran_type=""
	if [ "${link_type}" == "PPPoA" ]; then
		tran_type="PPPoA"
	else
		tran_type="PPPoE"
	fi
	cfgcmd sset ${path}TransportType ${tran_type}

	if_name=`cat /tmp/${wan_folder}/ppp_ifname`
	info="`ifconfig ${if_name}`"
	PPPC_MTUSize=`echo "${info}" | grep "MTU:" | awk '{print $7}' | cut -d : -f 2`
	cfgcmd sset ${path}CurrentMTUSize ${PPPC_MTUSize}

	cur_mru=`cfgcmd get ${path}MaxMRUSize`
	cfgcmd sset ${path}CurrentMRUSize ${cur_mru}

elif [ ${is_wan_ppp} == "0" ]; then
    update_uptime
fi

IPv4Conn_get()
{
	local wan_ipAddr=""
	local wan_subMask=""
	local wan_gw=""
	local wan_dns=""
	local wan_remote=""

	wan_up=`is_wan_up ${wan_folder}`
	if [ ${wan_up} == "1" ]; then
		if [ "${addr_type}" != "Static" ]; then
			ifname=`get_wanconn_ifname ${wan_folder}`
			if [ "$ConnectionType" == "Con_Bridged" ]; then
				wan_ipAddr=`cat /tmp/${wan_folder}/ip_address`
				wan_subMask=`cat /tmp/${wan_folder}/ip_mask`
			else
				dev_info="`ifconfig ${ifname}`"
				wan_ipAddr=`echo "${dev_info}" | grep "inet addr:" | awk '{print $2}' | cut -d : -f 2`
				wan_subMask=`echo "${dev_info}" | grep "inet addr:" | awk '{print $4}' | cut -d : -f 2`
			fi
			wan_dns=`get_wan_dns ${wan_folder}`
			if [ ${is_wan_ppp} == "1" ]; then
				wan_remote=`get_wan_ppp_remote ${wan_folder}`
			else
				wan_gw=`get_wan_gw ${wan_folder}`
			fi
		fi
	fi
	
	if [ "${addr_type}" != "Static" ]; then
		cfgcmd sset ${path}ExternalIPAddress "${wan_ipAddr}"
		
		if [ "${dns_override}" != "1" ]; then
		cfgcmd sset ${path}DNSServers "${wan_dns}"
		fi
		if [ ${is_wan_ppp} == "1" ]; then
			cfgcmd sset ${path}RemoteIPAddress "${wan_remote}"
		else
			cfgcmd sset ${path}DefaultGateway "${wan_gw}"
		    cfgcmd sset ${path}SubnetMask "${wan_subMask}"
		fi
	fi
}

IPv6Conn_get()
{
	local wan_ipAddr=""
	local wan_subMask=""
	local wan_gw=""
	local wan_dns=""

	wan_up=`is_ip6_wan_up ${wan_folder}`
	if [ ${wan_up} == "1" ]; then
		if [ "${ipv6addr_type}" != "Static" ]; then
			ifname=`get_wanconn_ifname ${wan_folder}`
			dev_info="`ifconfig ${ifname}`"
			wan_ipAddr=`echo "${dev_info}" | grep "Scope:Global" | awk '{print $3}' | cut -d / -f 1`
			wan_subMask=`echo "${dev_info}" | grep "Scope:Global" | awk '{print $3}' | cut -d / -f 2`
			if [ "${ConnectionType}" != "IP_Bridged" -a -z "$wan_ipAddr" ]; then
				wan_ipAddr=`echo "${dev_info}" | grep "Scope:Link" | awk '{print $3}' | cut -d / -f 1`
				wan_subMask=`echo "${dev_info}" | grep "Scope:Link" | awk '{print $3}' | cut -d / -f 2`
			fi
			wan_gw=`get_ip6_wan_gw ${wan_folder}`
			wan_dns=`get_ip6_wan_dns ${wan_folder}`
		fi
	fi

	if [ "${ipv6addr_type}" != "Static" ]; then
		cfgcmd sset ${path}X_CT-COM_IPv6IPAddress "${wan_ipAddr}"
		cfgcmd sset ${path}X_CT-COM_IPv6AddressPrefixLen "${wan_subMask}"
		cfgcmd sset ${path}X_CT-COM_DefaultIPv6Gateway "${wan_gw}"
	fi
	if [ "${ipv6dnsaddr_type}" != "Static" ]; then
		cfgcmd sset ${path}X_CT-COM_IPv6DNSServers "${wan_dns}"
	fi
}


case "${ip_mode}" in
	"1")
		IPv4Conn_get
		;;
	"2")
		IPv6Conn_get
		;;
	"3")
		IPv4Conn_get
		IPv6Conn_get
		;;
	*)
		#Unknow
		;;
esac



