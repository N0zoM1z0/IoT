#!/bin/sh 
VoIPPath="InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1"
provider=`cfgcmd get InternetGatewayDevice.DeviceInfo.X_TRI_Provider`

 setVoIPConfig()
 {
	cfgcmd set ${VoIPPath}.SIP.UserAgentPort  ${1}		
	cfgcmd set ${VoIPPath}.SIP.RegistrarServer ${2}
	cfgcmd set ${VoIPPath}.SIP.ProxyServer ${3}
	cfgcmd set ${VoIPPath}.SIP.OutboundProxy ${4}
	cfgcmd set ${VoIPPath}.SIP.OutboundProxyPort ${5}
		
	cfgcmd set ${VoIPPath}.SIP.X_CT-COM_Standby-RegistrarServer ${6}
	cfgcmd set ${VoIPPath}.SIP.X_CT-COM_Standby-ProxyServer  ${7}
	cfgcmd set ${VoIPPath}.SIP.X_CT-COM_Standby-OutboundProxy  ${8}
	cfgcmd set ${VoIPPath}.SIP.X_CT-COM_Standby-OutboundProxyPort  ${9}

	cfgcmd set ${VoIPPath}.SIP.RegisterExpires  ${10}
	cfgcmd set ${VoIPPath}.SIP.X_TRI-LinkTest  ${11}
	cfgcmd set ${VoIPPath}.SIP.X_TRI-LinkTestInterval ${12}
	cfgcmd set ${VoIPPath}.SIP.RegisterRetryInterval  ${13}
	cfgcmd set ${VoIPPath}.P-Asserted-Identity ${14}	
 }
 
if [ "ADSL_Streamyx" != ${provider} ]
then 
	 parameterNum=`echo "${QUERY_STRING}" | grep -o ? | wc -l`
	if [ ${parameterNum} == 6 ]
	then
		 INPUT_VoIP1=`echo "${QUERY_STRING}" | cut -d ? -f 2`
		 INPUT_VoIP1UserName=`echo "${QUERY_STRING}" | cut -d ? -f 3`
		 INPUT_VoIP1PassWord=`echo "${QUERY_STRING}" | cut -d ? -f 4`
		 INPUT_VoIP2=`echo "${QUERY_STRING}" | cut -d ? -f 5`
		 INPUT_VoIP2UserName=`echo "${QUERY_STRING}" | cut -d ? -f 6`
		 INPUT_VoIP2PassWord=`echo "${QUERY_STRING}" | cut -d ? -f 7`	

		 case ${provider} in
		"TM_Unifi"):
			setVoIPConfig "5060" "ims.tm.com.my" "10.255.0.1" "10.255.0.1" "5060" "ims.tm.com.my" "10.255.0.1" "10.255.0.1" "5060" "1200" "0" "20" "3600" "0"
		;;
		"ADSL_Streamyx"):
		;;
		"Maxis_Fibre"):
			setVoIPConfig "5060" "homesip.maxis.com.my" "bvgw01.maxis.com.my" "bvgw01.maxis.com.my" "5060" "homesip.maxis.com.my" "bvgw01.maxis.com.my" "bvgw01.maxis.com.my"  "5060" "1200" "0" "20" "3600" "0"
		;;
		"Other_Fibre_VDSL"):
		;;
		"Time_Fibre"):
		;;
		"VDSL_Bridge"):
			setVoIPConfig "5060" "ims.tm.com.my" "10.255.0.1" "10.255.0.1" "5060" "ims.tm.com.my" "10.255.0.1" "10.255.0.1" "5060" "1200" "0" "20" "3600" "0"		
		;;
		esac
		
		cfgcmd set ${VoIPPath}.Line.1.Enable ${INPUT_VoIP1}
		cfgcmd set ${VoIPPath}.Line.1.SIP.AuthUserName ${INPUT_VoIP1UserName}
		cfgcmd set ${VoIPPath}.Line.1.SIP.AuthPassword ${INPUT_VoIP1PassWord}
		cfgcmd set ${VoIPPath}.Line.2.Enable ${INPUT_VoIP2}
		cfgcmd set ${VoIPPath}.Line.2.SIP.AuthUserName ${INPUT_VoIP2UserName}
		cfgcmd set ${VoIPPath}.Line.2.SIP.AuthPassword ${INPUT_VoIP2PassWord}
		 
	fi
fi

echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: text/html"
echo ""

