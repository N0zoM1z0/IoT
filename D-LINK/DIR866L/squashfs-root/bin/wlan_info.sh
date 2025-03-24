#!/bin/sh

ssid="";
psk="";
ssid5g="";
psk5g="";

lan_mac="";
wan_mac="";
domain="";
hw_ver="";

w2g_chan="";
w2g_ui_chan="";
w5g_chan="";
w5g_ui_chan="";

wlan_24G_info()
{
	ssid=`artblock_cmd get wlan0_ssid`
	psk=`artblock_cmd get wlan0_psk_pass_phrase`
}

wlan_5G_info()
{
	ssid5g=`artblock_cmd get wlan1_ssid`
	psk5g=`artblock_cmd get wlan1_psk_pass_phrase`
}

get_artblock_info()
{
	lan_mac=`artblock_cmd get lan_mac`
	wan_mac=`artblock_cmd get wan_mac`
	domain=`artblock_cmd get wlan0_domain`
	hw_ver=`artblock_cmd get hw_version`
}

get_wps_pin()
{
	wps_default_pin=`nvram show|grep wps_default_pin|cut -d "=" -f 2`
}

get_board_id()
{
	board_id=`artblock_cmd get board_id`
}

get_wlan_2g_chan()
{
	w2g_chan=`wlanconfig ath0 list chk`
	w2g_ui_chan=`wlan channel list wlan0`
}

get_wlan_5g_chan()
{
	w5g_chan=`wlanconfig ath1 list chk`
	w5g_ui_chan=`wlan channel list wlan1`
}

case $1 in
	'0')
		echo "Wireless 2.4G Information"
		wlan_24G_info
		echo "ssid=$ssid" > /tmp/default_info.txt
		echo "psk=$psk" >> /tmp/default_info.txt
		;;
	'1')
		echo "Wireless 5G Information"
		wlan_5G_info
		echo "ssid5g=$ssid5g" > /tmp/default_info.txt
		echo "psk5g=$psk5g" >> /tmp/default_info.txt
		;;
	'2')
		echo "Wireless Dual Information"
		wlan_24G_info
		wlan_5G_info
		echo "ssid=$ssid" > /tmp/default_info.txt
		echo "psk=$psk" >> /tmp/default_info.txt
		echo "ssid5g=$ssid5g" >> /tmp/default_info.txt
		echo "psk5g=$psk5g" >> /tmp/default_info.txt
		;;
	'3')
		echo "Get Artblock Information"
		get_artblock_info
		echo "lan_mac=$lan_mac" > /tmp/default_info.txt
		echo "wan_mac=$wan_mac" >> /tmp/default_info.txt
		echo "wlan0_domain=$domain" >> /tmp/default_info.txt
		echo "hw_version=$hw_ver" >> /tmp/default_info.txt
		;;
	'4')
		echo "Get 24G Channel List"
		get_wlan_2g_chan
		echo "24G=$w2g_chan" > /tmp/default_info.txt
		echo "24G_UI=$w2g_ui_chan" >> /tmp/default_info.txt
		;;
	'5')
		echo "Get 5G Channel List"
		get_wlan_5g_chan
		echo "5G=$w5g_chan" > /tmp/default_info.txt
		echo "5G_UI=$w5g_ui_chan" >> /tmp/default_info.txt
		;;
	'7')
		echo "Get WPS Pin code"
		get_wps_pin
		echo "wps_pin=$wps_default_pin" > /tmp/default_info.txt
		;;
	'8')
		echo "Get Board ID"
		get_board_id
		echo "board_id=$board_id" > /tmp/default_info.txt
		;;
	*)
		echo "Nothing to do!"
		;;
esac
