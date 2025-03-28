#!/bin/sh
#
# $Id: //WIFI_SOC/MP/SDK_4_2_0_0/RT288x_SDK/source/user/rt2880_app/scripts/config-pppoe.sh#1 $
#
# usage: config-pppoe.sh <user> <password> <wan_if_name>
#

usage()
{
	echo "Usage:"
	echo "  $0 <user> <password> <wan_if_name>"
	exit 1
}

if [ "$3" = "" ]; then
	echo "$0: insufficient arguments"
	usage $0
fi

pppoe.sh $1 $2 $3 $4 $5
killall -9 pppd
#pppd file /etc/options.pppoe &

#udhcpc -i eth2.2 -s /sbin/udhcpc.sh -p /var/run/udhcpc.pid &
#iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu

