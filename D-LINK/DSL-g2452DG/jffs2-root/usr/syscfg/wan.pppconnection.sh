#!/bin/sh
. /usr/syscfg/wan.comm.param.sh
. /usr/syscfg/dsl.utils.sh
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/ebtables.param.sh
. /usr/syscfg/usb/dongle/dongle.comm.sh
. /usr/syscfg/api_log.sh

pppconnection_help()
{
	echo "-------------------------------------------------------"
	echo "Usage: `basename $0` action=<start|stop> path=<string>"
	echo "-------------------------------------------------------"
}

action=""
path=""
dsl_link_type_path=""
conn_ifname=""
ifname=""
ifname6=""
PPPC_IPMode=1

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

if [ -z ${dsl_link_type_path} ]; then
	    dsl_path_file="$(dirname $0)/dsllinktype_path"
		if [ -f ${dsl_path_file} ]; then
				dsl_link_type_path=`cat ${dsl_path_file}`
		fi
fi


if [ -z ${conn_ifname} ]; then
		conn_ifname_file="$(dirname $0)/lowerLayers_path"
		if [ -f ${conn_ifname_file} ]; then
				conn_ifname=`cat ${conn_ifname_file}`
		fi
fi

if [ -z ${path} ]; then
        pppconnection_help
        exit 0
fi

if [ -z ${dsl_link_type_path} ]; then
        pppconnection_help
        exit 0
fi


if [ -z ${conn_ifname} ]; then
        pppconnection_help
        exit 0
fi


pppconnection_folder=$(gen_pppconn_folder ${path})
conn_folder=`expr ${CONN_FOLFER_PREFIX}/${pppconnection_folder}`
pppconnection_lock_flag=`expr ${conn_folder}/pppconnection_lock_flag`

while [ -f ${pppconnection_lock_flag} ]
do             
	usleep 100        
done                           
#create pppconnection lock flag
touch ${pppconnection_lock_flag}

uptime_file_path=`expr ${conn_folder}/${UPTIME_FILE}`
ip6_uptime_file_path=`expr ${conn_folder}/${IP6_UPTIME}`
ifname_file_path=`expr ${conn_folder}/${IFNAME_FILE}`
user_defined_dns_path=`expr ${conn_folder}/${USER_DEFINED_DNS}`
server_assigned_dns_path=`expr ${conn_folder}/${SERVER_ASSIGNED_DNS}`

conf_info_path=`expr ${conn_folder}"/conf_info"`
script_ip_up_path=`expr ${conn_folder}"/script/ip_up"`
script_ip_down_path=`expr ${conn_folder}"/script/ip_down"`
pid_file_path=`expr ${conn_folder}/${PIDFILE_PPPD}`
pppoe_options_path=`expr ${conn_folder}/${PPPoE_OPTIONS}`
chat_options_path=`expr ${conn_folder}/${CHAT_OPTIONS}`
ppp_demand_script_path=`expr ${conn_folder}/${PPP_DEMAND_SCRIPT}`
ppp_ip_up_script_path=`expr ${conn_folder}/${PPP_IP_UP_SCRIPT}`
ppp_ip_down_script_path=`expr ${conn_folder}/${PPP_IP_DOWN_SCRIPT}`
ppp_ip6_up_script_path=`expr ${conn_folder}/${PPP_IP6_UP_SCRIPT}`
ppp_ip6_down_script_path=`expr ${conn_folder}/${PPP_IP6_DOWN_SCRIPT}`

ppp_ifname_file_path=`expr ${conn_folder}/${PPP_IFNAME}`
ppp_sessionid_path=`expr ${conn_folder}/${PPP_SESSIONID}`
ip_address_path=`expr ${conn_folder}/${IP_ADDRESS}`
ip_remote_path=`expr ${conn_folder}/${PPP_IPREMOTE}`
ppp6_llocal_path=`expr ${conn_folder}/${PPP6_LLLOCAL}`
ppp6_llremote_path=`expr ${conn_folder}/${PPP6_LLREMOTE}`

wan_servicelist_path=`expr ${conn_folder}/wan.servicelist.sh`
###################################################################
routed_normal_pppoe_gen_demand_script()
{
	local script=$1
	local ServiceList="$(cfgcmd get ${path}X_CT-COM_ServiceList)"
        local LanInterface="$(cfgcmd get ${path}X_CT-COM_LanInterface)"
	
	echo "#!/bin/sh" > ${script}
	echo '. /usr/syscfg/wan.utils.sh' >> ${script}
	echo '. /usr/syscfg/firewall.param.sh' >> ${script}
	echo '. /usr/syscfg/ebtables.param.sh' >> ${script}
	echo "PPPC_IPMode=${PPPC_IPMode}" >> ${script}
	echo "ServiceList=${ServiceList}" >> ${script}
	echo "LanInterface=${LanInterface}" >> ${script}
	echo "script_ip_down_path=${script_ip_down_path}" >> ${script}
	echo "wanpath=${path}" >> ${script}
	echo "ip_remote_path=${ip_remote_path}" >> ${script}
	echo "ppp6_llremote_path=${ppp6_llremote_path}" >> ${script}
	echo "ppp_ifname_file_path=${ppp_ifname_file_path}" >> ${script}
	echo "server_assigned_dns_path=${server_assigned_dns_path}" >> ${script}
	echo '
TGP_Log ${TGP_LOG_WARNING} "IPREMOTE=${IPREMOTE}, LLREMOTE=${LLREMOTE}"
if [ -n "$IPREMOTE" ]; then
    write_file "${ip_remote_path}" "${IPREMOTE}"
fi

if [ -n "$LLREMOTE" ]; then
    write_file "${ppp6_llremote_path}" "${LLREMOTE}"
fi
write_file "${ppp_ifname_file_path}" "${IFNAME}"

#if [ "${ServiceList}" == "TR069" -o -z "${LanInterface}" ]; then
	case "$PPPC_IPMode" in
		"1")
			#IPv4
			ip route add default via ${IPREMOTE} dev ${IFNAME}
			gen_dns_file ${server_assigned_dns_path} "$IPREMOTE"
			;;
		"2")
			#IPv6
			ip -6 route add default via ${LLREMOTE} dev ${IFNAME}
			gen_dns_file ${server_assigned_dns_path} "$LLREMOTE"
			;;
		"3")
			#IPv4&6
			ip route add default via ${IPREMOTE} dev ${IFNAME}
			ip -6 route add default via ${LLREMOTE} dev ${IFNAME}
			gen_dns_file ${server_assigned_dns_path} "$IPREMOTE,$LLREMOTE"
			;;
	esac
#else
#if [ "${ServiceList}" != "TR069" -a -n "${LanInterface}" ]; then
if [ "${ServiceList}" != "TR069" -a "${ServiceList}" != "VOIP" -a -n "${LanInterface}" ]; then
	case "$PPPC_IPMode" in
		"1")
			#IPv4
			/usr/syscfg/wan.portbinding.sh "${wanpath}" "ipv4"
			;;
		"2")
			#IPv6
			/usr/syscfg/wan.portbinding.sh "${wanpath}" "ipv6"
			;;
		"3")
			#IPv4&6
			/usr/syscfg/wan.portbinding.sh "${wanpath}" "ipv4"
			/usr/syscfg/wan.portbinding.sh "${wanpath}" "ipv6"
			;;
	esac
fi
add_dns ${server_assigned_dns_path}
' >> ${script}

	chmod +x ${script}
}


#dongle专用
routed_normal_ppp_gen_ip_up_script()
{
	local script=$1
	local PPPC_DNSEnabled="$(cfgcmd get ${path}DNSEnabled)"
	local PPPC_DNSOverrideAllowed="$(cfgcmd get ${path}DNSOverrideAllowed)"
	local PPPC_DNSServers="$(cfgcmd get ${path}DNSServers)"
	local PPPC_ProxyEnable="$(cfgcmd get ${path}X_CT-COM_ProxyEnable)"
	if [ "${PPPC_DNSOverrideAllowed}" == "1" ]; then
	gen_dns_file ${user_defined_dns_path} "${PPPC_DNSServers}"
	fi
	echo "#!/bin/sh" > ${script}
	echo '. /usr/syscfg/firewall.param.sh' >> ${script}
	echo '. /usr/syscfg/wan.utils.sh' >> ${script}
	echo "path=${path}" >> ${script}
	echo "ifname=${ifname}" >> ${script}
	echo "PPPC_DNSEnabled=${PPPC_DNSEnabled}" >> ${script}
	echo "PPPC_DNSOverrideAllowed=${PPPC_DNSEnabled}" >> ${script}
	echo "PPPC_DNSServers=${PPPC_DNSServers}" >> ${script}
	echo "uptime_file_path=${uptime_file_path}" >> ${script}
	echo "server_assigned_dns_path=${server_assigned_dns_path}" >> ${script}
	echo "ip_address_path=${ip_address_path}" >> ${script}
	echo "ppp_ifname_file_path=${ppp_ifname_file_path}" >> ${script}
	echo "ppp_sessionid_path=${ppp_sessionid_path}" >> ${script}
	echo "ip_remote_path=${ip_remote_path}" >> ${script}
	echo "wan_status_update_path=${wan_status_update_path}" >> ${script}
	echo "wan_servicelist_path=${wan_servicelist_path}" >> ${script}
	echo "pppoe_proxy=${PPPC_ProxyEnable}" >> ${script}
	echo '
subnet_mask="255.255.255.255"
ifconfig $IFNAME $IPLOCAL dstaddr $IPREMOTE
ifconfig $IFNAME netmask ${subnet_mask}
gen_uptime_file ${uptime_file_path}
if [ -n "$DNS1" -o -n "$DNS2" ]; then
        gen_dns_file ${server_assigned_dns_path} "$DNS1,$DNS2"
fi
write_file "${ip_address_path}" "${IPLOCAL}"
write_file "${ip_remote_path}" "${IPREMOTE}"
write_file "${ppp_ifname_file_path}" "${IFNAME}"
write_file "${ppp_sessionid_path}" "${SESSIONID}"

${wan_servicelist_path} action=start ipmode=ipv4 path=${path}
${wan_status_update_path} path=${path}

if [ "${PPP_PROTOCOL}" == "c023" ]; then
        cfgcmd sset ${path}PPPAuthenticationProtocol PAP
elif [ "${PPP_PROTOCOL}" == "c223" ]; then
        cfgcmd sset ${path}PPPAuthenticationProtocol CHAP
fi
cat /proc/uptime | cut -d . -f 1 > /tmp/.ppp.status

' >> ${script}
	
	chmod +x ${script}

}

routed_normal_pppoe_gen_ip_up_script()
{
	local script=$1
	local PPPC_DNSEnabled="$(cfgcmd get ${path}DNSEnabled)"
	local PPPC_DNSOverrideAllowed="$(cfgcmd get ${path}DNSOverrideAllowed)"
	local PPPC_DNSServers="$(cfgcmd get ${path}DNSServers)"
	local PPPC_ProxyEnable="$(cfgcmd get ${path}X_CT-COM_ProxyEnable)"
	if [ "${PPPC_DNSOverrideAllowed}" == "1" ]; then
	gen_dns_file ${user_defined_dns_path} "${PPPC_DNSServers}"
	fi
	echo "#!/bin/sh" > ${script}
	echo '. /usr/syscfg/firewall.param.sh' >> ${script}
	echo '. /usr/syscfg/wan.utils.sh' >> ${script}
	echo "path=${path}" >> ${script}
	echo "ifname=${ifname}" >> ${script}
	echo "PPPC_DNSEnabled=${PPPC_DNSEnabled}" >> ${script}
	echo "PPPC_DNSOverrideAllowed=${PPPC_DNSEnabled}" >> ${script}
	echo "PPPC_DNSServers=${PPPC_DNSServers}" >> ${script}
	echo "uptime_file_path=${uptime_file_path}" >> ${script}
	echo "server_assigned_dns_path=${server_assigned_dns_path}" >> ${script}
	echo "ip_address_path=${ip_address_path}" >> ${script}
	echo "ppp_ifname_file_path=${ppp_ifname_file_path}" >> ${script}
	echo "ppp_sessionid_path=${ppp_sessionid_path}" >> ${script}
	echo "ip_remote_path=${ip_remote_path}" >> ${script}
	echo "wan_status_update_path=${wan_status_update_path}" >> ${script}
	echo "wan_servicelist_path=${wan_servicelist_path}" >> ${script}
	echo "pppoe_proxy=${PPPC_ProxyEnable}" >> ${script}
	echo '
subnet_mask="255.255.255.255"
ifconfig $IFNAME $IPLOCAL dstaddr $IPREMOTE
ifconfig $IFNAME netmask ${subnet_mask}
gen_uptime_file ${uptime_file_path}
if [ -n "$DNS1" -o -n "$DNS2" ]; then
        gen_dns_file ${server_assigned_dns_path} "$DNS1,$DNS2"
fi
write_file "${ip_address_path}" "${IPLOCAL}"
write_file "${ip_remote_path}" "${IPREMOTE}"
write_file "${ppp_ifname_file_path}" "${IFNAME}"
write_file "${ppp_sessionid_path}" "${SESSIONID}"
if [ "${pppoe_proxy}" == "0" ]; then
	#support hardware accelerate
	cs_cli /home/cli/api/intf/setip -v ifname ${ifname} ip ${IPLOCAL}
	cs_cli /home/cli/api/intf/setppp -v ifname ${ifname} pppname ${IFNAME} enable 1 sessionid ${SESSIONID}
else
	iptables -I ${FLOW_ACCEL_CHAIN} 1 -o ${IFNAME} -j MARK --set-mark 0x60000000/0xf0000000
	proxy_accel=`flowaccel show | grep "0x60000000/0xf0000000" | wc -l`
	if [ "${proxy_accel}" == "0" ]; then
		flowaccel add 0x60000000/0xf0000000 no
	fi
fi
${wan_servicelist_path} action=start ipmode=ipv4 path=${path}
${wan_status_update_path} path=${path}

if [ "${PPP_PROTOCOL}" == "c023" ]; then
        cfgcmd sset ${path}PPPAuthenticationProtocol PAP
elif [ "${PPP_PROTOCOL}" == "c223" ]; then
        cfgcmd sset ${path}PPPAuthenticationProtocol CHAP
fi
cat /proc/uptime | cut -d . -f 1 > /tmp/.ppp.status

    start_dual_lan_routed_normal_pppoe

' >> ${script}
	
	chmod +x ${script}
}

# dongle专用
routed_normal_ppp_gen_ip_down_script()
{

	local script=$1
	local PPPC_ConnectionTrigger="$(cfgcmd get ${path}ConnectionTrigger)"

	echo "#!/bin/sh" > ${script}
	echo '. /usr/syscfg/firewall.param.sh' >> ${script}
	echo "path=${path}" >> ${script}
	echo "uptime_file_path=${uptime_file_path}" >> ${script}
	echo "ppp_ifname_file_path=${ppp_ifname_file_path}" >> ${script}
	echo "ppp_sessionid_path=${ppp_sessionid_path}" >> ${script}
	echo "user_defined_dns_path=${user_defined_dns_path}" >> ${script}
	echo "server_assigned_dns_path=${server_assigned_dns_path}" >> ${script}
	echo "ip_address_path=${ip_address_path}" >> ${script}
	echo "ip_remote_path=${ip_remote_path}" >> ${script}
	echo "wan_status_update_path=${wan_status_update_path}" >> ${script}
	echo "wan_servicelist_path=${wan_servicelist_path}" >> ${script}
	echo "ppp_demand_script_path=${ppp_demand_script_path}" >> ${script}
	echo "PPPC_ConnectionTrigger=${PPPC_ConnectionTrigger}" >> ${script}
	echo '

if [ -f ${uptime_file_path} ]; then
	${wan_servicelist_path} action=stop ipmode=ipv4 path=${path}
	rm -f ${uptime_file_path}
	rm -f ${server_assigned_dns_path}
	if [ -f ${user_defined_dns_path} ]; then
	  rm -f ${user_defined_dns_path}
	fi
	rm -f ${ip_address_path}
	rm -f ${ip_remote_path}
	rm -f ${ppp_ifname_file_path}
	rm -f ${ppp_sessionid_path}
	${wan_status_update_path} path=${path}
	
	if [ "${PPPC_ConnectionTrigger}" == "OnDemand" ]; then
		${ppp_demand_script_path}
	fi
fi
	cat /proc/uptime | cut -d . -f 1 > /tmp/.ppp.status

' >> ${script}

	chmod +x ${script}
}

routed_normal_pppoe_gen_ip_down_script()
{
	local script=$1
	local PPPC_ConnectionTrigger="$(cfgcmd get ${path}ConnectionTrigger)"

	echo "#!/bin/sh" > ${script}
	echo '. /usr/syscfg/firewall.param.sh' >> ${script}
	echo '. /usr/syscfg/wan.utils.sh' >> ${script}
	echo "path=${path}" >> ${script}
	echo "uptime_file_path=${uptime_file_path}" >> ${script}
	echo "ppp_ifname_file_path=${ppp_ifname_file_path}" >> ${script}
	echo "ppp_sessionid_path=${ppp_sessionid_path}" >> ${script}
	echo "user_defined_dns_path=${user_defined_dns_path}" >> ${script}
	echo "server_assigned_dns_path=${server_assigned_dns_path}" >> ${script}
	echo "ip_address_path=${ip_address_path}" >> ${script}
	echo "ip_remote_path=${ip_remote_path}" >> ${script}
	echo "wan_status_update_path=${wan_status_update_path}" >> ${script}
	echo "wan_servicelist_path=${wan_servicelist_path}" >> ${script}
	echo "ppp_demand_script_path=${ppp_demand_script_path}" >> ${script}
	echo "PPPC_ConnectionTrigger=${PPPC_ConnectionTrigger}" >> ${script}
	echo '

iptables -D ${FLOW_ACCEL_CHAIN} -o ${IFNAME} -j MARK --set-mark 0x60000000/0xf0000000
flowaccel del 0x60000000/0xf0000000 no

if [ -f ${uptime_file_path} ]; then
	${wan_servicelist_path} action=stop ipmode=ipv4 path=${path}
	rm -f ${uptime_file_path}
	rm -f ${server_assigned_dns_path}
	if [ -f ${user_defined_dns_path} ]; then
	  rm -f ${user_defined_dns_path}
	fi
	rm -f ${ip_address_path}
	rm -f ${ip_remote_path}
	rm -f ${ppp_ifname_file_path}
	rm -f ${ppp_sessionid_path}
	${wan_status_update_path} path=${path}
	
	if [ "${PPPC_ConnectionTrigger}" == "OnDemand" ]; then
		${ppp_demand_script_path}
	fi
fi
	cat /proc/uptime | cut -d . -f 1 > /tmp/.ppp.status

    stop_dual_lan_routed_normal_pppoe

' >> ${script}
	chmod +x ${script}
}

routed_normal_pppoe_gen_ip6_up_script()
{
	local script=$1
	local PPPC_ProxyEnable="$(cfgcmd get ${path}X_CT-COM_ProxyEnable)"
	
	echo "#!/bin/sh" > ${script}
	echo '. /usr/syscfg/firewall.param.sh' >> ${script}
	echo '. /usr/syscfg/wan.utils.sh' >> ${script}
	echo "path=${path}" >> ${script}
	echo "ifname=${ifname}" >> ${script}
	echo "uptime_file_path=${uptime_file_path}" >> ${script}
	echo "ppp_ifname_file_path=${ppp_ifname_file_path}" >> ${script}
	echo "ppp_sessionid_path=${ppp_sessionid_path}" >> ${script}
	echo "wan_status_update_path=${wan_status_update_path}" >>${script}
	echo "wan_servicelist_path=${wan_servicelist_path}" >> ${script}
	echo "script_ip_down_path=${script_ip_down_path}" >> ${script}
	echo "script_ip_up_path=${script_ip_up_path}" >> ${script}
	echo "ppp6_lllocal_path=${ppp6_lllocal_path}" >> ${script}
	echo "ppp6_llremote_path=${ppp6_llremote_path}" >> ${script}
	echo "pppoe_proxy=${PPPC_ProxyEnable}" >> ${script}
	echo '
write_file "${ppp6_lllocal_path}" "${LLLOCAL}"
write_file "${ppp6_llremote_path}" "${LLREMOTE}"
write_file "${ppp_ifname_file_path}" "${IFNAME}"
write_file "${ppp_sessionid_path}" "${SESSIONID}"
if [ "${pppoe_proxy}" == "0" ]; then
	cs_cli /home/cli/api/intf/setppp -v ifname ${ifname} pppname ${IFNAME} enable 1 sessionid ${SESSIONID}
else
	ip6tables -I ${FLOW_ACCEL_CHAIN} -o ${ifname} -j MARK --set-mark 0x60000000/0xf0000000
	proxy_accel=`flowaccel show | grep "0x60000000/0xf0000000" | wc -l`
	if [ "${proxy_accel}" == "0" ]; then
		flowaccel add 0x60000000/0xf0000000 no
	fi
fi
cat /proc/uptime | cut -d . -f 1 > /tmp/.ppp.status
' >> ${script}
	
	echo "conn_folder=${conn_folder}" >> ${script}
	echo '. /usr/syscfg/wan.ip6connection.sh' >> ${script}
	echo 'ifname6=${IFNAME}' >> ${script}
	echo "ipconnection_start_routed_ipv6" >> ${script}
    
    echo "start_dual_lan_routed_normal_pppoe_v6" >> ${script}

	chmod +x ${script}
}

routed_normal_pppoe_gen_ip6_down_script()
{
	local script=$1
    local PPPC_ConnectionTrigger="$(cfgcmd get ${path}ConnectionTrigger)"
	echo "#!/bin/sh" > ${script}
	echo '. /usr/syscfg/firewall.param.sh' >> ${script}
	echo '. /usr/syscfg/wan.utils.sh' >> ${script}
	echo "path=${path}" >> ${script}
	echo "uptime_file_path=${ip6_uptime_file_path}" >> ${script}
	echo "ppp_ifname_file_path=${ppp_ifname_file_path}" >> ${script}
	echo "ppp_sessionid_path=${ppp_sessionid_path}" >> ${script}
	echo "wan_status_update_path=${wan_status_update_path}" >> ${script}
	echo "wan_servicelist_path=${wan_servicelist_path}" >> ${script}
	echo "ppp_demand_script_path=${ppp_demand_script_path}" >> ${script}
	echo "PPPC_ConnectionTrigger=${PPPC_ConnectionTrigger}" >> ${script}
	echo "ppp6_lllocal_path=${ppp6_lllocal_path}" >> ${script}
	echo "ppp6_llremote_path=${ppp6_llremote_path}" >> ${script}
	echo '

ip6tables -D ${FLOW_ACCEL_CHAIN} -o ${IFNAME} -j MARK --set-mark 0x60000000/0xf0000000
flowaccel del 0x60000000/0xf0000000 no

if [ -f ${uptime_file_path} ];then
	${wan_servicelist_path} action=stop ipmode=ipv6 path=${path}
	rm -f ${uptime_file_path}
	rm -f ${ppp_ifname_file_path}
	rm -f ${ppp_sessionid_path}
	rm -f ${ppp6_lllocal_path}
	rm -f ${ppp6_llremote_path}
fi

	cat /proc/uptime | cut -d . -f 1 > /tmp/.ppp.status

if [ "${PPPC_ConnectionTrigger}" == "OnDemand" ]; then
    ${ppp_demand_script_path}
fi
    stop_dual_lan_routed_normal_pppoe_v6
' >> ${script}
	chmod +x ${script}
}

#dongle专用
routed_normal_ppp_gen_chat_option()
{
        local options_file=$1
        local APN=`${GET_NODE} ${X_TRI_APN}`     
        local DialNumber=`${GET_NODE} ${X_TRI_DialNumber}`   

        echo "''
AT OK
AT+CFUN=1 OK
AT+CGDCONT=1,\"IP\",\"$APN\" OK
ATD${DialNumber}
CONNECT ''" > ${options_file}
}

#dongle专用
routed_normal_ppp_gen_option()
{
	local options_file=$1
	local DialDelay=`${GET_NODE} ${X_TRI_DialDelay}`  
	local Enable=`${GET_NODE} ${CanBeDial}`
	local USER=`${GET_NODE} ${X_TRI_USER}`
	local PASSWD=`${GET_NODE} ${X_TRI_PASSWD}` 
	local pin=`${GET_NODE} ${X_TRI_PIN}`
	local DEVF=`cfgcmd get InternetGatewayDevice.WANDevice.3.WANDongleInterfaceConfig.X_TRI_TTYDEV`


	if [ "" != "${pin}" ]; then
        /usr/sbin/chat -s -v ABORT 'ERROR' TIMEOUT 5 '' AT+CPIN=${pin} OK 1> ${DEVF}  0< ${DEVF} &
        sleep 1
	fi	
	
	echo "debug
nodetach
${DEVF}
9600
crtscts
show-password
usepeerdns
noauth
noipdefault
novj
novjccomp
noccp
nolock
mru 1444
persist
ipcp-accept-local
ipcp-accept-remote" > ${options_file}
	if [ "${USER}" != "" ];then                     
		echo "user ${USER}" >> ${options_file}          
	fi                                                                                                   
	if [ "${PASSWD}" != "" ];then                                                                        
		echo "password ${PASSWD}" >> ${options_file}                                                
	fi 
	echo "connect \"/usr/sbin/chat -s -v -f ${chat_options_path}"\" >> ${options_file}
	echo "ip-up-script ${ppp_ip_up_script_path}" >> $options_file
	echo "ip-down-script ${ppp_ip_down_script_path}" >> $options_file
}

routed_normal_pppoe_gen_option()
{
	local options_file=$1
	local PPPC_ServiceName="$(cfgcmd get ${path}PPPoEServiceName)"
	local PPPC_Username="$(cfgcmd get ${path}Username)"
	local PPPC_Password="$(cfgcmd get ${path}Password)"
	local PPPC_ConnectionTrigger="$(cfgcmd get ${path}ConnectionTrigger)"
	local PPPC_PPPLCPEcho="$(cfgcmd get ${path}PPPLCPEcho)"
	local PPPC_PPPLCPEchoRetry="$(cfgcmd get ${path}PPPLCPEchoRetry)"
	local PPPC_AutoDisconnectTime="$(cfgcmd get ${path}AutoDisconnectTime)"
	local PPPC_LimitRetryTime="$(cfgcmd get ${path}X_TRI_LimitRetryTime)"
	local PPPC_RetryTimes="$(cfgcmd get ${path}X_TRI_RetryTimes)"
	local PPPC_IdleDisconnectTime="$(cfgcmd get ${path}IdleDisconnectTime)"
	local PPPC_TRI_PPPAuthenticationProtocol="$(cfgcmd get ${path}X_TRI_PPPAuthenticationProtocol)"
	local PPPC_MaxMTUSize="$(cfgcmd get ${path}MaxMTUSize)"
	local PPPC_MaxMRUSize="$(cfgcmd get ${path}MaxMRUSize)"
	local DSLLinkType="$(cfgcmd get ${dsl_link_type_path})"
	local rp_pppoe_service_param=""

	if [ -z ${PPPC_MaxMTUSize} ]; then
		PPPC_MaxMTUSize=1492
	fi
	if [ -z ${PPPC_MaxMRUSize} ]; then
		PPPC_MaxMRUSize=1492
	fi

	echo "noauth" > $options_file
	echo "noccp" > $options_file
	echo "mtu ${PPPC_MaxMTUSize}" >> $options_file
	echo "mru ${PPPC_MaxMRUSize}" >> $options_file

	#PPP Authentication Protocol
	if [ ${PPPC_TRI_PPPAuthenticationProtocol} == "Auto" ]; then
		#echo "" >> $options_file
		:
	elif [ ${PPPC_TRI_PPPAuthenticationProtocol} == "PAP" ]; then
		echo "-chap -mschap -mschap-v2 refuse-eap" >> $options_file
	elif [ ${PPPC_TRI_PPPAuthenticationProtocol} == "CHAP" ]; then
		#echo "-pap -mschap -mschap-v2 refuse-eap" >> $options_file
		echo "-pap -mschap-v2 refuse-eap" >> $options_file
	elif [ ${PPPC_TRI_PPPAuthenticationProtocol} == "MS-CHAP" ]; then
		echo "-pap -chap refuse-eap" >> $options_file
	fi

	#echo "noauth" > $options_file
	echo "user '${PPPC_Username}'" >> $options_file
	echo "password '${PPPC_Password}'" >> $options_file
	echo "hide-password" >> $options_file
	echo "noipdefault" >> $options_file
	#echo "defaultroute" >> $options_file
	echo "nodetach" >> $options_file
	echo "usepeerdns" >> $options_file
	if [ "${PPPC_ConnectionTrigger}" == "AlwaysOn" ]; then
		echo "persist" >> $options_file
	elif [ "${PPPC_ConnectionTrigger}" == "OnDemand" ]; then
		echo "demand" >> $options_file
		echo "idle ${PPPC_IdleDisconnectTime}" >> $options_file
	fi

	#PPP interface unit number to use if possible
	#echo "unit ${wanindex} " >> $options_file
	
	case "${PPPC_IPMode}" in
	"1")
		#IPv4
		#specify the ip-up-script which will be call when ip up
		echo "ip-up-script ${ppp_ip_up_script_path}" >> $options_file
		echo "ip-down-script ${ppp_ip_down_script_path}" >> $options_file
		echo "ipcp-accept-remote" >> $options_file
		echo "ipcp-accept-local" >> $options_file
		if [ "${PPPC_ConnectionTrigger}" == "OnDemand" ]; then
			routed_normal_pppoe_gen_demand_script ${ppp_demand_script_path}
			echo "ip-demand-script ${ppp_demand_script_path}" >> $options_file
		fi
		;;
	"2")
		#IPv6
		echo "-ip" >> $options_file
		echo "+ipv6" >> $options_file
		echo "ipv6-up-script ${ppp_ip6_up_script_path}" >> $options_file 
		echo "ipv6-down-script ${ppp_ip6_down_script_path}" >> $options_file
		echo "ipv6cp-accept-local" >> $options_file 
#		echo "ipv6cp-use-persistent" >> $options_file 
		if [ "${PPPC_ConnectionTrigger}" == "OnDemand" ]; then
			local local_EUI64="$(get_random_EUI64)"
			local remote_EUI64="$(get_random_EUI64)"
			routed_normal_pppoe_gen_demand_script ${ppp_demand_script_path}
			echo "ipv6-demand-script ${ppp_demand_script_path}" >> $options_file
			echo "ipv6 ${local_EUI64},${remote_EUI64}" >> $options_file
		fi
		;;
	"3")
		#IPv4&6
		#specify the ip-up-script which will be call when ip up
		echo "ip-up-script ${ppp_ip_up_script_path}" >> $options_file
		echo "ip-down-script ${ppp_ip_down_script_path}" >> $options_file
		echo "ipcp-accept-remote" >> $options_file
		echo "ipcp-accept-local" >> $options_file
		echo "+ipv6" >> $options_file
		echo "ipv6-up-script ${ppp_ip6_up_script_path}" >> $options_file 
		echo "ipv6-down-script ${ppp_ip6_down_script_path}" >> $options_file
		echo "ipv6cp-accept-local" >> $options_file 
#		echo "ipv6cp-use-persistent" >> $options_file 
		if [ "${PPPC_ConnectionTrigger}" == "OnDemand" ]; then
			local local_EUI64="$(get_random_EUI64)"
			local remote_EUI64="$(get_random_EUI64)"
			routed_normal_pppoe_gen_demand_script ${ppp_demand_script_path}
			echo "ip-demand-script ${ppp_demand_script_path}" >> $options_file
			echo "ipv6-demand-script ${ppp_demand_script_path}" >> $options_file
			echo "ipv6 ${local_EUI64},${remote_EUI64}" >> $options_file
		fi
		;;
	esac
	echo "lcp-echo-failure ${PPPC_PPPLCPEchoRetry}" >> $options_file
	echo "lcp-echo-interval ${PPPC_PPPLCPEcho}" >> $options_file
	if [ "${PPPC_AutoDisconnectTime}" != "0" ]; then
		echo "maxconnect ${PPPC_AutoDisconnectTime}" >> $options_file
	fi
	if [ "${PPPC_LimitRetryTime}" == "1" ]; then
		echo "maxfail ${PPPC_RetryTimes}" >> $options_file
	fi
	echo "ktune" >> $options_file
	echo "default-asyncmap nopcomp noaccomp" >> $options_file
	echo "novj nobsdcomp nodeflate" >> $options_file


	if [ -n "${PPPC_ServiceName}" ]; then
		rp_pppoe_service_param=" rp_pppoe_service '${PPPC_ServiceName}' "
	fi

	if [ "${DSLLinkType}" == "PPPoA" ]; then
		local mac="`ifconfig ${ifname} | grep "HWaddr" | awk '{print$5s}'`"
		local sessid="`xtm_cli conn --getpoasid ${conn_ifname} | awk '{print $2}'`"

		echo "plugin ${pppoe_plugin_path}  ${rp_pppoe_service_param} rp_pppoe_sess ${sessid}:${mac} ppp_lowertype pppoa ${ifname}" >> $options_file
	else
		echo "plugin ${pppoe_plugin_path} ${rp_pppoe_service_param} ${ifname}" >> $options_file
	fi

}

routed_proxy_pppoe_gen_secrets()
{
	local secrets_file="/tmp/.chap-secrets"
	local PPPC_Username="$(cfgcmd get ${path}Username)"
	local PPPC_Password="$(cfgcmd get ${path}Password)"
	local pppoe_servers=`pidof pppoe-server`
	if [ -z "${pppoe_servers}" ]; then
		echo "#USERNAME  PROVIDER  PASSWORD  IPADDRESS" > ${secrets_file}
	fi
	sed -i "/^${PPPC_Username}/d" ${secrets_file}
	echo "${PPPC_Username} * ${PPPC_Password} *" >> ${secrets_file}
}

gen_down_script_routed_normal_pppoe()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "path=${path}" >> ${script}
	echo "pid_file_path=${pid_file_path}" >> ${script}
	echo "uptime_file_path=${uptime_file_path}" >> ${script}
	echo "ppp_ifname_file_path=${ppp_ifname_file_path}" >> ${script}
	echo "ppp_sessionid_path=${ppp_sessionid_path}" >> ${script}
	echo "server_assigned_dns_path=${server_assigned_dns_path}" >> ${script}
	echo "user_defined_dns_path=${user_defined_dns_path}" >> ${script}
	echo "ip_address_path=${ip_address_path}" >> ${script}
	echo "ip_remote_path=${ip_remote_path}" >> ${script}

	echo "ppp6_lllocal_path=${ppp6_lllocal_path}" >> ${script}
	echo "ppp6_llremote_path=${ppp6_llremote_path}" >> ${script}
	echo "conf_info_path=${conf_info_path}" >> ${script}
	echo "ppp_ip_up_script_path=${ppp_ip_up_script_path}" >> ${script}
	echo "pppoe_options_path=${pppoe_options_path}" >> ${script}
	echo "chat_options_path=${chat_options_path}" >> ${script}
	echo "wan_status_update_path=${wan_status_update_path}" >> ${script}
	echo '
local pid=`cat ${pid_file_path}`

if [ -n "${pid}" ]; then
        kill ${pid}
        #ip_down.sh will be automatically called when pppd receive SIGKILL signal.
fi
if [ -f ${uptime_file_path} ]; then
	#instead ip_down.sh with bellow code:
	rm -f ${uptime_file_path}
	rm -f ${server_assigned_dns_path}
	if [ -f ${user_defined_dns_path} ]; then
	  rm -f ${user_defined_dns_path}
	fi
	rm -f ${ip_address_path}
	rm -f ${ip_remote_path}
	rm -f ${ppp6_lllocal_path}
	rm -f ${ppp6_llremote_path}
	rm -f ${ppp_ifname_file_path}
	rm -f ${ppp_sessionid_path}
	${wan_status_update_path} path=${path}
fi
rm -f ${pid_file_path}
rm -f ${conf_info_path}
rm -f ${ppp_ip_up_script_path}
rm -f ${pppoe_options_path}
rm -f ${chat_options_path}
' >> ${script}
	chmod +x ${script}
}

#dongle专用
gen_down_script_routed_normal_ppp()
{
	local script=$1
	echo "#!/bin/sh" > ${script}
	echo "path=${path}" >> ${script}
	echo "pid_file_path=${pid_file_path}" >> ${script}
	echo "uptime_file_path=${uptime_file_path}" >> ${script}
	echo "ppp_ifname_file_path=${ppp_ifname_file_path}" >> ${script}
	echo "server_assigned_dns_path=${server_assigned_dns_path}" >> ${script}
	echo "user_defined_dns_path=${user_defined_dns_path}" >> ${script}
	echo "ip_address_path=${ip_address_path}" >> ${script}
	echo "ip_remote_path=${ip_remote_path}" >> ${script}

	echo "conf_info_path=${conf_info_path}" >> ${script}
	echo "ppp_ip_up_script_path=${ppp_ip_up_script_path}" >> ${script}
	echo "pppoe_options_path=${pppoe_options_path}" >> ${script}
	echo "chat_options_path=${chat_options_path}" >> ${script}
	echo "wan_status_update_path=${wan_status_update_path}" >> ${script}
	echo '
local pid=`cat ${pid_file_path}`

if [ -n "${pid}" ]; then
        kill ${pid}
        #ip_down.sh will be automatically called when pppd receive SIGKILL signal.
fi
if [ -f ${uptime_file_path} ]; then
	#instead ip_down.sh with bellow code:
	rm -f ${uptime_file_path}
	rm -f ${server_assigned_dns_path}
	if [ -f ${user_defined_dns_path} ]; then
	  rm -f ${user_defined_dns_path}
	fi
	rm -f ${ip_address_path}
	rm -f ${ip_remote_path}
	rm -f ${ppp6_lllocal_path}
	rm -f ${ppp6_llremote_path}
	rm -f ${ppp_ifname_file_path}
	rm -f ${ppp_sessionid_path}
	${wan_status_update_path} path=${path}
fi
rm -f ${pid_file_path}
rm -f ${conf_info_path}
rm -f ${ppp_ip_up_script_path}
rm -f ${pppoe_options_path}
rm -f ${chat_options_path}
' >> ${script}
	chmod +x ${script}
}



pppconnection_start_routed_normal_pppoe()
{
	local PPPC_NATEnabled="$(cfgcmd get ${path}NATEnabled)"
	local PPPC_ConnectionTrigger="$(cfgcmd get ${path}ConnectionTrigger)"
	local PPPC_MACAddress="$(cfgcmd get ${path}MACAddress)"
	local PPPC_MACAddressOverride="$(cfgcmd get ${path}MACAddressOverride)"
	
	ifconfig ${ifname} down
	if [ "${PPPC_MACAddressOverride}" == "1" -a -n "${PPPC_MACAddress}"  ]; then
	        ifconfig ${ifname} hw ether ${PPPC_MACAddress}
	fi
	ifconfig ${ifname} up

	write_file ${conf_info_path} "NATEnabled=${PPPC_NATEnabled}"	
	if [ "${PPPC_NATEnabled}" == "0" ]; then
		cs_cli /home/cli/api/intf/setfwd -v ifname ${ifname} fwd 2
	fi
	#generate script which will be called when ip-up
	routed_normal_pppoe_gen_ip_up_script ${ppp_ip_up_script_path}
	routed_normal_pppoe_gen_ip_down_script ${ppp_ip_down_script_path}
	#generate script which will be called when ip6-up
	routed_normal_pppoe_gen_ip6_up_script ${ppp_ip6_up_script_path}
	routed_normal_pppoe_gen_ip6_down_script ${ppp_ip6_down_script_path}
	#generate pppoe options file
	routed_normal_pppoe_gen_option ${pppoe_options_path}
	gen_down_script_routed_normal_pppoe "${script_ip_down_path}/900_normal_pppoe.sh"
	#call pppd
	pppd file ${pppoe_options_path} &
	echo "$!" > ${pid_file_path}
		
}




pppconnection_start_routed_pppoe_proxy()
{
	local PPPC_NATEnabled="$(cfgcmd get ${path}NATEnabled)"
	local PPPC_MACAddress="$(cfgcmd get ${path}MACAddress)"
	local PPPC_MACAddressOverride="$(cfgcmd get ${path}MACAddressOverride)"
	local MaxUsers="$(cfgcmd get ${path}X_CT-COM_MAXUser)"
	
	ifconfig ${ifname} down
	if [ "${PPPC_MACAddressOverride}" == "1" -a -n "${PPPC_MACAddress}"  ]; then
	        ifconfig ${ifname} hw ether ${PPPC_MACAddress}
	fi
	ifconfig ${ifname} up

	write_file ${conf_info_path} "NATEnabled=${PPPC_NATEnabled}"	
	if [ "${PPPC_NATEnabled}" == "0" ]; then
		cs_cli /home/cli/api/intf/setfwd -v ifname ${ifname} fwd 2
	fi
	#generate script which will be called when ip-up
	routed_normal_pppoe_gen_ip_up_script ${ppp_ip_up_script_path}
	routed_normal_pppoe_gen_ip_down_script ${ppp_ip_down_script_path}
	#generate pppoe options file
	routed_normal_pppoe_gen_option ${pppoe_options_path}
	gen_down_script_routed_normal_pppoe "${script_ip_down_path}/900_normal_pppoe.sh"
	#call pppoe-server
	routed_proxy_pppoe_gen_secrets
	pppoe-server -I br0 -k -N ${MaxUsers} -A -W ${pppoe_options_path} -X ${pid_file_path} &
}

#dongle专用
pppconnection_start_routed_normal_ppp()
{	
	APN=`${GET_NODE} ${X_TRI_APN}`
	DialNumber=`${GET_NODE} ${X_TRI_DialNumber}`
	DialDelay=`${GET_NODE} ${X_TRI_DialDelay}`
	if [ "$APN" != "" ] && [ "$DialNumber" != "" ]; then
		
		if [ "$DialDelay" != "0" ];then
			${SLEEP} $DialDelay
		fi
		sleep 1
		pppd file ${pppoe_options_path} &
		echo "$!" > ${pid_file_path}
	fi
}

pppconnection_start_routed_ppp_proxy()
{
	#call pppoe-server
	routed_proxy_ppp_gen_secrets
	pppoe-server -I br0 -k -N ${MaxUsers} -A -W ${pppoe_options_path} -X ${pid_file_path} &
}

#dongle专用
ppp_conntion_start_routed()
{
	#local PPPC_ProxyEnable="$(cfgcmd get ${path}X_CT-COM_ProxyEnable)"
	local PPPC_NATEnabled="$(cfgcmd get ${path}NATEnabled)"

	write_file ${conf_info_path} "NATEnabled=${PPPC_NATEnabled}"

	routed_normal_ppp_gen_ip_up_script ${ppp_ip_up_script_path}
	routed_normal_ppp_gen_ip_down_script ${ppp_ip_down_script_path}
	routed_normal_ppp_gen_chat_option ${chat_options_path}
	routed_normal_ppp_gen_option ${pppoe_options_path}
	gen_down_script_routed_normal_ppp "${script_ip_down_path}/900_normal_pppoe.sh"
	###gen_down_script_routed_normal_ppp "${script_ip_down_path}/900_normal_pppoe.sh"

	#if [ "${PPPC_ProxyEnable}" == "0" ]; then
		pppconnection_start_routed_normal_ppp
	#elif [ "${PPPC_ProxyEnable}" == "1" ]; then
		#pppconnection_start_routed_ppp_proxy
	#fi
}

pppconnection_start_routed()
{
	local PPPC_ProxyEnable="$(cfgcmd get ${path}X_CT-COM_ProxyEnable)"
	PPPC_IPMode="$(cfgcmd get ${path}X_CT-COM_IPMode)"

	if [ "${PPPC_IPMode}" == "1" ]; then
		echo 1 > /proc/sys/net/ipv6/conf/${ifname}/disable_ipv6
	else
		echo 0 > /proc/sys/net/ipv6/conf/${ifname}/disable_ipv6
	fi

	if [ "${PPPC_ProxyEnable}" == "0" ]; then
		pppconnection_start_routed_normal_pppoe
	elif [ "${PPPC_ProxyEnable}" == "1" ]; then
		pppconnection_start_routed_pppoe_proxy
	fi
}

pppconnection_start_routed_bridged()
{
	/usr/syscfg/vlan_tagging.sh "wan_path=${path}" "down_dir=${script_ip_down_path}"
	return
}

pppconnection_start_bridged()
{
	/usr/syscfg/vlan_tagging.sh "wan_path=${path}" "down_dir=${script_ip_down_path}"
	#use IP_Bridged to implement wan bridged connection.
	return;
}

pppconnection_start()
{
	local PPPC_Enable="$(cfgcmd get ${path}Enable)"

	#check if this pppconnection has been enabled
	if [ "${PPPC_Enable}" != "1" ]; then
		return
	fi

	write_file ${ifname_file_path} "${ifname}"

	if [ "${path}" != "InternetGatewayDevice.WANDevice.3.WANConnectionDevice.1.WANPPPConnection.1." ];then
		local PPPC_ConnectionType="$(cfgcmd get ${path}ConnectionType)"
		if [ "${PPPC_ConnectionType}" == "IP_Routed" ]; then
			pppconnection_start_routed
		elif [ "${PPPC_ConnectionType}" == "Bridged_Routed" ]; then
			pppconnection_start_routed_bridged
		elif [ "${PPPC_ConnectionType}" == "PPPoE_Bridged" ]; then
			pppconnection_start_bridged
		fi
		#update wan mac 
		local mac="`ifconfig ${ifname} | grep "HWaddr" | awk '{print$5s}'`" 
		if [ -n "${mac}" ]; then 
			cfgcmd sset ${path}MACAddress ${mac} 
		fi 
	else
		${Dongle_Clear}
		sleep 5
		ppp_conntion_start_routed
	fi
	cfgcmd sset ${path}Reset 0

	## set vlan tagging
	#/usr/syscfg/vlan_tagging.sh "wan_path=${path}" "down_dir=${script_ip_down_path}"
}

pppconnection_stop()
{
	if [ ! -f ${ifname_file_path} ];then
		return
	fi

	local wan_ifname=`cat ${ifname_file_path}`
	if [ "${wan_ifname}" != "ppp_3_1_1" ];then
	echo 0 > /proc/sys/net/ipv4/conf/${wan_ifname}/forwarding
	fi

	local scripts=`expr ${script_ip_down_path}"/*"`
	for i in $scripts; do
		if [ -x "$i" ]; then
			${i}
		fi
	done


	if [ "${path}" != "InternetGatewayDevice.WANDevice.3.WANConnectionDevice.1.WANPPPConnection.1." ];then
	cs_cli /home/cli/api/mc/del_member -v ifname ${wan_ifname}
	cs_cli /home/cli/debug/app/mc/clear_grpusr_info -v ifname ${wan_ifname}
	fi

	/usr/syscfg/wan.backup.sh ${path} "down"
    

	rm -rf ${script_ip_down_path}/*
	rm -f ${ifname_file_path}
        return;
}

###################################################################
case "$action" in
	"start")
		pppconnection_start
		;;
	"stop")
		pppconnection_stop
		;;
	"restart")
		pppconnection_stop
		pppconnection_start
		;;
	*)
		pppconnection_help
		;;
esac
rm -f ${pppconnection_lock_flag}
