#!/bin/sh

local Type=$1
local Domain=$2
local ip=""
local index=0

if [ "${Type}" == "1" ];then
    for ip in $Domain;
    do
        if [ $index == 0 ];then
        cfgcmd set InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.ProxyServer "$ip"
        cfgcmd oset InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.OutboundProxy "$ip"
        elif [ $index == 1 ];then
        cfgcmd set InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.X_CT-COM_Standby-ProxyServer "$ip"
        cfgcmd oset InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.X_CT-COM_Standby-OutboundProxy "$ip"
        fi
        index=`expr $index + 1`
    done
else
    for ip in $Domain;
    do
        local host=`ping resolv_only $ip`
        if [ -n "$host" ];then
            if [ $index == 0 ];then
            cfgcmd set InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.ProxyServer "$host"
            cfgcmd oset InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.OutboundProxy "$host"
            elif [ $index == 1 ];then
            cfgcmd set InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.X_CT-COM_Standby-ProxyServer "$host"
            cfgcmd oset InternetGatewayDevice.Services.VoiceService.1.VoiceProfile.1.SIP.X_CT-COM_Standby-OutboundProxy "$host"
            fi
            index=`expr $index + 1`
        fi
    done
fi

