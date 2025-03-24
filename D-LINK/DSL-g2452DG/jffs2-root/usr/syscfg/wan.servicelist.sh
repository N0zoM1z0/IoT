#!/bin/sh
. /usr/syscfg/dsl.utils.sh
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/wan.comm.param.sh
. /usr/syscfg/mac.sh
. /usr/syscfg/policy_route.sh
. /usr/syscfg/ebtables.param.sh
. /usr/syscfg/api_log.sh
. /usr/syscfg/firewall.param.sh
. /usr/syscfg/api_log.sh
#. /usr/syscfg/tr069.sh

servicelist_help()
{
        echo "---------------------------------------------------------------------------------"
        echo "Usage: `basename $0` action=<start|stop|restart> path=<string> ipmode=<ipv4|ipv6>"
        echo "---------------------------------------------------------------------------------"
}

action=""
path=""
ipmode="" #ipv4 or ipv6
ip6mode=""  #DHCPv6 or AutoConfigured or Static for ipv6 wan mode

for para in $*
do
        export $para
done

conn_folder=$(dirname $0)
if [ -z ${path} ]; then
        path_file="${conn_folder}/path"
        if [ -f ${path_file} ]; then
                path=`cat ${path_file}`
        fi
fi

if [ -z ${path} ]; then
        servicelist_help
        exit 0
fi

WANCONN_TYPE=`echo ${path} | cut -d '.' -f 6` #WANIPConnection or WANPPPConnection
script_ip_down_path=`expr ${conn_folder}"/script/ip_down"`
conf_info_path=`expr ${conn_folder}"/conf_info"`
user_defined_dns_path=`expr ${conn_folder}/${USER_DEFINED_DNS}`
server_assigned_dns_path=`expr ${conn_folder}/${SERVER_ASSIGNED_DNS}`
ip_address_path=`expr ${conn_folder}/${IP_ADDRESS}`
server_assigned_tftp_addr_path=`expr ${conn_folder}/${SERVER_ASSIGNED_TFTP_ADDR}`

if [ "${WANCONN_TYPE}" == "WANIPConnection" ]; then
	wan_ifname_file_path=`expr ${conn_folder}/${IFNAME_FILE}`
	gateway_file_path=`expr ${conn_folder}/${GATEWAY_FILE}`
elif [ "${WANCONN_TYPE}" == "WANPPPConnection" ]; then
	wan_ifname_file_path=`expr ${conn_folder}/${PPP_IFNAME}`
	gateway_file_path=`expr ${conn_folder}/${PPP_IPREMOTE}`
fi

if [ -f ${wan_ifname_file_path} ]; then
	wan_ifname=`cat ${wan_ifname_file_path}`
fi
if [ -f ${gateway_file_path} ]; then
	gateway=`cat ${gateway_file_path}`
fi
if [ -f ${ip_address_path} ]; then
	ip_address=`cat ${ip_address_path}`
fi

ip6_user_defined_dns_path=`expr ${conn_folder}/${IP6_USER_DEFINED_DNS}`
ip6_server_assigned_dns_path=`expr ${conn_folder}/${IP6_SERVER_ASSIGNED_DNS}`
ip6_gateway_file_path=`expr ${conn_folder}/${IP6_GATEWAY_FILE}`
ip6_pd_address_file_path=`expr ${conn_folder}/${IP6_PD_ADDR_FILE}`
ip_address_path6=`expr ${conn_folder}/${IP6_ADDR}`
ppp6_llremote_path=`expr ${conn_folder}/${PPP6_LLREMOTE}`
if [ -f ${ip6_gateway_file_path} ]; then
	gateway6=`cat ${ip6_gateway_file_path}`
	if [ -z "${gateway6}" -a -f ${ppp6_llremote_path} ]; then
		gateway6=`cat ${ppp6_llremote_path}`
	fi
fi
if [ -f ${ip_address_path6} ]; then
	ip_address6=`cat ${ip_address_path6}`
fi
ip6_lan_cfg_path="InternetGatewayDevice.LANDevice.1.X_CT-COM_IPv6Config"
local IP6C_AddressingType=`cfgcmd get ${path}X_CT-COM_IPv6IPAddressOrigin`
local scl_only_tr69=`cfgcmd get InternetGatewayDevice.Services.ServiceAccessControl.OnlyTr69Wan`
local IP6C_DNSAddressSource=`cfgcmd get ${path}X_CT-COM_IPv6DNSAddressSource`
local do_ip6_wan=0
if [ "${IP6C_AddressingType}" == "${ip6mode}" -a -n "$ip_address6" ]; then
	do_ip6_wan=1
elif [ "${IP6C_AddressingType}" == "None" -a "${ip6mode}" == "DHCPv6" ]; then
    do_ip6_wan=1
fi
#################################################### ipv4 ########################################################

ipv4_lan_grouping_stop()
{
	if [ -f "${script_ip_down_path}/${laninterface_policy_routing_ipv4_script}" ]; then
		${script_ip_down_path}/${laninterface_policy_routing_ipv4_script}
		rm -f ${script_ip_down_path}/${laninterface_policy_routing_ipv4_script}
	fi
}

ipv4_lan_grouping()
{
	if [ "${C_ServiceList}" == "TR069" ]; then
		return;
	fi

	if [ -n "${gateway}" ] ; then		
		/usr/syscfg/wan.portbinding.sh "$path" "ipv4"
	else
		echo "[$0] gateway is empty!"
	fi
}

gen_stop_script_ipv4_forwarding()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "wan_ifname=${wan_ifname}" >> ${script}
	echo '
	echo 0 > /proc/sys/net/ipv4/conf/${wan_ifname}/forwarding
' >> ${script}
	chmod +x ${script}
}

ipv4_forwarding_stop()
{
	if [ -x "${script_ip_down_path}/${ipv4_forwarding_script}" ]; then
		${script_ip_down_path}/${ipv4_forwarding_script}
		rm -f ${script_ip_down_path}/${ipv4_forwarding_script}
	fi
}

ipv4_forwarding()
{
	gen_stop_script_ipv4_forwarding "${script_ip_down_path}/${ipv4_forwarding_script}"
	#enable ipv4 forwarding only for INTERNET
	echo 1 > /proc/sys/net/ipv4/conf/${wan_ifname}/forwarding
}

gen_stop_script_ipv4_nat()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "conntrack -F conntrack" >> ${script}
	echo "iptables -t nat -D POSTROUTING -o ${wan_ifname} -j MASQUERADE" >> ${script}
	chmod +x ${script}
}

ipv4_nat_stop()
{
	if [ -x "${script_ip_down_path}/${ipv4_nat_script}" ]; then
		${script_ip_down_path}/${ipv4_nat_script}
		rm -f ${script_ip_down_path}/${ipv4_nat_script}
	fi
	
	if [ -x "${script_ip_down_path}/${ipv4_route_flow_accel_script}" ]; then
		${script_ip_down_path}/${ipv4_route_flow_accel_script}
		rm -f ${script_ip_down_path}/${ipv4_route_flow_accel_script}
	fi

}

ipv4_route_set_flow_accel()
{
	local wan_folder=`gen_wanconn_folder ${path}`
	if [ "${wan_folder:0:2}" == "IP" ]; then
		return
	fi

	# work around ipv4 nat start again, without stop
	if [ -x "${script_ip_down_path}/${ipv4_route_flow_accel_script}" ]; then
		${script_ip_down_path}/${ipv4_route_flow_accel_script}
		rm -f ${script_ip_down_path}/${ipv4_route_flow_accel_script}
	fi

	local wan_ifname=${IFNAME}
	local hostCfgMgmt_path="InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1"
	local br0_ip="$(cfgcmd get ${hostCfgMgmt_path}.IPInterfaceIPAddress)"
	local br0_nm="$(cfgcmd get ${hostCfgMgmt_path}.IPInterfaceSubnetMask)"
	local br0_lannet=$(get_net_from_ip $br0_ip $br0_nm)

	conntrack -F conntrack
	iptables -A ${FLOW_ACCEL_CHAIN} -i ${wan_ifname} --dst ${br0_lannet}/${br0_nm} -j MARK --set-mark 0x70000000/0xf0000000
	iptables -A ${FLOW_ACCEL_CHAIN} -o ${wan_ifname} --src ${br0_lannet}/${br0_nm} -j MARK --set-mark 0x70000000/0xf0000000

	local script="${script_ip_down_path}/${ipv4_route_flow_accel_script}"
	echo "#!/bin/sh" > ${script}
	echo "conntrack -F conntrack" >> ${script}
	echo "iptables -D ${FLOW_ACCEL_CHAIN} -i ${wan_ifname} --dst ${br0_lannet}/${br0_nm} -j MARK --set-mark 0x70000000/0xf0000000"  >> ${script}
	echo "iptables -D ${FLOW_ACCEL_CHAIN} -o ${wan_ifname} --src ${br0_lannet}/${br0_nm} -j MARK --set-mark 0x70000000/0xf0000000"  >> ${script}
	chmod +x ${script}
}

ipv4_nat()
{
	local NATEnabled="0"
	if [ -f ${conf_info_path} ]; then
		source ${conf_info_path}
	fi
	if [ "${NATEnabled}" == "1" ]; then
		gen_stop_script_ipv4_nat "${script_ip_down_path}/${ipv4_nat_script}"
		conntrack -F conntrack
		iptables -t nat -A POSTROUTING -o ${wan_ifname} -j MASQUERADE
	else
		ipv4_route_set_flow_accel	
	fi
}

gen_stop_script_ipv4_default_route()
{
	local script=$1
	local dr_en=`cfgcmd get InternetGatewayDevice.X_TRI_DefautlRoute.Enabled`
	echo "#!/bin/sh" > ${script}
	if [ "$dr_en" != "1" ]; then
		echo "route del default gw ${gateway} dev ${wan_ifname} metric 1" >>${script}
	else
		echo "rm -f /tmp/.tri_defaultroute/${wan_ifname}" >>${script}
		echo "sh /usr/syscfg/wan.defaultroute.sh" >>${script}
	fi
	chmod +x ${script}
}

ipv4_default_route_stop()
{
	if [ -x "${script_ip_down_path}/${ipv4_default_route_script}" ]; then
		${script_ip_down_path}/${ipv4_default_route_script}
		rm -rf ${script_ip_down_path}/${ipv4_default_route_script}
	fi
}

ipv4_default_route()
{
	local dr_en=`cfgcmd get InternetGatewayDevice.X_TRI_DefautlRoute.Enabled`
	if [ -n "${gateway}" ]; then
			gen_stop_script_ipv4_default_route "${script_ip_down_path}/${ipv4_default_route_script}"
		if [ "$dr_en" != "1" ]; then
			route add default gw ${gateway} dev ${wan_ifname} metric 1
		else
			echo "route add default gw ${gateway} dev ${wan_ifname} metric 1" > /tmp/.tri_defaultroute/${wan_ifname}
			sh /usr/syscfg/wan.defaultroute.sh
		fi
	fi
}

gen_stop_script_ipv4_dns()
{
	local script=$1
	local addr_type="$(cfgcmd get ${path}AddressingType)"	
	local dns_override="$(cfgcmd get ${path}DNSOverrideAllowed)"	
	local use_serverdns=0;
	if [ "${addr_type}" != "Static" ]; then
	if [ "${dns_override}" != "1" ]; then
		 use_serverdns=1
	fi
	fi

	
	echo "#!/bin/sh" > ${script}
	echo '. /usr/syscfg/wan.comm.param.sh' >> ${script}
	echo '. /usr/syscfg/wan.utils.sh' >> ${script}
	echo "user_defined_dns_path=${user_defined_dns_path}" >> ${script}
	echo "server_assigned_dns_path=${server_assigned_dns_path}" >> ${script}
	#check dns server
	if [ "${use_serverdns}" == "1" ]; then
		echo 'del_dns ${server_assigned_dns_path}'>> ${script}
	else
		echo 'del_dns ${user_defined_dns_path}'>> ${script}  
	fi
	chmod +x ${script}
}

ipv4_dns_stop()
{
	if [ -x "${script_ip_down_path}/${ipv4_dns_script}" ]; then
		${script_ip_down_path}/${ipv4_dns_script}
		rm -f ${script_ip_down_path}/${ipv4_dns_script}
	fi
}

ipv4_dns()
{
	local addr_type="$(cfgcmd get ${path}AddressingType)"	
	local dns_override="$(cfgcmd get ${path}DNSOverrideAllowed)"	
	local use_serverdns=0;
	if [ "${addr_type}" != "Static" ]; then
	if [ "${dns_override}" != "1" ]; then
		 use_serverdns=1
	fi
	fi
	gen_stop_script_ipv4_dns "${script_ip_down_path}/${ipv4_dns_script}"
	#check dns server
	if [ "${use_serverdns}" == "1" ]; then
		add_dns ${server_assigned_dns_path}
	else
		add_dns ${user_defined_dns_path}
	fi

}

gen_stop_script_ipv4_if_hotplug()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo '. /usr/syscfg/wan.comm.param.sh' >> ${script}
	echo "path=${path}" >> ${script}
	echo "wan_ifname=${wan_ifname}" >> ${script}
	echo "ip_address=${ip_address}" >> ${script}
	echo "ipmode=ipv4" >> ${script}
	echo '
for i in ${IF_HOTPLUG_DIR}/*.sh
do
	if [ -x "${i}" ]; then
		${i} action="ifdown" wan_ifname=${wan_ifname} ipmode="ipv4" ip_address=${ip_address} path=${path}
	fi
done
' >> ${script}
	chmod +x ${script}
}

gen_stop_script_ipv4_if_hotplug_only_sroute()
{
    local script=$1
    echo "#!/bin/sh" > ${script}
    echo '. /usr/syscfg/wan.comm.param.sh' >> ${script}
    echo "path=${path}" >> ${script}
    echo "wan_ifname=${wan_ifname}" >> ${script}
    echo "ip_address=${ip_address}" >> ${script}
    echo "ipmode=ipv4" >> ${script}
    echo "" >> ${script}
    echo '${IF_HOTPLUG_DIR}/400.srouting.sh action="ifdown" wan_ifname=${wan_ifname} ipmode="ipv4" ip_address=${ip_address} path=${path}' >> ${script}
    chmod +x ${script}
}

servicelist_check_hybrid_Internet()
{
	local path=$1
	local serviceList=`cfgcmd get ${path}X_CT-COM_ServiceList`
	local ret=`echo ${serviceList} | grep INTERNET`
	echo $ret
}

ipv4_if_hotplug_stop()
{
	if [ -x "${script_ip_down_path}/${ipv4_if_hotplug_script}" ]; then
		${script_ip_down_path}/${ipv4_if_hotplug_script}
		rm -f ${script_ip_down_path}/${ipv4_if_hotplug_script}
	fi
}

ipv4_if_hotplug()
{
	gen_stop_script_ipv4_if_hotplug "${script_ip_down_path}/${ipv4_if_hotplug_script}"
	for i in ${IF_HOTPLUG_DIR}/*.sh
	do
		if [ -x "${i}" ]; then
			${i} action="ifup" wan_ifname=${wan_ifname} ipmode="ipv4" ip_address=${ip_address} path=${path}
		fi
	done
}

internet_ipv4_stop()
{
	ipv4_dns_stop
	ipv4_forwarding_stop
	ipv4_if_hotplug_stop
	ipv4_default_route_stop
	ipv4_nat_stop
	ipv4_lan_grouping_stop

}

change_radius_own_ip_value()
{
	file1="/var/RT2860AP/RT2860_11N_AP.dat"
	file2="/var/RT2860AP/RT2860_11AC_AP.dat"

    local name="own_ip_addr"
	local value="$1"
	
	if [ -f $file1 ]; then
	local found=`sed -n "/\<"$name"=/p" $file1 | awk -F '=' '{print $1}'`

	if [ -z $found ]; then
	    return
	else
		sed -i "s/\(\<$name=\).*/\1$value/g" $file1
	fi
	fi

    if [ -f $file2 ]; then
	local found=`sed -n "/\<"$name"=/p" $file2 | awk -F '=' '{print $1}'`
	if [ -z $found ]; then
        return
	else
		sed -i "s/\(\<$name=\).*/\1$value/g" $file2
	fi
	fi

	local flag=$(ps | grep rtdot1xd | grep -v grep | wc -l)
	local wl11n=0
	local wl11ac=0
	
	if  [ "${flag}" == "2" ]; then
	    killall rtdot1xd
	    sleep 1
        if [ -f $file1 ]; then
	    /usr/sbin/rtdot1xd -i 11n &
	    fi
	    if [ -f $file2 ]; then
	    /usr/sbin/rtdot1xd -i 11ac &
	    fi
	    
	elif  [ "${flag}" == "1" ]; then

	    wl11n=$(find /tmp/ -name wl80211n_pid | grep 11n | wc -l)	
	    wl11ac=$(find /tmp/ -name wl80211ac_pid | grep 11ac | wc -l) 	
	    
	    killall rtdot1xd
	    sleep 1

	    if [ "${wl11n}" == "1" ]; then
	        if [ -f $file1 ]; then
	        /usr/sbin/rtdot1xd -i 11n &
	        fi
	    elif [ "${wl11ac}" == "1" ]; then
	        if [ -f $file2 ]; then
	        /usr/sbin/rtdot1xd -i 11ac &
	        fi
	    fi	
	fi
}



internet_ipv4()
{
	ipv4_lan_grouping
	ipv4_nat
	ipv4_default_route
	ipv4_forwarding
	#flash hardware and software conntrack entries
	flush_hs_conntrack_entries
	ipv4_dns
	ipv4_if_hotplug
	echo ${ip_address} >> /tmp/internet_ipv4_address
	change_radius_own_ip_value ${ip_address}
}

gen_stop_script_tr069_ipv4()
{
	local script=$2
	echo "#!/bin/sh" > ${script}
	clear_tr069_route $1 ${script}
	if [ "${scl_only_tr69}" == "1" ];then
		echo "iptables -t nat -D ${SERVICES_CHAIN} -i ${wan_ifname} -j ${SERVICES_LOCAL_CHAIN}" >> ${script}
		echo "iptables -t filter -D ${SCL_FILTER_ACCESS_CHAIN} -i ${wan_ifname} -j ${SCL_ACCESS_CHAIN}" >> ${script}
	fi
	echo "/usr/syscfg/tr069.sh stop" >> ${script}

	chmod +x ${script}
}

tr069_ipv4_stop()
{
	if [ -x "${script_ip_down_path}/${ipv4_tr069_script}" ]; then
		${script_ip_down_path}/${ipv4_tr069_script}
		rm -f ${script_ip_down_path}/${ipv4_tr069_script}
	fi
	${IF_HOTPLUG_DIR}/500.qos.class.sh action="ifdown" wan_ifname=${wan_ifname} ipmode="ipv4" ip_address=${ip_address} path=${path} conn_code="IP_I_I_TR069"
}

tr069_ipv4()
{
  local IPC_ConnectionType="$(cfgcmd get ${path}ConnectionType)"

  gw=${gateway} 
  mask=`ifconfig | grep ${ip_address} | cut -d ":" -f 4`
  if [ "$gw" == "" ];then
    gw=`cfgcmd get ${path}DefaultGateway`
  fi
  if [ "${scl_only_tr69}" == "1" ];then
    iptables -t nat -D ${SERVICES_CHAIN} -i ${wan_ifname} -j ${SERVICES_LOCAL_CHAIN}
    iptables -t filter -D ${SCL_FILTER_ACCESS_CHAIN} -i ${wan_ifname} -j ${SCL_ACCESS_CHAIN}
    iptables -t nat -I ${SERVICES_CHAIN} -i ${wan_ifname} -j ${SERVICES_LOCAL_CHAIN}
    iptables -t filter -I ${SCL_FILTER_ACCESS_CHAIN} -i ${wan_ifname} -j ${SCL_ACCESS_CHAIN}
  fi

  gen_stop_script_tr069_ipv4 "${ip_address}" "${script_ip_down_path}/${ipv4_tr069_script}"

  # Con_Bridged 模式下以brvlan*为出口
  if [ "$IPC_ConnectionType" == "Con_Bridged" ]; then
    local brIf=`cat ${conn_folder}/ConBrOutIf`
    mask=`cat ${conn_folder}/ip_mask`
    setup_tr069_route "${ip_address}" "${gw}" "$brIf" "${mask}"
  else
    setup_tr069_route "${ip_address}" "${gw}" "${wan_ifname}" "${mask}"
  fi
  
  /usr/syscfg/tr069.sh quick_start  ${path}   
  /usr/syscfg/dhcpc_opt66.sh action="if_up"  wan_ifname="${wan_ifname}" path="${path}"&
  ${IF_HOTPLUG_DIR}/500.qos.class.sh action="ifup" wan_ifname=${wan_ifname} ipmode="ipv4" ip_address=${ip_address} path=${path} conn_code="IP_I_I_TR069"

    #静态路由处理
    local ret=`servicelist_check_hybrid_Internet ${path}`
    if [ "${ret}" == "" ];then
        gen_stop_script_ipv4_if_hotplug_only_sroute "${script_ip_down_path}/${ipv4_if_hotplug_script}"
    fi
    ${IF_HOTPLUG_DIR}/400.srouting.sh  action="ifup" wan_ifname=${wan_ifname} ipmode="ipv4" ip_address=${ip_address} path=${path}
}

gen_stop_script_voip_ipv4()
{
	local script=$2
	
	echo "#!/bin/sh" > ${script}
	clear_voip_route $1 ${script}
	echo "/usr/sbin/voipcmd stop" >> ${script}
	chmod +x ${script}
}

voip_ipv4_stop()
{
	if [ -x "${script_ip_down_path}/voip.sh" ]; then
		${script_ip_down_path}/voip.sh
		rm -f ${script_ip_down_path}/voip.sh
	fi
	
	${IF_HOTPLUG_DIR}/500.qos.class.sh action="ifdown" wan_ifname=${wan_ifname} ipmode="ipv4" ip_address=${ip_address} path=${path} conn_code="IP_I_I_VOIP"

	iptables -D OUTPUT -s ${ip_address} -p icmp --icmp-type destination-unreachable -j DROP
    #iptables -D service_list -d ${ip_address} -p udp --dport 5060 -j ACCEPT
}

gen_voip_dns()
{
	if [ -f "${server_assigned_dns_path}" ];then
		sed 's/^/nameserver &/g' ${server_assigned_dns_path} > $VOIP_RESOLV
	else

		dns=`cfgcmd get ${path}DNSServers`

		if [ "$dns" != "" ];then

			dns1=`echo $dns | cut -d "," -f 1`
			dns2=`echo $dns | cut -d "," -f 2`

			if [ "$dns1" == "" ];then
				return
			fi

			echo "nameserver $dns1" > $VOIP_RESOLV

			if [ "$dns2" == "" -o "$dns1" == "$dns2" ];then
				return
			fi

			echo "nameserver $dns2" >> $VOIP_RESOLV
		fi
	fi
}

gen_stop_void_dns()
{
	rm -f $VOIP_RESOLV
}

prepare_dm()
{

	default_dp="[2-8]xxxxxxx|1[3458]xxxxxxxxx|01[3458]xxxxxxxxx|0xxxxxxxxxx|0311xxxxxxxx|037[179]xxxxxxxx|04[135]1xxxxxxxx|0432xxxxxxxx|051[0-9]xxxxxxxx|052[37]xxxxxxxx|053[12]xxxxxxxx|057[13-79]xxxxxxxx|059[15]xxxxxxxx|0731xxxxxxxx|075[457]xxxxxxxx|076[09]xxxxxxxx|0898xxxxxxxx|9xxxx|1[0124-9]x|118xxx|100xx|20x|400xxxxxxx|800xxxxxxx|955xx|58426x.|58427|1630[06]|99699[8*#]|[*#][*#0-9][0-9*].#|##|**xx|x[0-9*].#|x[0-9*].T"
	
	dp=`cfgcmd get InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.DigitMap`
	if [ "$dp" == "" ];then
		dp=`nvram get InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.DigitMap`

		sleep 1
		if [ "$dp" != "" ];then
    		cfgcmd sset InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.DigitMap "$dp"
		else
    		cfgcmd sset InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.DigitMap "\"$default_dp\""
		fi
	fi
}

start_dect()
{
	dect_en=`cfgcmd get InternetGatewayDevice.Services.VoiceService.X_TRI_Is_Voip.X_TRI_has_dect`
	dect_active=`cfgcmd get InternetGatewayDevice.Services.VoiceService.1.X_TRI_Dect.DectEnable`

	if [ "$dect_en" == "1" -a "$dect_active" == "1" ]; then
		local flag=$(ps | grep DectHost | grep -v grep | wc -l)

		if [ "${flag}" != "0" ];then
			killall -9 DectHost
			sleep 1
		fi

		/usr/sbin/DectHost &
		sleep 5
	fi
}

voip_ipv4()
{
  local IPC_ConnectionType="$(cfgcmd get ${path}ConnectionType)"

  gw=${gateway} 
  mask=`ifconfig | grep ${ip_address} | cut -d ":" -f 4`

  gen_stop_script_voip_ipv4 ${ip_address} "${script_ip_down_path}/voip.sh"
  gen_voip_dns

  if [ "$gw" == "" ];then
    gw=`cfgcmd get ${path}DefaultGateway`
  fi
  
  # Con_Bridged 模式下以brvlan*为出口
  if [ "$IPC_ConnectionType" == "Con_Bridged" ]; then
    local brIf=`cat ${conn_folder}/ConBrOutIf`
    mask=`cat ${conn_folder}/ip_mask`
    setup_voip_route "${ip_address}" "${gw}" "$brIf" "${mask}"
  else
    setup_voip_route "${ip_address}" "${gw}" "${wan_ifname}" "${mask}"
  fi
  
  ##prepare_dm
  
  /usr/sbin/voipcmd initdrv
  sleep 1
  start_dect

  local flag=$(ps | grep triphone | grep -v grep | wc -l)

  if [ "${flag}" != "0" ];then
    killall -9 triphone
    sleep 1
  fi

  /usr/sbin/triphone ${ip_address} &
    cfgcmd set InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.ProxyServerTransport UDP
  cfgcmd set InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.X_CT-COM_Standby-ProxyServerTransport UDP
  cfgcmd set InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.RegistrarServerTransport UDP
  cfgcmd set InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.X_CT-COM_Standby-RegistrarServerTransport UDP
  
  ${IF_HOTPLUG_DIR}/500.qos.class.sh action="ifup" wan_ifname=${wan_ifname} ipmode="ipv4" ip_address=${ip_address} path=${path} conn_code="IP_I_I_VOIP"

    # 静态路由处理
    local ret=`servicelist_check_hybrid_Internet ${path}`
    if [ "${ret}" == "" ];then
        gen_stop_script_ipv4_if_hotplug_only_sroute "${script_ip_down_path}/${ipv4_if_hotplug_script}"
    fi
    ${IF_HOTPLUG_DIR}/400.srouting.sh  action="ifup" wan_ifname=${wan_ifname} ipmode="ipv4" ip_address=${ip_address} path=${path}
    
    iptables -I OUTPUT -s ${ip_address} -p icmp --icmp-type destination-unreachable -j DROP
    #iptables -A service_list -d ${ip_address} -p udp --dport 5060 -j ACCEPT
}

#################################################### ipv6 ########################################################
ipv6_lan_grouping_stop()
{
	if [ -f "${script_ip_down_path}/${laninterface_policy_routing_ipv6_script}" ]; then
		${script_ip_down_path}/${laninterface_policy_routing_ipv6_script}
		rm -f ${script_ip_down_path}/${laninterface_policy_routing_ipv6_script}
	fi
}

ipv6_lan_grouping()
{
	if [ "${C_ServiceList}" == "TR069" ]; then
		return;
	fi

	/usr/syscfg/wan.portbinding.sh "${path}" "ipv6"
}

gen_stop_script_ipv6_forwarding()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "wan_ifname=${wan_ifname}" >> ${script}
	echo '
	echo 0 > /proc/sys/net/ipv6/conf/${wan_ifname}/forwarding
' >> ${script}
	chmod +x ${script}
}

ipv6_forwarding_stop()
{
	if [ -x "${script_ip_down_path}/${ipv6_forwarding_script}" ]; then
		${script_ip_down_path}/${ipv6_forwarding_script}
		rm -f ${script_ip_down_path}/${ipv6_forwarding_script}
	fi
}

ipv6_forwarding()
{
	gen_stop_script_ipv6_forwarding "${script_ip_down_path}/${ipv6_forwarding_script}"
	#enable ipv6 forwarding only for INTERNET
	echo 1 > /proc/sys/net/ipv6/conf/${wan_ifname}/forwarding
}

gen_stop_script_ipv6_default_route()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "ip -6 r del default dev ${wan_ifname} via  ${gateway6}" >>${script}
	
	chmod +x ${script}
}

ipv6_default_route_stop()
{
	if [ -x "${script_ip_down_path}/${ipv6_default_route_script}" ]; then
		${script_ip_down_path}/${ipv6_default_route_script}
		rm -f ${script_ip_down_path}/${ipv6_default_route_script}
	fi
}

ipv6_default_route()
{
	if [ -n "${gateway6}" ]; then
		gen_stop_script_ipv6_default_route "${script_ip_down_path}/${ipv6_default_route_script}"
		ip -6 r add default dev ${wan_ifname} via ${gateway6} 
	fi
}

gen_stop_script_ipv6_dns()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo '. /usr/syscfg/wan.comm.param.sh' >> ${script}
	echo '. /usr/syscfg/wan.utils.sh' >> ${script}
	echo "ip6_user_defined_dns_path=${ip6_user_defined_dns_path}" >> ${script}
	echo "ip6_server_assigned_dns_path=${ip6_server_assigned_dns_path}" >> ${script}
	echo "ip6_lan_cfg_path=${ip6_lan_cfg_path}" >> ${script}
	
	if [ "${IP6C_DNSAddressSource}" == "Static" ]; then	
		echo 'del_dns ${ip6_user_defined_dns_path}' >> ${script}
	else
		echo 'del_dns ${ip6_server_assigned_dns_path}' >> ${script}
	fi

	echo '
local LANDNSType=`cfgcmd get ${ip6_lan_cfg_path}.IPv6DNSConfigType`
if [ ${LANDNSType} == "WANConnection" ]; then
	cfgcmd oset ${ip6_lan_cfg_path}.IPv6DNSWANConnection ""
fi
' >> ${script}
	chmod +x ${script}
}

ipv6_dns_stop()
{
	if [ -x "${script_ip_down_path}/${ipv6_dns_script}" ]; then
		${script_ip_down_path}/${ipv6_dns_script}
		rm -f ${script_ip_down_path}/${ipv6_dns_script}
	fi
}

ipv6_dns()
{
	ipv6_dns_stop
	local LANDNSType=`cfgcmd get ${ip6_lan_cfg_path}.IPv6DNSConfigType`

	gen_stop_script_ipv6_dns "${script_ip_down_path}/${ipv6_dns_script}"
	if [ "${IP6C_DNSAddressSource}" == "Static" ]; then	
		add_dns ${ip6_user_defined_dns_path}
	else
		add_dns ${ip6_server_assigned_dns_path}
	fi
	if [ ${LANDNSType} == "WANConnection" ]; then
		cfgcmd oset ${ip6_lan_cfg_path}.IPv6DNSWANConnection ${path}
	fi
}

gen_stop_script_ipv6_if_hotplug()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo '. /usr/syscfg/wan.comm.param.sh' >> ${script}
	echo "path=${path}" >> ${script}
	echo "wan_ifname=${wan_ifname}" >> ${script}
	echo "ip_address=${ip_address6}" >> ${script}
	echo "ipmode=ipv6" >> ${script}
	echo '
for i in ${IF_HOTPLUG_DIR6}/*.sh
do
	if [ -x "${i}" ]; then
		${i} action="ifdown" wan_ifname=${wan_ifname} ipmode="ipv6" path=${path}
	fi
done
' >> ${script}
	chmod +x ${script}
}

ipv6_if_hotplug_stop()
{
	if [ -x "${script_ip_down_path}/${ipv6_if_hotplug_script}" ]; then
		${script_ip_down_path}/${ipv6_if_hotplug_script}
		rm -f ${script_ip_down_path}/${ipv6_if_hotplug_script}
	fi
}

ipv6_if_hotplug()
{
	gen_stop_script_ipv6_if_hotplug "${script_ip_down_path}/${ipv6_if_hotplug_script}"
	for i in ${IF_HOTPLUG_DIR6}/*.sh
	do
		if [ -x "${i}" ]; then
			${i} action="ifup" wan_ifname=${wan_ifname} ipmode="ipv6" ip_address=${ip_address6} path=${path}
		fi
	done
}

gen_stop_script_ipv6_pd()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "local ip6_lan_cfg_path=${ip6_lan_cfg_path}" >> ${script}
	echo "local path=${path}" >> ${script}
	echo '
	cfgcmd set ${path}X_CT-COM_IPv6Prefix ""
	cfgcmd oset ${ip6_lan_cfg_path}.PrefixInformation.1.DelegatedWanConnection ""
' >>${script}
	chmod +x ${script}
}

ipv6_pd_stop()
{
	if [ -x "${script_ip_down_path}/${ipv6_pd_script}" ]; then
		${script_ip_down_path}/${ipv6_pd_script}
		rm -f ${script_ip_down_path}/${ipv6_pd_script}
	fi
}

ipv6_pd()
{
	ipv6_pd_stop
	if [ -e ${ip6_pd_address_file_path} ]; then
		local pd_addrs=`cat ${ip6_pd_address_file_path}`
		if [ -n ${pd_addrs} ]; then
			gen_stop_script_ipv6_pd "${script_ip_down_path}/${ipv6_pd_script}"
			cfgcmd set ${path}X_CT-COM_IPv6Prefix ${pd_addrs}
			local LanMode=`cfgcmd get ${ip6_lan_cfg_path}.PrefixInformation.1.Mode`
			if [ "${LanMode}" == "WANDelegated" ]; then	
				cfgcmd oset ${ip6_lan_cfg_path}.PrefixInformation.1.DelegatedWanConnection ${path}
			fi
		fi
	fi
}

stop_rsmonitor_send()
{
	if [ -x "${script_ip_down_path}/901_stop_rsmonitor.sh" ]; then
		${script_ip_down_path}/901_stop_rsmonitor.sh
		rm -f ${script_ip_down_path}/901_stop_rsmonitor.sh
	fi
}

internet_ipv6_stop()
{
	ipv6_pd_stop
if [ "$ra" == "1" ]; then
	return;
fi
	ipv6_dns_stop
	ipv6_forwarding_stop
	ipv6_if_hotplug_stop
	ipv6_default_route_stop
	ipv6_lan_grouping_stop
}

internet_ipv6()
{
	if [ ! -n "$ip_address6" ]; then
		return
	fi
	if [ "$do_ip6_wan" == "1" ]; then
		stop_rsmonitor_send
		ipv6_lan_grouping
		#ipv6_vlan_bind
		ipv6_default_route
		ipv6_forwarding
	fi
	ipv6_dns
	ipv6_pd
	
	if [ "$do_ip6_wan" == "1" ]; then
		ipv6_if_hotplug
	else
		${IF_HOTPLUG_DIR6}/402.aftr.sh action="ifup" wan_ifname=${wan_ifname} ipmode="ipv6" ip_address=${ip_address6} path=${path}
	fi

}


gen_stop_script_tr069_ipv6()
{
	local script=$1
	if [ "${scl_only_tr69}" == "1" ];then
		echo "#!/bin/sh" > ${script}
		echo "ip6tables -t filter -D ${SCL_FILTER_ACCEPT_CHAIN_V6} -i ${wan_ifname} -j ${SCL_ACCEPT_CHAIN_V6}" >> ${script}
		chmod +x ${script}
	fi
}

tr069_ipv6_stop()
{
	if [ -x "${script_ip_down_path}/${ipv6_tr069_script}" ]; then
		${script_ip_down_path}/${ipv6_tr069_script}
		rm -f ${script_ip_down_path}/${ipv6_tr069_script}
	fi
}

tr069_ipv6()
{
	if [ ! -n "$ip_address6" ]; then
		return
	fi
	gen_stop_script_tr069_ipv6 "${script_ip_down_path}/${ipv6_tr069_script}"
	if [ "${scl_only_tr69}" == "1" ];then
		ip6tables -t filter -D ${SCL_FILTER_ACCEPT_CHAIN_V6} -i ${wan_ifname} -j ${SCL_ACCEPT_CHAIN_V6}
		ip6tables -t filter -I ${SCL_FILTER_ACCEPT_CHAIN_V6} -i ${wan_ifname} -j ${SCL_ACCEPT_CHAIN_V6}
	fi
}

gen_stop_script_voip_ipv6()
{
	return
}

voip_ipv6_stop()
{
	return
}

voip_ipv6()
{
	if [ ! -n "$ip_address6" ]; then
		return
	fi
	gen_stop_script_voip_ipv6
	return
}

###################################################### iptv ##############################################################
gen_stop_script_iptv()
{
	local script=$1
	local iptv_ifname=$2

	echo "#!/bin/sh" > ${script}
	echo "cs_cli /home/cli/api/mc/del_member -v grpid 0 ifname ${iptv_ifname} upflag 1" >> ${script}
        echo "cs_cli /home/cli/debug/app/mc/clear_grpusr_info -v ifname ${iptv_ifname}" >> ${script}
	echo "xtm_cli intf --delete ${iptv_ifname}" >> ${script}
	chmod +x ${script}
}

iptv_stop()
{
	if [ -x "${script_ip_down_path}/${iptv_script}" ]; then
		${script_ip_down_path}/${iptv_script}
		rm -f ${script_ip_down_path}/${iptv_script}
	fi
}

iptv()
{
	local MVlan="$(cfgcmd get ${path}X_CT-COM_MulticastVlan)"
	if [ "${MVlan}" -ge "1" -a "${MVlan}" -le "4095" ]; then
		wanconn_instance=`echo ${path} | cut -d '.' -f 5`
		wanconn_inst_path="$(get_wanconn_inst_path $path)"
			
		#create interface for iptv
		local dsl_ifname=`get_dsl_ifname ${path}`
		local iptv_ifname="${dsl_ifname}_tv${wanconn_instance}"
		local iptv_mac="$(get_base_mac)"
		if [ -z "${iptv_mac}" ]; then
			iptv_mac=${BASE_MAC}
		fi
		ifconfig ${iptv_ifname}
		ret=$?
		if [ "${ret}" == "0" ]; then
			#iptv_ifname have been created
			return
		fi
		gen_stop_script_other_iptv "${script_ip_down_path}/${iptv_script}" "${iptv_ifname}"
		xtm_cli intf --add connname ${dsl_ifname} intfname ${iptv_ifname} vlanid ${MVlan} vlanpri 0 dmac ${iptv_mac}
		ifconfig ${iptv_ifname} up
		local mac=`ifconfig ${iptv_ifname} | grep HWaddr | awk '{ print $5 }'`
		#add iptv_ifname to mc group
		cs_cli /home/cli/api/intf/setmcmac -v ifname ${iptv_ifname} mac ${mac}
		cs_cli /home/cli/api/mc/add_member -v grpid 0 ifname ${iptv_ifname} upflag 1
	fi
}
##################################################### 6RD ################################################################ 
c6RD_tunnel_close()
{
	local tunnelname="${wan_ifname}_6rd"
	local flag=$(ifconfig | grep "${tunnelname}" | wc -l)
	if [ ${flag} == "1" ]; then
		ipv6_pd_stop
		ip -4 tunnel del ${tunnelname}
		cs_cli /home/cli/api/intf/settnl -v ifname ${wan_ifname} type 0
	fi	
}

c6RD_tunnel_setting()
{
	local path=$1
	#local wan_ip="$(cfgcmd get ${path}ExternalIPAddress)"
	local wan_name=$2
	local enable="$(cfgcmd get ${path}X_TRI_6RD_Enable)"
	local act="$(cfgcmd get ${path}X_TRI_6RD_Act)"
	####local lan_index="$(cfgcmd get ${path}X_TRI_6RD_LAN)" 
	local mask_len="$(cfgcmd get ${path}X_TRI_6RD_IPv4Mask_LEN)"
	local prefix="$(cfgcmd get ${path}X_TRI_6RD_Prefix)"
	local prefix_len="$(cfgcmd get ${path}X_TRI_6RD_PrefixLen)"
	local borderIp="$(cfgcmd get ${path}X_TRI_6RD_BorderRelay)"
   
	local tunnelname="${wan_name}_6rd"



	local flag=$(ifconfig | grep ${tunnelname} | wc -l)
	if [ ${flag} == "1" ]; then
		ip -4 tunnel del ${tunnelname}
	fi

	#ip -4 route del 0.0.0.0/0
	if [ ${enable} == "0" ]; then
		return
	fi

	#if [ -z "${wan_ip}" ]; then
	#	sleep 2
		wan_ip=`cat ${conn_folder}/ip_address`
	#fi	
	
	#Auto
	if [ ${act} == "2" ]; then
		mask_len=`cat ${conn_folder}/IPv4MaskLen`
		prefix=`cat ${conn_folder}/6rdPrefix`
		prefix_len=`cat ${conn_folder}/6rdPrefixLen`
		borderIp=`cat ${conn_folder}/6rdBRIPv4Addresses`
	fi
    
 	
	if [ -z "${wan_ip}" ]; then
		return
	fi

	if [ -z "${mask_len}" ]; then
		return
	fi
	if [ -z "${prefix}" ]; then
		return
	fi
	if [ -z "${prefix_len}" ]; then
		return
	fi
	if [ -z "${borderIp}" ]; then
		return
	fi

    local ip_str="`echo ${wan_ip} | tr "." " "`" 
	local ip_hex=`printf "%02X%02X:%02X%02X" ${ip_str}`  
	####local lan_name="$(cfgcmd get InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.${lan_index}.Name)"

	#local c6rd_delegate_prefix_len=`expr ${prefix_len} + 32 - ${mask_len}`
	local lan_delegate_prefix_len=`expr ${prefix_len} + 32`
	#local c6rd_ipv6=`expr ${prefix}:${ip_hex}::1234/${c6rd_delegate_prefix_len}`
	local lan_pd=`expr ${prefix}:${ip_hex}::/${lan_delegate_prefix_len}`

	#ifconfig br0 ${lan_ipv6} up
	#echo 1 > /proc/sys/net/ipv4/ip_forward
	#echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
	ip -4 tunnel add ${tunnelname} mode sit local ${wan_ip} ttl 64
	ip -4 tunnel 6rd dev ${tunnelname} 6rd-prefix ${prefix}::/${prefix_len}
	ip link set ${tunnelname} up

    ip -4 route add 0.0.0.0/0 via ${borderIp} dev ${wan_name}
	ip -6 route add ${prefix}::/${prefix_len} dev ${tunnelname}
	ip -6 route add ::/0 via ::${borderIp} dev ${tunnelname}

    cs_cli /home/cli/api/intf/settnl -v ifname ${wan_name} type 2
	cs_cli /home/cli/debug/app/res/setcap -v srvname 6rd cap 3
	#cs_cli /home/cli/api/intf/setip -v ifname ${wan_name} ip ${wan_ip}
	cs_cli /home/cli/api/intf/setfwd -v ifname ${wan_name} fwd 3

	echo "${lan_pd}" > ${ip6_pd_address_file_path}
	
	ipv6_pd

}

##################################################### service list ########################################################
servicelist_start_internet()
{
	if [ "${ipmode}" == "ipv4" ]; then
		internet_ipv4
		c6RD_tunnel_setting ${path} ${wan_ifname} 
	elif [ "${ipmode}" == "ipv6" ]; then
		internet_ipv6
	fi
}

servicelist_start_tr069()
{
	C_ServiceList="$(cfgcmd get ${path}X_CT-COM_ServiceList)"
	C_LanInterface="$(cfgcmd get ${path}X_CT-COM_LanInterface)"
	IPC_ConnectionType="$(cfgcmd get ${path}ConnectionType)"
	if [ "${C_ServiceList}" == "TR069" -a -n "${C_LanInterface}" -a "$IPC_ConnectionType" != "Con_Bridged" ]; then
		cfgcmd sset ${path}X_CT-COM_LanInterface ""
	fi
	
	if [ "${ipmode}" == "ipv4" ]; then
		tr069_ipv4
	elif [ "${ipmode}" == "ipv6" ]; then
		tr069_ipv6
	fi
}

servicelist_start_voip()
{
	if [ "${ipmode}" == "ipv4" ]; then
		voip_ipv4
	elif [ "${ipmode}" == "ipv6" ]; then
		voip_ipv6
	fi
}

servicelist_start_other()
{
	if [ "${ipmode}" == "ipv4" ]; then
		ipv4_nat
		ipv4_forwarding
		gen_stop_script_ipv4_if_hotplug_only_sroute "${script_ip_down_path}/${ipv4_if_hotplug_script}"
		${IF_HOTPLUG_DIR}/400.srouting.sh  action="ifup" wan_ifname=${wan_ifname} ipmode="ipv4" ip_address=${ip_address} path=${path}
	elif [ "${ipmode}" == "ipv6" ]; then
		ipv6_forwarding
	fi
	iptv
}

servicelist_start()
{
	C_ServiceList="$(cfgcmd get ${path}X_CT-COM_ServiceList)"
	C_LanInterface="$(cfgcmd get ${path}X_CT-COM_LanInterface)"

    # wan状态更新
    if [ "${ipmode}" = "ipv4" ]; then
		cfgcmd sset ${path}ConnectionStatus "Connected"
	else
		cfgcmd sset ${path}X_CT-COM_IPv6ConnStatus "Connected"
	fi

	C_ServiceLists=`echo ${C_ServiceList} |  tr ',' ' '`
	for serviceItem in ${C_ServiceLists}
	do
		case "${serviceItem}" in
			"INTERNET")
				servicelist_start_internet
				/usr/syscfg/led.sh internet on 
				/usr/syscfg/led.sh internet_nok off
				
				/usr/syscfg/wan.backup.sh ${path} "up"
				;;
			"TR069")
				servicelist_start_tr069
				;;
			"VOIP")
				servicelist_start_voip
				;;
			"OTHER")
				servicelist_start_other
	            other_wan_mc_setting ${script_ip_down_path} ${path}
				;;
			*)
				#Unknow
				;;
		esac
	done
	
	local IPC_ConnectionType="$(cfgcmd get ${path}ConnectionType)"
	if [ "${IPC_ConnectionType}" == "IP_Routed" ]; then
		/usr/syscfg/vlan_tagging.sh "wan_path=${path}" "down_dir=${script_ip_down_path}"
	fi
}

servicelist_stop()
{
    local haveDefaultGW=0

	if [ "${ipmode}" == "ipv4" ]; then
		cfgcmd sset ${path}ConnectionStatus "Disconnected"
		internet_ipv4_stop
		c6RD_tunnel_close
		tr069_ipv4_stop
		voip_ipv4_stop
	elif [ "${ipmode}" == "ipv6" ]; then
		cfgcmd sset ${path}X_CT-COM_IPv6ConnStatus "Disconnected"
		internet_ipv6_stop
		tr069_ipv6_stop
		voip_ipv6_stop
	fi
	iptv_stop

    # 没有默认网关说明没有internet wan连接上线，此时将Internet灯点灭
    haveDefaultGW=`ExistedDefaultGateway`
    if [ $haveDefaultGW -eq 0 ]; then
	    /usr/syscfg/led.sh internet off
    fi

	/usr/syscfg/wan.backup.sh ${path} "down"
}

#############################################################################
TGP_Log ${TGP_LOG_WARNING} "path=${path}, action=${action}, wan_ifname=${wan_ifname}, ipmode=${ipmode}, ip6mode=${ip6mode}"

case "$action" in
	"start")
		servicelist_start
		;;
	"stop")
		servicelist_stop
		;;
	"restart")
		servicelist_stop
		servicelist_start
		;;
	*)
		servicelist_help
		;;
esac

