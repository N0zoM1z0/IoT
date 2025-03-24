#!/bin/sh
. /usr/syscfg/wan.comm.param.sh
. /usr/syscfg/dsl.utils.sh
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/ebtables.param.sh
. /usr/syscfg/mac.sh
. /usr/syscfg/api_log.sh

ipconnection_help()
{
	echo "-------------------------------------------------------"
	echo "Usage: `basename $0` action=<start|stop> path=<string>"
	echo "-------------------------------------------------------"
}

action=""
path=""
ifname=""
ifname6=""
IPC_IPMode=1

for para in $*
do
	export $para
done

if [ -z ${path} ]; then
	path_file="$(dirname $0)/path"
	if [ -f ${path_file} ]; then
		path=`cat ${path_file}`
	fi
fi

if [ -z ${path} ]; then
	ipconnection_help
	exit 0
fi

ipconnection_folder=$(gen_ipconn_folder ${path})
conn_folder=`expr ${CONN_FOLFER_PREFIX}/${ipconnection_folder}`
ipconnection_lock_flag=`expr ${conn_folder}/ipconnection_lock_flag`

while [ -f ${ipconnection_lock_flag} ]
do
	usleep 100
done
#create ipconnection lock flag
touch ${ipconnection_lock_flag}

uptime_file_path=`expr ${conn_folder}/${UPTIME_FILE}`
ifname_file_path=`expr ${conn_folder}/${IFNAME_FILE}`
user_defined_dns_path=`expr ${conn_folder}/${USER_DEFINED_DNS}`
server_assigned_dns_path=`expr ${conn_folder}/${SERVER_ASSIGNED_DNS}`
gateway_file_path=`expr ${conn_folder}/${GATEWAY_FILE}`
conf_info_path=`expr ${conn_folder}"/conf_info"`
script_ip_up_path=`expr ${conn_folder}"/script/ip_up"`
script_ip_down_path=`expr ${conn_folder}"/script/ip_down"`
pid_file_path=`expr ${conn_folder}/${PIDFILE_DHCP}`
udhcpc_script_path=`expr ${conn_folder}/${DHCPC_SCRIPT}`
udhcpc_release_script_path=`expr ${conn_folder}/${DHCPC_RELEASE_SCRIPT}`
udhcpc_renew_script_path=`expr ${conn_folder}/${DHCPC_RENEW_SCRIPT}`
release_done_flag_path=`expr ${conn_folder}/${RELEASE_DONE_FLAG}`
dhcp_leasetime_path=`expr ${conn_folder}/${DCHP_LEASETIME}`
server_assigned_tftp_addr_path=`expr ${conn_folder}/${SERVER_ASSIGNED_TFTP_ADDR}`
ip_address_path=`expr ${conn_folder}/${IP_ADDRESS}`

wan_servicelist_path=`expr ${conn_folder}/wan.servicelist.sh`

. /usr/syscfg/wan.ip6connection.sh
###################################################################
#generate down script which will be called when interface down.
gen_down_script_routed_ipv4_static()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "rm -f ${conf_info_path}" >> ${script}
	echo "rm -f ${gateway_file_path}" >> ${script}
	echo "rm -f ${user_defined_dns_path}" >> ${script}
	echo "rm -f ${uptime_file_path}" >> ${script}
	echo "rm -f ${ip_address_path}" >> ${script}
	echo "ifconfig ${ifname} 0.0.0.0" >> ${script} 
	chmod +x ${script}
}

ipconnection_start_routed_ipv4_static()
{
	local IPC_NATEnabled="$(cfgcmd get ${path}NATEnabled)"
	local IPC_ExternalIPAddress="$(cfgcmd get ${path}ExternalIPAddress)"
	local IPC_SubnetMask="$(cfgcmd get ${path}SubnetMask)"
	local IPC_DefaultGateway="$(cfgcmd get ${path}DefaultGateway)"
	#local IPC_DNSEnabled="$(cfgcmd get ${path}DNSEnabled)"
	#local IPC_DNSOverrideAllowed="$(cfgcmd get ${path}DNSOverrideAllowed)"
	local IPC_DNSServers="$(cfgcmd get ${path}DNSServers)"
	local IPC_MaxMTUSize="$(cfgcmd get ${path}MaxMTUSize)"
	local IPC_MACAddress="$(cfgcmd get ${path}MACAddress)"
	local IPC_MACAddressOverride="$(cfgcmd get ${path}MACAddressOverride)"

	if [ -z "${IPC_MaxMTUSize}" ]; then
		IPC_MaxMTUSize=1500
	fi

        ifconfig ${ifname} down
	if [ "${IPC_MACAddressOverride}" == "1" -a -n "${IPC_MACAddress}"  ]; then
                ifconfig ${ifname} hw ether ${IPC_MACAddress}
        fi
        ifconfig ${ifname} ${IPC_ExternalIPAddress} netmask ${IPC_SubnetMask} mtu ${IPC_MaxMTUSize}
        ifconfig ${ifname} up

	write_file ${conf_info_path} "NATEnabled=${IPC_NATEnabled}"
	if [ "${IPC_NATEnabled}" == "0" ]; then
		cs_cli /home/cli/api/intf/setfwd -v ifname ${ifname} fwd 2
	fi

	write_file "${ip_address_path}" "${IPC_ExternalIPAddress}"
	if [ -n "${IPC_DefaultGateway}" ]; then
		write_file ${gateway_file_path} ${IPC_DefaultGateway}
	fi
	gen_dns_file ${user_defined_dns_path} "${IPC_DNSServers}"
	gen_uptime_file ${uptime_file_path}
	gen_down_script_routed_ipv4_static "${script_ip_down_path}/900_ipv4_static.sh"
	#support hardware accelerate
	cs_cli /home/cli/api/intf/setip -v ifname ${ifname} ip ${IPC_ExternalIPAddress}
	${wan_servicelist_path} action=start ipmode=ipv4 path=${path}
}
conbridge_ipv4_dhcp_gen_ip_up_script()
{
	local script=$1
	local IPC_DNSOverrideAllowed="$(cfgcmd get ${path}DNSOverrideAllowed)"
	local IPC_DNSServers="$(cfgcmd get ${path}DNSServers)"

	echo "#!/bin/sh" > ${script}
	echo "path=${path}" >> ${script}
	echo "ifname=${ifname}" >> ${script}
	echo 'ConnType="Con_Bridged"' >> ${script}
	echo "IPC_DNSOverrideAllowed=${IPC_DNSEnabled}" >> ${script}
	echo "IPC_DNSServers=${IPC_DNSServers}" >> ${script}
	echo "conn_folder=${conn_folder}" >> ${script}
	echo "uptime_file_path=${uptime_file_path}" >> ${script}
	echo "server_assigned_dns_path=${server_assigned_dns_path}" >> ${script}
	echo "gateway_file_path=${gateway_file_path}" >> ${script}
	echo "dhcp_leasetime_path=${dhcp_leasetime_path}" >> ${script}
	echo "ip_address_path=${ip_address_path}" >> ${script}
	echo "ip_mask_path=${conn_folder}/ip_mask" >> ${script}
	echo "wan_servicelist_path=${wan_servicelist_path}" >> ${script}
	if [ "${IPC_DNSOverrideAllowed}" == "1" ]; then
		gen_dns_file ${user_defined_dns_path} "${IPC_DNSServers}"
	fi
	cat ${DHCPC_PRE_SCRIPT} >> ${script}
	chmod +x ${script}
}
conbridge_down_script_routed_ipv4_dhcp()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "pid_file_path=${pid_file_path}" >> ${script}
	echo "user_defined_dns_path=${user_defined_dns_path}" >> ${script}	
	echo '
local pid=`cat $pid_file_path`
local check_num=0

if [ -n "${pid}" ]; then
	kill ${pid}
	#check if the pid still exist
	while [ -f /proc/${pid}/stat -a "${check_num}" -lt "200" ]
	do
		check_num=`expr $check_num + 1`
		usleep 10000
	done
fi' >> ${script}
	echo 'local ipaddr=`cat '"${ip_address_path}"'`' >> ${script}
	echo 'local ipmask=`cat '"${conn_folder}/ip_mask"'`' >> ${script}
	echo "rm -f ${conf_info_path}" >> ${script}
	echo "rm -f ${gateway_file_path}" >> ${script}
	echo "rm -f ${server_assigned_dns_path}" >> ${script}
	echo  '
	if [ -f ${user_defined_dns_path} ]; then
	  rm -f ${user_defined_dns_path}
	fi' >> ${script}
	echo "rm -f ${uptime_file_path}" >> ${script}
	echo "rm -f ${dhcp_leasetime_path}" >> ${script}
	echo "rm -f ${udhcpc_script_path}" >> ${script}
	echo "rm -f ${ip_address_path}" >> ${script}
	echo "rm -f ${conn_folder}/ip_mask" >> ${script}
	chmod +x ${script}
}
conbridge_start_routed_ipv4_dhcp()
{
	conbridge_ipv4_dhcp_gen_ip_up_script ${udhcpc_script_path}
	#gen_release_script_routed_ipv4_dhcp ${udhcpc_release_script_path}
	#gen_renew_script_routed_ipv4_dhcp ${udhcpc_renew_script_path}
	conbridge_down_script_routed_ipv4_dhcp "${script_ip_down_path}/900_ipv4_dhcp.sh"

	## voip bridge wan ip 
	local CBIfName=`cat "${conn_folder}/ConBrOutIf"`
	udhcpc -a -R -i "$CBIfName" -s ${udhcpc_script_path} -p ${pid_file_path} &
}
routed_ipv4_dhcp_gen_ip_up_script()
{
	local script=$1
	local IPC_DNSEnabled="$(cfgcmd get ${path}DNSEnabled)"
	local IPC_DNSOverrideAllowed="$(cfgcmd get ${path}DNSOverrideAllowed)"
	local IPC_DNSServers="$(cfgcmd get ${path}DNSServers)"
	local IPC_OP66SettingEnable="$(cfgcmd get ${path}X_TRI_OP66SettingEnable)"

	echo "#!/bin/sh" > ${script}
	echo "path=${path}" >> ${script}
	echo "ifname=${ifname}" >> ${script}
	echo 'ConnType=""' >> ${script}
	echo "IPC_DNSEnabled=${IPC_DNSEnabled}" >> ${script}
	echo "IPC_DNSOverrideAllowed=${IPC_DNSEnabled}" >> ${script}
	echo "IPC_DNSServers=${IPC_DNSServers}" >> ${script}
	echo "conn_folder=${conn_folder}" >> ${script}
	echo "release_done_flag_path=${release_done_flag_path}" >> ${script}
	echo "uptime_file_path=${uptime_file_path}" >> ${script}
	echo "server_assigned_dns_path=${server_assigned_dns_path}" >> ${script}
	if [ "${IPC_OP66SettingEnable}" == "1" ]; then
        echo "server_assigned_tftp_addr_path=${server_assigned_tftp_addr_path}" >> ${script}
	fi
	echo "gateway_file_path=${gateway_file_path}" >> ${script}
	echo "dhcp_leasetime_path=${dhcp_leasetime_path}" >> ${script}
	echo "ip_address_path=${ip_address_path}" >> ${script}
	echo "wan_servicelist_path=${wan_servicelist_path}" >> ${script}
	if [ "${IPC_DNSOverrideAllowed}" == "1" ]; then
		gen_dns_file ${user_defined_dns_path} "${IPC_DNSServers}"
	fi
	cat ${DHCPC_PRE_SCRIPT} >> ${script}
	chmod +x ${script}
}

gen_down_script_routed_ipv4_dhcp()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "pid_file_path=${pid_file_path}" >> ${script}
	echo "user_defined_dns_path=${user_defined_dns_path}" >> ${script}	
	echo '
local pid=`cat $pid_file_path`
local check_num=0

if [ -n "${pid}" ]; then
	kill ${pid}
	#check if the pid still exist
	while [ -f /proc/${pid}/stat -a "${check_num}" -lt "200" ]
	do
		check_num=`expr $check_num + 1`
		usleep 10000
	done
fi' >> ${script}
	echo "ifconfig ${ifname} 0.0.0.0" >> ${script}
	echo "rm -f ${conf_info_path}" >> ${script}
	echo "rm -f ${gateway_file_path}" >> ${script}
	echo "rm -f ${server_assigned_dns_path}" >> ${script}
	echo  '
	if [ -f ${user_defined_dns_path} ]; then
	  rm -f ${user_defined_dns_path}
	fi' >> ${script}
	echo "rm -f ${uptime_file_path}" >> ${script}
	echo "rm -f ${dhcp_leasetime_path}" >> ${script}
	echo "rm -f ${udhcpc_script_path}" >> ${script}
	echo "rm -f ${ip_address_path}" >> ${script}
	chmod +x ${script}
}

gen_release_script_routed_ipv4_dhcp()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "pid_file_path=${pid_file_path}" >> ${script}
	echo "uptime_file_path=${uptime_file_path}" >> ${script}
	echo "release_done_flag_path=${release_done_flag_path}" >> ${script}
	echo '
if [ -f ${uptime_file_path} ]; then
	local pid=`cat $pid_file_path`
	local check_num=0

	if [ -n "${pid}" ]; then
		rm -f ${release_done_flag_path}
		kill -USR2 ${pid}
		#wait release has been done
		while [ ! -f ${release_done_flag_path} -a "${check_num}" -lt "200" ]
		do
			check_num=`expr $check_num + 1`
			usleep 10000
		done
		rm -f ${release_done_flag_path}
	fi
fi' >> ${script}
	chmod +x ${script}
}


gen_renew_script_routed_ipv4_dhcp()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "pid_file_path=${pid_file_path}" >> ${script}
	echo "uptime_file_path=${uptime_file_path}" >> ${script}
	echo '
if [ ! -f ${uptime_file_path} ]; then
	local pid=`cat $pid_file_path`
	if [ -n "${pid}" ]; then
		kill -USR1 ${pid}
	fi
fi' >> ${script}
	chmod +x ${script}
}
ipconnection_process_dongle()
{
	local wancd=`echo ${path} | cut -d '.' -f 3`
	local apn="$(cfgcmd get ${path}X_TRI_APN)"
	local pin="$(cfgcmd get ${path}X_TRI_PIN)"
	local dialno="$(cfgcmd get ${path}X_TRI_DialNumber)"
	local has_ttyACM1=`ls /dev/tty* | grep ttyACM1`
	local is_05c6_9026=`lsusb | grep -i 05c6:9026`
	
	if [ "3" != "${wancd}" -o -z "${has_ttyACM1}" ]; then
		return
	fi

	if [ "" != "${pin}" ]; then
	/usr/sbin/chat -s -v ABORT 'ERROR' TIMEOUT 5 '' AT+CPIN=${pin} OK 1> /dev/ttyACM1  0< /dev/ttyACM1 &
	sleep 2
	fi	
	if [ "" != "${is_05c6_9026}" ]; then
		#customized for askey dongle
		/usr/sbin/chat -s -v ABORT 'ERROR' TIMEOUT 5 '' at+cwwan=1 OK 1> /dev/ttyACM1  0< /dev/ttyACM1 &
	else
		cp /etc/lte_dial ${conn_folder}/lte_dial
		sed -i "s/(TRI_DIALNO)/${dialno}/g" ${conn_folder}/lte_dial
		sed -i "s/(TRI_APN)/${apn}/g"   ${conn_folder}/lte_dial
		/usr/sbin/chat -s -v -f ${conn_folder}/lte_dial 1> /dev/ttyACM1  0< /dev/ttyACM1 &
	fi	
	

}
ipconnection_start_routed_ipv4_dhcp()
{
	local IPC_NATEnabled="$(cfgcmd get ${path}NATEnabled)"
	local IPC_MaxMTUSize="$(cfgcmd get ${path}MaxMTUSize)"
	local IPC_MACAddress="$(cfgcmd get ${path}MACAddress)"
	local IPC_MACAddressOverride="$(cfgcmd get ${path}MACAddressOverride)"
	local IPC_OP60Setting="$(cfgcmd get ${path}X_TRI_OP60Setting)"
	local IPC_OP60SettingEnable="$(cfgcmd get ${path}X_TRI_OP60SettingEnable)"
	local IPC_OP66SettingEnable="$(cfgcmd get ${path}X_TRI_OP66SettingEnable)"
	local IPC_OP120SettingEnable="$(cfgcmd get ${path}X_TRI_OP120SettingEnable)"
	
	local List_O=""

	if [ -z "${IPC_MaxMTUSize}" ]; then
		IPC_MaxMTUSize=1500
	fi

	ifconfig ${ifname} down
	if [ "${IPC_MACAddressOverride}" == "1" -a -n "${IPC_MACAddress}"  ]; then
		ifconfig ${ifname} hw ether ${IPC_MACAddress}
	fi
	ifconfig ${ifname} mtu ${IPC_MaxMTUSize}
	ifconfig ${ifname} up

	write_file ${conf_info_path} "NATEnabled=${IPC_NATEnabled}"
	if [ "${IPC_NATEnabled}" == "0" ]; then
		cs_cli /home/cli/api/intf/setfwd -v ifname ${ifname} fwd 2
	fi
	routed_ipv4_dhcp_gen_ip_up_script ${udhcpc_script_path}
	gen_release_script_routed_ipv4_dhcp ${udhcpc_release_script_path}
	gen_renew_script_routed_ipv4_dhcp ${udhcpc_renew_script_path}
	gen_down_script_routed_ipv4_dhcp "${script_ip_down_path}/900_ipv4_dhcp.sh"


	if [ "${IPC_OP66SettingEnable}" == "1" ]; then
		List_O="-O tftp"
	else
		List_O=""
	fi

	ipconnection_process_dongle
	
	if [ "${IPC_OP60SettingEnable}" == "1" -a -n "${IPC_OP60Setting}"  ]; then
	    if [ "${IPC_OP120SettingEnable}" == "1" ];then
		udhcpc -a -R -I -i ${ifname} -s ${udhcpc_script_path} -p ${pid_file_path} -V "${IPC_OP60Setting}" ${List_O}&
		else
		udhcpc -a -R -i ${ifname} -s ${udhcpc_script_path} -p ${pid_file_path} -V "${IPC_OP60Setting}" ${List_O}&
		fi
	else
	    if [ "${IPC_OP120SettingEnable}" == "1" ];then
	        udhcpc -a -R -I -i ${ifname} -s ${udhcpc_script_path} -p ${pid_file_path} ${List_O}&
	    else
	        udhcpc -a -R -i ${ifname} -s ${udhcpc_script_path} -p ${pid_file_path} ${List_O}&
	    fi
	fi
}

ipconnection_start_routed_ipv4_dhcp_release()
{
	if [ -x "${udhcpc_release_script_path}" ]; then
		${udhcpc_release_script_path}
	fi
}

ipconnection_start_routed_ipv4_dhcp_renew()
{

	if [ -x "${udhcpc_renew_script_path}" ]; then
		${udhcpc_renew_script_path}
	fi
}

ipconnection_start_routed_ipv4()
{
	local IPC_AddressingType="$(cfgcmd get ${path}AddressingType)"
	if [ "${IPC_AddressingType}" == "Static" ]; then
		ipconnection_start_routed_ipv4_static
	elif [ "${IPC_AddressingType}" == "DHCP" ]; then
		ipconnection_start_routed_ipv4_dhcp	
	fi
}

ipconnection_start_routed()
{

	local IPC_IPMode="$(cfgcmd get ${path}X_CT-COM_IPMode)"
	case "$IPC_IPMode" in
		"1")
			#IPv4
			echo 1 > /proc/sys/net/ipv6/conf/${ifname}/disable_ipv6
			ipconnection_start_routed_ipv4
			;;
		"2")
			#IPv6
			echo 0 > /proc/sys/net/ipv6/conf/${ifname}/disable_ipv6
			ifname6=${ifname}
			ipconnection_start_routed_ipv6
			;;
		"3")
			#IPv4&6
			echo 0 > /proc/sys/net/ipv6/conf/${ifname}/disable_ipv6
			ifname6=${ifname}
			ipconnection_start_routed_ipv4
			ipconnection_start_routed_ipv6
			;;
		*)
			#Unknow
			return
			;;
	esac
}

clear_wan_bridged_rules()
{
	local script=$1

    #local IsBrMcFlagSet="$(cfgcmd get ${path}X_TRI-InetBrMCRuleFlag)"
    #if [ "$IsBrMcFlagSet" == "1" ]; then
        echo "cfgcmd sset ${path}X_TRI-InetBrMCRuleFlag 0" >> ${script}
        echo "ebtables -D ${BR_MC_IGMP_FILTER} -d Multicast -o ${ifname} -j DROP" >> ${script}
    #fi

	case "$IPC_IPMode" in
		"1")
			#IPv4
			echo "rm -f ${uptime_file_path}" >> ${script}
			echo "ebtables -t filter -D ${WAN_BRIDGED_CHAIN} -p IPv6 -o ${ifname} -j DROP" >> ${script}
			echo "ebtables -t filter -D ${WAN_BRIDGED_CHAIN} -p IPv6 -i ${ifname} -j DROP" >> ${script}
			echo "ebtables -t filter -D ${WAN_BRIDGED_SERVICE_CHAIN} -p IPv4 -o ${ifname} --ip-proto 17 --ip-destination-port 68 -j DROP" >> ${script}
			echo "ebtables -t filter -D ${WAN_BRIDGED_SERVICE_CHAIN} -p arp  -o ${ifname} -j DROP" >> ${script}
			;;
		"2")
			#IPv6
			echo "rm -f ${ip6_uptime_file_path}" >> ${script}
			echo "ebtables -t filter -D ${WAN_BRIDGED_CHAIN} -p IPv4 -o ${ifname} -j DROP" >> ${script}
			echo "ebtables -t filter -D ${WAN_BRIDGED_CHAIN} -p IPv4 -i ${ifname} -j DROP" >> ${script}
			echo "ebtables -t filter -D ${WAN_BRIDGED_SERVICE_CHAIN} -p IPv6 -o ${ifname} --ip6-proto 17 --ip6-destination-port 546 -j DROP" >> ${script}
			echo "ebtables -t filter -D ${WAN_BRIDGED_SERVICE_CHAIN} -p IPv6 -o ${ifname} --ip6-protocol 58 --ip6-icmp-type router-advertisement -j DROP" >> ${script}
			;;
		"3")
			#IPv4&6
			echo "rm -f ${uptime_file_path}" >> ${script}
			echo "rm -f ${ip6_uptime_file_path}" >> ${script}
			#drop dhcp offer
			echo "ebtables -t filter -D ${WAN_BRIDGED_SERVICE_CHAIN} -p IPv4 -o ${ifname} --ip-proto 17 --ip-destination-port 68 -j DROP" >> ${script}
			echo "ebtables -t filter -D ${WAN_BRIDGED_SERVICE_CHAIN} -p arp  -o ${ifname} -j DROP" >> ${script}

			#drop RA and dhcp Advertise
			echo "ebtables -t filter -D ${WAN_BRIDGED_SERVICE_CHAIN} -p IPv6 -o ${ifname} --ip6-proto 17 --ip6-destination-port 546 -j DROP" >> ${script}
			echo "ebtables -t filter -D ${WAN_BRIDGED_SERVICE_CHAIN} -p IPv6 -o ${ifname} --ip6-protocol 58 --ip6-icmp-type router-advertisement -j DROP" >> ${script}
			;;
		*)
			#Unknow
			return
			;;
	esac
}

add_wan_bridged_rules()
{
	case "$IPC_IPMode" in
		"1")
			#IPv4
			echo 1 > /proc/sys/net/ipv6/conf/${ifname}/disable_ipv6
			ebtables -t filter -A ${WAN_BRIDGED_CHAIN} -p IPv6 -o ${ifname} -j DROP
			ebtables -t filter -A ${WAN_BRIDGED_CHAIN} -p IPv6 -i ${ifname} -j DROP
			#drop dhcp offer
			ebtables -t filter -A ${WAN_BRIDGED_SERVICE_CHAIN} -p IPv4 -o ${ifname} --ip-proto 17 --ip-destination-port 68 -j DROP
			ebtables -t filter -A ${WAN_BRIDGED_SERVICE_CHAIN} -p arp  -o ${ifname} -j DROP
			;;
		"2")
			#IPv6
			echo 0 > /proc/sys/net/ipv6/conf/${ifname}/disable_ipv6
			ebtables -t filter -A ${WAN_BRIDGED_CHAIN} -p IPv4 -o ${ifname} -j DROP
			ebtables -t filter -A ${WAN_BRIDGED_CHAIN} -p IPv4 -i ${ifname} -j DROP
			#drop RA and dhcp Advertise
			ebtables -t filter -A ${WAN_BRIDGED_SERVICE_CHAIN} -p IPv6 -o ${ifname} --ip6-proto 17 --ip6-destination-port 546 -j DROP
			ebtables -t filter -A ${WAN_BRIDGED_SERVICE_CHAIN} -p IPv6 -o ${ifname} --ip6-protocol 58 --ip6-icmp-type router-advertisement -j DROP
			;;
		"3")
			#IPv4&6
			echo 0 > /proc/sys/net/ipv6/conf/${ifname}/disable_ipv6
			#drop dhcp offer
			ebtables -t filter -A ${WAN_BRIDGED_SERVICE_CHAIN} -p IPv4 -o ${ifname} --ip-proto 17 --ip-destination-port 68 -j DROP
			ebtables -t filter -A ${WAN_BRIDGED_SERVICE_CHAIN} -p arp  -o ${ifname} -j DROP
			
			#drop RA and dhcp Advertise
			ebtables -t filter -A ${WAN_BRIDGED_SERVICE_CHAIN} -p IPv6 -o ${ifname} --ip6-proto 17 --ip6-destination-port 546 -j DROP
			ebtables -t filter -A ${WAN_BRIDGED_SERVICE_CHAIN} -p IPv6 -o ${ifname} --ip6-protocol 58 --ip6-icmp-type router-advertisement -j DROP
			;;
		*)
			#Unknow
			return
			;;
	esac
}

generate_uptime_files()
{
	case "$IPC_IPMode" in
		"1")
			#IPv4
			gen_uptime_file ${uptime_file_path}
			;;
		"2")
			#IPv6
			gen_uptime_file ${ip6_uptime_file_path}
			;;
		"3")
			#IPv4&6
			gen_uptime_file ${uptime_file_path}
			gen_uptime_file ${ip6_uptime_file_path}
			;;
		*)
			#Unknow
			return
			;;
	esac
}

gen_down_script_bridged()
{
	local script=$1
	local br_if=$2

	echo "#!/bin/sh" > ${script}
	echo "brctl delif ${br_if} ${ifname}" >> ${script}	

	clear_wan_bridged_rules ${script}
	chmod +x ${script}
}

gen_down_script_extbridged()
{
	local script=$1
	local br_if=$2

	echo "#!/bin/sh" > ${script}
	echo "brctl delif ${br_if} ${ifname}" >> ${script}	
	clear_wan_bridged_rules ${script}
	echo "ifconfig ${br_if} 0.0.0.0" >> ${script}	
	echo "ifconfig ${br_if} down" >> ${script}	
	echo "brctl delbr ${br_if}" >> ${script}	
	echo "rm ${conn_folder}/ConBrOutIf" >> ${script}	
	chmod +x ${script}
}

gen_down_script_bridged_other()
{
	local script=$1
	local br_if=$2
	local iptv_if=$3

	echo "#!/bin/sh" > ${script}
	echo "cs_cli /home/cli/api/mc/del_member -v grpid 1 ifname ${iptv_if} upflag 1" >> ${script}
	echo "cs_cli /home/cli/debug/app/mc/clear_grpusr_info -v ifname ${iptv_if}" >> ${script}
	echo "brctl delif ${br_if} ${iptv_if}" >> ${script}
	echo "xtm_cli intf --delete ${iptv_if}" >> ${script}

	clear_wan_bridged_rules ${script}
	chmod +x ${script}
}

bridge_connect_set_ip_empty()
{
	cfgcmd sset ${path}ExternalIPAddress ""
	cfgcmd sset ${path}RemoteIPAddress ""
	cfgcmd sset ${path}DNSServers ""
}

ipconnection_start_bridged()
{
	local C_ServiceList="$(cfgcmd get ${path}X_CT-COM_ServiceList)"
	local IPC_MaxMTUSize="$(cfgcmd get ${path}MaxMTUSize)"
	local C_LanInterface="$(cfgcmd get ${path}X_CT-COM_LanInterface)"
	local IsBrMcFlagSet="$(cfgcmd get ${path}X_TRI-InetBrMCRuleFlag)"
    local 
	local brIf=""
	IPC_IPMode="$(cfgcmd get ${path}X_CT-COM_IPMode)"

	if [ -z ${IPC_MaxMTUSize} ]; then
		IPC_MaxMTUSize=1500
	fi



	ifconfig ${ifname} down
	ifconfig ${ifname} mtu ${IPC_MaxMTUSize}
	ifconfig ${ifname} up

	add_wan_bridged_rules

	## add brvlan first before port binding
	if [ "${C_ServiceList}" == "VOIP" -o "${C_ServiceList}" == "TR069" ]; then
		local vlanID="$(cfgcmd get ${path}X_TRI_VlanID)"
		local wanIf=`echo "${ifname}" | awk -F "_" '{print $1$2$3$4}'`
		brIf="br${wanIf}V${vlanID}"

		# add new br if
		brctl addbr ${brIf}
		ifconfig ${brIf} up
		brctl addif ${brIf} "${ifname}"
		echo "${brIf}" > ${conn_folder}/ConBrOutIf
	fi

    #¶Ë¿Ú°ó¶¨
	/usr/syscfg/wan.portbinding.sh ${path} "bridge"

	case "${C_ServiceList}" in
		"INTERNET") # Internet Bridge & Con-Bridge
            ## br inet igmpproxy rules
            if [ "$IsBrMcFlagSet" == "0" -a "`pidof igmpproxy`" != "" ]; then
                cfgcmd sset ${path}X_TRI-InetBrMCRuleFlag 1
                ebtables -A ${BR_MC_IGMP_FILTER} -d Multicast -o ${ifname} -j DROP
            fi

			gen_down_script_bridged "${script_ip_down_path}/920_bridged.sh" br0
			/usr/syscfg/led.sh internet_wan on "${script_ip_down_path}/101_internetled.sh"
			brctl addif br0 ${ifname}
			# dhcp transparent
			dhcp_transparent ${ifname}
			;;
		"VOIP" | "TR069") # Internet Bridge & Con-Bridge
			gen_down_script_extbridged "${script_ip_down_path}/920_bridged.sh" "$brIf"
			/usr/syscfg/led.sh internet_wan on "${script_ip_down_path}/101_internetled.sh"
			# dhcp transparent
			#dhcp_transparent ${ifname}
			ebtables -t filter -D ${WAN_BRIDGED_SERVICE_CHAIN} -p arp -o ${ifname} -j DROP
			;;
        "OTHER")
			gen_down_script_bridged "${script_ip_down_path}/920_bridged.sh" br1
			local MVlan="$(cfgcmd get ${path}X_CT-COM_MulticastVlan)"
			if [ "${MVlan}" -ge "1" -a "${MVlan}" -le "4095" ]; then
				wanconn_inst_path="$(get_wanconn_inst_path $path)"
				wanconn_instance=`echo ${path} | cut -d '.' -f 5`
				
				#create interface for iptv
				local dsl_ifname=`get_dsl_ifname ${path}`
				local iptv_ifname="${dsl_ifname}_tv${wanconn_instance}"
				local iptv_mac="$(get_base_mac)"
				if [ -z "${iptv_mac}" ]; then
					iptv_mac=${BASE_MAC}
				fi
				gen_down_script_bridged_other "${script_ip_down_path}/930_bridged_other.sh" "br1" "${iptv_ifname}"
				xtm_cli intf --add connname ${dsl_ifname} intfname ${iptv_ifname} vlanid ${MVlan} vlanpri 0 dmac ${iptv_mac}
				ifconfig ${iptv_ifname} up
				brctl addif br1 ${ifname}
				#local mac=`ifconfig ${iptv_ifname} | grep HWaddr | awk '{ print $5 }'`
				local mac=`ifconfig br1 | grep HWaddr | awk '{ print $5 }'`
				#add iptv_ifname to mc group
				cs_cli /home/cli/api/intf/setmcmac -v ifname ${iptv_ifname} mac ${mac}
				cs_cli /home/cli/api/mc/add_member -v grpid 1 ifname ${iptv_ifname} upflag 1
			fi
			brctl addif br1 ${ifname}
			;;
	esac
	# vlan tagging
	/usr/syscfg/vlan_tagging.sh "wan_path=${path}" "down_dir=${script_ip_down_path}"    
	bridge_connect_set_ip_empty
	#generate uptime file
	generate_uptime_files
	#support hardware accelerate
    other_wan_mc_setting ${script_ip_down_path} ${path}
	cs_cli /home/cli/api/intf/setfwd -v ifname ${ifname} fwd 0
	local keeptag="$(cfgcmd get ${path}X_TRI_VlanPassKeepTag)"
	cs_cli /home/cli/api/intf/setvlanpass -v ifname ${ifname} pass ${keeptag}
	
	## Con-Bridge setup , get an ip address
	if [ "${C_ServiceList}" == "VOIP" -o "${C_ServiceList}" == "TR069" ]; then
		conbridge_start_routed_ipv4_dhcp
	fi
}

ipconnection_start()
{
	local IPC_Enable="$(cfgcmd get ${path}Enable)"

	#check if this ipconnection has been enabled
	if [ "${IPC_Enable}" != "1" ]; then
		return
	fi

	write_file ${ifname_file_path} "${ifname}"

	local IPC_ConnectionType="$(cfgcmd get ${path}ConnectionType)"
	if [ "${IPC_ConnectionType}" == "IP_Routed" ]; then
		ipconnection_start_routed
	elif [ "${IPC_ConnectionType}" == "IP_Bridged" -o "${IPC_ConnectionType}" == "Con_Bridged" ]; then
		ipconnection_start_bridged
	fi	
	#update wan mac
	local mac="`ifconfig ${ifname} | grep "HWaddr" | awk '{print$5s}'`"
	if [ -n "${mac}" ]; then
		cfgcmd sset ${path}MACAddress ${mac}
	fi
	cfgcmd sset ${path}Reset 0
}

ipconnection_stop()
{
	local wan_ifname=`cat ${ifname_file_path}`
	echo 0 > /proc/sys/net/ipv4/conf/${wan_ifname}/forwarding

	local scripts=`expr ${script_ip_down_path}"/*"`
	for i in $scripts; do
		if [ -x "$i" ]; then
			${i}
		fi
	done
	cs_cli /home/cli/api/mc/del_member -v ifname ${wan_ifname}
	cs_cli /home/cli/debug/app/mc/clear_grpusr_info -v ifname ${wan_ifname}


	rm -rf ${script_ip_down_path}/*
	rm -f ${ifname_file_path}
}

###################################################################

TGP_Log ${TGP_LOG_WARNING} "path=${path}, action=${action}"

case "$action" in
	"start")
		ipconnection_start
		;;
	"stop")
		ipconnection_stop
		;;
	"restart")
		ipconnection_stop
		ipconnection_start
		;;
	"dhcp_release")
		ipconnection_start_routed_ipv4_dhcp_release
		;;
	"dhcp_renew")
		ipconnection_start_routed_ipv4_dhcp_renew
		;;
	*)
		ipconnection_help
		;;
esac
rm -f ${ipconnection_lock_flag}
