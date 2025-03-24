#!/bin/sh 
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/firewall.param.sh

for para in $*
do
	export $para
done

if [ "${tnllist}" != "" -a "${action}" != "del" ]; then
	local L2TPWanPath=`cfgcmd get ${tnllist}.WanInterface`
	local L2TPWanStat=`cfgcmd get ${L2TPWanPath}ConnectionStatus`

	## if wan connection is not up, do nothing for l2tp settings.
	if [ "${L2TPWanStat}" == "Disconnected" ]; then
		exit 0;
	fi
fi

L2TP_BASIC_PATH="InternetGatewayDevice.Services.X_TRI_L2TP"
L2TP_PPP_UNIT_BASE=100
L2TP_PORT="1701"

local L2TPRunDir="/var/.l2tp"
local l2tp_lock_flag="${L2TPRunDir}/l2tp_lock_flag"
while [ -f ${l2tp_lock_flag} ]
do
	usleep 1000
done
#create l2tp_lock_flag 
touch ${l2tp_lock_flag}

# TODO: move to PPP ip-up script
l2tp_wait_ppp_up()
{
	local unit=$1
	local isup=`ip route show | grep ppp$unit`
	local retry=10
	local i=0
	while [ "${isup}" == "" -a ${i} -lt ${retry} ]
	do
		sleep 1 
		isup=`ip route show | grep ppp$unit`
		i=`expr $i + 1`
	done
	
	if [ "${i}" == "${retry}" ]; then
		echo "l2tp_cfg.sh: wait PPP up timeout. "
	fi

}

# TODO: move to PPP ip-down script
l2tp_wait_ppp_down()
{
	local idx=$1
	local unit=`expr $L2TP_PPP_UNIT_BASE + $idx`
	local isdown=`ip route show | grep ppp$unit`
	local retry=10
	local i=0
	while [ "${isdown}" != "" -a ${i} -lt ${retry} ]
	do
		sleep 1
		isdown=`ip route show | grep ppp$unit`
		i=`expr $i + 1`
	done
	
	if [ "${i}" == "${retry}" ]; then
		echo "l2tp_cfg.sh: wait PPP down timeout. "
	fi

}

l2tp_set_route()
{
	local actionType=$1
	local wanifpath=$2
	local wanif=`get_wan_l2_ifname_by_path "${wanifpath}"`
	local i=$3
	local unit=`expr $L2TP_PPP_UNIT_BASE + $i`

	local tnlPath="${L2TP_BASIC_PATH}.TunnelList.${i}" 
	local lns_lan_ip=`cfgcmd get "${tnlPath}.LnsLanIP"`
	local lns_lan_mask=`cfgcmd get "${tnlPath}.LnsLanMask"`

	## add/del static routes
	ip route "${actionType}" "${lns_lan_ip}"/"${lns_lan_mask}" dev ppp"${unit}" 2> /dev/null

	local tbl_idx="$(ip rule show | grep fwmark | awk -F 'lookup' '{print $2}')"   # " 201"
	if [ "${tbl_idx}" != "" ]; then
		for id in $tbl_idx
		do
			local devname=`ip route show table ${id} | grep default | awk '{print $5}'`
			# get the table bound to ${wanifpath}
			if [ "${devname}" == "${wanif}" ] ; then
			## add/del policy route
				ip route "${actionType}" "${lns_lan_ip}"/"${lns_lan_mask}" dev ppp"${unit}" table "${id}" 2> /dev/null
			fi
		done
	fi
}


l2tp_cfg_genWanIP()
{
	local wanifpath=$1
	local wanif=`get_wan_l2_ifname_by_path "${wanifpath}"`
	local wanip=`ifconfig "${wanif}" |  grep "inet addr:" | awk -F ':' '{print $2}' | awk '{print $1}'`

	echo -n "${wanip}"
}

l2tp_cfg_set()
{
	## 1st, del tunnel interface
	l2tp_cfg_del ${tnllist}

	## 2nd, readd tunnel interface
	l2tp_cfg_add ${tnllist}

}

l2tp_cfg_gen_lac_ppp_opts()
{
	local unit=$1
	local tname=$2
	local uname=$3
	local psw=$4
	local optfile=$5

	echo "#		" > ${optfile}
	echo "unit $unit" >> ${optfile}
	echo "lock" >> ${optfile}
	echo "noauth" >> ${optfile}
	echo "debug" >> ${optfile}
	echo "dump" >> ${optfile}
	echo "logfd 2" >> ${optfile}
	echo "logfile /var/log/xl2tpd_$unit.log" >> ${optfile}
	echo "noccp" >> ${optfile}
	echo "novj" >> ${optfile}
	echo "novjccomp" >> ${optfile}
	echo "nopcomp" >> ${optfile}
	echo "noaccomp" >> ${optfile}
	echo "remotename $tname" >> ${optfile}
	echo "user \"$uname\"" >> ${optfile} 
	echo "password \"$psw\"" >> ${optfile}
}

l2tp_cfg_add_lac_no_daemon()
{
	local listPath=$1
	local sameWanIdx=$2
	local l2tp_ctrl=${L2TPRunDir}/${sameWanIdx}/l2tp-control
	local l2tp_pid=${L2TPRunDir}/${sameWanIdx}/xl2tpd.pid
	local tunnel_name=`cfgcmd get ${listPath}.TunnelName`
	local wanpath=`cfgcmd get "${listPath}.WanInterface"`
	local lns_ip=`cfgcmd get "${listPath}.LnsIP"`
	local username=`cfgcmd get "${listPath}.PPPUserName"`
	local password=`cfgcmd get "${listPath}.PPPPassword"`
	local idx=`echo "${listPath}" | awk -F "." '{print $NF}'`
	local ppp_opt_file=${L2TPRunDir}/${idx}/options.xl2tpd
	local unit=`expr $L2TP_PPP_UNIT_BASE + $idx`

	echo "" > /var/log/xl2tpd_${unit}.log
	mkdir -p ${L2TPRunDir}/${idx}

	l2tp_cfg_gen_lac_ppp_opts $unit $tunnel_name $username $password $ppp_opt_file
	
	local tunnel_localip=`cfgcmd get ${listPath}.TunnelLocalIP`
	local localipopt=""
	if [ "${tunnel_localip}" != "" ];then
		localipopt=`echo "local ip=$tunnel_localip;"`
	fi

	echo "a $tunnel_name lns=$lns_ip;$localipopt pppoptfile=$ppp_opt_file;" > $l2tp_ctrl
	sleep 1 
	echo "c $tunnel_name" > $l2tp_ctrl

	# backup cfg for revert
	local bk_file=${L2TPRunDir}/${idx}/cfg.bk
	local pid=`cat $l2tp_pid`
	echo "pid=$pid" > ${bk_file}
	echo "tunnelname=$tunnel_name" >> ${bk_file}
	echo "tunnelidx=$idx" >> ${bk_file}
	echo "tunnelidxSameWan=$sameWanIdx" >> ${bk_file}
	echo "wanpath=$wanpath" >> ${bk_file}
}

l2tp_cfg_add_lac_start_daemon()
{
	local listPath=$1
	local wanpath=`cfgcmd get "${listPath}.WanInterface"`
	local tunnel_name=`cfgcmd get "${listPath}.TunnelName"`
	local tunnel_localip=`cfgcmd get "${listPath}.TunnelLocalIP"`
	local lns_ip=`cfgcmd get "${listPath}.LnsIP"`
	local username=`cfgcmd get "${listPath}.PPPUserName"`
	local password=`cfgcmd get "${listPath}.PPPPassword"`
	local listen_ip=`l2tp_cfg_genWanIP "${wanpath}"`
	local idx=`echo "${listPath}" | awk -F "." '{print $NF}'`
	local unit=`expr $L2TP_PPP_UNIT_BASE + $idx`

	cfgcmd sset ${listPath}.ListenIP ${listen_ip}

	# 1. prepare media files
	mkdir -p /var/log
	echo "" > /var/log/xl2tpd_${unit}.log
	#mkdir -p /var/run/xl2tpd
	#touch /var/run/xl2tpd/l2tp-control
	mkdir -p ${L2TPRunDir}/${idx}

	# 2. accept L2TP packet
	
	# 3. generate cfg files 
	local l2tp_sec_file=${L2TPRunDir}/${idx}/xl2tp-secrets
	local ppp_opt_file=${L2TPRunDir}/${idx}/options.xl2tpd
	local l2tp_conf=${L2TPRunDir}/${idx}/xl2tpd.conf
	local l2tp_pid=${L2TPRunDir}/${idx}/xl2tpd.pid
	local l2tp_ctrl=${L2TPRunDir}/${idx}/l2tp-control

	echo "[global]" > ${l2tp_conf}
	echo "port = $L2TP_PORT" >> ${l2tp_conf}
	echo "auth file = $l2tp_sec_file" >> ${l2tp_conf}
	echo "listen-addr = $listen_ip" >> ${l2tp_conf}
	echo "access control = no" >> ${l2tp_conf}
	echo "[lac $tunnel_name]" >> ${l2tp_conf}
	echo "lns = $lns_ip" >> ${l2tp_conf}
	if [ "${tunnel_localip}" != "" ];then
		echo "local ip = $tunnel_localip" >> ${l2tp_conf} 
	fi
	#echo "require authentication = yes" >> ${l2tp_conf}
	#echo "require chap = yes" >> ${l2tp_conf}
	#echo "require pap = yes" >> ${l2tp_conf}
	echo "name = $tunnel_name" >> ${l2tp_conf}
	echo "ppp debug = yes" >> ${l2tp_conf}
	echo "pppoptfile = $ppp_opt_file" >> ${l2tp_conf}

	echo "# Secrets for authenticating l2tp tunnels" > ${l2tp_sec_file}
	echo "# us		them		secret" >> ${l2tp_sec_file}

	l2tp_cfg_gen_lac_ppp_opts $unit $tunnel_name $username $password $ppp_opt_file

	# 4. start xl2tpd and connect server
	xl2tpd -c ${l2tp_conf} -s ${l2tp_sec_file} -p ${l2tp_pid} -C ${l2tp_ctrl} &
	sleep 1
	echo "c $tunnel_name" > ${l2tp_ctrl} 
	
	# 5. backup settings for revert
	local bk_file=${L2TPRunDir}/${idx}/cfg.bk
	local pid=`cat $l2tp_pid`
	echo "pid=$pid" > ${bk_file}
	echo "tunnelname=$tunnel_name" >> ${bk_file}
	echo "tunnelidx=$idx" >> ${bk_file}
	echo "wanpath=$wanpath" >> ${bk_file}

}

l2tp_cfg_add_lac()
{
	local listPath=$1
	local wanpath=`cfgcmd get "${listPath}.WanInterface"`
	local idx=`echo "${listPath}" | awk -F "." '{print $NF}'`
	local tunnelListNum=`cfgcmd get "${L2TP_BASIC_PATH}.TunnelListNumberOfEntries"`
	local tunnelIdxes=`cfgcmd get_idxes "${L2TP_BASIC_PATH}.TunnelList"`
	local is_daemon=1


	if [ "${tunnelListNum}" == "1" ]; then 
		iptables -t filter -A ${L2TPTUNNEL_CHAIN} -p udp --dport ${L2TP_PORT} -j ACCEPT 2>/dev/null
	fi
	
	for i in $tunnelIdxes
	do
		if [ "${i}" == "${idx}" ];then
			continue
		fi

		local tnlPath="${L2TP_BASIC_PATH}.TunnelList.${i}" 
		local l2tpWanPth=`cfgcmd get ${tnlPath}.WanInterface`
		if [ "${wanpath}" == "${l2tpWanPth}" -a -f "${L2TPRunDir}/${i}/xl2tpd.pid" ];then
			local l2tp_pid=`cat "${L2TPRunDir}/${i}/xl2tpd.pid"`
			if [ -d "/proc/$l2tp_pid" ]; then
				is_daemon=0
				break
			fi
		fi
	done

	# if there is a running l2tp, whose WAN is same with mine, don't start xl2tpd again;
	# otherwise, start a new xl2tpd; in other words, one xl2tpd for one WAN IF.
	if [ $is_daemon -eq 0  ]; then
		l2tp_cfg_add_lac_no_daemon ${listPath} ${i}
	else
		l2tp_cfg_add_lac_start_daemon ${listPath}
	fi	
	
	local unit=`expr $L2TP_PPP_UNIT_BASE + $idx`
	l2tp_wait_ppp_up "${unit}"
	l2tp_set_route "add" "${wanpath}" "${idx}"
}

l2tp_cfg_add_lns()
{
	#TBD
	return
}

l2tp_cfg_add()
{
	local listPath=$1
	local tunnel_enable=`cfgcmd get ${listPath}.TunnelEnable`	
	local tunnel_mode=`cfgcmd get ${listPath}.TunnelMode`

	if [ "${tunnel_enable}" == "0"  ] ;then
		return
	fi

	if [ "${tunnel_mode}" == "1" ] ;then
		l2tp_cfg_add_lns ${listPath}
	else
		l2tp_cfg_add_lac ${listPath}
	fi

}

l2tp_cfg_del()
{
	local listPath=$1
	local idx=`echo "${listPath}" | awk -F "." '{print $NF}'`
	local l2tp_cfg_bk=${L2TPRunDir}/${idx}/cfg.bk
	if [ ! -f "${l2tp_cfg_bk}" ]; then
		return
	fi

	local tunnel_name=`cat $l2tp_cfg_bk | grep tunnelname | awk -F "=" '{print $2}'`
	local pid=`cat $l2tp_cfg_bk | grep pid | awk -F "=" '{print $2}'`
	local wanpath=`cat $l2tp_cfg_bk | grep wanpath | awk -F "=" '{print $2}'`
	local kill=1
	local tunnelIdxes=`cfgcmd get_idxes "${L2TP_BASIC_PATH}.TunnelList"`
	
	for i in $tunnelIdxes
	do
		if [ "${i}" == "${idx}" ];then
			continue
		fi

		local tnlPath="${L2TP_BASIC_PATH}.TunnelList.${i}" 
		local l2tpWanPth=`cfgcmd get ${tnlPath}.WanInterface 2>/dev/null`
		if [ "${wanpath}" == "${l2tpWanPth}" -a -f "${L2TPRunDir}/${i}/cfg.bk" ];then
			kill=0
			break
		fi
	done
	
	# disconnect and remove tunnel
	local idxSameWan=`cat $l2tp_cfg_bk | grep tunnelidxSameWan | awk -F "=" '{print $2}' 2>/dev/null`
	local l2tp_ctrl=""
	if [ "${idxSameWan}" != "" ];then
		l2tp_ctrl=${L2TPRunDir}/${idxSameWan}/l2tp-control
	else
		l2tp_ctrl=${L2TPRunDir}/${idx}/l2tp-control
	fi	
	echo "d $tunnel_name" > $l2tp_ctrl
	l2tp_wait_ppp_down $idx
	echo "r $tunnel_name" > $l2tp_ctrl

	if [ "${idxSameWan}" != "" ];then
		rm -rf ${L2TPRunDir}/${idx}
	else
		rm -rf ${L2TPRunDir}/${idx}/cfg.bk
	fi

	if [ $kill -eq 1 ]; then
		kill $pid  2>/dev/null 
		if [ "${idxSameWan}" != "" ];then
			rm -rf ${L2TPRunDir}/${idxSameWan}
		else
			rm -rf ${L2TPRunDir}/${idx}
		fi
	fi

	if [ "${tunnelIdxes}" == "0" ]; then
		iptables -F ${L2TPTUNNEL_CHAIN}
	fi
}


l2tp_hotplug()
{
	local actionType=$1
	local wanPath=$2

	local tunnelIdxes=`cfgcmd get_idxes "${L2TP_BASIC_PATH}.TunnelList"`
	if [ "${tunnelIdxes}" == "0" ]; then
		return
	fi
	
	for i in $tunnelIdxes
	do
		local l2tpWan=`cfgcmd get "${L2TP_BASIC_PATH}.TunnelList.${i}.WanInterface"`
		local l2tpEnable=`cfgcmd get "${L2TP_BASIC_PATH}.TunnelList.${i}.TunnelEnable"`
		if [ "${l2tpWan}" == "${wanPath}" -a "${l2tpEnable}" == "1" ]; then
			if [ "${actionType}" == "up" ]; then
				l2tp_cfg_add "${L2TP_BASIC_PATH}.TunnelList.${i}"
			elif [  "${actionType}" == "down" ]; then
				l2tp_cfg_del "${L2TP_BASIC_PATH}.TunnelList.${i}"
			fi
		fi
	done

}

case "${action}" in
	"set")
		l2tp_cfg_set ${tnllist}
		;;
	"add")
		l2tp_cfg_add ${tnllist}
		;;
	"del")
		l2tp_cfg_del ${tnllist}
		;;
	"ifup")
		l2tp_hotplug "up" "${wanpath}"
		;;
	"ifdown")
		l2tp_hotplug "down" "${wanpath}"
		;;
	*)
		;;
esac
rm -f ${l2tp_lock_flag}
