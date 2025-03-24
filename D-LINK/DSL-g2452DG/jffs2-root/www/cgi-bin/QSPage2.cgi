#!/bin/sh

parameterNum=`echo "${QUERY_STRING}" | grep -o ? | wc -l`
provider=`cfgcmd get InternetGatewayDevice.DeviceInfo.X_TRI_Provider`
index_one=0
index_two=0
index_three=0
dualIndex=0
wanCMode=""
wanName=""
wanPath=""
dualPath=""
lan_4_Path="InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.1"
lan_3_Path="InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.2"
lan_2_Path="InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.3"
lan_1_Path="InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.4"
WLAN_1_Path="InternetGatewayDevice.LANDevice.1.WLANConfiguration.1"
WLAN_2_Path="InternetGatewayDevice.LANDevice.1.WLANConfiguration.2"
WLAN_3_Path="InternetGatewayDevice.LANDevice.1.WLANConfiguration.3"
WLAN_4_Path="InternetGatewayDevice.LANDevice.1.WLANConfiguration.4"
WLAN_5_Path="InternetGatewayDevice.LANDevice.1.WLANConfiguration.5"
WLAN_6_Path="InternetGatewayDevice.LANDevice.1.WLANConfiguration.6"
WLAN_7_Path="InternetGatewayDevice.LANDevice.1.WLANConfiguration.7"
WLAN_8_Path="InternetGatewayDevice.LANDevice.1.WLANConfiguration.8"

setPPP_Wan()
{
	wanCMode="WANPPPConnection"
	cfgcmd set InternetGatewayDevice.DeviceInfo.X_CT-COM_UPNP.Enable 1
	if [ "ADSL_Streamyx" = ${provider} ]
	then
		#ATM-PPPoE
	  index_one=1
		index_two=`cfgcmd add_obj InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.`
		cfgcmd set InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.WANDSLLinkConfig.Enable 1
		cfgcmd set InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.WANDSLLinkConfig.LinkType EoA
		cfgcmd set InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.WANDSLLinkConfig.DestinationAddress "PVC:0/35"
		cfgcmd set InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.WANDSLLinkConfig.ATMEncapsulation "LLC"
		index_three=`cfgcmd add_obj InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.${wanCMode}.`				
		wanName="ADSL_${index_two}_${index_three}"	
	else
		if [ "PTM" = ${WANmode} ]
		then	
		#PTM-PPPoE
			index_one=1
			index_two=`cfgcmd add_obj InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.`
			cfgcmd set InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.WANPTMLinkConfig.Enable 1
			index_three=`cfgcmd add_obj InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.${wanCMode}.`
					
			wanName="VDSL_${index_two}_${index_three}"	
		elif [ "ETH" = ${WANmode} ] 
		then
		#ETH-PPPoE
			index_one=2
			index_two=`cfgcmd add_obj InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.`
			index_three=`cfgcmd add_obj InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.${wanCMode}.`
		  wanName="ETH_${index_two}_${index_three}"		
		fi
	fi
	wanPath="InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.${wanCMode}.${index_three}"
	cfgcmd set ${wanPath}.Username ${INPUT_UserName}
	cfgcmd set ${wanPath}.Password ${INPUT_Password}		
	#static  IP
	cfgcmd set ${wanPath}.X_TRI_UnnumberEn ${INPUT_Static_IP}
	if [ "1" == ${INPUT_Static_IP} ]
	then
		dualIndex=`cfgcmd add_obj InternetGatewayDevice.Layer2Bridging.Bridge.`
		dualPath="InternetGatewayDevice.Layer2Bridging.Bridge.${dualIndex}.X_TRI_DualLanCfg"
		cfgcmd set ${dualPath}.Enable 1
		cfgcmd set ${dualPath}.AddrMode 1
		cfgcmd set ${dualPath}.IpAddr	${INPUT_UnnumberPPPIP}
		cfgcmd set ${dualPath}.IpUnnumberedAddr ${INPUT_UnnumberLanIP}
		cfgcmd set ${dualPath}.IpUnnumberedMask ${INPUT_Subnet}
		cfgcmd set ${dualPath}.LanStartIp ${INPUT_StartIP}
		cfgcmd set ${dualPath}.LanEndIp ${INPUT_StopIP}
		cfgcmd set ${dualPath}.PrimaryDns ${PrimaryDns}
		cfgcmd set ${dualPath}.SecondaryDns ${SecondaryDns}		
		cfgcmd set ${dualPath}.WanConnPath  "${wanPath}"
		cfgcmd set ${wanPath}.X_TRI_UnnumberLanPath  "InternetGatewayDevice.Layer2Bridging.Bridge.${dualIndex}."

		brPath="InternetGatewayDevice.Layer2Bridging.Bridge.${dualIndex}"
		cfgcmd set "${brPath}.BridgeName" "bripunnum${dualIndex}"
	fi
}
setIP_Wan()
{
	wanCMode="WANIPConnection"
	if [ "PTM" = ${WANmode} ]
	then	
	#PTM
	  index_one=1
		index_two=`cfgcmd add_obj InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.`
		cfgcmd set InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.WANPTMLinkConfig.Enable 1
		index_three=`cfgcmd add_obj InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.${wanCMode}.`		
		wanName="VDSL_${index_two}_${index_three}"	
	elif [ "ETH" = ${WANmode} ] 
	then
	#ETH
		index_one=2
		index_two=`cfgcmd add_obj InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.`
		index_three=`cfgcmd add_obj InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.${wanCMode}.`
		wanName="ETH_${index_two}_${index_three}"	
	elif [ "ATM" = ${WANmode} ]
	then
	#ATM
	  index_one=1
		index_two=`cfgcmd add_obj InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.`
		cfgcmd set InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.WANDSLLinkConfig.Enable 1
		cfgcmd set InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.WANDSLLinkConfig.LinkType EoA
		cfgcmd set InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.WANDSLLinkConfig.DestinationAddress "PVC:0/35"
		index_three=`cfgcmd add_obj InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.${wanCMode}.`
				
		wanName="ADSL_${index_two}_${index_three}"	
	fi
	wanPath="InternetGatewayDevice.WANDevice.${index_one}.WANConnectionDevice.${index_two}.${wanCMode}.${index_three}"
	cfgcmd set ${wanPath}.AddressingType ${1}
}

setWan()
{
	if [ ${1} = "IP_Routed" ]
	then
		case ${2} in
		"DHCP"):
			setIP_Wan "DHCP"
		;;
    "PPPoE"):
			setPPP_Wan
		;;
		"Static"):
			setIP_Wan "Static"
		;;
		esac
		cfgcmd set ${wanPath}.MaxMTUSize 1492
	else
		setIP_Wan "DHCP"
	fi	
	cfgcmd set ${wanPath}.Name  ${wanName}
	cfgcmd set ${wanPath}.Enable 1
	cfgcmd set ${wanPath}.NATEnabled 1
	cfgcmd set ${wanPath}.ConnectionType ${1}
	cfgcmd set ${wanPath}.X_CT-COM_ServiceList ${3}
	cfgcmd set ${wanPath}.X_TRI_VlanID ${4}
}

setIPMode()
{
	#ipv4&6
	if [ "0" == ${1} ]
	then
	    cfgcmd set  ${wanPath}.X_CT-COM_IPMode  1   #IPv4
	    return
	fi
	
	if [ "1" == ${1} ]
	then
	  cfgcmd set  ${wanPath}.X_CT-COM_IPMode  3
	  
	  if [ 4 -eq $#  ]
	  then
		    cfgcmd set  ${wanPath}.X_CT-COM_IPv6IPAddressOrigin  ${2}   #getIPAdress
		    cfgcmd set  ${wanPath}.X_CT-COM_IPv6PrefixDelegationEnabled  ${3}   #PD
		    cfgcmd set  ${wanPath}.X_CT-COM_IPv6DNSAddressSource ${4}
		fi
		
	fi
}

Tm_Unifi_Config()
{
	#第一条WAN
	setWan "IP_Routed" "PPPoE"	"INTERNET"	500	
	cfgcmd set ${wanPath}.X_TRI_VlanPriority 0     #802.1P
	setIPMode ${INPUT_IPv6} "AutoConfigured" 1  "DHCPv6"
	LanPortStr=""
	#LAN端口绑定
	if [ "1" = ${VoIPOnLan3} -a "1" = ${IPTVOnLan4} ]
	then
	  LanPortStr="${lan_1_Path},${lan_2_Path}"
		cfgcmd set  ${wanPath}.X_CT-COM_LanInterface "${lan_1_Path},${lan_2_Path},${WLAN_1_Path},${WLAN_2_Path},${WLAN_3_Path},${WLAN_4_Path},${WLAN_5_Path},${WLAN_6_Path},${WLAN_7_Path},${WLAN_8_Path}"
	elif [ "0" = ${VoIPOnLan3} -a "1" = ${IPTVOnLan4} ]
	then
	  LanPortStr="${lan_1_Path},${lan_2_Path},${lan_3_Path}"
		cfgcmd set  ${wanPath}.X_CT-COM_LanInterface "${lan_1_Path},${lan_2_Path},${lan_3_Path},${WLAN_1_Path},${WLAN_2_Path},${WLAN_3_Path},${WLAN_4_Path},${WLAN_5_Path},${WLAN_6_Path},${WLAN_7_Path},${WLAN_8_Path}"
	elif [ "1" = ${VoIPOnLan3} -a "0" = ${IPTVOnLan4} ]
	then
	LanPortStr="${lan_1_Path},${lan_2_Path},${lan_4_Path}"
		cfgcmd set  ${wanPath}.X_CT-COM_LanInterface "${lan_1_Path},${lan_2_Path},${lan_4_Path},${WLAN_1_Path},${WLAN_2_Path},${WLAN_3_Path},${WLAN_4_Path},${WLAN_5_Path},${WLAN_6_Path},${WLAN_7_Path},${WLAN_8_Path}"
	elif [ "0" = ${VoIPOnLan3} -a "0" = ${IPTVOnLan4} ]
	then
		LanPortStr="${lan_1_Path},${lan_2_Path},${lan_3_Path},${lan_4_Path}"
		cfgcmd set  ${wanPath}.X_CT-COM_LanInterface "${lan_1_Path},${lan_2_Path},${lan_3_Path},${lan_4_Path},${WLAN_1_Path},${WLAN_2_Path},${WLAN_3_Path},${WLAN_4_Path},${WLAN_5_Path},${WLAN_6_Path},${WLAN_7_Path},${WLAN_8_Path}"
	fi
	#Unnumbered端口绑定
	if [ "1" == ${INPUT_Static_IP} ]
	then	
		cfgcmd set ${dualPath}.LanPort ${LanPortStr} 
	fi
	
	#第二条WAN
	setWan "IP_Bridged" NULL "OTHER" 600
	cfgcmd set ${wanPath}.X_TRI_VlanPriority 5     #802.1P
	setIPMode  1   #IPv4/IPv6
	if [ "1" = ${IPTVOnLan4} ]
	then
		cfgcmd set ${wanPath}.X_CT-COM_LanInterface ${lan_4_Path}
	fi	
	#第三条WAN
	setWan "Con_Bridged" NULL "VOIP" 400
	cfgcmd set ${wanPath}.X_TRI_VlanPriority 5     #802.1P
	if [ "1" = ${VoIPOnLan3} ]
	then
		cfgcmd set ${wanPath}.X_CT-COM_LanInterface ${lan_3_Path}
	fi
}

Maxis_Fibre_Config()
{   
	#第一条wan
	setWan "IP_Routed" "PPPoE" "INTERNET" 621  
	cfgcmd set ${wanPath}.X_TRI_VlanPriority 0     #802.1P
	setIPMode ${INPUT_IPv6} "AutoConfigured" 1  "DHCPv6"    #ipv6
	#LAN/WLAN端口绑定
	cfgcmd set  ${wanPath}.X_CT-COM_LanInterface "${lan_1_Path},${lan_2_Path},${lan_3_Path},${lan_4_Path},${WLAN_1_Path},${WLAN_2_Path},${WLAN_3_Path},${WLAN_4_Path},${WLAN_5_Path},${WLAN_6_Path},${WLAN_7_Path},${WLAN_8_Path}"
	#Unnumbered端口绑定
	if [ "1" == ${INPUT_Static_IP} ]
	then
		cfgcmd set ${dualPath}.LanPort "${lan_1_Path},${lan_2_Path},${lan_3_Path},${lan_4_Path}"
	fi
	#第二条wan
	setWan "IP_Routed" "DHCP" "VOIP" 822
	if [ "ETH" = ${WANmode} ]
	then
		cfgcmd set ${wanPath}.X_TRI_VlanPriority  4    #802.1P
		cfgcmd set ${wanPath}.MaxMTUSize 1500
	elif [ "PTM" = ${WANmode} ]
	then
		cfgcmd set ${wanPath}.X_TRI_VlanPriority  4    #802.1P
		cfgcmd set ${wanPath}.MaxMTUSize 1500
	fi
	setIPMode 0     #ipv4
	#第三条wan
	setWan "IP_Routed" "DHCP" "OTHER" 823
	cfgcmd set ${wanPath}.X_TRI_VlanPriority 0     #802.1P
	cfgcmd set ${wanPath}.MaxMTUSize 1500
	setIPMode 1 "DHCPv6" 1  "DHCPv6"    #ipv6
	#igmp configurations for the third wan
	cfgcmd set InternetGatewayDevice.X_CT-COM_Multicast.IGMPProxy.WANVersion 3
	cfgcmd set InternetGatewayDevice.X_CT-COM_Multicast.IGMPProxy.LANVersion 2
	cfgcmd set InternetGatewayDevice.X_CT-COM_Multicast.IGMPProxy.WANPathName ${wanPath}.
}

Time_Fibre_Config()
{
	setWan "IP_Routed" "PPPoE" "INTERNET" -1
	cfgcmd set ${wanPath}.X_TRI_VlanPriority 5     #802.1P
	setIPMode ${INPUT_IPv6} "AutoConfigured" 1  "DHCPv6"
	cfgcmd set  ${wanPath}.X_CT-COM_LanInterface "${lan_1_Path},${lan_2_Path},${lan_3_Path},${lan_4_Path},${WLAN_1_Path},${WLAN_2_Path},${WLAN_3_Path},${WLAN_4_Path},${WLAN_5_Path},${WLAN_6_Path},${WLAN_7_Path},${WLAN_8_Path}"
	if [ "1" == ${INPUT_Static_IP} ]
	then
		cfgcmd set ${dualPath}.LanPort "${lan_1_Path},${lan_2_Path},${lan_3_Path},${lan_4_Path}"
	fi
}

Other_Fibre_VDSL_Config()
{
	if [ ${parameterNum} -ge 19 ]
	then
		Vlan_ID=`echo "${QUERY_STRING}" | cut -d ? -f 20`
	else
		Vlan_ID=500
	fi
	setWan "IP_Routed" "PPPoE" "INTERNET" ${Vlan_ID}
	cfgcmd set ${wanPath}.X_TRI_VlanPriority 0     #802.1P
	setIPMode ${INPUT_IPv6} "AutoConfigured" 1  "DHCPv6"
	cfgcmd set  ${wanPath}.X_CT-COM_LanInterface "${lan_1_Path},${lan_2_Path},${lan_3_Path},${lan_4_Path},${WLAN_1_Path},${WLAN_2_Path},${WLAN_3_Path},${WLAN_4_Path},${WLAN_5_Path},${WLAN_6_Path},${WLAN_7_Path},${WLAN_8_Path}"
	if [ "1" == ${INPUT_Static_IP} ]
	then
		cfgcmd set ${dualPath}.LanPort "${lan_1_Path},${lan_2_Path},${lan_3_Path},${WLAN_1_Path},${WLAN_2_Path},${WLAN_3_Path},${WLAN_4_Path},${WLAN_5_Path},${WLAN_6_Path},${WLAN_7_Path},${WLAN_8_Path}"
	fi
	
}

ADSL_Streamyx_Config()
{
	setWan "IP_Routed" "PPPoE" "INTERNET" -1
	setIPMode ${INPUT_IPv6} "AutoConfigured" 1  "DHCPv6"
	cfgcmd set  ${wanPath}.X_CT-COM_LanInterface "${lan_1_Path},${lan_2_Path},${lan_3_Path},${lan_4_Path},${WLAN_1_Path},${WLAN_2_Path},${WLAN_3_Path},${WLAN_4_Path},${WLAN_5_Path},${WLAN_6_Path},${WLAN_7_Path},${WLAN_8_Path}"
	if [ "1" == ${INPUT_Static_IP} ]
	then
		cfgcmd set ${dualPath}.LanPort "${lan_1_Path},${lan_2_Path},${lan_3_Path},${lan_4_Path}"
	fi	
}

VDSL_Bridge_Config()
{
	setWan "IP_Bridged" NULL "INTERNET" 500
	setIPMode  1   #IPv4/IPv6
	cfgcmd set ${wanPath}.X_TRI_VlanPriority  0    #802.1P
	cfgcmd set ${wanPath}.X_TRI_VlanTaggingIf "${lan_1_Path}."
	
	setWan "Con_Bridged" NULL "VOIP" 400
	cfgcmd set ${wanPath}.X_TRI_VlanPriority  5    #802.1P
	cfgcmd set ${wanPath}.X_TRI_VlanTaggingIf "${lan_1_Path}."
	cfgcmd set ${wanPath}.X_CT-COM_LanInterface ${lan_3_Path}
	
	setWan "IP_Bridged" NULL "OTHER" 600
	setIPMode  1   #IPv4/IPv6
	cfgcmd set ${wanPath}.X_TRI_VlanPriority  5    #802.1P
	cfgcmd set ${wanPath}.X_TRI_VlanTaggingIf "${lan_1_Path}."
	
	setWan "Con_Bridged" NULL "TR069" 209
	cfgcmd set ${wanPath}.X_TRI_VlanPriority  -1    #802.1P
	cfgcmd set ${wanPath}.X_TRI_VlanTaggingIf "${lan_1_Path}."
	cfgcmd set ${wanPath}.X_CT-COM_LanInterface ${lan_4_Path}
	
	WANmode="PTM"
	if [ ${parameterNum} -ge 18 ]
	then
		newWAN1=`echo "${QUERY_STRING}" | cut -d ? -f 16`
		newWAN2=`echo "${QUERY_STRING}" | cut -d ? -f 17`
		newWAN3=`echo "${QUERY_STRING}" | cut -d ? -f 18`
		newWAN4=`echo "${QUERY_STRING}" | cut -d ? -f 19`
	fi
	
	for WANInfo in ${newWAN1} ${newWAN2} ${newWAN3} ${newWAN4}
	do
		VLANID=`echo "${WANInfo}" | cut -d , -f 1`
		if [ ${VLANID} = "NULL" ]
		then
			continue
		fi
		VPriori=`echo "${WANInfo}" | cut -d , -f 2`
		LANTag2=`echo "${WANInfo}" | cut -d , -f 3`
		LANTag3=`echo "${WANInfo}" | cut -d , -f 4`
		LANTag4=`echo "${WANInfo}" | cut -d , -f 5`
		
		setWan "IP_Bridged" NULL "OTHER" ${VLANID}
		setIPMode 1
		if [ "undefined" != ${VPriori} ] 
		then
			cfgcmd set ${wanPath}.X_TRI_VlanPriority ${VPriori}
		fi
		#绑定LANTag
		LANTagStr=""
		if [ "1" = ${LANTag2} ]
		then
			LANTagStr=${lan_2_Path}
		fi
		
		if [ "1" = ${LANTag3} ]
		then
			LANTagStr="${LANTagStr},${lan_3_Path}"
		fi
		
		if [ "1" = ${LANTag4} ]
		then
			LANTagStr="${LANTagStr},${lan_4_Path}"
		fi
		cfgcmd set ${wanPath}.X_TRI_VlanTaggingIf "${LANTagStr}."
	done
}

if [ ${parameterNum} -ge 14 ]
then
	WANmode=`echo "${QUERY_STRING}" | cut -d ? -f 2`
	INPUT_UserName=`echo "${QUERY_STRING}" | cut -d ? -f 3`
	INPUT_Password=`echo "${QUERY_STRING}" | cut -d ? -f 4`
	INPUT_IPv6=`echo "${QUERY_STRING}" | cut -d ? -f 5`
	INPUT_Static_IP=`echo "${QUERY_STRING}" | cut -d ? -f 6`
	INPUT_UnnumberLanIP=`echo "${QUERY_STRING}" | cut -d ? -f 7`
	INPUT_UnnumberPPPIP=`echo "${QUERY_STRING}" | cut -d ? -f 8`
	INPUT_Subnet=`echo "${QUERY_STRING}" | cut -d ? -f 9`
	INPUT_StartIP=`echo "${QUERY_STRING}" | cut -d ? -f 10`
	INPUT_StopIP=`echo "${QUERY_STRING}" | cut -d ? -f 11`
	PrimaryDns=`echo "${QUERY_STRING}" | cut -d ? -f 12`
	SecondaryDns=`echo "${QUERY_STRING}" | cut -d ? -f 13`
	VoIPOnLan3=`echo "${QUERY_STRING}" | cut -d ? -f 14`
	IPTVOnLan4=`echo "${QUERY_STRING}" | cut -d ? -f 15`
	
	case ${provider} in 
	"TM_Unifi"):
		Tm_Unifi_Config
	;;
	"ADSL_Streamyx"):
		ADSL_Streamyx_Config
	;;
	"Maxis_Fibre"):
		Maxis_Fibre_Config
	;;
	"Other_Fibre_VDSL"):
		Other_Fibre_VDSL_Config
	;;
	"Time_Fibre"):
		Time_Fibre_Config
	;;
	"VDSL_Bridge"):
		VDSL_Bridge_Config
	;;
	esac
fi

`nvram commit`

echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: text/html"
echo ""

