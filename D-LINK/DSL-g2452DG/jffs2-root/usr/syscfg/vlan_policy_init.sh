#!/bin/sh

. /usr/syscfg/ebtables.param.sh

# LAN口规则
lanIdxes="$(cfgcmd get_idxes InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.)"
lanIfs=""
for lanidx in ${lanIdxes}
do
	local ifName="$(cfgcmd get InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.${lanidx}.Name)"
	lanIfs="${lanIfs}${ifName},"
done

lanIfs="${lanIfs%?}"
lanIfs=`echo $lanIfs| tr "," " "`
# LAN口报文不允许forward到所有vlan端口
for lanIf in $lanIfs
do
	for lanIf2 in $lanIfs
	do
		ebtables -A ${VLAN_BIND_CHIAN} -i $lanIf -o "${lanIf2}.+" -j DROP
	done
done
