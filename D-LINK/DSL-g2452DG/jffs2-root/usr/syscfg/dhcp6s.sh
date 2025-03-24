#!/bin/sh
. /usr/syscfg/ipv6.utils.sh
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/wan.comm.param.sh

RADVD_PATH="InternetGatewayDevice.LANDevice.1.X_CT-COM_IPv6LANHostConfigManagement.RadvdConfig"
DHCP6S_PATH="InternetGatewayDevice.LANDevice.1.X_CT-COM_DHCPv6Server"
IPV6_CFG_PATH="InternetGatewayDevice.LANDevice.1.X_CT-COM_IPv6Config"

DHCP6S_Br0_FILE=/var/dhcpv6/br0.conf
DHCP6S_Br1_FILE=/var/dhcpv6/br1.conf
DHCP6S_Br0_STOP_SCRIPT=/var/dhcp6sbr0stop.sh

Dhcp6sConfig_set()
{
	local DHCP6sEnable=`cfgcmd get ${DHCP6S_PATH}.Enabled`
	local DNSType=`cfgcmd get ${IPV6_CFG_PATH}.IPv6DNSConfigType`
	
	local CameraPdType=`cfgcmd get ${DHCP6S_PATH}.X_CT-COM_DHCPv6Camera.PrefixConfigType`
	local CameraPd=`cfgcmd get ${DHCP6S_PATH}.X_CT-COM_DHCPv6Camera.StaticPrefix`
	local STBPdType=`cfgcmd get ${DHCP6S_PATH}.X_CT-COM_DHCPv6STB.PrefixConfigType`
	local STBPd=`cfgcmd get ${DHCP6S_PATH}.X_CT-COM_DHCPv6STB.StaticPrefix`
	local PhonePdType=`cfgcmd get ${DHCP6S_PATH}.X_CT-COM_DHCPv6Phone.PrefixConfigType`
	local PhonePd=`cfgcmd get ${DHCP6S_PATH}.X_CT-COM_DHCPv6Phone.StaticPrefix`

	local SLAACEnable=`cfgcmd get ${RADVD_PATH}.SLAACEnabled`

	if [ ${DNSType} == "WANConnection" ]; then
		local conn_path=`cfgcmd get ${IPV6_CFG_PATH}.IPv6DNSWANConnection`
		if [ -n "$conn_path" ]; then
			local IP6C_DNSAddressSource=`cfgcmd get ${conn_path}X_CT-COM_IPv6DNSAddressSource`
			if [ "${IP6C_DNSAddressSource}" == "Static" ]; then
				ip6_dns_path=`expr /tmp/$(gen_wanconn_folder ${conn_path})/${IP6_USER_DEFINED_DNS}`
			else
				ip6_dns_path=`expr /tmp/$(gen_wanconn_folder ${conn_path})/${IP6_SERVER_ASSIGNED_DNS}`
			fi
			DNSID=`cat ${ip6_dns_path}`
		else
			DNSID="fe80::1"
		fi
	elif [ ${DNSType} == "HGWProxy" ]; then
		DNSID="fe80::1"
	else
		DNSID=`cfgcmd get ${IPV6_CFG_PATH}.IPv6DNSServers`
	fi

	[ ! -e /var/dhcpv6/dhcp6sctlkey ] && `dd if=/dev/urandom count=1 2> /dev/null | md5sum | cut -d" " -f1 > /var/dhcpv6/dhcp6sctlkey`

	if [ -f ${DHCP6S_Br0_STOP_SCRIPT} ]; then
		${DHCP6S_Br0_STOP_SCRIPT}
		rm ${DHCP6S_Br0_STOP_SCRIPT}
	fi
	
	echo "#!/bin/sh" > ${DHCP6S_Br0_STOP_SCRIPT}
	echo "killall -q dhcp6s" >> ${DHCP6S_Br0_STOP_SCRIPT}

	if [ -e ${DHCP6S_Br0_FILE} ]; then
		rm ${DHCP6S_Br0_FILE}
	fi

	if [ -e ${DHCP6S_Br1_FILE} ]; then
		rm ${DHCP6S_Br1_FILE}
	fi
	
	if [ -n "${DNSID}" ]; then
		echo "option domain-name-servers ${DNSID};" >> ${DHCP6S_Br0_FILE}
	fi
	if [ "${SLAACEnable}" == "1" ]; then
		echo "interface br0 {" >> ${DHCP6S_Br0_FILE}
		echo "	allow rapid-commit;" >> ${DHCP6S_Br0_FILE}
		echo "	preference 200;" >> ${DHCP6S_Br0_FILE}
		echo "};" >> ${DHCP6S_Br0_FILE}
	else
		local MaxPrefix=`cfgcmd get_max_obj ${IPV6_CFG_PATH}.PrefixInformation`
		local InstNum=1
		
		while [ ${InstNum} -le ${MaxPrefix} ]
		do
			local PrefixMode=`cfgcmd get ${IPV6_CFG_PATH}.PrefixInformation.${InstNum}.Mode`
		
			if [ "${PrefixMode}" == "Static" ]; then
				local Prefix=`cfgcmd get ${IPV6_CFG_PATH}.PrefixInformation.${InstNum}.Prefix`
				local PrefixID="${Prefix}/64"
				local PrefixprefTime=`cfgcmd get ${IPV6_CFG_PATH}.PrefixInformation.${InstNum}.PreferredLifeTime`
				local PrefixvaildTime=`cfgcmd get ${IPV6_CFG_PATH}.PrefixInformation.${InstNum}.ValidLifeTime`			
			fi
		
			if [ "${PrefixMode}" == "WANDelegated" ]; then
				local DelegatedWanPath=`cfgcmd get ${IPV6_CFG_PATH}.PrefixInformation.${InstNum}.DelegatedWanConnection`
				if [ -n "${DelegatedWanPath}" ]; then
					local PrefixID=`cfgcmd get ${DelegatedWanPath}X_CT-COM_IPv6Prefix`
				fi
			fi
		
			if [ -n "${PrefixID}" ]; then
				echo "host Computer" >> ${DHCP6S_Br0_FILE}
				echo "{" >> ${DHCP6S_Br0_FILE}
				echo "	prefix ${PrefixID} 3600;" >> ${DHCP6S_Br0_FILE}
				echo "};" >> ${DHCP6S_Br0_FILE}

			local paddr=`GenEui64 ${PrefixID} br0`
			ip -6 addr add ${paddr} dev br0

			echo "ip -6 addr del ${paddr} dev br0" >> ${DHCP6S_Br0_STOP_SCRIPT}
			echo "ip -6 r del ${PrefixID} dev br0" >> ${DHCP6S_Br0_STOP_SCRIPT}
			fi
	
			InstNum=`expr ${InstNum} + 1`
		done
	
		if [ "${CameraPdType}" == "Static" ]; then
			echo "host Camera" >> ${DHCP6S_Br0_FILE}
			echo "{" >> ${DHCP6S_Br0_FILE}
			echo "	prefix ${CameraPd}/64 3600;" >> ${DHCP6S_Br0_FILE}
			echo "};" >> ${DHCP6S_Br0_FILE}
		fi
		if [ "${STBPdType}" == "Static" ]; then
			echo "host STB" >> ${DHCP6S_Br0_FILE}
			echo "{" >> ${DHCP6S_Br0_FILE}
			echo "	prefix ${STBPd}/64 3600;" >> ${DHCP6S_Br0_FILE}
			echo "};" >> ${DHCP6S_Br0_FILE}
		fi
		if [ "${PhonePdType}" == "Static" ]; then
			echo "host Phone" >> ${DHCP6S_Br0_FILE}
			echo "{" >> ${DHCP6S_Br0_FILE}
			echo "	prefix ${PhonePd}/64 3600;" >> ${DHCP6S_Br0_FILE}
			echo "};" >> ${DHCP6S_Br0_FILE}
		fi
	fi


	echo "option domain-name-servers fe80::2;" >> ${DHCP6S_Br1_FILE}
	echo "interface br1 {" >> ${DHCP6S_Br1_FILE}
	echo "	allow rapid-commit;" >> ${DHCP6S_Br1_FILE}
	echo "	preference 200;" >> ${DHCP6S_Br1_FILE}
	echo "};" >> ${DHCP6S_Br1_FILE}
	
	chmod +x ${DHCP6S_Br0_STOP_SCRIPT}
	dhcp6s -c $DHCP6S_Br0_FILE -f br0 -k /var/dhcpv6/dhcp6sctlkey &
#	dhcp6s -c $DHCP6S_Br1_FILE -f br1 -k /var/dhcpv6/dhcp6sctlkey &

}
########################################################################
case "$1" in	
	"set")
		Dhcp6sConfig_set
		;;
	*)
		;;
esac

