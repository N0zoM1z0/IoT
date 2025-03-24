#!/bin/sh

wificonf_get_2G="wificonf -f /etc/wireless/mt7628/mt7628.dat get"
wificonf_get_5G="wificonf -f /etc/wireless/mt7663/mt7663.2.dat get"

set_2g_led()
{
	wifi_2G_master_exist=`ifconfig | grep ra0`
	wifi_2G_guest_exist=`ifconfig | grep ra1`
	enable_2g_master=`$wificonf_get_2G WIFIEnable 0`
	enable_2g_guest=`$wificonf_get_2G WIFIEnable 1`
	
	if [ "$enable_2g_master" == "0" -a "$enable_2g_guest" == "0" ];then
		if [ -n "$wifi_2G_master_exist" ];then
			iwpriv ra0 set led=20
		elif [ -n "$wifi_2G_guest_exist" ];then
			iwpriv ra1 set led=20
		fi
	else
		if [ -n "$wifi_2G_master_exist" ];then
			iwpriv ra0 set led=22
			uci set system.route.led_2g_blink=0
			uci commit system
		elif [ -n "$wifi_2G_guest_exist" ];then
			iwpriv ra1 set led=22
			uci set system.route.led_2g_blink=0
			uci commit system
		fi
	fi
}

set_5g_led()
{
	wifi_5G_master_exist=`ifconfig | grep rai0`
	wifi_5G_guest_exist=`ifconfig | grep rai1`
	enable_5g_master=`$wificonf_get_5G WIFIEnable 0`
	enable_5g_guest=`$wificonf_get_5G WIFIEnable 1`
	
	if [ "$enable_5g_master" == "0" -a "$enable_5g_guest" == "0" ];then
		if [ -n "$wifi_5G_master_exist" ];then
			iwpriv rai0 set led_setting=1-0-0-0-2-0-0-1
		elif [ -n "$wifi_5G_guest_exist" ];then
			iwpriv rai1 set led_setting=1-0-0-0-2-0-0-1
		fi
	else
		if [ -n "$wifi_5G_master_exist" ];then
			iwpriv rai0 set led_setting=1-0-0-0-2-0-0-2
		elif [ -n "$wifi_5G_guest_exist" ];then
			iwpriv rai1 set led_setting=1-0-0-0-2-0-0-2
		fi
	fi
}

if [ "$1" == "2.4G" ];then
	set_2g_led
elif [ "$1" == "5.8G" ];then
	set_5g_led
else
	echo "Usage: set_wifi_led.sh 2.4G or 5.8G"
fi

