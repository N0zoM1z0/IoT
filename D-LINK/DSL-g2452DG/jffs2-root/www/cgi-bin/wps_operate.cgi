#!/bin/sh

parse()
{
	echo $1 | sed 's/.*'$2'=\([[:alnum:]]*\).*/\1/'
}

type=$(parse ${QUERY_STRING} "action")
index=$(parse ${QUERY_STRING} "index")

echo ${QUERY_STRING} ${type} ${index} > /tmp/wps_cgi

wlan_path="InternetGatewayDevice.LANDevice.1.WLANConfiguration"
intf=`cfgcmd get ${wlan_path}.${index}.Name`
case "$type" in
	"1") #pbc
        if [ -e "/usr/lib/rtl8192cd.ko" ] && [ "`which hostapd`" != "" ]; then
            if [ $index -eq 1 ];then
                wscd -sig_pbc ${intf}
            elif [ $index -eq 5 ];then
                hostapd_cli wps_cancel -i ${intf}
                hostapd_cli wps_pbc -i ${intf}
            fi
        elif [ -e "/usr/lib/rtl8192cd.ko" ];then
          wscd -sig_pbc ${intf}
        else
        if [ $index -eq 1 ];then
          if [ -e "/usr/lib/mt7603e_ap.ko" ]; then
            iwpriv wlan0 set WscConfMode=0
            iwpriv wlan1 set WscConfMode=0
            
            iwpriv ${intf} set WscConfMode=7
            iwpriv ${intf} set WscConfStatus=2
            iwpriv ${intf} set WscMode=2
            iwpriv ${intf} set WscGetConf=1
          elif [ "`which hostapd`" != "" ]; then
            hostapd_cli wps_cancel -i ${intf}
            hostapd_cli wps_pbc -i ${intf}
          fi
        elif [ $index -eq 5 ];then
          if [ -e "/usr/lib/mt7662e_ap.ko" ]; then
            iwpriv wlan0 set WscConfMode=0
            iwpriv wlan1 set WscConfMode=0
            
            iwpriv ${intf} set WscConfMode=7
            iwpriv ${intf} set WscConfStatus=2
            iwpriv ${intf} set WscMode=2
            iwpriv ${intf} set WscGetConf=1
          elif [ "`which hostapd`" != "" ]; then
            hostapd_cli wps_cancel -i ${intf}
            hostapd_cli wps_pbc -i ${intf}
          fi
        fi
        fi
        cfgcmd oset ${wlan_path}.$index.WPS.GeneratePinStatus "PROCESSING"
		echo "Pragma: no-cache\n"
		echo "Cache-control: no-cache\n"
		echo "Content-type: text/html"
		echo ""
		echo "OK"
		;;
	"2") #pin
		pin=$(parse ${QUERY_STRING} "value")
		wps_enable=`cfgcmd get ${wlan_path}.${index}.WPS.Enable`
		if [ "${wps_enable}" == 1 ]; then
			cfgcmd sset ${wlan_path}.${index}.WPS.GeneratePinStatus "PROCESSING"
		else
			cfgcmd sset ${wlan_path}.${index}.WPS.GeneratePinStatus ERROR
			echo "Pragma: no-cache\n"
			echo "Cache-control: no-cache\n"
			echo "Content-type: text/html"
			echo ""
			echo "wps not enable"
			exit 1
	
		fi
		cfgcmd set ${wlan_path}.${index}.WPS.DevicePassword "${pin}" > /dev/null 2>&1
        if [ -e "/usr/lib/rtl8192cd.ko" ] && [ "`which hostapd`" != "" ]; then
            if [ $index -eq 1 ];then
                iwpriv wlan0 set_mib pin=${pin}
            elif [ $index -eq 5 ];then
                hostapd_cli wps_cancel -i ${intf}
                hostapd_cli wps_pin any ${pin} -i ${intf}
            fi
        elif [ -e "/usr/lib/rtl8192cd.ko" ];then
          iwpriv wlan0 set_mib pin=${pin}
        else
          if [ $index -eq 1 ];then
            if [ -e "/usr/lib/mt7603e_ap.ko" ]; then
              iwpriv wlan0 set WscConfMode=0
              iwpriv wlan1 set WscConfMode=0

              iwpriv ${intf} set WscConfMode=4
              iwpriv ${intf} set WscConfStatus=2
              iwpriv ${intf} set WscMode=1
              iwpriv ${intf} set WscPinCode=${pin}
              iwpriv ${intf} set WscGetConf=1
            elif [ "`which hostapd`" != "" ]; then
              hostapd_cli wps_cancel -i ${intf}
              hostapd_cli wps_pin any ${pin} -i ${intf}
            fi
          elif [ $index -eq 5 ];then
            if [ -e "/usr/lib/mt7662e_ap.ko" ]; then
              iwpriv wlan0 set WscConfMode=0
              iwpriv wlan1 set WscConfMode=0

              iwpriv ${intf} set WscConfMode=4
              iwpriv ${intf} set WscConfStatus=2
              iwpriv ${intf} set WscMode=1
              iwpriv ${intf} set WscPinCode=${pin}
              iwpriv ${intf} set WscGetConf=1
            elif [ "`which hostapd`" != "" ]; then
              hostapd_cli wps_cancel -i ${intf}
              hostapd_cli wps_pin any ${pin} -i ${intf}
            fi
          fi
        fi
		cfgcmd oset ${wlan_path}.${index}.WPS.GeneratePinStatus "PROCESSING"
		echo "Pragma: no-cache\n"
		echo "Cache-control: no-cache\n"
		echo "Content-type: text/html"
		echo ""
		echo "sucess"
		;;
	"3")#reset OOB for E8
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.SSID "ChinaNet-Tnja" > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.BeaconType "WPAand11i" > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.IEEE11iEncryptionModes "TKIPandAESEncryption" > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.PreSharedKey.1.KeyPassphrase "undefined" > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.PreSharedKey.1.PreSharedKey "3132333435363738" > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.WPS.PeerPassword 27006672 > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.Enable 1 > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.2.Enable 0 > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.3.Enable 0 > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.4.Enable 0 > /dev/null 2>&1
		/usr/syscfg/wifi_init.sh > /dev/null 2>&1
		echo "Pragma: no-cache\n"
		echo "Cache-control: no-cache\n"
		echo "Content-type: text/html"
		echo ""
		echo "sucess"
		
		;;
	"4") #create pin
        if [ -e "/usr/lib/rtl8192cd.ko" ] && [ "`which hostapd`" != "" ]; then
            if [ $index -eq 1 ];then
                flash gen-pin ${intf} > /dev/null 2>&1
                pin_number=`cat /var/rtl8192c/${intf}/wsc_pin`
            elif [ $index -eq 5 ];then
                hostapd_cli wps_ap_pin  random 300 -i ${intf} 
                pin_number=`hostapd_cli wps_ap_pin get -i ${intf}` 
            fi
		elif [ -e "/usr/lib/rtl8192cd.ko" ];then
		  flash gen-pin ${intf} > /dev/null 2>&1
		  pin_number=`cat /var/rtl8192c/${intf}/wsc_pin`
		elif [ "`which hostapd`" != "" ]; then
		  hostapd_cli wps_ap_pin  random 300 -i ${intf} 
		  pin_number=`hostapd_cli wps_ap_pin get -i ${intf}` 
        else
		  iwpriv ${intf} set WscConfMode=1
		  iwpriv ${intf} set WscConfStatus=2
		  iwpriv ${intf} set WscMode=1
		  iwpriv ${intf} set WscGetConf=1
		  flash gen-pin ${intf} > /dev/null 2>&1
		  pin_number=`cat /var/RT2860AP/${intf}_pin`
		fi
		cfgcmd set ${wlan_path}.${index}.WPS.PeerPassword ${pin_number} > /dev/null 2>&1
		echo "Pragma: no-cache\n"
		echo "Cache-control: no-cache\n"
		echo "Content-type: text/html"
		echo ""
		echo "${pin_number}"
		;;
	"5") #reset OOB for SBN and Neutral
		branch=$(parse ${QUERY_STRING} "value")
		local defaultSSID=""
		if [ "$branch" == "SBN" ];then
			. /usr/syscfg/ssid_init.sh
			defaultSSID=`get_ssid 1`
			pwd=`get_pwd`
			sbn_psk=`change_str_to_ascii $pwd`
			cfgcmd set ${wlan_path}.${index}.PreSharedKey.1.KeyPassphrase "undefined" > /dev/null 2>&1
			cfgcmd set ${wlan_path}.${index}.PreSharedKey.1.PreSharedKey "$sbn_psk" > /dev/null 2>&1
		else # Neutral
		    defaultSSID=`nvram default get ${wlan_path}.${index}.SSID`
			if [ "$index" = "1" ]; then
				if [ "${defaultSSID}" == "\n" ];then
				  defaultSSID="Triductor_2GAp"
				fi
				defaultPIN="33467580"
			else
				if [ "${defaultSSID}" == "\n" ];then
				  defaultSSID="Triductor_5GAp"
				fi
				defaultPIN="33467627"
			fi
			defaultKey=`nvram default get ${wlan_path}.${index}.PreSharedKey.1.PreSharedKey`
			if [ "${defaultKey}" == "\n" ];then
			  defaultKey="3132333435363738"
			fi
			cfgcmd set ${wlan_path}.${index}.PreSharedKey.1.PreSharedKey $defaultKey > /dev/null 2>&1
			cfgcmd set ${wlan_path}.${index}.PreSharedKey.1.KeyPassphrase "undefined" > /dev/null 2>&1
		fi
		cfgcmd set ${wlan_path}.${index}.SSID "$defaultSSID" > /dev/null 2>&1
		cfgcmd set ${wlan_path}.${index}.BeaconType "WPAand11i" > /dev/null 2>&1
		cfgcmd set ${wlan_path}.${index}.IEEE11iEncryptionModes "AESEncryption" > /dev/null 2>&1

		cfgcmd set ${wlan_path}.${index}.WPS.PeerPassword ${defaultPIN} > /dev/null 2>&1
		cfgcmd set ${wlan_path}.${index}.Enable 1 > /dev/null 2>&1
		if [ "$index" = "1" ]; then
		  cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.2.Enable 0 > /dev/null 2>&1
		  cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.3.Enable 0 > /dev/null 2>&1
		  cfgcmd oset InternetGatewayDevice.LANDevice.1.WLANConfiguration.4.Enable 0 > /dev/null 2>&1
		else
		  cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.6.Enable 0 > /dev/null 2>&1
		  cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.7.Enable 0 > /dev/null 2>&1
		  cfgcmd oset InternetGatewayDevice.LANDevice.1.WLANConfiguration.8.Enable 0 > /dev/null 2>&1
		fi
		
		echo "Pragma: no-cache\n"
		echo "Cache-control: no-cache\n"
		echo "Content-type: text/html"
		echo ""
		echo "sucess"
		
		;;
	"6")#reset OOB for KW5217
		/usr/syscfg/ssid_init.sh
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.BeaconType "None" > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.1.Enable 1 > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.2.Enable 0 > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.3.Enable 0 > /dev/null 2>&1
		cfgcmd set InternetGatewayDevice.LANDevice.1.WLANConfiguration.4.Enable 0 > /dev/null 2>&1
		/usr/syscfg/wifi_init.sh > /dev/null 2>&1
		echo "Pragma: no-cache\n"
		echo "Cache-control: no-cache\n"
		echo "Content-type: text/html"
		echo ""
		echo "sucess"
		;;
esac

#save to flash
nvram commit
