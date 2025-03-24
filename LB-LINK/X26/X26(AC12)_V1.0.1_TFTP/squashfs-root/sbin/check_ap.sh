#!/bin/sh

MODE=`uci get system.route.operationmode`

if [ "$MODE" == "AP" ]; then
	uci set system.route.dhcp_dns="0"
	uci commit system
fi

