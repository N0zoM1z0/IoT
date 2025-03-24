#!/bin/sh
. /usr/syscfg/firewall.param.sh
. /usr/syscfg/wan.utils.sh

DMP_DMZ="InternetGatewayDevice.X_TRI-DMZ"

DMZ_EN=`cfgcmd get ${DMP_DMZ}.Enabled`
DMZ_HOST=`cfgcmd get ${DMP_DMZ}.Host`

RULE_RESET="/tmp/.dmz.reset.sh"

# reset first
iptables -t nat -F ${DMZ_CHAIN}
iptables -t nat -F ${DMZ_INTERNET_CHAIN}

if [ "${DMZ_EN}" == "0" ]; then
	exit
fi

iptables -t nat -A ${DMZ_INTERNET_CHAIN} -j DNAT --to-destination ${DMZ_HOST}


# add jumping rule to DMZ_INTERNET_CHAIN
DMZ_WAN=`cfgcmd get ${DMP_DMZ}.WanConnection`
DMZ_WAN_CODE=`gen_wanconn_folder ${DMZ_WAN}`

wanup=`is_wan_up ${DMZ_WAN_CODE}`
if [ "${wanup}" == "0" ]; then
	exit
fi

wan_ifname=`get_wanconn_ifname ${DMZ_WAN_CODE}`
if [ -z "${wan_ifname}" ]; then
	exit
fi

iptables -t nat -A ${DMZ_CHAIN} -i ${wan_ifname} -j ${DMZ_INTERNET_CHAIN}

