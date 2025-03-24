#!/bin/sh

for para in $*
do
	export $para
done


##################################################################
case "$action" in
	"ifup")
		/usr/syscfg/ipgre_cfg.sh action="ifup" tnllist="" wanpath="$path"
		;;
	"ifdown")
		/usr/syscfg/ipgre_cfg.sh action="ifdown" tnllist="" wanpath="$path" &
		;;
	*)
		;;
esac

