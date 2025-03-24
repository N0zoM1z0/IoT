#!/bin/sh

. /usr/syscfg/firewall.param.sh
. /usr/syscfg/nat/param.sh
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
		iptables -t nat -A ${MULTINAT_CHAIN} -o ${wan_ifname} -j ${MULTINAT_INTERNET_CHAIN}
		${WR_DO} config ${conn_code} $MULTINAT
		;;
	"ifdown")
		iptables -t nat -D ${MULTINAT_CHAIN} -o ${wan_ifname} -j ${MULTINAT_INTERNET_CHAIN}
		${WR_DO} reset ${conn_code} $MULTINAT
		;;
	*)
		echo "unsupported action"
		;;
esac

