#!/bin/sh 
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/firewall.param.sh

for para in $*
do
	export $para
done

if [ "${tnllist}" != "" -a "${action}" != "del" ]; then
	local GREWanPath=`cfgcmd get ${tnllist}.WanInterface`
	local GREWanStat=`cfgcmd get ${GREWanPath}ConnectionStatus`

	## if wan connection is not up, do nothing for gre settings.
	if [ "${GREWanStat}" == "Disconnected" ]; then
		exit 0;
	fi
fi

IPGRE_BASIC_PATH="InternetGatewayDevice.Services.X_TRI_GRETunnel"
IPv4_SROUTE_PATH="InternetGatewayDevice.Layer3Forwarding"

local IPGRERunDir="/var/.ipgre"
local ipgre_lock_flag="${IPGRERunDir}/ipgre_lock_flag"
while [ -f ${ipgre_lock_flag} ]
do
	usleep 10000
done
#create ipgre_lock_flag 
touch ${ipgre_lock_flag}

ipgre_set_route()
{
	local action=$1
	local wanifpath=$2
	local wanif=`get_wan_l2_ifname_by_path "${wanifpath}"`
	local i=$3
	local tnlPath="${IPGRE_BASIC_PATH}.TunnelList.${i}"

	local routeIdxes=`cfgcmd get_idxes "${IPv4_SROUTE_PATH}.Forwarding"`
	if [ "${routeIdxes}" == "0" ]; then
		return	
	fi

	for j in $routeIdxes
	do
		local routeIf=`cfgcmd get "${IPv4_SROUTE_PATH}.Forwarding.${j}.Interface"`
		# get the static route bound to GRE
		if [ "${routeIf}" == "${tnlPath}." ]; then
			local greDevName=`cfgcmd get "${tnlPath}.TunnelName"`
			local dstIP=`cfgcmd get "${IPv4_SROUTE_PATH}.Forwarding.${j}.DestIPAddress"`
			local dstIPMask=`cfgcmd get "${IPv4_SROUTE_PATH}.Forwarding.${j}.DestSubnetMask"`
			## add/del static routes
			ip route "${action}" "${dstIP}"/"${dstIPMask}" dev "${greDevName}" 2> /dev/null

			local tbl_idx="$(ip rule show | grep fwmark | awk -F 'lookup' '{print $2}')"   # " 201"
			if [ "${tbl_idx}" != "" ]; then
				for id in $tbl_idx
				do
					local devname=`ip route show table ${id} | grep default | awk '{print $5}'`
					# get the table bound to ${wanifpath}
					if [ "${devname}" == "${wanif}" ] ; then
						## add/del policy routes
						ip route "${action}" "${dstIP}"/"${dstIPMask}" dev "${greDevName}" table "${id}" 2> /dev/null
					fi
				done
			fi
		fi
	done
}

ipgre_sh_run_all()
{
	local IPGREInstRunType=$1
	local wanPath=$2

	local tunnelIdxes=`cfgcmd get_idxes "${IPGRE_BASIC_PATH}.TunnelList"`
	if [ "${tunnelIdxes}" == "0" ]; then
		return
	fi

	for i in $tunnelIdxes
	do
		local greWan=`cfgcmd get "${IPGRE_BASIC_PATH}.TunnelList.${i}.WanInterface"`
		if [ "${greWan}" == "$wanPath" ]; then
			if [ "${IPGREInstRunType}" == "start" ]; then
				ipgre_cfg_add "${IPGRE_BASIC_PATH}.TunnelList.${i}"
			elif [  "${IPGREInstRunType}" == "stop" ]; then
				ipgre_cfg_del "${IPGRE_BASIC_PATH}.TunnelList.${i}"
			fi
		fi
	done
}

ipgre_genLocalIP()
{
	local wanifpath=$1
	local wanif=`get_wan_l2_ifname_by_path "${wanifpath}"`
	local wanip=`ifconfig "${wanif}" |  grep "inet addr:" | awk -F ':' '{print $2}' | awk '{print $1}'`

	echo -n "${wanip}"
}

ipgre_cfg_set()
{
	## 1st, del tunnel interface
	ipgre_cfg_del ${tnllist}

	## 2nd, readd tunnel interface
	ipgre_cfg_add ${tnllist}
}

ipgre_cfg_add()
{
	local listPath=$1
	local grename=`cfgcmd get ${listPath}.TunnelName`
	local gretype=`cfgcmd get ${listPath}.TunnelMode`
	local remoteip=`cfgcmd get ${listPath}.RemoteIP`
	local wanpath=`cfgcmd get "${listPath}.WanInterface"`
	local ifIPAddr=`cfgcmd get "${listPath}.TunnelIPAddr"`
	local ifIPMask=`cfgcmd get "${listPath}.TunnelIPMask"`
	local localip=`ipgre_genLocalIP "${wanpath}"`
	local ttl=`cfgcmd get "${listPath}.TTL"`

	## 1st, add tunnel interface
	ip link add $grename type $gretype remote $remoteip local $localip ttl ${ttl}
	ip link set $grename up
	ifconfig $grename $ifIPAddr netmask $ifIPMask

    ## 2nd, accept GRE triffic when acts as receiver
	iptables -t filter -A ${GRETUNNEL_CHAIN} -p 47 -j ACCEPT


	## 3rd, add del shell script
	local idx=`echo "${listPath}" | awk -F "." '{print $NF}'`
	echo "#!/bin/sh" > ${IPGRERunDir}/${idx}_del.sh
	echo "ip link set $grename down" >> ${IPGRERunDir}/${idx}_del.sh
	echo "ip link del $grename type $gretype" >> ${IPGRERunDir}/${idx}_del.sh
	echo "iptables -t filter -D ${GRETUNNEL_CHAIN} -p 47 -j ACCEPT" >> ${IPGRERunDir}/${idx}_del.sh

	## 4th, add route if needed
	ipgre_set_route "add" "${wanpath}" "${idx}"
}

ipgre_cfg_del()
{
	local listPath=$1
	local idx=`echo "${listPath}" | awk -F "." '{print $NF}'`

	## del the interface , to routes will delete autolly
	if [ -f "${IPGRERunDir}/${idx}_del.sh" ]; then
		sh ${IPGRERunDir}/${idx}_del.sh
		rm -f ${IPGRERunDir}/${idx}_del.sh
	fi
}

case "${action}" in
	"init")
		ipgre_cfg_sh_gen_all
		;;
	"set")
		ipgre_cfg_set ${tnllist}
		;;
	"add")
		ipgre_cfg_add ${tnllist}
		;;
	"del")
		ipgre_cfg_del ${tnllist}
		;;
	"ifup")
		ipgre_sh_run_all "start" "${wanpath}"
		;;
	"ifdown")
		ipgre_sh_run_all "stop" "${wanpath}"
		;;
	*)
		;;
esac
rm -f ${ipgre_lock_flag}
