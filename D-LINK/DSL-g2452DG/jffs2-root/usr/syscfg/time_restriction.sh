#!/bin/sh

. /usr/syscfg/firewall.param.sh

CFGCMD="cfgcmd"
RULE_LIST="/tmp/.timerestrict.rule"
RootPth="InternetGatewayDevice.TimeRestriction"
RestrictionEnable=`$CFGCMD get ${RootPth}.Enable`
WEEKDAY_ALL="Sun Mon Tue Wed Thu Fri Sat"

if [ "$RestrictionEnable" == "0" ]; then
	iptables -F ${PARENTAL_CONTROL_MAC} 
	exit 0
fi

timeRestrict_GetUnchkDay()
{
	local weekdays=$1
	local uncheck=""
	local ret=""

	for day in $WEEKDAY_ALL
	do
		ret=`echo $weekdays | grep $day`
		if [ "${ret}" == "" ];then
			if [ "${uncheck}" == "" ];then
				uncheck="${uncheck}${day}"
			else
				uncheck="${uncheck},${day}"
			fi
		fi
	done
	echo -n "${uncheck}"
}

timeRestrict_Init()
{
	rm -rf $RULE_LIST
	local ruleList=`$CFGCMD get_idxes ${RootPth}.RestRules`
	if [ "$ruleList" != "0" ]; then
		for list in $ruleList ; do
			local allowed=`$CFGCMD get ${RootPth}.RestRules.$list.InternetAllowed`
			local macaddr=`$CFGCMD get ${RootPth}.RestRules.$list.MACAddr`
			local weekdays=`$CFGCMD get ${RootPth}.RestRules.$list.WeekDays`
			local timefrom=`$CFGCMD get ${RootPth}.RestRules.$list.TimeFrom`
			local timeto=`$CFGCMD get ${RootPth}.RestRules.$list.TimeTo`
			if [ "$allowed" == "1" ]; then
				# only allow pkgs pass from $timefrom to $timeto

				local del_rule="${list}>iptables -D ${PARENTAL_CONTROL_MAC} -m time --timestart "$timeto" --timestop "$timefrom" --weekdays "$weekdays" --kerneltz -m mac --mac-source "$macaddr"  -j DROP"
				local unchk=`timeRestrict_GetUnchkDay ${weekdays}`
				if [ "${unchk}" != "" ]; then
					del_rule="${del_rule} && iptables -D ${PARENTAL_CONTROL_MAC} -m time  --weekdays "$unchk" --kerneltz -m mac --mac-source "$macaddr"  -j DROP"
				fi
				echo "${del_rule}" >> $RULE_LIST

				iptables -I ${PARENTAL_CONTROL_MAC} -m time --timestart "$timeto" --timestop "$timefrom" --weekdays "$weekdays" --kerneltz -m mac --mac-source "$macaddr"  -j DROP
				if [ "${unchk}" != "" ]; then
					iptables -I ${PARENTAL_CONTROL_MAC} -m time  --weekdays "$unchk" --kerneltz -m mac --mac-source "$macaddr"  -j DROP
				fi

			elif [ "$allowed" == "0" ]; then
				# drop pkgs from $timefrom to $timeto
				echo "${list}>iptables -D ${PARENTAL_CONTROL_MAC} -m time --timestart "$timefrom" --timestop "$timeto" --weekdays "$weekdays" --kerneltz -m mac --mac-source "$macaddr"  -j DROP" >> $RULE_LIST
				iptables -I ${PARENTAL_CONTROL_MAC} -m time --timestart "$timefrom" --timestop "$timeto" --weekdays "$weekdays" --kerneltz -m mac --mac-source "$macaddr"  -j DROP
			fi
		done
	fi
}

timeRestrict_Set()
{
	local nodePth=$1
	local allowed=`$CFGCMD get ${nodePth}.InternetAllowed`
	local macaddr=`$CFGCMD get ${nodePth}.MACAddr`
	local weekdays=`$CFGCMD get ${nodePth}.WeekDays`
	local timefrom=`$CFGCMD get ${nodePth}.TimeFrom`
	local timeto=`$CFGCMD get ${nodePth}.TimeTo`
	local nodeNum=`echo ${nodePth} | awk -F . '{print $4}'`

	# delete the old rule from chain.
	local numrules=`sed -n /^${nodeNum}\>/p $RULE_LIST`
	local cmd=${numrules/${nodeNum}>/}
	eval ${cmd}

	sed -i /^${nodeNum}\>/d $RULE_LIST
	if [ "$allowed" == "1" ]; then
		# only allow pkgs pass from $timefrom to $timeto
		local del_rule="${nodeNum}>iptables -D ${PARENTAL_CONTROL_MAC} -m time --timestart "$timeto" --timestop "$timefrom" --weekdays "$weekdays" --kerneltz -m mac --mac-source "$macaddr"  -j DROP"
		local unchk=`timeRestrict_GetUnchkDay ${weekdays}`
		if [ "${unchk}" != "" ]; then
			del_rule="${del_rule} && iptables -D ${PARENTAL_CONTROL_MAC} -m time  --weekdays "$unchk" --kerneltz -m mac --mac-source "$macaddr"  -j DROP"
		fi
		echo "${del_rule}" >> $RULE_LIST

		iptables -I ${PARENTAL_CONTROL_MAC} -m time --timestart "$timeto" --timestop "$timefrom" --weekdays "$weekdays" --kerneltz -m mac --mac-source "$macaddr"  -j DROP
		if [ "${unchk}" != "" ]; then
			iptables -I ${PARENTAL_CONTROL_MAC} -m time  --weekdays "$unchk" --kerneltz -m mac --mac-source "$macaddr"  -j DROP
		fi

	elif [ "$allowed" == "0" ]; then
		# drop pkgs from $timefrom to $timeto
		echo "${nodeNum}>iptables -D ${PARENTAL_CONTROL_MAC} -m time --timestart "$timefrom" --timestop "$timeto" --weekdays "$weekdays" --kerneltz -m mac --mac-source "$macaddr"  -j DROP" >> $RULE_LIST
		iptables -I ${PARENTAL_CONTROL_MAC} -m time --timestart "$timefrom" --timestop "$timeto" --weekdays "$weekdays" --kerneltz -m mac --mac-source "$macaddr"  -j DROP
	fi
}

timeRestrict_Del()
{
	local nodePth=$1
	local nodeNum=`echo ${nodePth} | awk -F . '{print $4}'`
	local numrules=`sed -n /^${nodeNum}\>/p $RULE_LIST`
	local cmd=${numrules/${nodeNum}>/}
	eval ${cmd}
	sed -i /^${nodeNum}\>/d $RULE_LIST
}

case "$1" in
	"init")
		timeRestrict_Init
		;;
	"set")
		timeRestrict_Set $2
		;;
	"del")
		timeRestrict_Del $2
		;;
	*)
		;;
esac
