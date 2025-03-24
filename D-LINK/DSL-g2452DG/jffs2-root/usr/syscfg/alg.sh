#!/bin/sh

ALG_PATH="InternetGatewayDevice.DeviceInfo.X_CT-COM_ALGAbility"



###################################################################
ALGAbility_set()
{
	local ALG_TFTPEnable=`cfgcmd get "${ALG_PATH}.TFTPEnable"`
	local ALG_FTPEnable=`cfgcmd get "${ALG_PATH}.FTPEnable"`
	local ALG_PPTPEnable=`cfgcmd get "${ALG_PATH}.PPTPEnable"`
	local ALG_RTSPEnable=`cfgcmd get "${ALG_PATH}.RTSPEnable"`
	local ALG_L2TPEnable=`cfgcmd get "${ALG_PATH}.L2TPEnable"`
	local ALG_H323Enable=`cfgcmd get "${ALG_PATH}.H323Enable"`
	local ALG_SIPEnable=`cfgcmd get "${ALG_PATH}.SIPEnable"`
	local ALG_IPSECEnable=`cfgcmd get "${ALG_PATH}.IPSECEnable"`
	
	echo tftp ${ALG_TFTPEnable} > /proc/alg
	echo ftp ${ALG_FTPEnable} > /proc/alg
	echo pptp ${ALG_PPTPEnable} > /proc/alg
	echo rtsp ${ALG_RTSPEnable} > /proc/alg
	echo l2tp ${ALG_L2TPEnable} > /proc/alg
	echo h323 ${ALG_H323Enable} > /proc/alg
	if [ ! -f "/tmp/.e8c" ];then
		echo sip ${ALG_SIPEnable} > /proc/alg
	fi
	echo ipsec ${ALG_IPSECEnable} > /proc/alg

	iptables -t filter -D alg_filter -p udp -m multiport --dport 1701 -j DROP 2> /dev/null 
	iptables -t filter -D alg_filter -p udp -m multiport --dport 500,4500 -j DROP 2> /dev/null 
	if [ "$ALG_L2TPEnable" != "1" ]; then
		iptables -t filter -A alg_filter -p udp -m multiport --dport 1701 -j DROP
	fi
	if [ "$ALG_IPSECEnable" != "1" ]; then
		iptables -t filter -A alg_filter -p udp -m multiport --dport 500,4500 -j DROP
	fi
}

###################################################################
case "$1" in
	"set")
		ALGAbility_set
		;;
	*)
		;;
esac
