#!/bin/sh

. /usr/syscfg/wan.utils.sh

for para in $*
do
    export $para
done 

case "$action" in
	"ifup")
		/usr/syscfg/dRouting.sh "${action}" "${path}" &
		;;
	"ifdown")
		/usr/syscfg/dRouting.sh "${action}" "${path}" &
		;;
	*)
		echo "unsupported action"
		;;
esac

