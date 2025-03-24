#!/bin/sh

for para in $*
do
	export $para
done


##################################################################
case "$action" in
	"ifup")
		/usr/syscfg/l2tp_cfg.sh action="ifup" tnllist="" wanpath="$path" &
		;;
	"ifdown")
		/usr/syscfg/l2tp_cfg.sh action="ifdown" tnllist="" wanpath="$path" &
		;;
	*)
		;;
esac

