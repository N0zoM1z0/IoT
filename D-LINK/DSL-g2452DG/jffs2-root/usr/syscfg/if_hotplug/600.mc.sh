#!/bin/sh

. /usr/syscfg/wan.utils.sh

for para in $*
do
    export $para
done 

wan_if_path=$path

case "$action" in
	"ifup")
		/usr/syscfg/mc_snooping.sh action="if_up" path="${wan_if_path}"
		/usr/syscfg/mc_proxy.sh action="if_up" path="${wan_if_path}"
		/usr/syscfg/igmp_mld_init.sh action="if_up" path="${wan_if_path}"
		;;
	"ifdown")
		/usr/syscfg/mc_snooping.sh action="if_down" path="${wan_if_path}"
		/usr/syscfg/mc_proxy.sh action="if_down" path="${wan_if_path}"
		/usr/syscfg/igmp_mld_init.sh action="if_down" path="${wan_if_path}"
		;;
	*)
		echo "unsupported action"
		;;
esac

