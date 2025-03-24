#!/bin/sh

route_mode=`uci get system.route.operationmode`

iwpriv apcli0 set ApCliEnable=0
iwpriv apclii0 set ApCliEnable=0

if [ "$route_mode" == "wisp" ];then
	wisp_mode=`uci get internet.wisp.wisp_type`
	if [ "$wisp_mode" == "2.4G" ];then
		/sbin/wifi_connect.sh apcli0
	else
		/sbin/wifi_connect.sh apclii0
	fi
fi

if [ "$route_mode" == "repeater" ];then
        repeater_mode=`uci get internet.repeater.repeater_type`
        if [ "$repeater_mode" == "2.4G" ];then
                /sbin/wifi_connect.sh apcli0
        else
                /sbin/wifi_connect.sh apclii0
        fi
fi



