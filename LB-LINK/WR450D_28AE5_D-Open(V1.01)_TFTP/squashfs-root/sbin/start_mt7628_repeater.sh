#!/bin/sh 

local channel=`uci get wireless.mt7628.channel`
local ssid=`uci get internet.config.ssid`
local encryption=`uci get internet.config.auth`
local key=`uci get internet.config.wirelesspwd`
local authmode
local encryptype

# authmode
case "$encryption" in
    *WPA1PSKWPA2PSK*)
        authmode="WPAPSKWPA2PSK";;
    *WPA2PSK*)
        authmode="WPA2PSK";;    
    *WPA1PSK*)
        authmode="WPAPSK";;    
    *)
        authmode="OPEN";;
esac

# encryptype
case "$encryption" in
    *TKIPAES*)
        encryptype="TKIPAES";;
    *AES*)
        encryptype="AES";;    
    *TKIP*)
        encryptype="TKIP";;    
    *)
        encryptype="NONE";;
esac

ifconfig apcli0 up
ifconfig ra0 up

iwpriv ra0 set Channel=$channel
iwpriv apcli0 set ApCliEnable=0
iwpriv apcli0 set ApCliSsid=$ssid
iwpriv apcli0 set ApCliAuthMode=$authmode
iwpriv apcli0 set ApCliEncrypType=$encryptype
iwpriv apcli0 set ApCliWPAPSK=$key
#iwpriv apcli0 set ApCliBssid=
iwpriv apcli0 set ApCliEnable=1
    
