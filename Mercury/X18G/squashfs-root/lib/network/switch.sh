#!/bin/sh

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

config6855Esw()
{
	if [ "$1" = "LLLLW" ]; then
		#VLAN member port
		switch vlan  set 1 1 11110011
		switch vlan  set 2 2 00001010
		#set PVID
		switch pvid 4 2

		#set port 6 VLAN mode to User Port(tag PVID only for untagged packet)
		switch reg w 2610 81000000

		#LAN/WAN ports as security mode
		switch reg w 2004 ff0003 #port0
		switch reg w 2104 ff0003 #port1
		switch reg w 2204 ff0003 #port2
		switch reg w 2304 ff0003 #port3
		switch reg w 2404 ff0003 #port4
		switch reg w 2504 ff0003 #port5
		switch reg w 2604 ff0003 #port6
		switch tag on 6
	elif [ "$1" = "WLLLL" ]; then
		#VLAN member port
		switch vlan  set 1 1 01111011
		switch vlan  set 2 2 10000010
		#set PVID
		switch pvid 0 2

		#set port 6 VLAN mode to User Port(tag PVID only for untagged packet)
		switch reg w 2610 81000000

		#LAN/WAN ports as security mode
		switch reg w 2004 ff0003 #port0
		switch reg w 2104 ff0003 #port1
		switch reg w 2204 ff0003 #port2
		switch reg w 2304 ff0003 #port3
		switch reg w 2404 ff0003 #port4
		switch reg w 2504 ff0003 #port5
		switch reg w 2604 ff0003 #port6
		switch tag on 6
	fi
}

reloadWanSpeedAndDuplex()
{
if [ -d "/proc/mt7621" ]; then
	wan_rate=$(uci get protocol.wan.wan_rate)
	if [ "$wan_rate" == "10F" ]; then
		mii_mgr -s -p 4 -r 4 -v 0441
		mii_mgr -s -p 4 -r 9 -v 0
		mii_mgr -s -p 4 -r 0 -v 900
		mii_mgr -s -p 4 -r 0 -v 100
	elif [ "$wan_rate" == "10H" ]; then
		mii_mgr -s -p 4 -r 4 -v 0421
		mii_mgr -s -p 4 -r 9 -v 0
		mii_mgr -s -p 4 -r 0 -v 800
		mii_mgr -s -p 4 -r 0 -v 0
	elif [ "$wan_rate" == "100F" ]; then
		mii_mgr -s -p 4 -r 4 -v 0501
		mii_mgr -s -p 4 -r 9 -v 0
		mii_mgr -s -p 4 -r 0 -v 2900
		mii_mgr -s -p 4 -r 0 -v 2100
	elif [ "$wan_rate" == "100H" ]; then
		mii_mgr -s -p 4 -r 4 -v 0481
		mii_mgr -s -p 4 -r 9 -v 0
		mii_mgr -s -p 4 -r 0 -v 2800
		mii_mgr -s -p 4 -r 0 -v 2000
	elif [ "$wan_rate" == "1000F" ]; then
		mii_mgr -s -p 4 -r 9 -v 200
		mii_mgr -s -p 4 -r 0 -v 1340
	elif [ "$wan_rate" == "auto" ]; then
		mii_mgr -s -p 4 -r 4 -v 05e1
		mii_mgr -s -p 4 -r 9 -v 0600
		uci set network.wan.speed_duplex=auto
		mii_mgr -s -p 4 -r 0 -v 1240
	fi
fi
}

setup_switch()
{
	echo "7621 use an independent gmac as lan, LLLLW"
	config6855Esw LLLLW
}

reset_switch()
{
	echo "7621 use an independent gmac as lan & wan"
	restore6855Esw
}

reload_switch()
{
	reloadWanSpeedAndDuplex
}