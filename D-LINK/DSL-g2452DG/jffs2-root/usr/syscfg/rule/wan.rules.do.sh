#!/bin/sh
# 
# configuring wan related rules of all or a certain wan
# 
# $1: config | reset
# $2: all | wan_code
# $3: all | script
# $4: callback script to exec the script
#
# NOTE:
#  1. treat common rules as a wan with the name of 'common';
#  2. if it's called from wan hotplug, `PPP_I_I_I=ppp0'
#     should be exported.
#
#

usage()
{
        echo "------------------------------------------------------"
        echo "Usage: $0 <config|reset> <all|wan_code> <script> <callback>"
        echo "------------------------------------------------------"
}

if [ $# -lt 3 ]; then
	usage
	exit
fi

op=$1
wan=$2
script=$3
callback=$4

exwan=""

root_dir="/tmp/.wan_rules"
cmn_dir="${root_dir}/common"

#Find VOIP or TR069 From IP_I_I_I_VOIP for Qos APP
findwan()
{
	local _type=$1
	local ret=""
	local up=""

	if [ -n ${_type} ];then
		wanDevs=`cfgcmd get_idxes InternetGatewayDevice.WANDevice.`
		for i in ${wanDevs} ; do
			wanTypeStr=`cfgcmd get InternetGatewayDevice.WANDevice.$i.WANCommonInterfaceConfig.WANAccessType`
			state=""
			case "${wanTypeStr}" in
				"Ethernet")
					state=`cfgcmd get InternetGatewayDevice.WANDevice.$i.WANEthernetInterfaceConfig.Status`
					;;
				"DSL")
					state=`cfgcmd get InternetGatewayDevice.WANDevice.$i.WANDSLInterfaceConfig.Status`
					;;
				"Dongle")
					state=""
					;;
				*)
					echo "WARR: get_uplink_line_state() fail, can not get the WANAccessType!!!"
					;;
			esac
			if [ "${state}" == "Up" ]; then
				wanConnDevs=`cfgcmd get_idxes InternetGatewayDevice.WANDevice."$i".WANConnectionDevice`
				if [ "${wanConnDevs}" != "0" ]; then
					for s in $wanConnDevs ; do
						wanPPPs=`cfgcmd get_idxes InternetGatewayDevice.WANDevice."$i".WANConnectionDevice."$s".WANPPPConnection`
						if [ "${wanPPPs}" != "0" ]; then
							for x in $wanPPPs ; do
								ServerTypeStr=`cfgcmd get InternetGatewayDevice.WANDevice."$i".WANConnectionDevice."$s".WANPPPConnection."$x".X_CT-COM_ServiceList`
								echo "$ServerTypeStr" | grep -q "$_type"
								if [ $? -eq 0 ]; then 
									ret="PPP_${i}_${s}_${x}"
									wanup ${ret}
									up=$?
									if [ ${up} -ne 0 ]; then
										break 3
									fi
								fi
							done
						fi
						wanIPs=`cfgcmd get_idxes InternetGatewayDevice.WANDevice."$i".WANConnectionDevice."$s".WANIPConnection`
						if [ "${wanIPs}" != "0" ]; then
							for y in $wanIPs ; do
								ServerTypeStr=`cfgcmd get InternetGatewayDevice.WANDevice."$i".WANConnectionDevice."$s".WANIPConnection."$y".X_CT-COM_ServiceList`
								echo "$ServerTypeStr" | grep -q "$_type"
								if [ $? -eq 0 ]; then 
									ret="IP_${i}_${s}_${y}"
									wanup ${ret}
									up=$?
									if [ ${up} -ne 0 ]; then
										break 3
									fi
								fi
							done
						fi
					done
				fi
			fi
		done
	fi
	echo "${ret}"
}

wanup()
{
	if [ $# -lt 1 ]; then
		return 0
	fi

	local _wan=$1

	# wan common always up
	if [ "${_wan}" == "common" ]; then
		return 1
	fi

#	if [ ! -z "${_wan}" -a -f "/tmp/${_wan}/uptime" ]; then
#		return 1
#	fi
        
	if [ ! -z "${_wan}" ] && [ -f "/tmp/${_wan}/uptime" -o -f "/tmp/${_wan}/ip6_uptime" ]; then
		return 1
	fi

	return 0
}

export_ifaddr()
{
	local _wan=$1
	
	export "${_wan}_BRNAME=br+"
	local f_ifn_addr="/tmp/${_wan}/ip_address"
	if [ -e "${f_ifn_addr}" ]; then
			_ifn_addr=`cat ${f_ifn_addr}`
			export "${_wan}_ADDR=${_ifn_addr}"
			if [ -n "${exwan}" ];then
				export "${exwan}=${_ifn_addr}"
			fi
	fi
}

export_ifname()
{
	if [ $# -lt 1 ]; then
		return 0
	fi
	
	local _wan=$1

	# PPP_I_I_I/common
	export "wan_code=${_wan}"

	# wan common don't need a name
	if [ "${_wan}" == "common" ]; then
		export_ifaddr ${_wan}	
		return 1
	fi

	eval _ifn=\$${_wan}
	# called from hotplug,
	# $PPP_I_I_I is already set
	if [ ! -z "${_ifn}" ]; then
		export_ifaddr ${_wan}
		return 1
	fi

	local f_ifn="/tmp/${_wan}/ppp_ifname"
	if [ -e "${f_ifn}" ]; then
		_ifn=`cat ${f_ifn}`
		export_ifaddr ${_wan}		
		export "${_wan}=${_ifn}"
		return 1
	fi
	
	f_ifn="/tmp/${_wan}/ifname"
	if [ -e "${f_ifn}" ]; then
		_ifn=`cat ${f_ifn}`
		export_ifaddr ${_wan}		
		export "${_wan}=${_ifn}"
		return 1
	fi
	return 0
}

# exec a script or all scripts recursively in a dir
# $1: a script file, or a scripts dir
do_exec()
{
	if [ $# -lt 1 ]; then
		return
	fi

	local this=$1
	
	if [ -f ${this} ]; then
		if [ -z "${callback}" ]; then
			. ${this}
		else
			${callback} ${this}
		fi
	fi

	if [ ! -d ${this} ]; then
		return
	fi

	for s in `ls ${this}`; do
		do_exec ${this}/$s
	done; unset s
}

do_script()
{
	if [ $# -lt 1 ]; then
		return
	fi
	local dir=$1

	do_exec "${dir}/${script}"
}

do_config()
{
	if [ $# -lt 1 ]; then
		return
	fi
	local _wan=$1	

	if [ ${_wan} == 'all' ]; then
		for w in `ls ${root_dir}`; do
			do_config $w
		done; unset w
	else
		exwan=""
		_subwan="`echo $_wan | awk -F '_' ' {print $4} '`"
		if [ "${_subwan}" == "VOIP" -o "${_subwan}" == "TR069" ];then
			exwan=${_wan}
			_wan=$(findwan "${_subwan}")
			if [ -z "${_wan}" ];then
				exwan=""
				return
			fi
		fi

		wanup ${_wan}
		ret=$?
		if [ ${ret} -ne 1 ]; then
			return
		fi
		
		export_ifname ${_wan}
		ret=$?
		if [ ${ret} -ne 1 ]; then
			return
		fi
	
		if [ -n "${exwan}" ]; then
			dir="${root_dir}/${exwan}/${op}"
		else
			dir="${root_dir}/${_wan}/${op}"
		fi
		do_script ${dir}
	fi
}

do_reset()
{
	if [ $# -lt 1 ]; then
		return
	fi
	local _wan=$1	

	if [ ${_wan} == 'all' ]; then
		for w in `ls ${root_dir}`; do
			do_reset $w
		done; unset w
	else
		_subwan="`echo $_wan | awk -F '_' ' {print $4} '`"
		if [ "${_subwan}" == "VOIP" -o "${_subwan}" == "TR069" ];then
			dir="${root_dir}/${_wan}/${op}"
			do_script ${dir}
		else
			export_ifname ${_wan}
			ret=$?
			if [ ${ret} -ne 1 ]; then
				return
			fi

			dir="${root_dir}/${_wan}/${op}"
			do_script ${dir}
		fi
	fi
}


case "${op}" in
	"reset")
		do_reset ${wan}
		;;
	"config")
		do_config ${wan}
		;;
	*)
		exit
		;;
esac

