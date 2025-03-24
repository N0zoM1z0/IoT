#!/bin/sh
. /usr/syscfg/wan.comm.param.sh

##################################################################
ip6_address_path=`expr ${conn_folder}/${IP6_ADDR}`
ip6_gateway_file_path=`expr ${conn_folder}/${IP6_GATEWAY_FILE}`
ip6_pd_address_file_path=`expr ${conn_folder}/${IP6_PD_ADDR_FILE}`
ip6_user_defined_dns_path=`expr ${conn_folder}/${IP6_USER_DEFINED_DNS}`
ip6_server_assigned_dns_path=`expr ${conn_folder}/${IP6_SERVER_ASSIGNED_DNS}`
now_str=`date +%Y%m%d%H%M%S`
ip6_pid_file_path=`expr ${conn_folder}/${IP6_PIDFILE_DHCP}_${now_str}`
ip6_conf_file_path=`expr ${conn_folder}"/ip6_conf_info"`
ip6_uptime_file_path=`expr ${conn_folder}/${IP6_UPTIME}`
ip6_dhcp6c_conf_path=`expr ${conn_folder}`
ip6_dhcp6c_script_path=`expr ${conn_folder}/${IP6_DHCP6C_SCRIPT}`
ip6_rsmonitor_pid_path=`expr ${conn_folder}/pid_rsmonitor`
###################################################################


gen_down_script_routed_ipv6_static()
{
	local script=$1
	local ip6_addr=`cat ${ip6_address_path}`
	echo "#!/bin/sh" > ${script}
	echo "rm -f ${ip6_gateway_file_path}" >> ${script}
	echo "rm -f ${ip6_user_defined_dns_path}" >> ${script}
	echo "rm -f ${ip6_server_assigned_dns_path}" >> ${script}
	echo "rm -f ${ip6_uptime_file_path}" >> ${script}
	echo "rm -f ${ip6_address_path}" >> ${script}
	echo "ip -6 addr del ${ip6_addr} dev ${ifname6}" >> ${script} 
	echo "ip -6 r del ${ip6_addr} dev ${ifname6}" >> ${script}

	chmod +x ${script}
}

ipconnection_start_routed_ipv6_static()
{
	local IP6C_IPAddress=`cfgcmd get ${path}X_CT-COM_IPv6IPAddress`
	local IP6C_PrefixLen=`cfgcmd get ${path}X_CT-COM_IPv6AddressPrefixLen`
	local IP6C_DefaultIPv6Gateway=`cfgcmd get ${path}X_CT-COM_DefaultIPv6Gateway`
	local IP6C_DnsServers=`cfgcmd get ${path}X_CT-COM_IPv6DNSServers`
	
    echo 0 > /proc/sys/net/ipv6/conf/${ifname6}/autoconf
	ip -6 addr add ${IP6C_IPAddress}/${IP6C_PrefixLen} dev ${ifname6}
	ip -6 r add ${IP6C_IPAddress} dev ${ifname6}

	write_file "${ip6_address_path}" "${IP6C_IPAddress}/${IP6C_PrefixLen}"
	write_file "${ip6_gateway_file_path}" "${IP6C_DefaultIPv6Gateway}"

	gen_dns_file ${ip6_user_defined_dns_path} "${IP6C_DnsServers}"
	gen_uptime_file ${ip6_uptime_file_path}

	gen_down_script_routed_ipv6_static "${script_ip_down_path}/900_ipv6_static.sh"
	${wan_servicelist_path} action=start ipmode=ipv6 path=${path} ip6mode=Static
}

gen_down_script_routed_ipv6_auto()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "ip6_address_path=${ip6_address_path}" >> ${script}
	echo "ifname6=${ifname6}" >> ${script}
	echo '
cat ${ip6_address_path} | while read addr; do ip -6 addr del $addr dev $ifname6;done
	'>> ${script}
	echo "rm -f ${ip6_address_path}" >> ${script}
	echo "rm -f ${ifname6}" >> ${script}
	echo "rm -f ${ip6_uptime_file_path}" >> ${script}
	echo "rm -f ${ip6_user_defined_dns_path}" >> ${script}
	echo "rm -f ${ip6_server_assigned_dns_path}" >> ${script}
	echo "rm -f ${ip6_gateway_file_path}" >> ${script}

	chmod +x ${script}
}
local do_ipv6_auto=0
gen_up_script_routed_ipv6_auto()
{
	local script=$1
	local IP6C_DNSAddressSource=`cfgcmd get ${path}X_CT-COM_IPv6DNSAddressSource`
	local IP6C_AddressingType=`cfgcmd get ${path}X_CT-COM_IPv6IPAddressOrigin`
	if [ "${do_ipv6_auto}" == "1" ]; then
	  return
	fi
	do_ipv6_auto=1
	echo "#!/bin/sh" > ${script}
	echo ". /usr/syscfg/ipv6.utils.sh" >> ${script}
	echo ". /usr/syscfg/wan.utils.sh" >> ${script}
	echo "ip6_uptime_file_path=${ip6_uptime_file_path}" >> ${script}
	echo "wan_status_update_path=${wan_status_update_path}" >> ${script}
	echo "wan_servicelist_path=${wan_servicelist_path}" >> ${script}
	echo "ifname6=${ifname6}" >> ${script}
	echo "ip6_address_path=${ip6_address_path}" >> ${script}
	echo "path=${path}" >> ${script}
	echo "ip6_server_assigned_dns_path=${ip6_server_assigned_dns_path}" >> ${script}
	echo "ip6_gateway_file_path=${ip6_gateway_file_path}" >> ${script}
	echo "conn_folder=${conn_folder}" >> ${script}
	
	if [ "${IP6C_AddressingType}" == "AutoConfigured" ]; then
	echo '	
if [ ! -z $prefixlist ]; then
prefixlist=`echo ${prefixlist} | tr "," " "`
for prefix in ${prefixlist}
do
local hw=`ifconfig $ifname6 | grep HWaddr`
if [ -z "${hw}" ]; then
	local addr=`PPP64 $prefix $ifname6`
else
	local addr=`GenEui64 $prefix $ifname6`
fi
echo $addr >> ${ip6_address_path}
ip -6 addr add ${addr} dev $ifname6
done
fi

write_file "${ip6_gateway_file_path}" "${ip6gw}"
	'>> ${script}
	fi
#the value of dns slaac mode is changed from "None" to  "AutoConfigured" 
	if [ "${IP6C_DNSAddressSource}" == "AutoConfigured" -o "${IP6C_DNSAddressSource}" == "None" ]; then
	echo '
if [ ! -z $dnslist ]; then
	gen_dns_file ${ip6_server_assigned_dns_path} "${dnslist}" 
fi
	'>> ${script}
	fi

	if [ "${IP6C_AddressingType}" == "AutoConfigured" ]; then
	echo '
touch ${ip6_uptime_file_path}
${wan_servicelist_path} action=start ipmode=ipv6 path=${path} ip6mode=AutoConfigured
${wan_status_update_path} path=${path}
	'>> ${script}
	else
	#if address was dhcpv6 and dns mode was slaac
	echo '
${wan_servicelist_path} action=start ipmode=ipv6 path=${path} ip6mode=AutoConfigured
	'>> ${script}
	fi
	chmod +x ${script}
}

ipconnection_start_routed_ipv6_auto()
{	
	gen_down_script_routed_ipv6_auto "${script_ip_down_path}/900_ipv6_auto.sh"
	echo 1 > /proc/sys/net/ipv6/conf/${ifname6}/autoconf
	gen_up_script_routed_ipv6_auto "${conn_folder}/${IP6_AUTO_START_SCRIPT}"
}

gen_up_script_routed_ipv6_dhcp()
{
	local script=$1
	local IP6C_AddressingType=`cfgcmd get ${path}X_CT-COM_IPv6IPAddressOrigin`
	local IP6C_DNSAddressSource=`cfgcmd get ${path}X_CT-COM_IPv6DNSAddressSource`
	echo "#!/bin/sh" > ${script}
	echo "path=${path}" >> ${script}
	echo "ifname6=${ifname6}" >> ${script}
	echo "conn_folder=${conn_folder}" >> ${script}
	echo "ip6_uptime_file_path=${ip6_uptime_file_path}" >> ${script}
	echo "ip6_server_assigned_dns_path=${ip6_server_assigned_dns_path}" >> ${script}
	echo "wan_status_update_path=${wan_status_update_path}" >> ${script}
	echo "wan_servicelist_path=${wan_servicelist_path}" >> ${script}
	echo "ip6_address_path=${ip6_address_path}" >> ${script}
	echo "ip6_pd_address_file_path=${ip6_pd_address_file_path}" >> ${script}
	
	echo '
for i in ${new_ianas}
do
	if [ -n "${i}" ];then
		echo "${i}" > ${ip6_address_path}
	fi
	break
done
	' >> ${script}
	
#	echo "echo "$""new_iapds" > ${ip6_pd_address_file_path}" >> ${script}
#	echo "echo "$""new_aftr_name" > ${conn_folder}/aftr" >> ${script}
#	echo "echo "$""new_domain_name_servers" > ${ip6_user_defined_dns_path}" >> ${script}
	
	echo '
if [ -n "${new_iapds}" ]; then
	echo "${new_iapds}" > ${ip6_pd_address_file_path}
fi
if [ -n "${new_aftr_name}" ]; then
	echo "${new_aftr_name}" > ${conn_folder}/aftr
fi	
	' >> ${script}
	
	if [ "${IP6C_DNSAddressSource}" == "DHCPv6" ]; then
	echo '
if [ -n "${new_domain_name_servers}" ]; then
	echo "${new_domain_name_servers}" >  ${ip6_server_assigned_dns_path}
fi	' >> ${script}	
	fi
	
	if [ "${IP6C_AddressingType}" == "AutoConfigured" ]; then
		echo "${wan_servicelist_path} action=restart ipmode=ipv6 path=${path} ip6mode=DHCPv6 ra=1" >> ${script}
	elif [ "${IP6C_AddressingType}" == "DHCPv6" -o "${IP6C_AddressingType}" == "None" ]; then
		TGP_Log ${TGP_LOG_WARNING} "!!!! wan.servicelist.sh restart for None mode"
		if [ "${IP6C_AddressingType}" == "None" ]; then
		  wan_ipAddr=`ifconfig "${ifname6}" | grep "Scope:Link" | awk '{print $3}' | cut -d / -f 1`
		  echo $wan_ipAddr > ${ip6_address_path}
		fi
		echo 'touch ${ip6_uptime_file_path}' >> ${script}
		echo '
if [ "${state}" != "RENEW" ]; then
	${wan_servicelist_path} action=restart ipmode=ipv6 path=${path} ip6mode=DHCPv6 ra=0
fi		
		' >> ${script}
	fi
	echo "${wan_status_update_path} path=${path}"

	chmod +x ${script}
}

gen_down_script_routed_ipv6_dhcp()
{
	local script=$1
	local conf=`cat ${ip6_conf_file_path}`

	echo "#!/bin/sh" > ${script}
	echo "ip6_address_path=${ip6_address_path}" >> ${script}
	echo "rm -f ${conf}" >> ${script}
	echo "ip6_pid_file_path=${ip6_pid_file_path}" >> ${script}
	echo '
local pid=`cat $ip6_pid_file_path`
local check_num=0

if [ -n "${pid}" ]; then
	kill -9 ${pid}
	#check if the pid still exist
	while [ -f /proc/${pid}/stat -a "${check_num}" -lt "200" ]
	do
		check_num=`expr $check_num + 1`
		usleep 10000
	done
fi' >> ${script}
	echo "rm -f ${ip6_address_path}" >> ${script}
	echo "rm -f ${ip6_pid_file_path}" >> ${script}
	echo "rm -f ${ip6_conf_file_path}" >> ${script}
	echo "rm -f ${ip6_uptime_file_path}" >> ${script}
	echo "rm -f ${ip6_dhcp6c_script_path}" >> ${script}
	echo "rm -f ${ip6_user_defined_dns_path}" >> ${script}
	echo "rm -f ${ip6_server_assigned_dns_path}" >> ${script}
	echo "rm -f ${ip6_pd_address_file_path}" >> ${script}
	echo "rm -f ${ip6_gateway_file_path}" >> ${script}
		
	chmod +x ${script}
}
gen_dhcpv6_base_by_path()
{
	if [ $# -lt 1 ]; then
		echo -n ""
		return
	fi
	local path=$1
	local base=""
	local wan_type=`echo ${path} | awk -F '.' '{print $6}'`
	if [ "${wan_type}" == "WANIPConnection" ]; then
		base=`echo "${path}" | awk -F "." '{print "1012"$3$5$7"0"}'`
	else
		base=`echo "${path}" | awk -F "." '{print "1012"$3$5$7"1"}'`
	fi
	echo "${base}"
	
}
gen_dhcpv6_config()
{
	local wanconn_instance=`echo ${path} | cut -d '.' -f 5`
	#local base=10121478;
	local base=`gen_dhcpv6_base_by_path ${path}` 
	let "iaid=$base + ($wanconn_instance * 2)"
	let "paid=$iaid - 1"
	
	local script=$1$iaid;

	if [ -e ${script} ]; then
		rm -fr ${script}
	fi

	local IP6C_AddressingType=`cfgcmd get ${path}X_CT-COM_IPv6IPAddressOrigin`
	local IP6C_PrefixDelegation=`cfgcmd get ${path}X_CT-COM_IPv6PrefixDelegationEnabled`

	local IP6C_DNSAddressSource=`cfgcmd get ${path}X_CT-COM_IPv6DNSAddressSource`
	local IP6C_DsliteEnable=`cfgcmd get ${path}X_CT-COM_Dslite_Enable`
	local IP6C_AftrMode=`cfgcmd get ${path}X_CT-COM_AftrMode`
	echo "interface ${ifname6} {" >> ${script}
	if [ "${IP6C_AddressingType}" == "DHCPv6" ]; then
		echo "	send ia-na ${iaid};" >> ${script}
	fi
	if [ "${IP6C_PrefixDelegation}" == "1" ]; then
		echo "	send ia-pd ${paid};" >> ${script}
	fi
	echo "	script \"${ip6_dhcp6c_script_path}\";" >> ${script}
	if [ "${IP6C_DNSAddressSource}" == "DHCPv6" ]; then	
	  echo "	request domain-name-servers;" >> ${script}
	fi	
	echo "	request ntp-servers;" >> ${script}
	if [ "${IP6C_DsliteEnable}" == "1" -a "${IP6C_AftrMode}" == "0" ]; then
	  #enable dslite and get aftr name automatically,we need start dhcp6c to get aftr address
	  echo "	request aftr-name;" >> ${script}
	fi
	echo "};" >> ${script}

	if [ "${IP6C_AddressingType}" == "DHCPv6" ]; then
		echo "id-assoc na ${iaid} {" >> ${script}
		echo "};" >> ${script}
	fi

	if [ "${IP6C_PrefixDelegation}" == "1" ]; then
		echo "id-assoc pd ${paid} {" >> ${script}
		echo "};" >> ${script}
	fi
	
	write_file  ${ip6_conf_file_path} "${script}"
}

gen_start_script_routed_ipv6_dhcp()
{
	local script=$1
	local dhcp6_conf_path=`cat ${ip6_conf_file_path}`

	echo "#!/bin/sh" > ${script}
	echo ". /usr/syscfg/wan.utils.sh" >> ${script}
	echo "ip6_gateway_file_path=${ip6_gateway_file_path}" >> ${script}
	echo "script_ip_down_path=${script_ip_down_path}" >> ${script}
	echo '
${script_ip_down_path}/901_stop_rsmonitor.sh
write_file "${ip6_gateway_file_path}" "${ip6gw}"
	' >> ${script}
	echo "dhcp6c -c ${dhcp6_conf_path} -p ${ip6_pid_file_path} -f ${ifname6}&" >> ${script}

	chmod +x ${script}
}
local do_ipv6_dhcpv6=0
gen_ipconnection_start_routed_ipv6_dhcpv6()
{
	if [ "${do_ipv6_dhcpv6}" == "1" ]; then
	  return
	fi
	do_ipv6_dhcpv6=1
	gen_up_script_routed_ipv6_dhcp ${ip6_dhcp6c_script_path}
	
	gen_dhcpv6_config "${ip6_dhcp6c_conf_path}/dhcp6c_"
	
	gen_down_script_routed_ipv6_dhcp "${script_ip_down_path}/900_ipv6_dhcp.sh"

	gen_start_script_routed_ipv6_dhcp "${conn_folder}/${IP6_DHCP_START_SCRIPT}" 
}

ipconnection_start_routed_ipv6_dhcpv6()
{	
	gen_ipconnection_start_routed_ipv6_dhcpv6
}

ipconnection_start_routed_ipv6_disable()
{	
	#nothing to do
	return; 
}

ipv6_start_prefixdelegation_static()
{
	return;
}

ipv6_start_prefixdelegation_none()
{
	return;
}

gen_stop_route_solicit_send()
{
	local script=$1

	echo "#!/bin/sh" > ${script}
	echo "ip6_rsmonitor_pid_path=${ip6_rsmonitor_pid_path}" >> ${script}
	echo '
if [ ! -f ${ip6_rsmonitor_pid_path} ]; then
    echo rsmonitor has been killed
    exit 0
fi
local pid=`cat $ip6_rsmonitor_pid_path`
rm -fr $ip6_rsmonitor_pid_path
if [ -n "${pid}" ]; then
	kill ${pid}
fi' >> ${script}
	
	chmod +x ${script}
}

ipconnection_start_route_solicit_send()
{
    if  [ -f ${ip6_rsmonitor_pid_path} ]; then
        echo rsmonitor is running!
        return
    fi
    rsmonitor ${ifname6} ${ip6_rsmonitor_pid_path}&

    gen_stop_route_solicit_send "${script_ip_down_path}/901_stop_rsmonitor.sh"
}

ipconnection_start_routed_ipv6()
{
	local IP6C_AddressingType=`cfgcmd get ${path}X_CT-COM_IPv6IPAddressOrigin`
	local IP6C_PrefixDelegation=`cfgcmd get ${path}X_CT-COM_IPv6PrefixDelegationEnabled`
	local IP6C_PrefixOrigin=`cfgcmd get ${path}X_CT-COM_IPv6PrefixOrigin`
	local IP6C_DsliteEnable=`cfgcmd get ${path}X_CT-COM_Dslite_Enable`
	local IP6C_AftrMode=`cfgcmd get ${path}X_CT-COM_AftrMode`
	local IP6C_DnsServers=`cfgcmd get ${path}X_CT-COM_IPv6DNSServers`
	local IP6C_DNSAddressSource=`cfgcmd get ${path}X_CT-COM_IPv6DNSAddressSource`
	
	if [ "${IP6C_DNSAddressSource}" == "Static" ]; then
		gen_dns_file ${ip6_user_defined_dns_path} "${IP6C_DnsServers}"	
	fi
	
	ipconnection_start_route_solicit_send

	case "${IP6C_AddressingType}" in
			"Static")
				ipconnection_start_routed_ipv6_static
				;;
			"AutoConfigured")
				ipconnection_start_routed_ipv6_auto
				;;
			"DHCPv6")
				ipconnection_start_routed_ipv6_dhcpv6
				;;
			*)
				#Unknow
				ipconnection_start_routed_ipv6_disable
				;;
	esac

	if [ "${IP6C_PrefixDelegation}" == "0" ]; then
		if [ "${IP6C_PrefixOrigin}" == "Static" ]; then
			ipv6_start_prefixdelegation_static
		else
			ipv6_start_prefixdelegation_none
		fi
	else
		gen_ipconnection_start_routed_ipv6_dhcpv6
	fi
	if [ "${IP6C_DNSAddressSource}" == "DHCPv6" ]; then
		ipconnection_start_routed_ipv6_dhcpv6
	elif [ "${IP6C_DNSAddressSource}" == "AutoConfigured" -o "${IP6C_DNSAddressSource}" == "None" ]; then
		ipconnection_start_routed_ipv6_auto
	fi
	if [ "${IP6C_DsliteEnable}" == "1" -a "${IP6C_AftrMode}" == "0" ]; then
	#enable dslite and get aftr name automatically,we need start dhcp6c to get aftr address
		gen_ipconnection_start_routed_ipv6_dhcpv6
	fi


	return;
}

