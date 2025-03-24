#!/bin/sh

curr_mode=`uci get system.route.operationmode`
conntype=`uci get system.route.conntype`
wan_dev=`uci get network.wan.ifname`

if [ "$curr_mode" == "router" -a "$conntype" == "dhcp" ]; then
	br_traverse_ipv6=`uci get network.lan.br_traverse_ipv6`
	if [ "$br_traverse_ipv6" = "1" ];then
		brctl addif br-lan $wan_dev

		ebtables -t broute -D BROUTING -i br-lan -p ! ipv6 -j DROP
		ebtables -t broute -D BROUTING -i $wan_dev   -p ! ipv6 -j DROP
		ebtables -t broute -A BROUTING -i br-lan -p ! ipv6 -j DROP
		ebtables -t broute -A BROUTING -i $wan_dev   -p ! ipv6 -j DROP
	else
		brctl delif br-lan $wan_dev
		ebtables -t broute -F
	fi
else
	brctl delif br-lan $wan_dev
	ebtables -t broute -F
fi
