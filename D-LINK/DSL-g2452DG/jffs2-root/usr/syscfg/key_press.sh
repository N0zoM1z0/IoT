#!/bin/sh

#引用产品侧gpio配置
. /usr/syscfg/gpio_cfg.sh
. /usr/syscfg/api_log.sh
. /usr/syscfg/key_event.sh

set_led_sh="/usr/syscfg/led.sh"

# "/proc/gpio_config/key"在package/triams/xdsl/trigpio/src/trigpio.c中创建，这里不能修改
key_proc_file="/proc/gpio_config/key"

usage()
{
    echo "error event :$1"
    echo "usage:"
    echo "    $0 $MSG_MONITOR_EVT_WPS_INIT (wps key is press envent)"
    echo "    $0 $MSG_MONITOR_EVT_WLAN_INIT (wlan key is press envent)"
    echo "    $0 $MSG_MONITOR_EVT_RESET_REBOOT (reset key is press trigger 'reboot' envent)"
    echo "    $0 $MSG_MONITOR_EVT_RESET_FACTORY (reset key is press trigger 'factory default' envent)"
    echo "    $0 $MSG_MONITOR_EVT_RESET_FACTORY_CLEAN (reset key is press trigger 'factory clean' envent)"
    echo "    $0 $MSG_MONITOR_EVT_BLINK(reset key is press trigger 'blink' envent)"
}

wlan_path="InternetGatewayDevice.LANDevice.1.WLANConfiguration"

push_key_wps()
{
    local index=$1
    local WIFIEnable=`cfgcmd get ${wlan_path}.${index}.Enable`
    local WPSEnable=`cfgcmd get ${wlan_path}.${index}.WPS.Enable`
    local intf=`cfgcmd get ${wlan_path}.${index}.Name`
    if [ "$WIFIEnable" = "1" ] && [ "$WPSEnable" = "1" ]; then
      if [ -e "/usr/lib/rtl8192cd.ko" ];then
        wscd -sig_pbc ${intf}
      else
        if [ $index -eq 1 ];then
          if [ -e "/usr/lib/mt7603e_ap.ko" ]; then
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
    fi
    return
}

push_key_wlan()
{
    local isEnable24G=`/usr/sbin/cfgcmd get ${wlan_path}.1.Enable`
	local isHad5G=`/usr/sbin/cfgcmd check_obj ${wlan_path}.5`

    if [ "$isHad5G" != "0" ]; then
       if [ "$isEnable24G" == "0" ]; then
           /usr/sbin/cfgcmd oset ${wlan_path}.1.Enable 1
           nvram commit
       fi
       if [ "$isEnable24G" == "1" ]; then
           /usr/sbin/cfgcmd oset ${wlan_path}.1.Enable 0
           nvram commit
       fi
    else
       local isEnable5G=`/usr/sbin/cfgcmd get ${wlan_path}.5.Enable`
       if [ "0" != "$isEnable24G" -o "0" != "$isEnable5G" ]; then
           /usr/sbin/cfgcmd oset ${wlan_path}.1.Enable 0
           /usr/sbin/cfgcmd oset ${wlan_path}.5.Enable 0
           nvram commit
       fi
       if [ "0" == "$isEnable24G" -a "0" == "$isEnable5G" ]; then
           /usr/sbin/cfgcmd oset ${wlan_path}.1.Enable 1
           /usr/sbin/cfgcmd oset ${wlan_path}.5.Enable 1
           nvram commit
       fi
    fi 
}

push_key_reset()
{
    cmd_type=$1

    if [ $cmd_type = "reboot" ]; then
        reboot
    elif [ $cmd_type = "factory" ]; then
        /usr/sbin/cfgcmd factory
    else
        /usr/sbin/cfgcmd factory clean
    fi
}

set_AllLed_blink()
{
    $set_led_sh dsl blink  5000
    $set_led_sh wlan_n blink 5000
    $set_led_sh wlan_ac blink 5000
    $set_led_sh usb 0 blink 5000
    $set_led_sh usb 1 blink 5000
    $set_led_sh internet blink 5000
    $set_led_sh power blink 5000
    $set_led_sh power_nok blink 5000
    $set_led_sh internet_nok blink 5000
    $set_led_sh pots 0 blink 5000
    $set_led_sh pots 1 blink 5000
}

case $1 in
    "init")
    init_key
    ;;
    "$MSG_MONITOR_EVT_WPS_INIT")
    ##WPS key press envent
    push_key_wps 1
    push_key_wps 5
    ;;
    "$MSG_MONITOR_EVT_WLAN_INIT")
    ##WLAN key press envent
    push_key_wlan
    ;;
    "$MSG_MONITOR_EVT_RESET_REBOOT")
    ##RESET key 'reboot' envent
    push_key_reset "reboot"
    ;;
    "$MSG_MONITOR_EVT_RESET_FACTORY")
    ##RESET key 'factory default' envent
    push_key_reset "factory"
    ;;
    "$MSG_MONITOR_EVT_RESET_FACTORY_CLEAN")
    push_key_reset "factory_clean"
    ;;
    "$MSG_MONITOR_EVT_BLINK")
    set_AllLed_blink
    ;;
    *)
    usage $1
    exit
    ;;
esac

