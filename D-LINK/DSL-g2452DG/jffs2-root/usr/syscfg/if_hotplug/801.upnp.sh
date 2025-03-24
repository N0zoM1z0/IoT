#!/bin/sh
. /usr/syscfg/getifname.sh
####################################################
for para in $*
do
	export $para
done
####################################################
if [ "${action}" == "ifup" ]; then
PATH=InternetGatewayDevice.DeviceInfo.X_CT-COM_UPNP
upnp_wanpath=`/usr/sbin/cfgcmd get ${PATH}.WANPathName`
IFNAME=`GetIfName ${upnp_wanpath}`
	if [ "${IFNAME}" == "${wan_ifname}" ]; then
		/usr/syscfg/miniupnpd.sh remove
		/usr/syscfg/miniupnpd.sh upnp_server
		/usr/syscfg/miniupnpd.sh blacklist_init
	fi
elif [ "${action}" == "ifdown" ]; then

	if [ "${IFNAME}" == "${wan_ifname}" ]; then
	/usr/syscfg/miniupnpd.sh remove
	fi
fi
