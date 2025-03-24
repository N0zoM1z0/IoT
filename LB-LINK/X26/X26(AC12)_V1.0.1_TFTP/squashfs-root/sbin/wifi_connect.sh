#!/bin/sh

wifi_ifname=$1
operationmode=`uci get system.route.operationmode`
apcli_connect=`iwconfig $wifi_ifname | grep Not-Associated`

if [ -z "$apcli_connect" ];then
	exit 0
fi

if [ "$wifi_ifname" == "apcli0" ];then
	wificonf -f /etc/wireless/mt7628/mt7628.dat set ApCliEnable 1
else
	wificonf -f /etc/wireless/mt7663/mt7663.2.dat set ApCliEnable 1
fi

if [ "$operationmode" == "wisp" ];then
	ApCliAuthMode=`uci get internet.wisp.ApCliAuthMode`
	ApCliEncrypType=`uci get internet.wisp.ApCliEncrypType`
	ApCliSsid=`uci get internet.wisp.ApCliSsid`
	ApCliWPAPSK=`uci get internet.wisp.ApCliWPAPSK`
	Channel=`uci get internet.wisp.Channel`
elif [ "$operationmode" == "repeater" ];then
	ApCliAuthMode=`uci get internet.repeater.ApCliAuthMode`
	ApCliEncrypType=`uci get internet.repeater.ApCliEncrypType`
	ApCliSsid=`uci get internet.repeater.ApCliSsid`
	ApCliWPAPSK=`uci get internet.repeater.ApCliWPAPSK`
	Channel=`uci get internet.repeater.Channel`
else
	echo "nonsupport mode"
	exit 0	
fi

if [ $wifi_ifname == "apcli0" ];then
	iwpriv apcli0 ap_scan_running > /tmp/ap_scan_running
	is_running=`sed -n 2p /tmp/ap_scan_running`
	
	while true
	do
		if [ "$is_running" == "0" ];then
			break
		else
			sleep 2
			iwpriv apcli0 ap_scan_running > /tmp/ap_scan_running
			is_running=`sed -n 2p /tmp/ap_scan_running`
		fi
	done
	
	rm -rf /tmp/ap_scan_running
fi

ifconfig $wifi_ifname up
iwpriv $wifi_ifname set MACRepeaterEn=0
iwpriv $wifi_ifname set ApCliEnable=0
iwpriv $wifi_ifname set Channel="$Channel"
iwpriv $wifi_ifname set ApCliAuthMode="$ApCliAuthMode"
iwpriv $wifi_ifname set ApCliEncrypType="$ApCliEncrypType"

if [ -n $ApCliWPAPSK ];then
	iwpriv $wifi_ifname set ApCliWPAPSK="$ApCliWPAPSK"
fi

iwpriv $wifi_ifname set ApCliSsid="$ApCliSsid"
iwpriv $wifi_ifname set ApCliEnable=1
