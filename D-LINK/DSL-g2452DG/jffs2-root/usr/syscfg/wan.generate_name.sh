#!/bin/sh
#描述：生成wan连接的名称
#输入：path - 指向wanc的path，比如InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.


local wanName=""
local ServiceList=""
local ConnectionType=""
local wanType=""
local X_TRI_VlanID=""

#参数检查
for para in $*
do
	export $para
done

if [ -z $path ]; then
	echo  "[$0] parameter cannot be empty!"
	exit 1
fi


wanName=`echo "${path}" | awk -F "." '{print $3"_"$5"_"$7}'`


ServiceList=`cfgcmd get ${path}X_CT-COM_ServiceList`
ServiceList=`echo ${ServiceList} |tr  "," "_"` #把逗号修改成下划线，好无聊的工作>_<
wanName=$wanName"_"$ServiceList

ConnectionType=`cfgcmd get ${path}ConnectionType`
if [ "$ConnectionType" == "IP_Routed" ]; then
	wanName=$wanName"_R"
elif [ "$ConnectionType" == "PPPoE_Bridged" -o "$ConnectionType" == "IP_Bridged" ]; then
	wanName=$wanName"_B"
elif [ "$ConnectionType" == "Con_Bridged" ]; then
	wanName=$wanName"_CB"
elif [ "$ConnectionType" == "Unconfigured" ]; then
	wanName=$wanName"_Unconfigured"
else
	echo  "[$0] Unknown ConnectionType!"
	exit 1
fi


wanType=`echo ${path} | awk -F '.' '{print $6}'`
if [ "$wanType" == "WANPPPConnection" ]; then
	wanName=$wanName"_PPP"
elif [ "$wanType" == "WANIPConnection" ]; then
	wanName=$wanName"_IP"
else
	echo  "[$0] Unknown wanType!"
	exit 1
fi


X_TRI_VlanID=`cfgcmd get ${path}X_TRI_VlanID`
if [ "$X_TRI_VlanID" != "-1" ]; then
	wanName=$wanName"_VID_"$X_TRI_VlanID
fi

cfgcmd sset ${path}Name $wanName > /dev/null

