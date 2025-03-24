#!/bin/sh

. /usr/syscfg/firewall.param.sh
. /usr/syscfg/wan.utils.sh

for para in $*
do
	export $para
done

# conn_path=PPP_I_I_I
# wan_ifname=ppp0

DMP_DMZ="InternetGatewayDevice.X_TRI-DMZ"

DMZ_WAN=`cfgcmd get ${DMP_DMZ}.WanConnection`
DMZ_WAN_CODE=`gen_wanconn_folder ${DMZ_WAN}`

conn_code=`gen_wanconn_folder ${path}`
 
if [ "${conn_code}" != "${DMZ_WAN_CODE}" ]; then
	exit
fi

##################################################################
case "$action" in
	"ifup")
		#add iptables rules for dmz
		iptables -t nat -A ${DMZ_CHAIN} -i ${wan_ifname} -j ${DMZ_INTERNET_CHAIN}
		;;
	"ifdown")
		iptables -t nat -D ${DMZ_CHAIN} -i ${wan_ifname} -j ${DMZ_INTERNET_CHAIN}
		;;
	*)
		echo "unsupported action"
		;;
esac
