#!/bin/ash

. /usr/share/libubox/jshn.sh

if [ -f "/tmp/set_time_zone" ];then
	exit 0
fi

getdata=`curl -s http://ip-api.com/json`

if [ ${#getdata} -gt 0 ];then
	json_init
	json_load "$getdata"
	
	json_get_var zonename timezone
	
	echo "zonename:$zonename"
	
	if [ ${#zonename} -eq 0 ];then
		echo "get zonename failed"
		exit 0
	fi
	
	json_init
	tz_data=$(cat /etc/timezone_file)
	json_load "$tz_data"
	
	json_get_var timezone_value $zonename
	
	echo "timezone_value:$timezone_value"
	
	if [ ${#timezone_value} -eq 0 ];then
		echo "get timezone_value failed"
		exit 0
	fi
	
	uci set system.@system[0].zonename="$zonename"
	uci set system.@system[0].timezone="$timezone_value"
	uci commit system
	
	/etc/init.d/system restart
	touch /tmp/set_time_zone
else
	echo "get failed"
	
	tz_now=`uci get system.@system[0].timezone`
	if [ "$tz_now" == "UTC" ];then
		uci set system.@system[0].zonename='Asia/Shanghai'
		uci set system.@system[0].timezone='CST-8'
		uci commit system
		/etc/init.d/system restart
	fi

	exit 0
fi

