#!/bin/sh

. /usr/syscfg/gpio_cfg.sh

get_button_status()
{
    local value=""
    local status=""
    value=`/bin/cs_cli /home/cli/debug/driver/kgpio/readbit -v gpio $1 | /bin/grep 'attribute(01)-alias(level' | /usr/bin/awk '{print $4}'`
    if [ "${value}" = "00000000" ];then
        status="pressed"
    elif [ "${value}" = "00000001" ];then
        status="released"
    else
        status="error"
    fi
    echo -n ${status}
}

case "$1" in
	"wps")
		get_button_status ${TRI_GPIO_WPS_KEY}
		;;
	"wlan")
		get_button_status ${TRI_GPIO_WLAN_KEY}
		;;
	"reset")
		get_button_status ${TRI_GPIO_RESET_KEY}
		;;
    *)
        echo button.sh input invalid param:"$1"
        ;;
esac
