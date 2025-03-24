#!/bin/sh
. /usr/syscfg/ipv6.utils.sh
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/wan.comm.param.sh

RADVD_PATH="InternetGatewayDevice.LANDevice.1.X_CT-COM_IPv6LANHostConfigManagement.RadvdConfig"
IPV6_CFG_PATH="InternetGatewayDevice.LANDevice.1.X_CT-COM_IPv6Config"
iface="$2"

LinkLocalAddr_set()
{
	local oldAddr=`ifconfig ${iface} | grep fe80 | awk '{ print $3 }'`
	local newAddr="fe80::1/64"
	
	if [ "${oldAddr}" != "${newAddr}" ]; then
		ip -6 addr add ${newAddr} dev ${iface} 
		ip -6 addr del ${oldAddr} dev ${iface} 
	fi
}

RadvdConfig_set()
{
	RADVD_FILE=/var/radvd_${iface}.conf
	RADVD_STOP_SCRIPT=/var/radvdstop_${iface}.sh

    local existed=`brctl show | grep ${iface}`
    if [ "${existed}" == "" ];then
        return
    fi
	
	local SLAACEnable=`cfgcmd get ${RADVD_PATH}.SLAACEnabled`
	local MaxRtrAdvInterval=`cfgcmd get ${RADVD_PATH}.MaxRAInterval`
	local MinRtrAdvInterval=`cfgcmd get ${RADVD_PATH}.MinRAInterval`
	local AdvManagedFlag=`cfgcmd get ${RADVD_PATH}.ManagedFlag`
	local AdvOtherConfFlag=`cfgcmd get ${RADVD_PATH}.OtherConfFlag`
	local UniqueLocalPrefixFlag=`cfgcmd get ${RADVD_PATH}.UniqueLocalPrefixConfig.Enable`
	local UniqLocID=`cfgcmd get ${RADVD_PATH}.UniqueLocalPrefixConfig.GlobalID`
	local FlagConfType=`cfgcmd get ${RADVD_PATH}.FlagConfType`

	#11:22:33:44:55 ==> fd11:2233:4455
	local UniqueLocalPrefix="fd${UniqLocID:0:2}:${UniqLocID:3:2}${UniqLocID:6:2}:${UniqLocID:9:2}${UniqLocID:12:2}"

	local AdvDefaultLifetime=`expr 3 \* ${MaxRtrAdvInterval}`

	local MaxPrefix=`cfgcmd get_max_obj ${IPV6_CFG_PATH}.PrefixInformation`
	local InstNum=1

	LinkLocalAddr_set
	if [ -f ${RADVD_STOP_SCRIPT} ];then
		${RADVD_STOP_SCRIPT}
		rm ${RADVD_STOP_SCRIPT}
	fi
	
	if [ -f ${RADVD_FILE} ]; then
		rm $RADVD_FILE
	fi
	
	echo "#!/bin/sh" > ${RADVD_STOP_SCRIPT}
#	echo "killall -q radvd" >> ${RADVD_STOP_SCRIPT}

    echo "local intf=${iface}" >> ${RADVD_STOP_SCRIPT}
    echo -n 'local radvd_pids="$(ps | grep radvd_${intf}.conf | grep "radvd -C" | ' >> ${RADVD_STOP_SCRIPT}
    echo "awk '{print \$1}' )\" "  >> ${RADVD_STOP_SCRIPT}
    echo 'for pid in ${radvd_pids}' >> ${RADVD_STOP_SCRIPT}
    echo 'do' >>  ${RADVD_STOP_SCRIPT}
    echo '      kill -9 ${pid}' >> ${RADVD_STOP_SCRIPT}
    echo 'done' >> ${RADVD_STOP_SCRIPT}

	echo "interface ${iface} 
{" >> ${RADVD_FILE}

	echo "	AdvSendAdvert on;" >> ${RADVD_FILE}

	if [ "${FlagConfType}" == "Auto" ]; then
		if [ ${SLAACEnable} == "1" ]; then
			echo "	AdvOtherConfigFlag on;" >> ${RADVD_FILE}
			echo "	AdvManagedFlag off;" >> ${RADVD_FILE}
		else
			echo "	AdvOtherConfigFlag on;" >> ${RADVD_FILE}
			echo "	AdvManagedFlag on;" >> ${RADVD_FILE}
		fi
	else

		if [ ${AdvOtherConfFlag} == "1" ]; then
			echo "	AdvOtherConfigFlag on;" >> ${RADVD_FILE}
		else
			echo "	AdvOtherConfigFlag off;" >> ${RADVD_FILE}
		fi
		if [ ${AdvManagedFlag} == "1" ]; then
			echo "	AdvManagedFlag on;" >> ${RADVD_FILE}
		else
			echo "	AdvManagedFlag off;" >> ${RADVD_FILE}
		fi
	fi

	echo "	MinRtrAdvInterval ${MinRtrAdvInterval};" >> ${RADVD_FILE}
	echo "	MaxRtrAdvInterval ${MaxRtrAdvInterval};" >> ${RADVD_FILE}
	echo "	AdvDefaultPreference medium;" >> ${RADVD_FILE}
	echo "	AdvDefaultLifetime ${AdvDefaultLifetime};" >> ${RADVD_FILE}

	if [ "${UniqueLocalPrefixFlag}" == "1" ]; then
	echo "	prefix ${UniqueLocalPrefix}::/64
	{
		AdvOnLink on;
		AdvAutonomous on;
		AdvRouterAddr off;
		AdvValidLifetime 86400;
		AdvPreferredLifetime 14400;
	};" >> $RADVD_FILE
	
	local addr=`GenEui64 ${UniqueLocalPrefix}::/64 ${iface}`
	ip -6 addr add ${addr} dev ${iface} 

	echo "ip -6 addr del ${addr} dev ${iface}" >> ${RADVD_STOP_SCRIPT}
	echo "ip -6 r del ${UniqueLocalPrefix}::/64 dev ${iface}" >> ${RADVD_STOP_SCRIPT}
	fi

#if [ ${SLAACEnable} == "1" ]; then
# android phone not support dhcpv6
if [ "1" == "1" ]; then
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
				if [ -n "${PrefixID}"]; then
				local PrefixID=`cfgcmd get ${DelegatedWanPath}X_CT-COM_IPv6Prefix`
					local PreLen=`echo $PrefixID | cut -d '/' -f 2`
					local PreStr=`echo $PrefixID | cut -d '/' -f 1`
					if [ "$PreLen" -lt "64" ];then 
						PrefixID=${PreStr}/64
					fi
				fi 
			fi
		fi

        # update ipunnum's prefix ID
        if [ "${iface}" != "br0" -a -n "${PrefixID}" ]; then

            local duallan_idx=`echo ${iface:7}`
            if [ "${duallan_idx}" == "" ]; then
                echo "FAIL. Invalid interface ${iface} !!!"
                return
            fi
            local pref=`echo $PrefixID | awk -F '::/' '{ printf $1 }'`
            local prefLen=`echo $PrefixID | awk -F '::/' '{ printf $2 }'`
            local prefix1=`echo $pref | awk -F ':' '{ printf $1 }'`
            local prefix2=`echo $pref | awk -F ':' '{ printf $2 }'`
            local prefix3=`echo $pref | awk -F ':' '{ printf $3 }'`
            local prefix4=`echo $pref | awk -F ':' '{ printf $4 }'`

            if [ "${prefix1}" == "" ]; then
                prefix1="0"
            fi
            if [ "${prefix2}" == "" ]; then
                prefix2="0"
            fi
            if [ "${prefix3}" == "" ]; then
                prefix3="0"
            fi
            if [ "${prefix4}" == "" ]; then
                prefix4="0"
            fi
            let "prefix4=${prefix4}+${duallan_idx}"
            PrefixID="${prefix1}:${prefix2}:${prefix3}:${prefix4}::/${prefLen}"
        fi

		
		if [ -n "${PrefixID}" ]; then
				echo "	prefix ${PrefixID}" >> $RADVD_FILE
				echo "	{" >> $RADVD_FILE
				echo "		AdvOnLink on;" >> $RADVD_FILE
				echo "		AdvAutonomous on;" >> $RADVD_FILE
				echo "		AdvRouterAddr off;" >> $RADVD_FILE
				echo "		AdvValidLifetime 86400;" >> $RADVD_FILE
				echo "		AdvPreferredLifetime 14400;" >> $RADVD_FILE
				echo "	};" >> $RADVD_FILE
	
		local paddr=`GenEui64 ${PrefixID} ${iface}`
		ip -6 addr add ${paddr} dev ${iface} 

		echo "ip -6 addr del ${paddr} dev ${iface}" >> ${RADVD_STOP_SCRIPT}
		echo "ip -6 r del ${PrefixID} dev ${iface}" >> ${RADVD_STOP_SCRIPT}
		fi
	
		InstNum=`expr ${InstNum} + 1`
	done
	
	local DNSType=`cfgcmd get ${IPV6_CFG_PATH}.IPv6DNSConfigType`
	if [ ${DNSType} == "WANConnection" ]; then
		local conn_path=`cfgcmd get ${IPV6_CFG_PATH}.IPv6DNSWANConnection`
			local IP6C_DNSAddressSource=`cfgcmd get ${conn_path}X_CT-COM_IPv6DNSAddressSource`
			if [ "${IP6C_DNSAddressSource}" == "Static" ]; then
				ip6_dns_path=`expr /tmp/$(gen_wanconn_folder ${conn_path})/${IP6_USER_DEFINED_DNS}`
			else
				ip6_dns_path=`expr /tmp/$(gen_wanconn_folder ${conn_path})/${IP6_SERVER_ASSIGNED_DNS}`
			fi
			DNSID=`cat ${ip6_dns_path}`

	elif [ ${DNSType} == "HGWProxy" ]; then
		DNSID="fe80::1"
	else
		DNSID=`cfgcmd get ${IPV6_CFG_PATH}.IPv6DNSServers`
	fi
	
	if [ -n "${DNSID}" ]; then
		local lifetime=`expr ${MaxRtrAdvInterval} \* 2`
		echo "	RDNSS ${DNSID}" >> $RADVD_FILE
		echo "	{" >> $RADVD_FILE
		echo "		AdvRDNSSOpen on;" >> $RADVD_FILE
		echo "		AdvRDNSSLifetime ${lifetime};" >> $RADVD_FILE
		echo "	};" >> $RADVD_FILE
	fi
fi

	echo "};" >> $RADVD_FILE
	
	chmod +x ${RADVD_STOP_SCRIPT}
	radvd -C $RADVD_FILE -d 1 &

	# save ${iface} Global IPV6 address
    if [ "${iface}" == "br0" ]; then
	    local lanipv6address=`ifconfig ${iface} | grep Global | awk '{print $3}' | cut -d / -f 1`
        cfgcmd sset InternetGatewayDevice.LANDevice.1.X_CT-COM_IPv6Config.PrefixInformation.1.X_TRI-LanIPv6Address "${lanipv6address}"
    fi
}
########################################################################
case "$1" in	
	"set")
		RadvdConfig_set
		;;
	*)
		;;
esac

