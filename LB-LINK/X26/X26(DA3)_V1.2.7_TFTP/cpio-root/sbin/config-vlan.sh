#!/bin/sh

# $Id: //WIFI_SOC/MP/SDK_4_2_0_0/RT288x_SDK/source/user/rt2880_app/scripts/config-vlan.sh#2 $
#
# usage: config-vlan.sh <switch_type> <vlan_type>
#   switch_type: 0=IC+, 1=vtss
#   vlan_type: 0=no_vlan, 1=vlan, LLLLW=wan_4, WLLLL=wan_0
# 

. /sbin/config.sh

usage()
{
	echo "Usage:"
	echo "  $0 0 0 - restore IC+ to no VLAN partition"
	echo "  $0 0 LLLLW - config IC+ with VLAN and WAN at port 4"
	echo "  $0 0 WLLLL - config IC+ with VLAN and WAN at port 0"
	echo "  $0 1 0 - restore Vtss to no VLAN partition"
	echo "  $0 1 LLLLW - config Vtss with VLAN and WAN at port 4"
	echo "  $0 1 WLLLL - config Vtss with VLAN and WAN at port 0"
	echo "  $0 2 0 - restore Ralink ESW to no VLAN partition"
	echo "  $0 2 LLLLW - config Ralink ESW with VLAN and WAN at port 4"
	echo "  $0 2 WLLLL - config Ralink ESW with VLAN and WAN at port 0"
	echo "  $0 2 W1234 - config Ralink ESW with VLAN 5 at port 0 and VLAN 1~4 at port 1~4"
	echo "  $0 2 12345 - config Ralink ESW with VLAN 1~5 at port 0~4"
	echo "  $0 2 GW - config Ralink ESW with WAN at Giga port"
	echo "  $0 2 G01234 - config Ralink ESW with VLAN 6 at Giga port, and VLAN 1~5 at port 0~4"
	echo "  $0 3 0 - restore Ralink RT6855/MT7620/MT7621 ESW to no VLAN partition"
	echo "  $0 3 LLLLW - config Ralink RT6855/MT7620/MT7621 ESW with VLAN and WAN at port 4"
	echo "  $0 3 WLLLL - config Ralink RT6855/MT7620/MT7621 ESW with VLAN and WAN at port 0"
	echo "  $0 3 12345 - config Ralink RT6855/MT7620/MT7621 ESW with VLAN 1~5 at port 0~4"
	echo "  $0 3 GW - config Ralink RT6855/MT7620/MT7621 ESW with WAN at Giga port"
	exit 0
}

config175C()
{
	mii_mgr -s -p 29 -r 23 -v 0x07c2
	mii_mgr -s -p 29 -r 22 -v 0x8420

	if [ "$1" = "LLLLW" ]; then
		mii_mgr -s -p 29 -r 24 -v 0x1
		mii_mgr -s -p 29 -r 25 -v 0x1
		mii_mgr -s -p 29 -r 26 -v 0x1
		mii_mgr -s -p 29 -r 27 -v 0x1
		mii_mgr -s -p 29 -r 28 -v 0x2
		mii_mgr -s -p 30 -r 9 -v 0x1089
		if [ "$CONFIG_RALINK_VISTA_BASIC" == "y" ]; then
			mii_mgr -s -p 30 -r 1 -v 0x2f3f
		else
			mii_mgr -s -p 30 -r 1 -v 0x2f00
		fi
		mii_mgr -s -p 30 -r 2 -v 0x0030
	elif [ "$1" = "WLLLL" ]; then
		mii_mgr -s -p 29 -r 24 -v 0x2
		mii_mgr -s -p 29 -r 25 -v 0x1
		mii_mgr -s -p 29 -r 26 -v 0x1
		mii_mgr -s -p 29 -r 27 -v 0x1
		mii_mgr -s -p 29 -r 28 -v 0x1
		mii_mgr -s -p 30 -r 9 -v 0x0189
		if [ "$CONFIG_RALINK_VISTA_BASIC" == "y" ]; then
			mii_mgr -s -p 30 -r 1 -v 0x3e3f
		else
			mii_mgr -s -p 30 -r 1 -v 0x3e00
		fi
		mii_mgr -s -p 30 -r 2 -v 0x0021
	else
		echo "LAN WAN layout $0 is not suported"
	fi
}

restore175C()
{
	mii_mgr -s -p 29 -r 23 -v 0x0
	mii_mgr -s -p 29 -r 22 -v 0x420
	mii_mgr -s -p 29 -r 24 -v 0x1
	mii_mgr -s -p 29 -r 25 -v 0x1
	mii_mgr -s -p 29 -r 26 -v 0x1
	mii_mgr -s -p 29 -r 27 -v 0x1
	mii_mgr -s -p 29 -r 27 -v 0x2
	mii_mgr -s -p 30 -r 9 -v 0x1001
	mii_mgr -s -p 30 -r 1 -v 0x2f3f
	mii_mgr -s -p 30 -r 2 -v 0x3f30
}

restore175D()
{
	mii_mgr -s -p 20 -r  4 -v 0xa000
	mii_mgr -s -p 20 -r 13 -v 0x20
	mii_mgr -s -p 21 -r  1 -v 0x1800
	mii_mgr -s -p 22 -r  0 -v 0x0
	mii_mgr -s -p 22 -r  2 -v 0x0
	mii_mgr -s -p 22 -r 10 -v 0x0
	mii_mgr -s -p 22 -r 14 -v 0x1
	mii_mgr -s -p 22 -r 15 -v 0x2
	mii_mgr -s -p 23 -r  8 -v 0x0
	mii_mgr -s -p 23 -r 16 -v 0x0

	mii_mgr -s -p 22 -r 4 -v 0x1
	mii_mgr -s -p 22 -r 5 -v 0x1
	mii_mgr -s -p 22 -r 6 -v 0x1
	mii_mgr -s -p 22 -r 7 -v 0x1
	mii_mgr -s -p 22 -r 8 -v 0x1
	mii_mgr -s -p 23 -r 0 -v 0x3f3f
}

config175D()
{
	mii_mgr -s -p 20 -r  4 -v 0xa000
	mii_mgr -s -p 20 -r 13 -v 0x21
	mii_mgr -s -p 21 -r  1 -v 0x1800
	mii_mgr -s -p 22 -r  0 -v 0x27ff
	mii_mgr -s -p 22 -r  2 -v 0x20
	mii_mgr -s -p 22 -r  3 -v 0x8100
	mii_mgr -s -p 22 -r 10 -v 0x3
	mii_mgr -s -p 22 -r 14 -v 0x1001
	mii_mgr -s -p 22 -r 15 -v 0x2002
	mii_mgr -s -p 23 -r  8 -v 0x2020
	mii_mgr -s -p 23 -r 16 -v 0x1f1f
	if [ "$1" = "LLLLW" ]; then
		mii_mgr -s -p 22 -r 4 -v 0x1
		mii_mgr -s -p 22 -r 5 -v 0x1
		mii_mgr -s -p 22 -r 6 -v 0x1
		mii_mgr -s -p 22 -r 7 -v 0x1
		mii_mgr -s -p 22 -r 8 -v 0x2
		mii_mgr -s -p 23 -r 0 -v 0x302f
	elif [ "$1" = "WLLLL" ]; then
		mii_mgr -s -p 22 -r 4 -v 0x2
		mii_mgr -s -p 22 -r 5 -v 0x1
		mii_mgr -s -p 22 -r 6 -v 0x1
		mii_mgr -s -p 22 -r 7 -v 0x1
		mii_mgr -s -p 22 -r 8 -v 0x1
		mii_mgr -s -p 23 -r 0 -v 0x213e
	else
		echo "LAN WAN layout $0 is not suported"
	fi
}
config7530Esw_7620AG1()
{
	switch_7530 reg w 2014 10001
	switch_7530 reg w 2114 10002
	switch_7530 reg w 2214 10003
	switch_7530 reg w 2314 10004
	switch_7530 reg w 2414 10005



	switch_7530 vlan set  0 1 10000110
	switch_7530 vlan set  0 2 01000110
	switch_7530 vlan set  0 3 00100110
	switch_7530 vlan set  0 4 00010110
	switch_7530 vlan set  0 5 00001110


	switch_7530 reg w 2010 810000c0
	switch_7530 reg w 2110 810000c0
	switch_7530 reg w 2210 810000c0
	switch_7530 reg w 2310 810000c0
	switch_7530 reg w 2410 810000c0
	switch_7530 reg w 2510 81000000
	switch_7530 reg w 2610 81000000


	switch_7530 reg w 2004 ff0003
	switch_7530 reg w 2104 ff0003
	switch_7530 reg w 2204 ff0003
	switch_7530 reg w 2304 ff0003
	switch_7530 reg w 2404 ff0003
	switch_7530 reg w 2504 20ff0003
	switch_7530 reg w 2604 20ff0003

	switch reg w 2410 81000000

	switch reg w 2510 81000000
	switch reg w 2610 81000000

	switch reg w 2404 20ff0003
	switch reg w 2504 20ff0003
	switch reg w 2604 20ff0003

	switch reg w 2014 10001
	switch reg w 2114 10002
	switch reg w 2214 10003
	switch reg w 2314 10004
	switch reg w 2414 10001

	switch vlan set 0 1 10001110
	switch vlan set 1 2 01001110
	switch vlan set 2 3 00101110
	switch vlan set 3 4 00011110
	switch vlan set 4 5 00001110

}
config7530Esw()
{
	#LAN/WAN ports as security mode
	switch_7530 reg w 2004 ff0003 #port0
	switch_7530 reg w 2104 ff0003 #port1
	switch_7530 reg w 2204 ff0003 #port2
	switch_7530 reg w 2304 ff0003 #port3
	switch_7530 reg w 2404 ff0003 #port4
	switch_7530 reg w 2504 ff0003 #port5
	#LAN/WAN ports as transparent port
	switch_7530 reg w 2010 810000c0 #port0
	switch_7530 reg w 2110 810000c0 #port1
	switch_7530 reg w 2210 810000c0 #port2
	switch_7530 reg w 2310 810000c0 #port3	
	switch_7530 reg w 2410 810000c0 #port4
	switch_7530 reg w 2510 810000c0 #port5
	#set CPU/P7 port as user port
	switch_7530 reg w 2610 81000000 #port6
	switch_7530 reg w 2710 81000000 #port7

	switch_7530 reg w 2604 20ff0003 #port6, Egress VLAN Tag Attribution=tagged
	switch_7530 reg w 2704 20ff0003 #port7, Egress VLAN Tag Attribution=tagged
	if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
	    echo "Special Tag Enabled"
		switch_7530 reg w 2610 81000020 #port6
		#VLAN member port
		switch_7530 vlan set  0 1 10000010
		switch_7530 vlan set  0 2 01000010
		switch_7530 vlan set  0 3 00100010
		switch_7530 vlan set  0 4 00010010
		switch_7530 vlan set  0 5 00001010
		switch_7530 vlan set  0 6 00000110
		switch_7530 vlan set  0 7 00000110
	else
	    echo "Special Tag Disabled"
		switch_7530 reg w 2610 81000000 #port6
	fi

	if [ "$1" = "LLLLW" ]; then
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		#set PVID
		switch_7530 reg w 2014 10007 #port0
		switch_7530 reg w 2114 10007 #port1
		switch_7530 reg w 2214 10007 #port2
		switch_7530 reg w 2314 10007 #port3
		switch_7530 reg w 2414 10008 #port4
		switch_7530 reg w 2514 10007 #port5
		#VLAN member port
		switch_7530 vlan set 0 1 10000010
		switch_7530 vlan set 0 2 01000010
		switch_7530 vlan set 0 3 00100010
		switch_7530 vlan set 0 4 00010010
		switch_7530 vlan set 0 5 00001010
		switch_7530 vlan set 0 6 00000110
		switch_7530 vlan set 0 7 11110110
		switch_7530 vlan set 0 8 00001010
		else
		#set PVID
		switch_7530 reg w 2014 10001 #port0
		switch_7530 reg w 2114 10001 #port1
		switch_7530 reg w 2214 10001 #port2
		switch_7530 reg w 2314 10001 #port3
		switch_7530 reg w 2414 10002 #port4
		switch_7530 reg w 2514 10001 #port5
		#VLAN member port
		switch_7530 vlan set  0 1 11110110
		switch_7530 vlan set  0 2 00001010
		fi
	elif [ "$1" = "WLLLL" ]; then
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		#set PVID
		switch_7530 reg w 2014 10008 #port0
		switch_7530 reg w 2114 10007 #port1
		switch_7530 reg w 2214 10007 #port2
		switch_7530 reg w 2314 10007 #port3
		switch_7530 reg w 2414 10007 #port4
		switch_7530 reg w 2514 10007 #port5
		#VLAN member port
		switch_7530 vlan set  0 5 10000010
		switch_7530 vlan set  0 1 01000010
		switch_7530 vlan set  0 2 00100010
		switch_7530 vlan set  0 3 00010010
		switch_7530 vlan set  0 4 00001010
		switch_7530 vlan set  0 6 00000110
		switch_7530 vlan set  0 7 01111110
		switch_7530 vlan set  0 8 10000010
		else
		#set PVID
		switch_7530 reg w 2014 10002 #port0
		switch_7530 reg w 2114 10001 #port1
		switch_7530 reg w 2214 10001 #port2
		switch_7530 reg w 2314 10001 #port3
		switch_7530 reg w 2414 10001 #port4
		switch_7530 reg w 2514 10001 #port5
		#VLAN member port
		switch_7530 vlan set  0 1 01111110
		switch_7530 vlan set  0 2 10000010
		fi
	elif [ "$1" = "W1234" ]; then
		echo "W1234"
		#set PVID
		switch_7530 reg w 2014 10005 #port0
		switch_7530 reg w 2114 10001 #port1
		switch_7530 reg w 2214 10002 #port2
		switch_7530 reg w 2314 10003 #port3
		switch_7530 reg w 2414 10004 #port4
		switch_7530 reg w 2514 10006 #port5
		#VLAN member port
		switch_7530 vlan set  0 5 10000010
		switch_7530 vlan set  0 1 01000010
		switch_7530 vlan set  0 2 00100010
		switch_7530 vlan set  0 3 00010010
		switch_7530 vlan set  0 4 00001010
		switch_7530 vlan set  0 6 00000110
	   
	elif [ "$1" = "12345" ]; then
		echo "12345"
		#set PVID
		switch_7530 reg w 2014 10001 #port0
		switch_7530 reg w 2114 10002 #port1
		switch_7530 reg w 2214 10003 #port2
		switch_7530 reg w 2314 10004 #port3
		switch_7530 reg w 2414 10005 #port4
		switch_7530 reg w 2514 10006 #port5
		#VLAN member port
		switch_7530 vlan set  0 1 10000010
		switch_7530 vlan set  0 2 01000010
		switch_7530 vlan set  0 3 00100010
		switch_7530 vlan set  0 4 00010010
		switch_7530 vlan set  0 5 00001010
		switch_7530 vlan set  0 6 00000110
	elif [ "$1" = "GW" ]; then
		echo "GW"
		#set PVID
		switch_7530 reg w 2014 10001 #port0
		switch_7530 reg w 2114 10001 #port1
		switch_7530 reg w 2214 10001 #port2
		switch_7530 reg w 2314 10001 #port3
		switch_7530 reg w 2414 10001 #port4
		switch_7530 reg w 2514 10002 #port5
		#VLAN member port
		switch_7530 vlan set  0 1 11111010
		switch_7530 vlan set  0 2 00000110
	fi

	#clear mac table if vlan configuration changed
	switch_7530 clear
}



config6855Esw()
{
	#LAN/WAN ports as security mode
	switch reg w 2004 ff0003 #port0
	switch reg w 2104 ff0003 #port1
	switch reg w 2204 ff0003 #port2
	switch reg w 2304 ff0003 #port3
	switch reg w 2404 ff0003 #port4
	switch reg w 2504 ff0003 #port5
	#LAN/WAN ports as transparent port
	switch reg w 2010 810000c0 #port0
	switch reg w 2110 810000c0 #port1
	switch reg w 2210 810000c0 #port2
	switch reg w 2310 810000c0 #port3	
	switch reg w 2410 810000c0 #port4
	switch reg w 2510 810000c0 #port5
	#set CPU/P7 port as user port
	switch reg w 2610 81000000 #port6
	switch reg w 2710 81000000 #port7

	switch reg w 2604 20ff0003 #port6, Egress VLAN Tag Attribution=tagged
	switch reg w 2704 20ff0003 #port7, Egress VLAN Tag Attribution=tagged
	if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
	    echo "Special Tag Enabled"
		switch reg w 2610 81000020 #port6

	else
	    echo "Special Tag Disabled"
		switch reg w 2610 81000000 #port6
	fi

	if [ "$1" = "LLLLW" ]; then
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		#set PVID
		switch reg w 2014 10007 #port0
		switch reg w 2114 10007 #port1
		switch reg w 2214 10007 #port2
		switch reg w 2314 10007 #port3
		switch reg w 2414 10008 #port4
		switch reg w 2514 10007 #port5
		#VLAN member port
		switch vlan set 0 1 10000011
		switch vlan set 1 2 01000011
		switch vlan set 2 3 00100011
		switch vlan set 3 4 00010011
		switch vlan set 4 5 00001011
		switch vlan set 5 6 00000111
		switch vlan set 6 7 11110111
		switch vlan set 7 8 00001011
		else
		#set PVID
		switch reg w 2014 10001 #port0
		switch reg w 2114 10001 #port1
		switch reg w 2214 10001 #port2
		switch reg w 2314 10001 #port3
		switch reg w 2414 10002 #port4
		switch reg w 2514 10001 #port5
		#VLAN member port
		switch vlan set 0 1 11110111
		switch vlan set 1 2 00001011
		fi
	elif [ "$1" = "WLLLL" ]; then
		if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		#set PVID
		switch reg w 2014 10008 #port0
		switch reg w 2114 10007 #port1
		switch reg w 2214 10007 #port2
		switch reg w 2314 10007 #port3
		switch reg w 2414 10007 #port4
		switch reg w 2514 10007 #port5
		#VLAN member port
		switch vlan set 4 5 10000011
		switch vlan set 0 1 01000011
		switch vlan set 1 2 00100011
		switch vlan set 2 3 00010011
		switch vlan set 3 4 00001011
		switch vlan set 5 6 00000111
		switch vlan set 6 7 01111111
		switch vlan set 7 8 10000011
		else
		#set PVID
		switch reg w 2014 10002 #port0
		switch reg w 2114 10001 #port1
		switch reg w 2214 10001 #port2
		switch reg w 2314 10001 #port3
		switch reg w 2414 10001 #port4
		switch reg w 2514 10001 #port5
		#VLAN member port
		switch vlan set 0 1 01111111
		switch vlan set 1 2 10000011
		fi
	elif [ "$1" = "W1234" ]; then
		echo "W1234"
		#set PVID
		switch reg w 2014 10005 #port0
		switch reg w 2114 10001 #port1
		switch reg w 2214 10002 #port2
		switch reg w 2314 10003 #port3
		switch reg w 2414 10004 #port4
		switch reg w 2514 10006 #port5
		#VLAN member port
		switch vlan set 4 5 10000011
		switch vlan set 0 1 01000011
		switch vlan set 1 2 00100011
		switch vlan set 2 3 00010011
		switch vlan set 3 4 00001011
		switch vlan set 5 6 00000111
	elif [ "$1" = "12345" ]; then
		echo "12345"
		#set PVID
		switch reg w 2014 10001 #port0
		switch reg w 2114 10002 #port1
		switch reg w 2214 10003 #port2
		switch reg w 2314 10004 #port3
		switch reg w 2414 10005 #port4
		switch reg w 2514 10006 #port5
		#VLAN member port
		switch vlan set 0 1 10000011
		switch vlan set 1 2 01000011
		switch vlan set 2 3 00100011
		switch vlan set 3 4 00010011
		switch vlan set 4 5 00001011
		switch vlan set 5 6 00000111
	elif [ "$1" = "GW" ]; then
		echo "GW"
		#set PVID
		switch reg w 2014 10001 #port0
		switch reg w 2114 10001 #port1
		switch reg w 2214 10001 #port2
		switch reg w 2314 10001 #port3
		switch reg w 2414 10001 #port4
		switch reg w 2514 10002 #port5
		#VLAN member port
		switch vlan set 0 1 11111011
		switch vlan set 1 2 00000111
	fi

	#clear mac table if vlan configuration changed
	switch clear
}

configEsw()
{
	switch reg w 14 405555
	switch reg w 50 2001
	switch reg w 98 7f3f
if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
	switch reg w e4 40043f  
else
	switch reg w e4 3f
fi

	if [ "$1" = "LLLLW" ]; then
if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		switch reg w 40 7007
		switch reg w 44 7007
		switch reg w 48 7008
		switch reg w 70 48444241
		switch reg w 74 50ef6050
else
		switch reg w 40 1001
		switch reg w 44 1001
		switch reg w 48 1002
		switch reg w 70 ffff506f
fi
	elif [ "$1" = "WLLLL" ]; then
if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		switch reg w 40 7008
		switch reg w 44 7007
		switch reg w 48 7007
		switch reg w 70 48444241
		switch reg w 74 41fe6050
else
		switch reg w 40 1002
		switch reg w 44 1001
		switch reg w 48 1001
		switch reg w 70 ffff417e
fi
	elif [ "$1" = "W1234" ]; then
		switch reg w 40 1005
		switch reg w 44 3002
		switch reg w 48 1004
		switch reg w 70 50484442
		switch reg w 74 ffffff41
	elif [ "$1" = "12345" ]; then
		switch reg w 40 2001
		switch reg w 44 4003
		switch reg w 48 1005
		switch reg w 70 48444241
		switch reg w 74 ffffff50
	elif [ "$1" = "GW" ]; then
		switch reg w 40 1001
		switch reg w 44 1001
		switch reg w 48 2001
		switch reg w 70 ffff605f
	elif [ "$1" = "G01234" ]; then
		switch reg w 40 2001
		switch reg w 44 4003
		switch reg w 48 6005
		switch reg w 70 48444241
		switch reg w 74 ffff6050
	fi

	#clear mac table if vlan configuration changed
	switch clear
}

restore7530Esw()
{
	echo "restore MT7530 ESW to dump switch mode"
	#port matrix mode
	switch_7530 reg w 2004 ff0000 #port0
	switch_7530 reg w 2104 ff0000 #port1
	switch_7530 reg w 2204 ff0000 #port2
	switch_7530 reg w 2304 ff0000 #port3
	switch_7530 reg w 2404 ff0000 #port4
	switch_7530 reg w 2504 ff0000 #port5
	switch_7530 reg w 2604 ff0000 #port6

	#LAN/WAN ports as transparent mode
	switch_7530 reg w 2010 810000c0 #port0
	switch_7530 reg w 2110 810000c0 #port1
	switch_7530 reg w 2210 810000c0 #port2
	switch_7530 reg w 2310 810000c0 #port3	
	switch_7530 reg w 2410 810000c0 #port4
	switch_7530 reg w 2510 810000c0 #port5
	switch_7530 reg w 2610 810000c0 #port6
	
	#clear mac table if vlan configuration changed
	switch_7530 clear
	switch_7530 vlan clear
}

restore6855Esw()
{
	echo "restore GSW to dump switch mode"
	#port matrix mode
	switch reg w 2004 ff0000 #port0
	switch reg w 2104 ff0000 #port1
	switch reg w 2204 ff0000 #port2
	switch reg w 2304 ff0000 #port3
	switch reg w 2404 ff0000 #port4
	switch reg w 2504 ff0000 #port5
	switch reg w 2604 ff0000 #port6
	switch reg w 2704 ff0000 #port7

	#LAN/WAN ports as transparent mode
	switch reg w 2010 810000c0 #port0
	switch reg w 2110 810000c0 #port1
	switch reg w 2210 810000c0 #port2
	switch reg w 2310 810000c0 #port3	
	switch reg w 2410 810000c0 #port4
	switch reg w 2510 810000c0 #port5
	switch reg w 2610 810000c0 #port6
	switch reg w 2710 810000c0 #port7
	
	#clear mac table if vlan configuration changed
	switch clear
	switch vlan clear
}
restoreEsw()
{
	switch reg w 14 5555
	switch reg w 40 1001
	switch reg w 44 1001
	switch reg w 48 1001
	switch reg w 4c 1
	switch reg w 50 2001
	switch reg w 70 ffffffff
	switch reg w 98 7f7f
	switch reg w e4 7f
	
	#clear mac table if vlan configuration changed
	switch clear
}

vtss_cpu()
{
	vreg=`spicmd vtss read 7 0 10 | sed -e 's/.*> //'`
	pre=`echo $vreg | sed -e 's/\(.*\)[0-9a-f]/\1/'`
	hex=`echo $vreg | sed -e 's/.*\([0-9a-f]\)/\1/'`

	# 0 -> disable clock (bit 1)
	# 1 -> enable clock (bit 1)
	# 2 -> soft reset (bit 0)
	if [ "$1" = "0" ]; then
		case $hex in
			"2")	rep="0"	;;
			"3")	rep="1"	;;
			"6")	rep="4"	;;
			"7")	rep="5"	;;
			"a")	rep="8"	;;
			"b")	rep="9"	;;
			"e")	rep="c"	;;
			"f")	rep="d"	;;
			*)	return;;
		esac
		new=$pre$rep
		spicmd vtss write 7 0 10 $new > /dev/null
	elif [ "$1" = "1" ]; then
		case $hex in
			"0")	rep="2"	;;
			"1")	rep="3"	;;
			"4")	rep="6"	;;
			"5")	rep="7"	;;
			"8")	rep="a"	;;
			"9")	rep="b"	;;
			"c")	rep="e"	;;
			"d")	rep="f"	;;
			*)	return;;
		esac
		new=$pre$rep
		spicmd vtss write 7 0 10 $new > /dev/null
	elif [ "$1" = "2" ]; then
		case $hex in
			"1")	rep="0";;
			"3")	rep="2";;
			"5")	rep="4";;
			"7")	rep="6";;
			"9")	rep="8";;
			"b")	rep="a";;
			"d")	rep="c";;
			"f")	rep="e";;
			*)	return;;
		esac
		new=$pre$rep
		spicmd vtss write 7 0 10 $new > /dev/null
		spicmd vtss write 7 0 10 $vreg > /dev/null
	fi
}

vtss_power_save()
{
	# turn on ActiPHY feature (PHY_AUX_CTRL_STAT bit 6) for power saving
	for i in 0 1 2 3 4; do
		x=`expr $i \* 2 + 1`
		spicmd vtss write 3 0 1 4${x}c0000 /dev/null > /dev/null
		vreg=`spicmd vtss read 3 0 2 | sed -e 's/.*> //'`
		h1=`echo $vreg | sed -e 's/.//'`
		h2=`echo $vreg | sed -e 's/..//'`
		h3=`echo $vreg | sed -e 's/...//'`
		h4=`echo $vreg | sed -e 's/....//'`
		if [ "$h1" = "" ]; then
			spicmd vtss write 3 0 1 ${x}c004$vreg > /dev/null
		elif [ "$h2" = "" ]; then
			hex=`echo $vreg | sed -e 's/\(.\)./\1/'`
			post=`echo $vreg | sed -e 's/.\(.\)/\1/'`
			case $hex in
				"0")	rep="4";;
				"1")	rep="5";;
				"2")	rep="6";;
				"3")	rep="7";;
				"8")	rep="c";;
				"9")	rep="d";;
				"a")	rep="e";;
				"b")	rep="f";;
				*)	return;;
			esac
			spicmd vtss write 3 0 1 ${x}c00$rep$post > /dev/null
		elif [ "$h3" = "" ]; then
			pre=`echo $vreg | sed -e 's/\(.\)../\1/'`
			hex=`echo $vreg | sed -e 's/.\(.\)./\1/'`
			post=`echo $vreg | sed -e 's/..\(.\)/\1/'`
			case $hex in
				"0")	rep="4";;
				"1")	rep="5";;
				"2")	rep="6";;
				"3")	rep="7";;
				"8")	rep="c";;
				"9")	rep="d";;
				"a")	rep="e";;
				"b")	rep="f";;
				*)	return;;
			esac
			spicmd vtss write 3 0 1 ${x}c0$pre$rep$post > /dev/null
		elif [ "$h4" = "" ]; then
			pre=`echo $vreg | sed -e 's/\(..\)../\1/'`
			hex=`echo $vreg | sed -e 's/..\(.\)./\1/'`
			post=`echo $vreg | sed -e 's/...\(.\)/\1/'`
			case $hex in
				"0")	rep="4";;
				"1")	rep="5";;
				"2")	rep="6";;
				"3")	rep="7";;
				"8")	rep="c";;
				"9")	rep="d";;
				"a")	rep="e";;
				"b")	rep="f";;
				*)	return;;
			esac
			spicmd vtss write 3 0 1 ${x}c0$pre$rep$post > /dev/null
		fi
	done
}

if [ "$1" = "0" ]; then
	#isc is used to distinguish between 175C and 175D
	isc=`mii_mgr -g -p 29 -r 31`
	if [ "$2" = "0" ]; then
		if [ "$isc" = "Get: phy[29].reg[31] = 175c" ]; then
			restore175C
		else
			restore175D
		fi
	elif [ "$2" = "LLLLW" ]; then
		if [ "$isc" = "Get: phy[29].reg[31] = 175c" ]; then
			config175C "LLLLW"
		else
			config175D "LLLLW"
		fi
	elif [ "$2" = "WLLLL" ]; then
		if [ "$isc" = "Get: phy[29].reg[31] = 175c" ]; then
			config175C "WLLLL"
		else
			config175D "WLLLL"
		fi
	else
		echo "unknown vlan type $2"
		echo ""
		usage $0
	fi
elif [ "$1" = "1" ]; then
	if [ "$2" = "0" ]; then
		spicmd vtss novlan
	elif [ "$2" = "LLLLW" ]; then
		spicmd vtss p4
	elif [ "$2" = "WLLLL" ]; then
		spicmd vtss p0
	else
		echo "unknown vlan type $2"
		echo ""
		usage $0
	fi
	sleep 1
	vtss_cpu 0
	vtss_power_save
	vtss_cpu 2
	vtss_cpu 1
elif [ "$1" = "2" ]; then
	if [ "$2" = "0" ]; then
		restoreEsw
	elif [ "$2" = "LLLLW" ]; then
		configEsw LLLLW
	elif [ "$2" = "WLLLL" ]; then
		configEsw WLLLL
	elif [ "$2" = "W1234" ]; then
		configEsw W1234
	elif [ "$2" = "12345" ]; then
		configEsw 12345
	elif [ "$2" = "G01234" ]; then
		configEsw G01234
	elif [ "$2" = "GW" ]; then
		configEsw GW
	else
		echo "unknown vlan type $2"
		echo ""
		usage $0
	fi
elif [ "$1" = "3" ]; then
	if [ "$2" = "0" ]; then
		restore6855Esw
	elif [ "$2" = "LLLLW" ]; then
		config6855Esw LLLLW
	elif [ "$2" = "WLLLL" ]; then
		config6855Esw WLLLL
	elif [ "$2" = "12345" ]; then
		config6855Esw 12345
	elif [ "$2" = "GW" ]; then
		config6855Esw GW
	else
		echo "unknown vlan type $2"
		echo ""
		usage $0
	fi
elif [ "$1" = "4" ]; then
	if [ "$2" = "0" ]; then
		restore7530Esw
	elif [ "$2" = "LLLLW" ]; then
		config7530Esw LLLLW
	elif [ "$2" = "WLLLL" ]; then
		config7530Esw WLLLL
	elif [ "$2" = "12345" ]; then
		config7530Esw 12345
	elif [ "$2" = "GW" ]; then
		config7530Esw GW
	else
		echo "unknown vlan type $2"
		echo ""
		usage $0
	fi
elif [ "$1" = "5" ]; then
	config7530Esw_7620AG1
else
	echo "unknown swith type $1"
	echo ""
	usage $0
fi
