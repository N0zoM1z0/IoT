#!/bin/sh

action=$1
wifi_type=$2
skip_band_width=0
wificonf_get_2G="wificonf -f /etc/wireless/mt7628/mt7628.dat get"
wificonf_get_5G="wificonf -f /etc/wireless/mt7663/mt7663.2.dat get"

wifi_2G_master_exist=`ifconfig | grep ra0`
wifi_2G_guest_exist=`ifconfig | grep ra1`
wifi_5G_master_exist=`ifconfig | grep rai0`
wifi_5G_guest_exist=`ifconfig | grep rai1`

system_mode=`uci get system.route.operationmode`
if [ "$system_mode" == "wisp" -o "$system_mode" == "repeater" ];then
	skip_band_width=1
fi

usage_show()
{
	echo "usage:"
	echo "wifi_setup.sh wifi_model"
	echo "wifi_setup.sh wifi_txpower all"
	echo "wifi_setup.sh wifi_txpower 2.4G"
	echo "wifi_setup.sh wifi_txpower 5.8G"
	echo "wifi_setup.sh wifi_channel all"
	echo "wifi_setup.sh wifi_channel 2.4G"
	echo "wifi_setup.sh wifi_channel 5.8G"
	echo "wifi_setup.sh wifi_restart all"
	echo "wifi_setup.sh wifi_guest_restart all"
	echo "wifi_setup.sh wifi_master_restart all"
	echo "wifi_setup.sh wifi_master_enable all"
	echo "wifi_setup.sh wifi_master_enable 2.4G"
	echo "wifi_setup.sh wifi_master_enable 5.8G"
	echo "wifi_setup.sh wifi_master_hidden 2.4G"
	echo "wifi_setup.sh wifi_master_hidden 5.8G"
	echo "wifi_setup.sh wifi_guest_arguments all"
	echo "wifi_setup.sh wifi_guest_arguments 2.4G"
	echo "wifi_setup.sh wifi_guest_arguments 5.8G"
	echo "wifi_setup.sh wifi_guest_disable 2.4G"
	echo "wifi_setup.sh wifi_guest_disable 5.8G"
	echo "wifi_setup.sh wifi_guest_disable all"
	echo "wifi_setup.sh wifi_master_disable 2.4G"
	echo "wifi_setup.sh wifi_master_disable 5.8G"
	echo "wifi_setup.sh wifi_master_disable all"
	echo "wifi_setup.sh wifi_master_arguments all"
	echo "wifi_setup.sh wifi_master_arguments 2.4G"
	echo "wifi_setup.sh wifi_master_arguments 5.8G"
}

check_wifi_scan()
{
	ifname=$1
	
	iwpriv $ifname ap_scan_running > /tmp/ap_scan_running2
	is_running=`sed -n 2p /tmp/ap_scan_running2`
	
	while true
	do
		if [ "$is_running" == "0" ];then
			break
		else
			sleep 2
			iwpriv $ifname ap_scan_running > /tmp/ap_scan_running2
			is_running=`sed -n 2p /tmp/ap_scan_running2`
		fi
	done
	
	rm -rf /tmp/ap_scan_running2
}

set_wifi_txpower()
{
	txpower_2g=`$wificonf_get_2G TxPower`
	txpower_5g=`$wificonf_get_5G TxPower`

	if [ "$wifi_type" == "2.4G" ];then
		if [ -n "$wifi_2G_master_exist" ];then
			iwpriv ra0 set TxPower=$txpower_2g
		fi
		
		if [ -n "$wifi_2G_guest_exist" ];then
			iwpriv ra1 set TxPower=$txpower_2g
		fi
	elif [ "$wifi_type" == "5.8G" ];then
		if [ -n "$wifi_5G_master_exist" ];then
			iwpriv rai0 set TxPower=$txpower_5g
		fi
		
		if [ -n "$wifi_5G_guest_exist" ];then
			iwpriv rai1 set TxPower=$txpower_5g
		fi
	elif [ "$wifi_type" == "all" ];then	
		if [ -n "$wifi_2G_master_exist" ];then
			iwpriv ra0 set TxPower=$txpower_2g
		fi
		
		if [ -n "$wifi_2G_guest_exist" ];then
			iwpriv ra1 set TxPower=$txpower_2g
		fi
		
		if [ -n "$wifi_5G_master_exist" ];then
			iwpriv rai0 set TxPower=$txpower_5g
		fi
		
		if [ -n "$wifi_5G_guest_exist" ];then
			iwpriv rai1 set TxPower=$txpower_5g
		fi
	else
		usage_show
		exit 1
	fi
}

set_wifi_master_enable()
{
	echo "set_wifi_master_enable"
	
	if [ "$wifi_type" == "2.4G" ];then
		uci set system.route.7628_wifi_start=1
		uci commit system
	
		ifconfig ra0 up
		sleep 2
		
		#set wifi mode
		wifi_2g_master_mode=`$wificonf_get_2G WirelessMode 0`
		iwpriv ra0 set WirelessMode=$wifi_2g_master_mode
		
		#set wifi hidden
		wifi_hidden=`$wificonf_get_2G HideSSID 0`
		if [ "$wifi_hidden" == "0" ];then
			iwpriv ra0 set HideSSID=0
		else
			iwpriv ra0 set HideSSID=1
		fi
		
		#set 2.4G master channel
		channel_2g=`$wificonf_get_2G Channel`
		countrycode_2g=`$wificonf_get_2G CountryCode`
		countryregion_2g=`$wificonf_get_2G CountryRegion`
		ht_bw_2g=`$wificonf_get_2G HT_BW`
		ht_bsscoexistence_2g=`$wificonf_get_2G HT_BSSCoexistence`
		
		iwpriv ra0 set CountryCode="$countrycode_2g"
		iwpriv ra0 set CountryRegion="$countryregion_2g"
		
		if [ "$skip_band_width" == "0" ];then
			iwpriv ra0 set HtBw=$ht_bw_2g
			iwpriv ra0 set HtBssCoex=$ht_bsscoexistence_2g
		fi
		
		if [ "$channel_2g" != "0" ];then
			check_wifi_scan ra0
			iwpriv ra0 set Channel=$channel_2g
		fi	
		
		#set 2.4G master arguments
		ssid_2g=`$wificonf_get_2G SSID1`
		pwd_2g=`$wificonf_get_2G WPAPSK1`
		txpower_2g=`$wificonf_get_2G TxPower`
		authmode_2g=`$wificonf_get_2G AuthMode 0`
		encryptype_2g=`$wificonf_get_2G EncrypType 0`
		pmfmfpr_2g=`$wificonf_get_2G PMFMFPR 0`
		pmfmfpc_2g=`$wificonf_get_2G PMFMFPC 0`
		rekeymethod_2g=`$wificonf_get_2G RekeyMethod 0`

		iwpriv ra0 set TxPower=$txpower_2g
		iwpriv ra0 set AuthMode=$authmode_2g
		iwpriv ra0 set EncrypType=$encryptype_2g
		#iwpriv ra0 set PMFMFPR=$pmfmfpr_2g
		#iwpriv ra0 set PMFMFPC=$pmfmfpc_2g
		iwpriv ra0 set RekeyMethod="$rekeymethod_2g"
		
		iwpriv ra0 set SSID="$ssid_2g"
		
		if [ "$authmode_2g" != "OPEN" ];then
			iwpriv ra0 set WPAPSK="$pwd_2g"
		fi
		
		/sbin/set_wifi_led.sh 2.4G
	elif [ "$wifi_type" == "5.8G" ];then
		ifconfig rai0 up
		sleep 2
		
		#set wifi mode
		wifi_5g_master_mode=`$wificonf_get_5G WirelessMode 0`
		iwpriv rai0 set WirelessMode=$wifi_5g_master_mode
		
		#set wifi hidden
		wifi_hidden=`$wificonf_get_5G HideSSID 0`
		if [ "$wifi_hidden" == "0" ];then
			iwpriv rai0 set HideSSID=0
		else
			iwpriv rai0 set HideSSID=1
		fi
	
		#set 5.8G master channel
		channel_5g=`$wificonf_get_5G Channel`
		countrycode_5g=`$wificonf_get_5G CountryCode`
		countryregion_5g=`$wificonf_get_5G CountryRegionABand`
		ht_bw_5g=`$wificonf_get_5G HT_BW`
		ht_bsscoexistence_5g=`$wificonf_get_5G HT_BSSCoexistence`
		vht_bw_5g=`$wificonf_get_5G VHT_BW`
		
		iwpriv rai0 set CountryCode="$countrycode_5g"
		iwpriv rai0 set CountryRegionABand="$countryregion_5g"
		
		if [ "$skip_band_width" == "0" ];then
			iwpriv rai0 set HtBw=$ht_bw_5g
			iwpriv rai0 set VhtBw=$vht_bw_5g
			iwpriv rai0 set HtBssCoex=$ht_bsscoexistence_5g
		fi
		
		iwpriv rai0 set Channel=$channel_5g
		if [ "$channel_5g" == "0" ];then
			iwpriv rai0 set AutoChannelSel=3
		fi
		
		#set 5.8G master arguments
		ssid_5g=`$wificonf_get_5G SSID1`
		pwd_5g=`$wificonf_get_5G WPAPSK1`
		txpower_5g=`$wificonf_get_5G TxPower`
		authmode_5g=`$wificonf_get_5G AuthMode 0`
		encryptype_5g=`$wificonf_get_5G EncrypType 0`
		pmfmfpr_5g=`$wificonf_get_5G PMFMFPR 0`
		pmfmfpc_5g=`$wificonf_get_5G PMFMFPC 0`
		rekeymethod_5g=`$wificonf_get_5G RekeyMethod 0`
		
		iwpriv rai0 set TxPower=$txpower_5g
		iwpriv rai0 set AuthMode=$authmode_5g
		iwpriv rai0 set EncrypType=$encryptype_5g
		iwpriv rai0 set PMFMFPR=$pmfmfpr_5g
		iwpriv rai0 set PMFMFPC=$pmfmfpc_5g
		iwpriv rai0 set RekeyMethod="$rekeymethod_5g"
		
		if [ "$authmode_5g" != "OPEN" ];then
			iwpriv rai0 set WPAPSK="$pwd_5g"
		fi
		
		iwpriv rai0 set SSID="$ssid_5g"		
		
		/sbin/set_wifi_led.sh 5.8G
		iwpriv rai0 set tpc_duty=050:040:030:020
		iwpriv rai0 set tpc=1:1:1:110:080:120:0010:1
	elif [ "$wifi_type" == "all" ];then
		ifconfig ra0 up
		sleep 2
		
		#set wifi mode
		wifi_2g_master_mode=`$wificonf_get_2G WirelessMode 0`
		iwpriv ra0 set WirelessMode=$wifi_2g_master_mode
		
		#set wifi hidden
		wifi_hidden=`$wificonf_get_2G HideSSID 0`
		if [ "$wifi_hidden" == "0" ];then
			iwpriv ra0 set HideSSID=0
		else
			iwpriv ra0 set HideSSID=1
		fi
		
		#set 2.4G master channel
		channel_2g=`$wificonf_get_2G Channel`
		countrycode_2g=`$wificonf_get_2G CountryCode`
		countryregion_2g=`$wificonf_get_2G CountryRegion`
		ht_bw_2g=`$wificonf_get_2G HT_BW`
		ht_bsscoexistence_2g=`$wificonf_get_2G HT_BSSCoexistence`
		
		iwpriv ra0 set CountryCode="$countrycode_2g"
		iwpriv ra0 set CountryRegion="$countryregion_2g"
		
		if [ "$skip_band_width" == "0" ];then
			iwpriv ra0 set HtBw=$ht_bw_2g
			iwpriv ra0 set HtBssCoex=$ht_bsscoexistence_2g
		fi
		
		if [ "$channel_2g" != "0" ];then
			check_wifi_scan ra0
			iwpriv ra0 set Channel=$channel_2g
		fi	
		
		#set 2.4G master arguments
		ssid_2g=`$wificonf_get_2G SSID1`
		pwd_2g=`$wificonf_get_2G WPAPSK1`
		txpower_2g=`$wificonf_get_2G TxPower`
		authmode_2g=`$wificonf_get_2G AuthMode 0`
		encryptype_2g=`$wificonf_get_2G EncrypType 0`
		pmfmfpr_2g=`$wificonf_get_2G PMFMFPR 0`
		pmfmfpc_2g=`$wificonf_get_2G PMFMFPC 0`
		rekeymethod_2g=`$wificonf_get_2G RekeyMethod 0`

		iwpriv ra0 set TxPower=$txpower_2g
		iwpriv ra0 set AuthMode=$authmode_2g
		iwpriv ra0 set EncrypType=$encryptype_2g
		#iwpriv ra0 set PMFMFPR=$pmfmfpr_2g
		#iwpriv ra0 set PMFMFPC=$pmfmfpc_2g
		iwpriv ra0 set RekeyMethod="$rekeymethod_2g"
		
		iwpriv ra0 set SSID="$ssid_2g"
		
		if [ "$authmode_2g" != "OPEN" ];then
			iwpriv ra0 set WPAPSK="$pwd_2g"
		fi
		
		ifconfig rai0 up
		sleep 2
		
		#set wifi mode
		wifi_5g_master_mode=`$wificonf_get_5G WirelessMode 0`
		iwpriv rai0 set WirelessMode=$wifi_5g_master_mode
		
		#set wifi hidden
		wifi_hidden=`$wificonf_get_5G HideSSID 0`
		if [ "$wifi_hidden" == "0" ];then
			iwpriv rai0 set HideSSID=0
		else
			iwpriv rai0 set HideSSID=1
		fi
	
		#set 5.8G master channel
		channel_5g=`$wificonf_get_5G Channel`
		countrycode_5g=`$wificonf_get_5G CountryCode`
		countryregion_5g=`$wificonf_get_5G CountryRegionABand`
		ht_bw_5g=`$wificonf_get_5G HT_BW`
		ht_bsscoexistence_5g=`$wificonf_get_5G HT_BSSCoexistence`
		vht_bw_5g=`$wificonf_get_5G VHT_BW`
		
		iwpriv rai0 set CountryCode="$countrycode_5g"
		iwpriv rai0 set CountryRegionABand="$countryregion_5g"
		
		if [ "$skip_band_width" == "0" ];then
			iwpriv rai0 set HtBw=$ht_bw_5g
			iwpriv rai0 set VhtBw=$vht_bw_5g
			iwpriv rai0 set HtBssCoex=$ht_bsscoexistence_5g
		fi
		
		iwpriv rai0 set Channel=$channel_5g
		if [ "$channel_5g" == "0" ];then
			iwpriv rai0 set AutoChannelSel=3
		fi
		
		#set 5.8G master arguments
		ssid_5g=`$wificonf_get_5G SSID1`
		pwd_5g=`$wificonf_get_5G WPAPSK1`
		txpower_5g=`$wificonf_get_5G TxPower`
		authmode_5g=`$wificonf_get_5G AuthMode 0`
		encryptype_5g=`$wificonf_get_5G EncrypType 0`
		pmfmfpr_5g=`$wificonf_get_5G PMFMFPR 0`
		pmfmfpc_5g=`$wificonf_get_5G PMFMFPC 0`
		rekeymethod_5g=`$wificonf_get_5G RekeyMethod 0`
		
		iwpriv rai0 set TxPower=$txpower_5g
		iwpriv rai0 set AuthMode=$authmode_5g
		iwpriv rai0 set EncrypType=$encryptype_5g
		iwpriv rai0 set PMFMFPR=$pmfmfpr_5g
		iwpriv rai0 set PMFMFPC=$pmfmfpc_5g
		iwpriv rai0 set RekeyMethod="$rekeymethod_5g"
		
		if [ "$authmode_5g" != "OPEN" ];then
			iwpriv rai0 set WPAPSK="$pwd_5g"
		fi
		
		iwpriv rai0 set SSID="$ssid_5g"		
		
		/sbin/set_wifi_led.sh 2.4G
		/sbin/set_wifi_led.sh 5.8G
		iwpriv rai0 set tpc_duty=050:040:030:020
		iwpriv rai0 set tpc=1:1:1:110:080:120:0010:1
	else
		usage_show
		exit 1
	fi
}

set_wifi_master_disable()
{
	echo "set_wifi_master_disable"
	if [ "$wifi_type" == "2.4G" ];then
		/sbin/set_wifi_led.sh 2.4G
		ifconfig ra0 down
	elif [ "$wifi_type" == "5.8G" ];then
		/sbin/set_wifi_led.sh 5.8G
		ifconfig rai0 down
	elif [ "$wifi_type" == "all" ];then	
		/sbin/set_wifi_led.sh 2.4G
		/sbin/set_wifi_led.sh 5.8G
		ifconfig ra0 down
		ifconfig rai0 down
	else
		usage_show
		exit 1
	fi
}

set_wifi_guest_disable()
{
	echo "set_wifi_guest_disable"
	if [ "$wifi_type" == "2.4G" ];then
		/sbin/set_wifi_led.sh 2.4G
		ifconfig ra1 down
	elif [ "$wifi_type" == "5.8G" ];then
		/sbin/set_wifi_led.sh 5.8G
		ifconfig rai1 down
	elif [ "$wifi_type" == "all" ];then	
		/sbin/set_wifi_led.sh 2.4G
		/sbin/set_wifi_led.sh 5.8G
		ifconfig ra1 down
		ifconfig rai1 down
	else
		usage_show
		exit 1
	fi
}

set_wifi_master_arguments()
{
	echo "set_wifi_master_arguments"
	
	ssid_2g=`$wificonf_get_2G SSID1`
	ssid_5g=`$wificonf_get_5G SSID1`
	
	pwd_2g=`$wificonf_get_2G WPAPSK1`
	pwd_5g=`$wificonf_get_5G WPAPSK1`
	
	txpower_2g=`$wificonf_get_2G TxPower`
	txpower_5g=`$wificonf_get_5G TxPower`
	
	authmode_2g=`$wificonf_get_2G AuthMode 0`
	authmode_5g=`$wificonf_get_5G AuthMode 0`
	
	encryptype_2g=`$wificonf_get_2G EncrypType 0`
	encryptype_5g=`$wificonf_get_5G EncrypType 0`
	
	pmfmfpr_2g=`$wificonf_get_2G PMFMFPR 0`
	pmfmfpr_5g=`$wificonf_get_5G PMFMFPR 0`

	pmfmfpc_2g=`$wificonf_get_2G PMFMFPC 0`
	pmfmfpc_5g=`$wificonf_get_5G PMFMFPC 0`
	
	rekeymethod_2g=`$wificonf_get_2G RekeyMethod 0`
	rekeymethod_5g=`$wificonf_get_5G RekeyMethod 0`
	
	if [ "$wifi_type" == "2.4G" ];then
		#set 2.4G
		if [ -n "$wifi_2G_master_exist" ];then
			iwpriv ra0 set TxPower=$txpower_2g
			iwpriv ra0 set AuthMode=$authmode_2g
			iwpriv ra0 set EncrypType=$encryptype_2g
			#iwpriv ra0 set PMFMFPR=$pmfmfpr_2g
			#iwpriv ra0 set PMFMFPC=$pmfmfpc_2g
			iwpriv ra0 set RekeyMethod="$rekeymethod_2g"
			
			iwpriv ra0 set SSID="$ssid_2g"
			
			if [ "$authmode_2g" != "OPEN" ];then
				iwpriv ra0 set WPAPSK="$pwd_2g"
			fi
		fi
	elif [ "$wifi_type" == "5.8G" ];then
		#set 5.8G
		if [ -n "$wifi_5G_master_exist" ];then
			iwpriv rai0 set TxPower=$txpower_5g
			iwpriv rai0 set AuthMode=$authmode_5g
			iwpriv rai0 set EncrypType=$encryptype_5g
			iwpriv rai0 set PMFMFPR=$pmfmfpr_5g
			iwpriv rai0 set PMFMFPC=$pmfmfpc_5g
			iwpriv rai0 set RekeyMethod="$rekeymethod_5g"
			
			if [ "$authmode_5g" != "OPEN" ];then
				iwpriv rai0 set WPAPSK="$pwd_5g"
			fi
			
			iwpriv rai0 set SSID="$ssid_5g"
		fi
	elif [ "$wifi_type" == "all" ];then
		#set 2.4G
		if [ -n "$wifi_2G_master_exist" ];then
			iwpriv ra0 set TxPower=$txpower_2g
			iwpriv ra0 set AuthMode=$authmode_2g
			iwpriv ra0 set EncrypType=$encryptype_2g
			#iwpriv ra0 set PMFMFPR=$pmfmfpr_2g
			#iwpriv ra0 set PMFMFPC=$pmfmfpc_2g
			iwpriv ra0 set RekeyMethod="$rekeymethod_2g"
			
			iwpriv ra0 set SSID="$ssid_2g"
			
			if [ "$authmode_2g" != "OPEN" ];then
				iwpriv ra0 set WPAPSK="$pwd_2g"
			fi
		fi
		#set 5.8G
		if [ -n "$wifi_5G_master_exist" ];then
			iwpriv rai0 set TxPower=$txpower_5g
			iwpriv rai0 set AuthMode=$authmode_5g
			iwpriv rai0 set EncrypType=$encryptype_5g
			iwpriv rai0 set PMFMFPR=$pmfmfpr_5g
			iwpriv rai0 set PMFMFPC=$pmfmfpc_5g
			iwpriv rai0 set RekeyMethod="$rekeymethod_5g"
			
			if [ "$authmode_5g" != "OPEN" ];then
				iwpriv rai0 set WPAPSK="$pwd_5g"
			fi
			
			iwpriv rai0 set SSID="$ssid_5g"
		fi	
	else
		usage_show
		exit 1
	fi	
}

set_wifi_master_hidden()
{
	echo "set_wifi_master_hidden"
	if [ "$wifi_type" == "2.4G" ];then
		if [ -n "$wifi_2G_master_exist" ];then
			wifi_hidden=`$wificonf_get_2G HideSSID 0`
			if [ "$wifi_hidden" == "0" ];then
				iwpriv ra0 set HideSSID=0
			else
				iwpriv ra0 set HideSSID=1
			fi
		fi
	elif [ "$wifi_type" == "5.8G" ];then
		if [ -n "$wifi_5G_master_exist" ];then
			wifi_hidden=`$wificonf_get_5G HideSSID 0`
			if [ "$wifi_hidden" == "0" ];then
				iwpriv rai0 set HideSSID=0
			else
				iwpriv rai0 set HideSSID=1
			fi
		fi
	else
		usage_show
		exit 1
	fi
}

set_wifi_channel()
{
	echo "set_wifi_channel"
	channel_2g=`$wificonf_get_2G Channel`
	channel_5g=`$wificonf_get_5G Channel`
	
	countrycode_2g=`$wificonf_get_2G CountryCode`
	countrycode_5g=`$wificonf_get_5G CountryCode`
	
	countryregion_2g=`$wificonf_get_2G CountryRegion`
	countryregion_5g=`$wificonf_get_5G CountryRegionABand`
	
	wifi_5g_master_mode=`$wificonf_get_5G WirelessMode 0`
	wifi_5g_guest_mode=`$wificonf_get_5G WirelessMode 1`
	
	ht_bw_2g=`$wificonf_get_2G HT_BW`
	ht_bw_5g=`$wificonf_get_5G HT_BW`
	
	ht_bsscoexistence_2g=`$wificonf_get_2G HT_BSSCoexistence`
	ht_bsscoexistence_5g=`$wificonf_get_5G HT_BSSCoexistence`
	
	vht_bw_5g=`$wificonf_get_5G VHT_BW`
	
	if [ "$wifi_type" == "2.4G" ];then
		#2.4G master
		if [ -n "$wifi_2G_master_exist" ];then
			iwpriv ra0 set CountryCode="$countrycode_2g"
			iwpriv ra0 set CountryRegion="$countryregion_2g"
			
			if [ "$skip_band_width" == "0" ];then
				iwpriv ra0 set HtBw=$ht_bw_2g
				iwpriv ra0 set HtBssCoex=$ht_bsscoexistence_2g
			fi
			
			if [ "$channel_2g" != "0" ];then
				check_wifi_scan ra0
				iwpriv ra0 set Channel=$channel_2g
			else
				ifconfig ra0 down
				sleep 2
				ifconfig ra0 up	
			fi	
		fi
		#2.4G guest
		if [ -n "$wifi_2G_guest_exist" ];then
			iwpriv ra1 set CountryCode="$countrycode_2g"
			iwpriv ra1 set CountryRegion="$countryregion_2g"
			
			if [ "$skip_band_width" == "0" ];then
				iwpriv ra1 set HtBw=$ht_bw_2g
				iwpriv ra1 set HtBssCoex=$ht_bsscoexistence_2g
			fi
			
			if [ "$channel_2g" != "0" ];then
				check_wifi_scan ra1
				iwpriv ra1 set Channel=$channel_2g
			else
				ifconfig ra1 down
				sleep 2
				ifconfig ra1 up	
			fi	
		fi
	elif [ "$wifi_type" == "5.8G" ];then
		#5.8G master
		if [ -n "$wifi_5G_master_exist" ];then
			iwpriv rai0 set CountryCode="$countrycode_5g"
			iwpriv rai0 set CountryRegionABand="$countryregion_5g"
			
			if [ "$skip_band_width" == "0" ];then
				iwpriv rai0 set HtBw=$ht_bw_5g
				iwpriv rai0 set VhtBw=$vht_bw_5g
				iwpriv rai0 set HtBssCoex=$ht_bsscoexistence_5g
			fi
			
			if [ -n "$wifi_5G_master_exist" ];then
				iwpriv rai0 set WirelessMode=$wifi_5g_master_mode
			fi
			
			iwpriv rai0 set Channel=$channel_5g
			if [ "$channel_5g" == "0" ];then
				iwpriv rai0 set AutoChannelSel=3
			fi
		fi
		#5.8G guest
		if [ -n "$wifi_5G_guest_exist" ];then
			iwpriv rai1 set CountryCode="$countrycode_5g"
			iwpriv rai1 set CountryRegionABand="$countryregion_5g"
			
			if [ "$skip_band_width" == "0" ];then
				iwpriv rai1 set HtBw=$ht_bw_5g
				iwpriv rai1 set VhtBw=$vht_bw_5g
				iwpriv rai1 set HtBssCoex=$ht_bsscoexistence_5g
			fi
			
			if [ -n "$wifi_5G_guest_exist" ];then
				iwpriv rai1 set WirelessMode=$wifi_5g_guest_mode
			fi
			
			iwpriv rai1 set Channel=$channel_5g
			if [ "$channel_5g" == "0" ];then
				iwpriv rai1 set AutoChannelSel=3
			fi
			
		fi
	elif [ "$wifi_type" == "all" ];then	
		#2.4G master
		if [ -n "$wifi_2G_master_exist" ];then
			iwpriv ra0 set CountryCode="$countrycode_2g"
			iwpriv ra0 set CountryRegion="$countryregion_2g"
			
			if [ "$skip_band_width" == "0" ];then
				iwpriv ra0 set HtBw=$ht_bw_2g
				iwpriv ra0 set HtBssCoex=$ht_bsscoexistence_2g
			fi
			
			if [ "$channel_2g" != "0" ];then
				check_wifi_scan ra0
				iwpriv ra0 set Channel=$channel_2g
			else
				ifconfig ra0 down
				sleep 2
				ifconfig ra0 up		
			fi	
		fi
		
		#2.4G guest
		if [ -n "$wifi_2G_guest_exist" ];then
			iwpriv ra1 set CountryCode="$countrycode_2g"
			iwpriv ra1 set CountryRegion="$countryregion_2g"
			
			if [ "$skip_band_width" == "0" ];then
				iwpriv ra1 set HtBw=$ht_bw_2g
				iwpriv ra1 set HtBssCoex=$ht_bsscoexistence_2g
			fi
			
			if [ "$channel_2g" != "0" ];then
				check_wifi_scan ra1
				iwpriv ra1 set Channel=$channel_2g
			else
				ifconfig ra1 down
				sleep 2
				ifconfig ra1 up	
			fi	
		fi
		
		#5.8G master
		if [ -n "$wifi_5G_master_exist" ];then
			iwpriv rai0 set CountryCode="$countrycode_5g"
			iwpriv rai0 set CountryRegionABand="$countryregion_5g"
			
			if [ "$skip_band_width" == "0" ];then
				iwpriv rai0 set HtBw=$ht_bw_5g
				iwpriv rai0 set VhtBw=$vht_bw_5g
				iwpriv rai0 set HtBssCoex=$ht_bsscoexistence_5g
			fi
			
			if [ -n "$wifi_5G_master_exist" ];then
				iwpriv rai0 set WirelessMode=$wifi_5g_master_mode
			fi
			
			iwpriv rai0 set Channel=$channel_5g
			if [ "$channel_5g" == "0" ];then
				iwpriv rai0 set AutoChannelSel=3
			fi
		fi
		
		#5.8G guest
		if [ -n "$wifi_5G_guest_exist" ];then
			iwpriv rai1 set CountryCode="$countrycode_5g"
			iwpriv rai1 set CountryRegionABand="$countryregion_5g"
			
			if [ "$skip_band_width" == "0" ];then
				iwpriv rai1 set HtBw=$ht_bw_5g
				iwpriv rai1 set VhtBw=$vht_bw_5g
				iwpriv rai1 set HtBssCoex=$ht_bsscoexistence_5g
			fi
			
			if [ -n "$wifi_5G_guest_exist" ];then
				iwpriv rai1 set WirelessMode=$wifi_5g_guest_mode
			fi
			
			iwpriv rai1 set Channel=$channel_5g
			if [ "$channel_5g" == "0" ];then
				iwpriv rai1 set AutoChannelSel=3
			fi
		fi
	else
		usage_show
		exit 1
	fi
}

set_wifi_model()
{
	echo "set_wifi_model"
	wifi_2g_master_mode=`$wificonf_get_2G WirelessMode 0`
	wifi_2g_guest_mode=`$wificonf_get_2G WirelessMode 1`
	wifi_5g_master_mode=`$wificonf_get_5G WirelessMode 0`
	wifi_5g_guest_mode=`$wificonf_get_5G WirelessMode 1`
	
	if [ -n "$wifi_2G_master_exist" ];then
		iwpriv ra0 set WirelessMode=$wifi_2g_master_mode
	fi
	
	if [ -n "$wifi_2G_guest_exist" ];then
		iwpriv ra1 set WirelessMode=$wifi_2g_guest_mode
	fi
	
	if [ -n "$wifi_5G_master_exist" ];then
		iwpriv rai0 set WirelessMode=$wifi_5g_master_mode
	fi
	
	if [ -n "$wifi_5G_guest_exist" ];then
		iwpriv rai1 set WirelessMode=$wifi_5g_guest_mode
	fi
}

set_wifi_guest_arguments()
{
	echo "set_wifi_guest_arguments"
	
	enable_2g_guest=`$wificonf_get_2G WIFIEnable 1`
	enable_5g_guest=`$wificonf_get_5G WIFIEnable 1`
	
	if [ "$wifi_type" == "2.4G" ];then
		if [ "$enable_2g_guest" == "0" ];then
			/sbin/set_wifi_led.sh 2.4G
			ifconfig ra1 down
		else
			uci set system.route.7628_wifi_start=1
			uci commit system
		
			ifconfig ra1 down
			sleep 2
			ifconfig ra1 up
			sleep 2
			
			#set wifi mode
			wifi_2g_guest_mode=`$wificonf_get_2G WirelessMode 1`
			iwpriv ra1 set WirelessMode=$wifi_2g_guest_mode
			
			#set wifi hidden
			wifi_hidden=`$wificonf_get_2G HideSSID 1`
			if [ "$wifi_hidden" == "0" ];then
				iwpriv ra1 set HideSSID=0
			else
				iwpriv ra1 set HideSSID=1
			fi
			
			#set 2.4G guest channel
			channel_2g=`$wificonf_get_2G Channel`
			countrycode_2g=`$wificonf_get_2G CountryCode`
			countryregion_2g=`$wificonf_get_2G CountryRegion`
			ht_bw_2g=`$wificonf_get_2G HT_BW`
			ht_bsscoexistence_2g=`$wificonf_get_2G HT_BSSCoexistence`
			
			iwpriv ra1 set CountryCode="$countrycode_2g"
			iwpriv ra1 set CountryRegion="$countryregion_2g"
			
			if [ "$skip_band_width" == "0" ];then
				iwpriv ra1 set HtBw=$ht_bw_2g
				iwpriv ra1 set HtBssCoex=$ht_bsscoexistence_2g
			fi
			
			if [ "$channel_2g" != "0" ];then
				check_wifi_scan ra1
				iwpriv ra1 set Channel=$channel_2g
			fi	
			
			#set 2.4G guest arguments
			ssid_2g=`$wificonf_get_2G SSID2`
			pwd_2g=`$wificonf_get_2G WPAPSK2`
			txpower_2g=`$wificonf_get_2G TxPower`
			authmode_2g=`$wificonf_get_2G AuthMode 1`
			encryptype_2g=`$wificonf_get_2G EncrypType 1`
			pmfmfpr_2g=`$wificonf_get_2G PMFMFPR 1`
			pmfmfpc_2g=`$wificonf_get_2G PMFMFPC 1`
			rekeymethod_2g=`$wificonf_get_2G RekeyMethod 1`
			
			iwpriv ra1 set TxPower=$txpower_2g
			iwpriv ra1 set AuthMode=$authmode_2g
			iwpriv ra1 set EncrypType=$encryptype_2g
			#iwpriv ra1 set PMFMFPR=$pmfmfpr_2g
			#iwpriv ra1 set PMFMFPC=$pmfmfpc_2g
			iwpriv ra1 set RekeyMethod="$rekeymethod_2g"
			
			iwpriv ra1 set SSID="$ssid_2g"
			
			if [ "$authmode_2g" != "OPEN" ];then
				iwpriv ra1 set WPAPSK="$pwd_2g"
			fi
			
			brctl addif br-lan ra1
			/sbin/set_wifi_led.sh 2.4G
		fi
	elif [ "$wifi_type" == "5.8G" ];then
		if [ "$enable_5g_guest" == "0" ];then
			/sbin/set_wifi_led.sh 5.8G
			ifconfig rai1 down
		else
			ifconfig rai1 down
			sleep 2
			ifconfig rai1 up
			sleep 2
			
			#set wifi mode
			wifi_5g_guest_mode=`$wificonf_get_5G WirelessMode 1`
			iwpriv rai1 set WirelessMode=$wifi_5g_guest_mode
			
			#set wifi hidden
			wifi_hidden=`$wificonf_get_5G HideSSID 1`
			if [ "$wifi_hidden" == "0" ];then
				iwpriv rai1 set HideSSID=0
			else
				iwpriv rai1 set HideSSID=1
			fi
			
			#set 5.8G guest channel
			channel_5g=`$wificonf_get_5G Channel`
			countrycode_5g=`$wificonf_get_5G CountryCode`
			countryregion_5g=`$wificonf_get_5G CountryRegionABand`
			ht_bw_5g=`$wificonf_get_5G HT_BW`
			ht_bsscoexistence_5g=`$wificonf_get_5G HT_BSSCoexistence`
			vht_bw_5g=`$wificonf_get_5G VHT_BW`
			
			iwpriv rai1 set CountryCode="$countrycode_5g"
			iwpriv rai1 set CountryRegionABand="$countryregion_5g"
			
			if [ "$skip_band_width" == "0" ];then
				iwpriv rai1 set HtBw=$ht_bw_5g
				iwpriv rai1 set VhtBw=$vht_bw_5g
				iwpriv rai1 set HtBssCoex=$ht_bsscoexistence_5g
			fi
			
			iwpriv rai1 set Channel=$channel_5g
			if [ "$channel_5g" == "0" ];then
				iwpriv rai1 set AutoChannelSel=3
			fi
			
			#set 5.8G guest arguments
			ssid_5g=`$wificonf_get_5G SSID2`
			pwd_5g=`$wificonf_get_5G WPAPSK2`
			txpower_5g=`$wificonf_get_5G TxPower`
			authmode_5g=`$wificonf_get_5G AuthMode 1`
			encryptype_5g=`$wificonf_get_5G EncrypType 1`
			pmfmfpr_5g=`$wificonf_get_5G PMFMFPR 1`
			pmfmfpc_5g=`$wificonf_get_5G PMFMFPC 1`
			rekeymethod_5g=`$wificonf_get_5G RekeyMethod 1`
			
			iwpriv rai1 set TxPower=$txpower_5g
			iwpriv rai1 set AuthMode=$authmode_5g
			iwpriv rai1 set EncrypType=$encryptype_5g
			iwpriv rai1 set PMFMFPR=$pmfmfpr_5g
			iwpriv rai1 set PMFMFPC=$pmfmfpc_5g
			iwpriv rai1 set RekeyMethod="$rekeymethod_5g"
			
			if [ "$authmode_5g" != "OPEN" ];then
				iwpriv rai1 set WPAPSK="$pwd_5g"
			fi
			
			iwpriv rai1 set SSID="$ssid_5g"	
			brctl addif br-lan rai1	
			/sbin/set_wifi_led.sh 5.8G
			iwpriv rai1 set tpc_duty=050:040:030:020
			iwpriv rai1 set tpc=1:1:1:110:080:120:0010:1
		fi
	elif [ "$wifi_type" == "all" ];then	
		if [ "$enable_2g_guest" == "0" ];then
			/sbin/set_wifi_led.sh 2.4G
			ifconfig ra1 down
		else
			ifconfig ra1 down
			sleep 2
			ifconfig ra1 up
			sleep 2
			
			#set wifi mode
			wifi_2g_guest_mode=`$wificonf_get_2G WirelessMode 1`
			iwpriv ra1 set WirelessMode=$wifi_2g_guest_mode
			
			#set wifi hidden
			wifi_hidden=`$wificonf_get_2G HideSSID 1`
			if [ "$wifi_hidden" == "0" ];then
				iwpriv ra1 set HideSSID=0
			else
				iwpriv ra1 set HideSSID=1
			fi
			
			#set 2.4G guest channel
			channel_2g=`$wificonf_get_2G Channel`
			countrycode_2g=`$wificonf_get_2G CountryCode`
			countryregion_2g=`$wificonf_get_2G CountryRegion`
			ht_bw_2g=`$wificonf_get_2G HT_BW`
			ht_bsscoexistence_2g=`$wificonf_get_2G HT_BSSCoexistence`
			
			iwpriv ra1 set CountryCode="$countrycode_2g"
			iwpriv ra1 set CountryRegion="$countryregion_2g"
			
			if [ "$skip_band_width" == "0" ];then
				iwpriv ra1 set HtBw=$ht_bw_2g
				iwpriv ra1 set HtBssCoex=$ht_bsscoexistence_2g
			fi
			
			if [ "$channel_2g" != "0" ];then
				check_wifi_scan ra1
				iwpriv ra1 set Channel=$channel_2g
			fi	
			
			#set 2.4G guest arguments
			ssid_2g=`$wificonf_get_2G SSID2`
			pwd_2g=`$wificonf_get_2G WPAPSK2`
			txpower_2g=`$wificonf_get_2G TxPower`
			authmode_2g=`$wificonf_get_2G AuthMode 1`
			encryptype_2g=`$wificonf_get_2G EncrypType 1`
			pmfmfpr_2g=`$wificonf_get_2G PMFMFPR 1`
			pmfmfpc_2g=`$wificonf_get_2G PMFMFPC 1`
			rekeymethod_2g=`$wificonf_get_2G RekeyMethod 1`
			
			iwpriv ra1 set TxPower=$txpower_2g
			iwpriv ra1 set AuthMode=$authmode_2g
			iwpriv ra1 set EncrypType=$encryptype_2g
			#iwpriv ra1 set PMFMFPR=$pmfmfpr_2g
			#iwpriv ra1 set PMFMFPC=$pmfmfpc_2g
			iwpriv ra1 set RekeyMethod="$rekeymethod_2g"
			
			iwpriv ra1 set SSID="$ssid_2g"
			
			if [ "$authmode_2g" != "OPEN" ];then
				iwpriv ra1 set WPAPSK="$pwd_2g"
			fi
			
			brctl addif br-lan ra1
			/sbin/set_wifi_led.sh 2.4G
		fi
		
		if [ "$enable_5g_guest" == "0" ];then
			/sbin/set_wifi_led.sh 5.8G
			ifconfig rai1 down
		else
			ifconfig rai1 down
			sleep 2
			ifconfig rai1 up
			sleep 2
			
			#set wifi mode
			wifi_5g_guest_mode=`$wificonf_get_5G WirelessMode 1`
			iwpriv rai1 set WirelessMode=$wifi_5g_guest_mode
			
			#set wifi hidden
			wifi_hidden=`$wificonf_get_5G HideSSID 1`
			if [ "$wifi_hidden" == "0" ];then
				iwpriv rai1 set HideSSID=0
			else
				iwpriv rai1 set HideSSID=1
			fi
			
			#set 5.8G guest channel
			channel_5g=`$wificonf_get_5G Channel`
			countrycode_5g=`$wificonf_get_5G CountryCode`
			countryregion_5g=`$wificonf_get_5G CountryRegionABand`
			ht_bw_5g=`$wificonf_get_5G HT_BW`
			ht_bsscoexistence_5g=`$wificonf_get_5G HT_BSSCoexistence`
			vht_bw_5g=`$wificonf_get_5G VHT_BW`
			
			iwpriv rai1 set CountryCode="$countrycode_5g"
			iwpriv rai1 set CountryRegionABand="$countryregion_5g"
			
			if [ "$skip_band_width" == "0" ];then
				iwpriv rai1 set HtBw=$ht_bw_5g
				iwpriv rai1 set VhtBw=$vht_bw_5g
				iwpriv rai1 set HtBssCoex=$ht_bsscoexistence_5g
			fi
			
			iwpriv rai1 set Channel=$channel_5g
			if [ "$channel_5g" == "0" ];then
				iwpriv rai1 set AutoChannelSel=3
			fi
			
			#set 5.8G guest arguments
			ssid_5g=`$wificonf_get_5G SSID2`
			pwd_5g=`$wificonf_get_5G WPAPSK2`
			txpower_5g=`$wificonf_get_5G TxPower`
			authmode_5g=`$wificonf_get_5G AuthMode 1`
			encryptype_5g=`$wificonf_get_5G EncrypType 1`
			pmfmfpr_5g=`$wificonf_get_5G PMFMFPR 1`
			pmfmfpc_5g=`$wificonf_get_5G PMFMFPC 1`
			rekeymethod_5g=`$wificonf_get_5G RekeyMethod 1`
			
			iwpriv rai1 set TxPower=$txpower_5g
			iwpriv rai1 set AuthMode=$authmode_5g
			iwpriv rai1 set EncrypType=$encryptype_5g
			iwpriv rai1 set PMFMFPR=$pmfmfpr_5g
			iwpriv rai1 set PMFMFPC=$pmfmfpc_5g
			iwpriv rai1 set RekeyMethod="$rekeymethod_5g"
			
			if [ "$authmode_5g" != "OPEN" ];then
				iwpriv rai1 set WPAPSK="$pwd_5g"
			fi
			
			iwpriv rai1 set SSID="$ssid_5g"	
			brctl addif br-lan rai1	
			/sbin/set_wifi_led.sh 5.8G
			iwpriv rai1 set tpc_duty=050:040:030:020
			iwpriv rai1 set tpc=1:1:1:110:080:120:0010:1
		fi
	else
		usage_show
		exit 1
	fi
}

set_wifi_guest_restart()
{
	set_wifi_guest_disable
	sleep 1
	set_wifi_guest_arguments
}

set_wifi_master_restart()
{
	set_wifi_master_disable
	sleep 1
	set_wifi_master_enable
}

set_wifi_restart()
{
	set_wifi_guest_restart
	sleep 1
	set_wifi_master_enable
}

case "$action" in
	wifi_master_enable)
		set_wifi_master_enable
		;;
	wifi_master_disable)
		set_wifi_master_disable
		;;
	wifi_master_arguments)
		set_wifi_master_arguments
		;;
	wifi_master_hidden)
		set_wifi_master_hidden
		;;
	wifi_channel)
		set_wifi_channel
		;;
	wifi_model)
		set_wifi_model
		;;
	wifi_guest_arguments)
		set_wifi_guest_arguments
		;;
	wifi_txpower)
		set_wifi_txpower
		;;		
	wifi_guest_disable)
		set_wifi_guest_disable
		;;
	wifi_guest_restart)
		set_wifi_guest_restart
		;;
	wifi_master_restart)
		set_wifi_master_restart
		;;		
	wifi_restart)
		set_wifi_restart
		;;																	
	*) 
		usage_show
		exit 1
		;;
esac  
