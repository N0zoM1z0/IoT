#!/bin/sh

. /usr/syscfg/firewall.param.sh
. /usr/syscfg/wan.utils.sh

IPSEC_BASIC_PATH="InternetGatewayDevice.Services.X_TRI_IPSec"

for para in $*
do
	export $para
done


local tunnelListNum=`cfgcmd get ${IPSEC_BASIC_PATH}.TunnelListNumberOfEntries`

##################################################################
case "$action" in
	"ifup")
		/usr/syscfg/ipsec_cfg.sh ifup &
		;;
	"ifdown")
		/usr/syscfg/ipsec_cfg.sh ifdown &
		;;
	*)
		;;
esac

