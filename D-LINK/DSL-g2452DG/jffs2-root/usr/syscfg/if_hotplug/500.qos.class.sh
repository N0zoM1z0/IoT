#!/bin/sh

. /usr/syscfg/firewall.param.sh
. /usr/syscfg/wan.utils.sh

for para in $*
do
	export $para
done

WR_DO="/usr/syscfg/rule/wan.rules.do.sh"
WR_CB="/usr/syscfg/qos/class.cb.sh"

if [ -z ${conn_code} ]; then
conn_code=`gen_wanconn_folder ${path}`
fi

# conn_code=PPP_I_I_I
# wan_ifname=ppp0
export "${conn_code}=${wan_ifname}"

##################################################################
case "$action" in
	"ifup")
		${WR_DO} config ${conn_code} class.config.sh ${WR_CB}
		;;
	"ifdown")
		${WR_DO} reset ${conn_code} class.reset.sh ${WR_CB}
		;;
	*)
		echo "unsupported action"
		;;
esac

