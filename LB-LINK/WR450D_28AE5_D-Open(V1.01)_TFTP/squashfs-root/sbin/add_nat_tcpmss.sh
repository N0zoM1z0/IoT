#!/bin/sh /etc/rc.common

. /usr/share/libubox/jshn.sh

start() {
	lan=`uci get -q network.lan.ipaddr | awk -F"." '{print $1"."$2"."$3"."0}'`
	wan=`uci get -q network.wan.ifname`
	wan_proto=`uci get -q network.wan.proto`
	if [ "$lan" != "" ] && [ "$wan" != "" ]; then
		if [ "$wan_proto" == "pppoe" ];then
			json_load "$(ubus call network.interface.wan status)"
			json_get_var device "l3_device"
			iptables -wt nat -D POSTROUTING -s $lan/24 -o $device -j MASQUERADE
			iptables -t mangle -D POSTROUTING -o $device -p tcp -m tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu  
			iptables -wt nat -A POSTROUTING -s $lan/24 -o $device -j MASQUERADE
			iptables -t mangle -I POSTROUTING -o $device -p tcp -m tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu  
		else
			iptables -wt nat -D POSTROUTING -s $lan/24 -o $wan -j MASQUERADE
			iptables -wt nat -A POSTROUTING -s $lan/24 -o $wan -j MASQUERADE
		fi
	fi
}

start

