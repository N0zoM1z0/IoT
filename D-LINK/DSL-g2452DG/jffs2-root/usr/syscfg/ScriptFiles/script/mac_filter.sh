#!/bin/sh

NODEPATH=${1}
EnablePath=${NODEPATH//X_TRI-ACL/Enable}

CFGCMD=cfgcmd
IWPRIV=iwpriv
INTERFACEENABLE=`${CFGCMD} get ${EnablePath}`

if [ "$INTERFACEENABLE" == "0" ]; then
	exit 0
fi

IFCONFIG=ifconfig
INTERFACENAMEPATH=${NODEPATH//X_TRI-ACL/Name}
INTERFACENAME=`${CFGCMD} get ${INTERFACENAMEPATH}`
SET_WLAN="${IWPRIV} $INTERFACENAME set"

ACL_MODE=`${CFGCMD} get ${NODEPATH}.Status`
ACL_NUM=`${CFGCMD} get ${NODEPATH}.Mac_ListNumberOfEntries`

##aclmode
$SET_WLAN AccessPolicy=${ACL_MODE}
## clear all Entries in list
$SET_WLAN ACLClearAll=1

MACLISTPATH=${NODEPATH}.Mac_List
MAX_MACLIST=`${CFGCMD} get_max_obj ${MACLISTPATH}.`

MAC_LIST=""
I=1
INST=1
while [ $INST -le $MAX_MACLIST -a $I -le $ACL_NUM ]
do
	isExist=`${CFGCMD} check_obj ${MACLISTPATH}.${INST}`
	if [ "$isExist" == "0" ]; then
		MAC_ADDR_17B=`${CFGCMD} get ${MACLISTPATH}.${INST}.MacAddr`
		MAC_LIST=${MAC_LIST}"${MAC_ADDR_17B};"
		I=$((I + 1))
	fi
	INST=$((INST + 1))
done
MAC_LIST=${MAC_LIST%;}
if [ "$MAC_LIST" != "" ]; then
	$SET_WLAN ACLAddEntry="${MAC_LIST}"
fi
