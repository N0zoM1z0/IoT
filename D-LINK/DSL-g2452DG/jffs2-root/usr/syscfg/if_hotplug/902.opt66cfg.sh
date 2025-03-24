#!/bin/sh

. /usr/syscfg/wan.utils.sh

for para in $*
do
    export $para
done 

wan_if_path=$path
wan_if_name=$wan_ifname

case "$action" in
	"ifup")
		/usr/syscfg/dhcpc_opt66.sh action="if_up"  wan_ifname="${wan_if_name}" path="${wan_if_path}"&
		;;
	"ifdown")
		/usr/syscfg/dhcpc_opt66.sh action="if_down" wan_ifname="${wan_if_name}" path="${wan_if_path}"&
		;;
	*)
		echo "unsupported action"
		;;
esac

