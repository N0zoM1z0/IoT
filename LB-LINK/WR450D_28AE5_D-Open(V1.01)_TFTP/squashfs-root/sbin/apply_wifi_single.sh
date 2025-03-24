#!/bin/sh

ifc_name=$1
action=$2

case "$ifc_name" in
    ra0)  idx=0;;
    ra1)  idx=1;;
    ra2)  idx=2;;
    ra3)  idx=3;;
    rai0) idx=4;;
    rai1) idx=5;;
    rai2) idx=6;;
    rai3) idx=7;;
    *) 
        echo "ifc name error, should look like 'apply_wifi_single ra0 enable'."
        exit 1
        ;; 
esac   

if [ $idx -lt 4 ]
then
    device_name=`uci get wireless.@wifi-device[0].type`
else
    device_name=`uci get wireless.@wifi-device[1].type`
fi

echo "device_name=${device_name}"

set_wifi_txpower()
{
    local txpower=`uci get wireless.${device_name}.txpower`
    echo "set TxPower=$txpower"
   
    if [ $idx -lt 4 ]
    then
        iwpriv ra0 set TxPower=$txpower
    else
        if [ "$device_name" == "mt7663e" ]
        then
            iwpriv rai0 set PercentageCtrl=1
            iwpriv rai0 set PowerDropCtrl=$txpower
        elif [ "$device_name" == "mt7612e" ]
        then
            iwpriv rai0 set TxPower=$txpower
        else
            iwpriv rai0 set TxPower=$txpower
        fi
    fi
}

set_wifi_channel()
{
    # Move setting channel function ... 
    return

    if [ "$device_name" == "mt7628" ]; then
        return
    fi
    
    uci2dat -d $device_name -f /etc/wireless/$device_name/$device_name.dat > /dev/null
    
    # --- set channel and bandwidth.
    local channel=`uci get wireless.${device_name}.channel`
    local bw
    
    if [ $idx -lt 4 ]
    then
        # ------ 2.4G ------
        bw=`uci get misc.wifi.dw_g24`
        
        if [ $bw -eq 0 ]
        then
            # auto
            iwpriv ra0 set HtBw=1
            iwpriv ra0 set HtBssCoex=1
        elif [ $bw -eq 1 ]
        then
            # 20MHz
            iwpriv ra0 set HtBw=0
            iwpriv ra0 set HtBssCoex=1
        else
            # 40MHz
            iwpriv ra0 set HtBw=1
            iwpriv ra0 set HtBssCoex=0
        fi
        
        iwpriv ra0 set Channel=0
        sleep 2 
        iwpriv ra0 set Channel=$channel
    else
        # ------ 5.8G ------
        bw=`uci get misc.wifi.dw_g5`
        
        if [ $bw -eq 0 ] || [ $bw -eq 3 ]
        then
            # auto or 80Mhz
            iwpriv rai0 set HtBw=1
            iwpriv rai0 set VhtBw=1
            iwpriv rai0 set WirelessMode=14
            iwpriv rai0 set HtBssCoex=1
        elif [ $bw -eq 1 ]
        then
            # 20MHz
            iwpriv rai0 set HtBw=0
            iwpriv rai0 set VhtBw=0
            iwpriv rai0 set WirelessMode=8
            iwpriv rai0 set HtBssCoex=1
        else
            # 40MHz
            iwpriv rai0 set HtBw=1
            iwpriv rai0 set VhtBw=0
            iwpriv rai0 set WirelessMode=14
            iwpriv rai0 set HtBssCoex=0
        fi
        
        ifconfig rai0 down
        sleep 3
        ifconfig rai0 up

        if [ $idx -ge 4 ] && [ "$device_name" == "mt7612e" ]             
        then
            iwpriv rai0 set Channel=$channel
        fi
    fi
}

set_key_val()
{
    MT7628_DAT=/etc/wireless/mt7628/mt7628.dat
    local key=$1
    local val=$2
    sed -i "s|^[#]*[ ]*${key}\([ ]*\)=.*|${key}=${val}|" ${MT7628_DAT}
}

authmode_g="WPAPSKWPA2PSK"
encryptype_g="AES"

get_mt7628_auth_info()
{
    local ra_idx=$1
    local encryption=`uci get wireless.@wifi-iface[$ra_idx].encryption`
    local authmode
    local encryptype

    # authmode
    case "$encryption" in
        *mixed*)
            authmode="WPAPSKWPA2PSK";;
        *psk2*)
            authmode="WPA2PSK";;    
        *psk*)
            authmode="WPAPSK";;    
        *wep*)
            authmode="OPEN";;    
        *)
            authmode="OPEN";;
    esac

    # encryptype
    case "$encryption" in
        *tkip+ccmp*)
            encryptype="TKIPAES";;
        *tkip*)
            encryptype="TKIP";;    
        *ccmp*)
            encryptype="AES";;    
        *wep*)
            encryptype="WEP"
            key=`uci get wireless.@wifi-iface[$idx].key1`
            ;;    
        *)
            encryptype="NONE";;
    esac
 
    authmode_g=$authmode
    encryptype_g=$encryptype
}

set_mt7628_enable()
{    
    local ssid=`uci get wireless.@wifi-iface[$idx].ssid`
    local encryption=`uci get wireless.@wifi-iface[$idx].encryption`
    local key=`uci get wireless.@wifi-iface[$idx].key`
    local hidden=`uci get wireless.@wifi-iface[$idx].hidden`
    local txpower=`uci get wireless.${device_name}.txpower`
    local channel=`uci get wireless.${device_name}.channel`
    local bw=`uci get misc.wifi.dw_g24`
    
    local authmode
    local encryptype
    local no=$(($idx+1)) 

    # get $idx auth info
    get_mt7628_auth_info $idx
    authmode=$authmode_g
    encryptype=$encryptype_g
    
    # set Key / password 
    case "$encryptype" in
    NONE)
        set_key_val "WPAPSK$no" ""
        ;;
    WEP) 
        set_key_val "DefaultKeyID" 1
        set_key_val "Key1Str$no" $key
        ;;
    *)               
        set_key_val "WPAPSK$no" $key
        ;;           
    esac

    # ra0 auth info
    get_mt7628_auth_info 0
    authmode=$authmode_g
    encryptype=$encryptype_g
    # ra1 auth info.  ~_~
    get_mt7628_auth_info 1
    authmode="$authmode;$authmode_g"
    encryptype="$encryptype;$encryptype_g"
    
    # set authmode / encryptype / ssid
    set_key_val "AuthMode" $authmode
    set_key_val "EncrypType" $encryptype
    set_key_val "SSID$no" "$ssid"
    
    if [ "$idx" == "0" ]; then
        # hidessid / txpower
        hidden="$hidden;0;0;0"
        set_key_val "HideSSID" $hidden
        set_key_val "TxPower" $txpower
        
        # set RF TxPower.
        iwpriv ra0 set TxPower=$txpower
    
        # set bandwidth / channel
        if [ $bw -eq 0 ]; then
            # auto
            set_key_val "HT_BW" "1"
            set_key_val "HT_BSSCoexistence" "1"
            iwpriv ra0 set HtBw=1
            iwpriv ra0 set HtBssCoex=1
        elif [ $bw -eq 1 ]; then
            # 20MHz
            set_key_val "HT_BW" "0"
            set_key_val "HT_BSSCoexistence" "1"
            iwpriv ra0 set HtBw=0
            iwpriv ra0 set HtBssCoex=1
        else
            # 40MHz
            set_key_val "HT_BW" "1"
            set_key_val "HT_BSSCoexistence" "0"
            iwpriv ra0 set HtBw=1
            iwpriv ra0 set HtBssCoex=0
        fi
    
        set_key_val "Channel" "$channel"
        if [ "$channel" == "0" ]; then
            channel=1
        fi
        iwpriv ra0 set Channel=$channel
    fi
        
    # Now, ifconfig down, then up.
    ifconfig $ifc_name down
    sleep 1
    ifconfig $ifc_name up

    # mt7628: should do iwpriv cmd for ssid/key.

    get_mt7628_auth_info $idx                               
    authmode=$authmode_g                                   
    encryptype=$encryptype_g

    iwpriv $ifc_name set SSID="$ssid"
    iwpriv $ifc_name set AuthMode="$authmode"
    iwpriv $ifc_name set EncrypType="$encryptype"
    iwpriv $ifc_name set WPAPSK="$key"
    iwpriv $ifc_name set SSID="$ssid"
    
    echo "------ mt7628 iwpriv set channel=$channel !!!!!------"  >  /dev/console
    
    # mt7628: set channel secondly
    if [ "$idx" == "0" ]; then 
        iwpriv ra0 set Channel=$channel
    fi
    
    # mt7628 2G LED
    iwpriv ra0 set led=1
    iwpriv ra0 set WlanLed=0
}

set_wifi_enable()
{    
    if [ "$device_name" == "mt7628" ]; then
        set_mt7628_enable
        return
    fi
    
    local mt7612e_drv_exist=`ls /lib/modules/3.10.108 | grep 'mt76x2e.ko'`
    if [ $idx -ge 4 ] && [ "$mt7612e_drv_exist" == "" ]; then
        return
    fi
        
    uci2dat -d $device_name -f /etc/wireless/$device_name/$device_name.dat > /dev/null    

    # need to ifconfig down/up.
    ifconfig $ifc_name down
    sleep 1
    ifconfig $ifc_name up
    
    # get wifi config date form /etc/config/wireless.
    local ssid=`uci get wireless.@wifi-iface[$idx].ssid`
    local encryption=`uci get wireless.@wifi-iface[$idx].encryption`
    local key=`uci get wireless.@wifi-iface[$idx].key`
    local authmode
    local encryptype
  
    echo "----- get wifi config date form /etc/config/wireless. -----"  
    echo "ssid=$ssid, encryption=$encryption, key=$key, ifc_name=$ifc_name"

    # authmode
    case "$encryption" in
        *mixed*)
            authmode="WPAPSKWPA2PSK";;
        *psk2*)
            authmode="WPA2PSK";;    
        *psk*)
            authmode="WPAPSK";;    
        *wep*)
            authmode="OPEN";;    
        *)
            authmode="OPEN";;
    esac

    # encryptype
    case "$encryption" in
        *tkip+ccmp*)
            encryptype="TKIPAES";;
        *tkip*)
            encryptype="TKIP";;    
        *ccmp*)
            encryptype="AES";;    
        *wep*)
            encryptype="WEP"
            key=`uci get wireless.@wifi-iface[$idx].key1`
            ;;    
        *)
            encryptype="NONE";;
    esac
 
    # iwpriv cmd.
    echo "--- set SSIDSingle, AuthModeSingle, EncrypType. -----"
    echo "ssid=$ssid, authmode=$authmode, encryptype=$encryptype, key=$key"

    # set RF TxPower.
    set_wifi_txpower

    # set Key            
    case "$encryptype" in
        NONE)            
            echo "authmode=$authmode, encryptype==NONE." 
            ;;           
        WEP)             
            iwpriv $ifc_name set DefaultKeyID=1             
            iwpriv $ifc_name set Key1=$key   
            ;;           
        *)
            iwpriv $ifc_name set WPAPSK=$key 
            ;;           
    esac

    # Note: Setting ssid command should be the last iwpriv command.
    if [ $idx -lt 4 ]
    then
        iwpriv $ifc_name set AuthModeSingle=$authmode
        iwpriv $ifc_name set EncrypType=$encryptype
        iwpriv $ifc_name set SSIDSingle=$ssid    
    else
        iwpriv $ifc_name set AuthMode=$authmode
        iwpriv $ifc_name set EncrypType=$encryptype
        iwpriv $ifc_name set SSID=$ssid
    fi
  
    # set SSID twice.
    if [ $idx -lt 4 ]
    then
        iwpriv $ifc_name set SSIDSingle=$ssid    
    else
        iwpriv $ifc_name set SSID=$ssid
    fi

    if [ $idx -ge 4 ] && [ "$device_name" == "mt7612e" ]
    then
        # set Key    
        case "$encryptype" in       
            NONE)    
                echo "authmode=$authmode, encryptype==NONE."           
                ;;
            WEP)
                iwpriv $ifc_name set DefaultKeyID=1
                iwpriv $ifc_name set Key1=$key
                ;;
            *)
                iwpriv $ifc_name set WPAPSK=$key
                ;;
        esac

        # set bandwidth for changing TKIP/WEP to normal mode.
        local channel=`uci get wireless.${device_name}.channel`
        local bw=`uci get misc.wifi.dw_g5`
        if [ $bw -eq 0 ] || [ $bw -eq 3 ]
        then
            # auto or 80Mhz
            iwpriv rai0 set HtBw=1
            iwpriv rai0 set VhtBw=1
            iwpriv rai0 set WirelessMode=14
            iwpriv rai0 set HtBssCoex=1
        elif [ $bw -eq 1 ]
        then
            # 20MHz
            iwpriv rai0 set HtBw=0
            iwpriv rai0 set VhtBw=0
            iwpriv rai0 set WirelessMode=8
            iwpriv rai0 set HtBssCoex=1
        else
            # 40MHz
            iwpriv rai0 set HtBw=1
            iwpriv rai0 set VhtBw=0
            iwpriv rai0 set WirelessMode=14
            iwpriv rai0 set HtBssCoex=0
        fi
        
        iwpriv rai0 set Channel=$channel
    fi   

    #if [ "$ifc_name" == "ra0" -o "$ifc_name" == "ra1" -o "$ifc_name" == "ra2" -o "$ifc_name" == "ra3" ]; then
        # sys_led=`uci get system.@system[0].led | tr -d '\n'`
        # ra0_led=`uci get wireless.mt7603e.led | tr -d '\n'`
        # [ "sys_led" = "1" -a "$ra0_led" = "1" ] && iwpriv ra0 set MT7603LED=0
    #fi
    
    if [ "$ifc_name" == "rai0" -o "$ifc_name" == "rai1" -o "$ifc_name" == "rai2" -o "$ifc_name" == "rai3" ]; then
        iwpriv rai0 set LedOn=1
    fi
}


set_wifi_disable()
{
    # 2G LED
    if [ "$ifc_name" == "ra0" -o "$ifc_name" == "ra1" -o "$ifc_name" == "ra2" -o "$ifc_name" == "ra3" ]; then
		radio0=`uci get wireless.@wifi-iface[0].disabled | tr -d '\n'`
		radio1=`uci get wireless.@wifi-iface[1].disabled | tr -d '\n'`
		radio2=`uci get wireless.@wifi-iface[2].disabled | tr -d '\n'`
		radio3=`uci get wireless.@wifi-iface[3].disabled | tr -d '\n'`
		if [ $radio0 = "1" -a $radio1 = "1" -a $radio2 = "1" -a $radio3 = "1"  ]; then
	    	# iwpriv ra0 set MT7603LED=1
	    	# for mt7628
	    	iwpriv ra0 set led=0
	    else
	        iwpriv ra0 set led=1
    	fi
    fi
    
    # 5.8G LED
    if [ "$ifc_name" == "rai0" -o "$ifc_name" == "rai1" -o "$ifc_name" == "rai2" -o "$ifc_name" == "rai3" ]; then
		radio0=`uci get wireless.@wifi-iface[4].disabled | tr -d '\n'`
		radio1=`uci get wireless.@wifi-iface[5].disabled | tr -d '\n'`
		radio2=`uci get wireless.@wifi-iface[6].disabled | tr -d '\n'`
		radio3=`uci get wireless.@wifi-iface[7].disabled | tr -d '\n'`
		if [ $radio0 = "1" -a $radio1 = "1" -a $radio2 = "1" -a $radio3 = "1"  ]; then
	    	# for mt7612e
	    	iwpriv rai0 set LedOn=0
	    else
	        iwpriv rai0 set LedOn=1
    	fi
    fi
    
    ifconfig $ifc_name down
}


# --- main process ---
case "$action" in
    enable)
        set_wifi_enable
        ;;
    disable)
        set_wifi_disable
        ;;
    channel)
        set_wifi_channel
        ;;
    txpower)
        set_wifi_txpower
        ;;    
    *) 
        echo "parameter format error, should look like 'apply_wifi_single ra0 enable'."
        exit 1
        ;;
esac  

case "$ifc_name" in
    ra0  | \
    ra1  | \
    ra2  | \
    ra3  | \
    rai0 | \
    rai1 | \
    rai2 | \
    rai3)
        isbr=`brctl show | grep $ifc_name | wc -l | tr -d '\n'` 
        [ "$isbr" = "0" ] && brctl addif br-lan $ifc_name
        ;;
esac

exit 0
