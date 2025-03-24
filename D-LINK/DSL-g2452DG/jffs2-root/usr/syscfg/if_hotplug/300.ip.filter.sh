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

##################################################################
case "$action" in
	"ifup")
		iptables -A ${IPPORT_FILTER_CHAIN} -i ${wan_ifname} -j ${WAN_FILTER_CHAIN}
		${WR_DO} config ${conn_code} lan_filter ${WR_CB}
		${WR_DO} config ${conn_code} wan_filter ${WR_CB}
		;;
	"ifdown")
		iptables -D ${IPPORT_FILTER_CHAIN} -i ${wan_ifname} -j ${WAN_FILTER_CHAIN}
		${WR_DO} reset ${conn_code} lan_filter ${WR_CB}
		${WR_DO} reset ${conn_code} wan_filter ${WR_CB}
		;;
	*)
		echo "unsupported action"
		;;
esac

