#!/bin/sh
. /usr/syscfg/firewall.param.sh
. /usr/syscfg/wan.utils.sh



for para in $*
do
	export $para
done

WR_DO="/usr/syscfg/rule/wan.rules.do.sh"
WR_CB="/usr/syscfg/rule/cb/iptables.sh"

conn_code=`gen_wanconn_folder ${path}`

# conn_code=PPP_I_I_I
# wan_ifname=ppp0
export "${conn_code}=${wan_ifname}"

# wan_ifname=ppp0
##################################################################
case "$action" in
	"ifup")
		#add iptables rules for port forwarding
		iptables -t nat -A ${PORT_FORWARD_CHAIN} -i ${wan_ifname} -j  ${PORT_FORWARD_INTERNET_CHAIN}
		${WR_DO} config ${conn_code} vs ${WR_CB}		
		;;
	"ifdown")
		iptables -t nat -D ${PORT_FORWARD_CHAIN} -i ${wan_ifname} -j  ${PORT_FORWARD_INTERNET_CHAIN}
		${WR_DO} reset ${conn_code} vs ${WR_CB}
		;;
	*)
		echo "unsupported action"
		;;
esac
