#!/bin/sh
# 
# callback funcs for qos classification rules
# export ifnames instead of ppp ifnames
# 
# $1: rule file name
#

script=$1

if [ -z "${wan_code}" ]; then
	exit
fi

export_ifname()
{
	if [ $# -lt 1 ]; then
		return 0
	fi
	
	local _wan=$1

	if [ "${_wan}" == "common" ]; then
		return 1
	fi

	eval _ifn=\$${_wan}

	f_ifn="/tmp/${_wan}/ifname"
	if [ -e "${f_ifn}" ]; then
		_ifn=`cat ${f_ifn}`
		export "${_wan}=${_ifn}"
		return 1
	fi
	return 0
}

export_ifname ${wan_code}
ret=$?
if [ ${ret} -ne 1 ]; then
	exit
fi

${script}

