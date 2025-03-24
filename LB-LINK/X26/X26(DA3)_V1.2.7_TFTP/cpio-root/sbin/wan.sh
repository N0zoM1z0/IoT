#!/bin/sh
#
# $Id: //WIFI_SOC/MP/SDK_4_2_0_0/RT288x_SDK/source/user/rt2880_app/scripts/wan.sh#1 $
#
# usage: wan.sh
#

. /sbin/global.sh
. /sbin/config.sh #add by wgl 20160725

# stop all
killall -q -9 syslogd
killall -q -9 udhcpc
killall -q -9 pppd
killall -q -9 l2tpd
killall -q -9 openl2tpd

clone_en=`nvram_get 2860 macCloneEnabled`
local_mac=`nvram_get 2860 WAN_MAC_ADDR`
clone_mac=`nvram_get 2860 macCloneMac`
#MAC Clone: bridge mode doesn't support MAC Clone
if [ "$opmode" != "0" -a "$clone_en" = "1" -a "$clone_mac" != " " ]; then
	ifconfig $wan_if down
	if [ "$opmode" = "2" -a "$CONFIG_RT2860V2_STA" == "m" ]; then
			rmmod rt2860v2_sta_net
			rmmod rt2860v2_sta
			rmmod rt2860v2_sta_util

			insmod -q rt2860v2_sta_util
			insmod -q rt2860v2_sta mac=$clone_mac
			insmod -q rt2860v2_sta_net
	else
			ifconfig $wan_if hw ether $clone_mac
	fi
	ifconfig $wan_if up
fi
if [ "$wanmode" = "STATIC" -o "$opmode" = "0" ]; then
	#always treat bridge mode having static wan connection
	ip=`nvram_get 2860 wan_ipaddr`
	nm=`nvram_get 2860 wan_netmask`
	gw=`nvram_get 2860 wan_gateway`
	pd=`nvram_get 2860 wan_primary_dns`
	sd=`nvram_get 2860 wan_secondary_dns`

	#lan and wan ip should not be the same except in bridge mode
	if [ "$opmode" != "0" ]; then
		lan_ip=`nvram_get 2860 lan_ipaddr`
		if [ "$ip" = "$lan_ip" ]; then
			echo "wan.sh: warning: WAN's IP address is set identical to LAN"
			exit 0
		fi
	else
		#use lan's ip address instead
		ip=`nvram_get 2860 lan_ipaddr`
		nm=`nvram_get 2860 lan_netmask`
	fi
	ifconfig $wan_if $ip netmask $nm
		mtuvalue=`nvram_get 2860 MTUstaticvalue`
	ifconfig $wan_if mtu $mtuvalue
	route del default
	if [ "$gw" != "" ]; then
	route add default gw $gw
	fi
	config-dns.sh $pd $sd
elif [ "$wanmode" = "DHCP" ]; then
	hn=`nvram_get 2860 wan_dhcp_hn`
	pd=`nvram_get 2860 wan_advanced1_dns`
	sd=`nvram_get 2860 wan_advanced2_dns`
	sw=`nvram_get 2860 wan_dns_switch`
	if [ "$hn" != "" ]; then
		udhcpc -i $wan_if -h $hn -s /sbin/udhcpc.sh -p /var/run/udhcpc.pid &
	else
		udhcpc -i $wan_if -s /sbin/udhcpc.sh -p /var/run/udhcpc.pid &
	fi
	if [ "$sw" = "1" ]; then
		config-dns.sh $pd $sd
	fi
	
	mtuvalue=`nvram_get 2860 MTUdhcpvalue`
	ifconfig $wan_if mtu $mtuvalue
elif [ "$wanmode" = "PPPOE" ]; then
	srv=`nvram_get 2860 wan_pppoe_server`
	u=`nvram_get 2860 wan_pppoe_user`
	pw=`nvram_get 2860 wan_pppoe_pass`
	pppoe_opmode=`nvram_get 2860 wan_pppoe_opmode`
	pppoe_optime=`nvram_get 2860 wan_pppoe_optime`
	pppoe_mtu=`nvram_get 2860 MTUpppoevalue`
	mode=`nvram_get 2860 wan_pppoe_mode`

	if [ "$mode" = "2" ]; then
		ip=`nvram_get 2860 wan_pppoe_ip`
		nm=`nvram_get 2860 wan_pppoe_netmask`
		gw=`nvram_get 2860 wan_pppoe_gateway`
		if [ "$gw" = "" ]; then
			gw="0.0.0.0"
		fi		
		ifconfig eth2.2 $ip netmask $nm
		lanip_pre=`echo "$ip" | sed 's/[0-9]\{1,3\}$//g'`
		lo_ip_net=`echo "${lanip_pre}0"`
		route add -net $lo_ip_net netmask $nm gw $gw
		check_net &
	elif [ "$mode" = "1" ]; then
		udhcpc -i eth2.2 -s /sbin/udhcpc.sh -p /var/run/udhcpc.pid &
		check_net &
	fi
	config-pppoe.sh "$u" "$pw" $wan_if $pppoe_opmode $pppoe_optime
elif [ "$wanmode" = "L2TP" ]; then
	srv=`nvram_get 2860 wan_l2tp_server`
	u=`nvram_get 2860 wan_l2tp_user`
	pw=`nvram_get 2860 wan_l2tp_pass`
	mode=`nvram_get 2860 wan_l2tp_mode`
	l2tp_opmode=`nvram_get 2860 wan_l2tp_opmode`
	l2tp_optime=`nvram_get 2860 wan_l2tp_optime`
	if [ "$mode" = "0" ]; then
		ip=`nvram_get 2860 wan_l2tp_ip`
		nm=`nvram_get 2860 wan_l2tp_netmask`
		gw=`nvram_get 2860 wan_l2tp_gateway`
		if [ "$gw" = "" ]; then
			gw="0.0.0.0"
		fi
		config-l2tp.sh static $wan_if $ip $nm $gw $srv $u $pw $l2tp_opmode $l2tp_optime
	else
		config-l2tp.sh dhcp $wan_if $srv $u $pw $l2tp_opmode $l2tp_optime
	fi
	#mtuvalue=`nvram_get 2860 MTUl2tpvalue`
	#ifconfig $wan_if mtu $mtuvalue
	check_net &

elif [ "$wanmode" = "PPTP" ]; then
	srv=`nvram_get 2860 wan_pptp_server`
	u=`nvram_get 2860 wan_pptp_user`
	pw=`nvram_get 2860 wan_pptp_pass`
	mode=`nvram_get 2860 wan_pptp_mode`
	pptp_opmode=`nvram_get 2860 wan_pptp_opmode`
	pptp_optime=`nvram_get 2860 wan_pptp_optime`
	if [ "$mode" = "0" ]; then
		ip=`nvram_get 2860 wan_pptp_ip`
		nm=`nvram_get 2860 wan_pptp_netmask`
		gw=`nvram_get 2860 wan_pptp_gateway`
		if [ "$gw" = "" ]; then
			gw="0.0.0.0"
		fi
		config-pptp.sh static $wan_if $ip $nm $gw $srv $u $pw $pptp_opmode $pptp_optime
	else
		config-pptp.sh dhcp $wan_if $srv $u $pw $pptp_opmode $pptp_optime
	fi
	#mtuvalue=`nvram_get 2860 MTUpptpvalue`
	#ifconfig $wan_if mtu $mtuvalue
	check_net &
elif [ "$wanmode" = "PPPOERS" ]; then
	srv=`nvram_get 2860 wan_pppoe_server`
	u=`nvram_get 2860 wan_pppoe_user`
	pw=`nvram_get 2860 wan_pppoe_pass`
	pppoe_opmode=`nvram_get 2860 wan_pppoe_opmode`
	pppoe_optime=`nvram_get 2860 wan_pppoe_optime`
	pppoe_mtu=`nvram_get 2860 MTUpppoevalue`
	mode=`nvram_get 2860 wan_pppoe_mode`
	if [ "$mode" = "0" ]; then
		ip=`nvram_get 2860 wan_pppoe_ip`
		nm=`nvram_get 2860 wan_pppoe_netmask`
		gw=`nvram_get 2860 wan_pppoe_gateway`
		if [ "$gw" = "" ]; then
			gw="0.0.0.0"
		fi		
		ifconfig eth2.2 $ip netmask $nm
		lanip_pre=`echo "$ip" | sed 's/[0-9]\{1,3\}$//g'`
		lo_ip_net=`echo "${lanip_pre}0"`
		route add -net $lo_ip_net netmask $nm gw $gw
	else
		udhcpc -i eth2.2 -s /sbin/udhcpc.sh -p /var/run/udhcpc.pid &
	fi
	config-pppoe.sh "$u" "$pw" $wan_if $pppoe_opmode $pppoe_optime

elif [ "$wanmode" = "3G" ]; then
	autoconn3G.sh connect &
else
	echo "wan.sh: unknown wan connection type: $wanmode"
	exit 1
fi

if [ "$CONFIG_BLINK_REPEATER_IP" = "y" ]; then
	if [ "$opmode" = "0" ];then
		udhcpc -i $wan_if -s /sbin/udhcpc.sh -p /var/run/udhcpc.pid&
	fi
fi

