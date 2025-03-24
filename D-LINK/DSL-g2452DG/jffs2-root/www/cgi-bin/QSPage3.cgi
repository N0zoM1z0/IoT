#!/bin/sh  
provider=`cfgcmd get InternetGatewayDevice.DeviceInfo.X_TRI_Provider`
if [ ${provider} != "VDSL_Bridge" ]
then 
	 parameterNum=`echo "${QUERY_STRING}" | grep -o ? | wc -l`
	if [ ${parameterNum} == 6 ]
	then
		 Wireless24g=`echo "${QUERY_STRING}" | cut -d ? -f 2`
		 Wireless24gSSID=`echo "${QUERY_STRING}" | cut -d ? -f 3`
		 Wireless24gPassphrase=`echo "${QUERY_STRING}" | cut -d ? -f 4`
		 Wireless5g=`echo "${QUERY_STRING}" | cut -d ? -f 5`
		 Wireless5gSSID=`echo "${QUERY_STRING}" | cut -d ? -f 6`
		 Wireless5gPassphrase=`echo "${QUERY_STRING}" | cut -d ? -f 7`
     WLANPath="InternetGatewayDevice.LANDevice.1.WLANConfiguration"
		#2.4g
		cfgcmd set ${WLANPath}.1.Enable ${Wireless24g} 
		cfgcmd set ${WLANPath}.1.SSID  ${Wireless24gSSID} 
		cfgcmd set ${WLANPath}.1.PreSharedKey.1.PreSharedKey ${Wireless24gPassphrase} 
		#5g
		cfgcmd set ${WLANPath}.5.Enable ${Wireless5g} 
		cfgcmd set ${WLANPath}.5.SSID  ${Wireless5gSSID} 
		cfgcmd set ${WLANPath}.5.PreSharedKey.1.PreSharedKey ${Wireless5gPassphrase} 
		#passphrase type
		if [ ${Wireless24g} != 0 -o ${Wireless5g} != 0 ]
		then
			LANIndex=1
			for LANIndex in 1 2 3 4 5 6 7 8
			do
				cfgcmd set ${WLANPath}.${LANIndex}.BeaconType "11i"   #Authentication
			done
		fi
	fi
else
  WLANPath="InternetGatewayDevice.LANDevice.1.WLANConfiguration"
	cfgcmd set ${WLANPath}.1.Enable 0
	cfgcmd set ${WLANPath}.5.Enable 0
fi

echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: text/html"
echo ""

