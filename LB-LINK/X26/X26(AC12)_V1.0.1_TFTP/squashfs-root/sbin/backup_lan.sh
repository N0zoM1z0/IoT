#!/bin/sh

route_mode=`uci get system.route.operationmode`

lan_ip=`uci get network.lan.ipaddr`
lan_netmask=`uci get network.lan.netmask`

if [ "$route_mode" == "router" ];then
	uci set system.route.lan_ipaddr=$lan_ip
	uci set system.route.lan_netmask=$lan_netmask

	uci commit system
fi
