#!/bin/sh
# 
# dispatch qos configuration calls
# 
# $1: queue/policer/class/mngmt
# $2: reset/config

usage()
{
        echo "------------------------------------------------------"
        echo "Usage: $0 <queue/app/class/mngmt> <reset|config>"
        echo "------------------------------------------------------"
}

if [ $# -lt 2 ]; then
        usage
        exit
fi

ca=$1
op=$2

S_DIR="/tmp/.qos"

#######################################################################
case "${op}" in
	"reset")
		;;
	"config")
		;;
	*)
		exit
		;;
esac

case "${ca}" in
	"app")
		/usr/syscfg/rule/wan.rules.do.sh ${op} all qos.${ca}
		;;
	"class")
		/usr/syscfg/rule/wan.rules.do.sh ${op} all qos.${ca}
		;;
	"queue" | "mngmt")
		. /usr/syscfg/qos/wan.param.export.sh

		# 0/1
		# shaper depends on wan band
		if [ ${op} == "config" -a "${wan_status}" == "0" ]; then
			exit
		fi

		${S_DIR}/${ca}.${op}.sh
		;;
	*)
		exit
		;;
esac

