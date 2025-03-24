#!/bin/sh
. /usr/syscfg/wan.utils.sh

path=""
ifname=""

for para in $*
do
        export $para
done

###################################################################
wan_connecton_stats_get()
{
	local WAN_DIR=`gen_wanconn_folder ${path}`
	local wanup="0"
	local ip6_wanup="0"
	local eth_PR="0"
	local eth_PS="0"
	local eth_BR="0"
	local eth_BS="0"

	#check if wan connection up
	wanup="`is_wan_up ${WAN_DIR}`"
	ip6_wanup="`is_ip6_wan_up ${WAN_DIR}`"

	if [ "${wanup}" == "1" -o "${ip6_wanup}" == "1" ]; then
		ifname=`get_wanconn_ifname ${WAN_DIR}`
		if [ -n "${ifname}" ]; then
			local dev_info="`ifconfig ${ifname}`"
			eth_PR="`echo "${dev_info}" | grep "RX packets" |cut -d : -f 2 | awk '{print$1}'`"
			eth_PS="`echo "${dev_info}" | grep "TX packets" |cut -d : -f 2 | awk '{print$1}'`"
			eth_BR="`echo "${dev_info}" | grep "RX bytes" |cut -d : -f 2 | awk '{print$1}'`"
			eth_BS="`echo "${dev_info}" | grep "TX bytes" |cut -d : -f 3 | awk '{print$1}'`"
		fi
	fi

	#update stats
	cfgcmd sset ${path}EthernetPacketsReceived ${eth_PR}
	cfgcmd sset ${path}EthernetPacketsSent     ${eth_PS}
	cfgcmd sset ${path}EthernetBytesReceived   ${eth_BR}
	cfgcmd sset ${path}EthernetBytesSent       ${eth_BS}
}

wan_connecton_stats_get
