#!/bin/sh 
local parameterNum=`echo "${QUERY_STRING}" | grep -o ? | wc -l`
local provider=`cfgcmd get InternetGatewayDevice.DeviceInfo.X_TRI_Provider`
local DSL_StandardsSupported_path="InternetGatewayDevice.WANDevice.1.WANDSLInterfaceConfig.StandardsSupported"

if [ ${parameterNum} -ge 3 ]
then
	local useLevel=`echo "${QUERY_STRING}" | cut -d ? -f 2`
	local webPassword_realtext=`echo "${QUERY_STRING}" | cut -d ? -f 3`
	local webPassword=`echo "${QUERY_STRING}" | cut -d ? -f 4`
	if [ "1" = ${useLevel} ]
	then
		cfgcmd set InternetGatewayDevice.X_CT-COM_UserInfo.UserList.1.Password_realtext  ${webPassword_realtext}
		cfgcmd set InternetGatewayDevice.X_CT-COM_UserInfo.UserList.1.Password  ${webPassword}
	elif [ "2" = ${useLevel} ]
	then
		cfgcmd set InternetGatewayDevice.X_CT-COM_UserInfo.UserList.2.Password_realtext  ${webPassword_realtext}
		cfgcmd set InternetGatewayDevice.X_CT-COM_UserInfo.UserList.2.Password  ${webPassword}
    else [ "3" = ${useLevel} ]
	fi
fi
if [ ${provider} = "ADSL_Streamyx" ];then
	local DSL_StandardsSupported=`cfgcmd get ${DSL_StandardsSupported_path}`
	local tmp="${DSL_StandardsSupported}"
	#½«G.993.2_Annex_A£¬G.993.2_Annex_B£¬G.993.2_Annex_C ÓÃ¿Õ×Ö·û´úÌæ
	tmp=`echo ${tmp//",G.993.2_Annex_A"/""}`
	tmp=`echo ${tmp//",G.993.2_Annex_B"/""}`
	tmp=`echo ${tmp//",G.993.2_Annex_C"/""}`
	
	cfgcmd set ${DSL_StandardsSupported_path} ${tmp}
else
	local DSL_StandardsSupported_tmp=`cat "/etc/default"|grep ""${DSL_StandardsSupported_path}`
	local DSL_StandardsSupported=${DSL_StandardsSupported_tmp##*=}
	
	cfgcmd set ${DSL_StandardsSupported_path} ${DSL_StandardsSupported}
fi

index=5
let "parameterNum++"
while [ ${index} -le ${parameterNum} ]
do
	FPath=`echo "${QUERY_STRING}" | cut -d ? -f ${index}`
	cfgcmd del_obj ${FPath}
	let "index++"
done

echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: text/html"
echo ""

