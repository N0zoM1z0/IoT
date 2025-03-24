#!/bin/sh
. /usr/syscfg/ebtables.param.sh

CFGCMD=/usr/sbin/cfgcmd
EBTABLES=/usr/sbin/ebtables
mac_filter_path="/var/mac_filter"
MAC_FILTER_PATH=InternetGatewayDevice.X_CT-COM_MacFilter
MAC_LIST_PATH=InternetGatewayDevice.X_CT-COM_MacFilter.MacList
filter_enable=`$CFGCMD get ${MAC_FILTER_PATH}.Enable`
filter_mode=`$CFGCMD get ${MAC_FILTER_PATH}.FilterMode`

mac_filter_init()
{
	$EBTABLES -t nat -F ${MAC_FILTER_CHAIN}
	rm -rf ${mac_filter_path}
	mkdir ${mac_filter_path}

	if [ "${filter_enable}" == "1" ]; then
		#need_default=0
		instnum=1
		max_inst=$(${CFGCMD} get_max_obj ${MAC_LIST_PATH})

		if [ -z "${max_inst}" -o "${max_inst}" == "0" ]; then
			return 0;
		fi

		if [ "${filter_mode}" == "Deny" ]; then
			TARGET="DROP"
		else
			TARGET="RETURN"
			$EBTABLES -t nat -A ${MAC_FILTER_CHAIN} -j DROP
		fi
		while [ "${instnum}" -le "${max_inst}" ]
		do
			inst_path="${MAC_LIST_PATH}.${instnum}."
			inst_exist=$($CFGCMD check_obj ${inst_path})
			if [ "${inst_exist}" != "0" ]; then
				instnum=`expr ${instnum} + 1`
				continue
			fi
			macaddr=$(${CFGCMD} get ${inst_path}MACAddress)
			if [ -n "${macaddr}" ]; then
				${EBTABLES} -t nat -I ${MAC_FILTER_CHAIN} --source ${macaddr} -j ${TARGET}
				echo "$EBTABLES -t nat -D ${MAC_FILTER_CHAIN} --source ${macaddr} -j ${TARGET}" > ${mac_filter_path}/${instnum}.sh
				chmod +x ${mac_filter_path}/${instnum}.sh
				#need_default=1
			fi
			instnum=`expr ${instnum} + 1`
		done
	fi
}

mac_list_add()
{
	local inst_path=$1
	if [ "${filter_enable}" == "1" ]; then
		instnum=`echo $1 | cut -d . -f 4`
		macaddr=`$CFGCMD get ${inst_path}MACAddress`

		if [ "${filter_mode}" == "Deny" ]; then
			TARGET="DROP"
		else
			TARGET="RETURN"
		fi
		if [ -n "${macaddr}" ]; then
			${EBTABLES} -t nat -I ${MAC_FILTER_CHAIN} --source ${macaddr} -j ${TARGET}
			echo "$EBTABLES -t nat -D ${MAC_FILTER_CHAIN} --source ${macaddr} -j ${TARGET}" > ${mac_filter_path}/${instnum}.sh
			chmod +x ${mac_filter_path}/${instnum}.sh
		fi
		#filter_rules=`ls -l ${mac_filter_path}/*.sh | wc -l`
		#if [ "${filter_mode}" != "Deny" -a "${filter_rules}" -ge "1" ]; then
		#	$EBTABLES -A ${MAC_FILTER_CHAIN} -j DROP
		#fi
	fi
}

mac_list_del()
{
	if [ "${filter_enable}" == "1" ]; then
		instnum=`echo $1 | cut -d . -f 4`
		if [ -x "${mac_filter_path}/${instnum}.sh" ]; then
			${mac_filter_path}/${instnum}.sh
			rm -f ${mac_filter_path}/${instnum}.sh
		fi
	fi
	#delete the default rule, if no mac list exist
	#filter_rules=`ls -l ${mac_filter_path}/*.sh | wc -l`
	#if [ "${filter_mode}" != "Deny" -a "${filter_rules}" == "0" ]; then
	#	$EBTABLES -D ${MAC_FILTER_CHAIN} -j DROP
	#fi
}

case $1 in
	"init")
		mac_filter_init
		;;
	"list_add")
		mac_list_add $2
		;;
	"list_del")
		mac_list_del $2
		;;
	"list_set")
		mac_list_del $2
		mac_list_add $2
		;;
esac
