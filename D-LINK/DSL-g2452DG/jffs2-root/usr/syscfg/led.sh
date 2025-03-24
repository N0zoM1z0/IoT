#!/bin/sh

. /usr/syscfg/api_log.sh

#引用产品侧gpio配置
. /usr/syscfg/gpio_cfg.sh

# "/proc/gpio_config/led"在package/triams/xdsl/trigpio/src/trigpio.c中创建，这里不能修改
led_proc_file="/proc/gpio_config/led"

Time=""

get_led_status()
{
    local value=""
    local status=""
    value=`/bin/cs_cli /home/cli/debug/driver/kgpio/readbit -v gpio $1 | /bin/grep 'attribute(01)-alias(level' | /usr/bin/awk '{print $4}'`
    if [ "${value}" = "00000000" ];then
        status="on"
    elif [ "${value}" = "00000001" ];then
        status="off"
    else
        status="error"
    fi
    echo -n ${status}
}

set_ledtime()
{
    if [ "$1" = "" ];then
        Time=0
    else
        Time=$1
    fi
}

dsl_led_handle()
{
    if [ "${TRI_GPIO_DSL_LED}" == "" ];then
        echo "gpio config of dsl led is empty!"
        return
    fi
    if [ "$1" = "" ];then
        get_led_status ${TRI_GPIO_DSL_LED}
        return
    fi
    case "$1" in
        "on")
        echo "${TRI_GPIO_DSL_LED} 1 $Time" > ${led_proc_file}
        ;;
        "off")
        echo "${TRI_GPIO_DSL_LED} 0 $Time" > ${led_proc_file}
        ;;
        "fastblink")
        echo "${TRI_GPIO_DSL_LED} 2 250 $Time" > ${led_proc_file}
        ;;
        "slowblink")
        echo "${TRI_GPIO_DSL_LED} 2 500 $Time" > ${led_proc_file}
        ;;
        "blink")
        echo "${TRI_GPIO_DSL_LED} 2 250 $Time" > ${led_proc_file}
        ;;
        *)
        echo "dsl_led_handle() input invalid param:$1"
        ;;
    esac
}

wlan_11AC_led_handle()
{
    if [ "${TRI_GPIO_11AC_LED}" == "" ];then
        echo "gpio config of 11ac led is empty!"
        return
    fi
    if [ "$1" = "" ];then
        get_led_status ${TRI_GPIO_11AC_LED}
        return
    fi
    case "$1" in
        "on")
        echo "${TRI_GPIO_11AC_LED} 1 $Time" > ${led_proc_file}
        ;;
        "off")
        echo "${TRI_GPIO_11AC_LED} 0 $Time" > ${led_proc_file}
        ;;
        "blink")
        echo "${TRI_GPIO_11AC_LED} 2 250 $Time" > ${led_proc_file}
        ;;
        *)
        echo "wlan_11AC_led_handle() input invalid param:$1"
        ;;
    esac
}

wlan_11N_led_handle()
{
    if [ "${TRI_GPIO_WLAN_LED}" == "" ];then
        echo "gpio config of 11n led is empty!"
        return
    fi
    if [ "$1" = "" ];then
        get_led_status ${TRI_GPIO_WLAN_LED}
        return
    fi
    case "$1" in
        "on")
        echo "${TRI_GPIO_WLAN_LED} 1 $Time" > ${led_proc_file}
        ;;
        "off")
        echo "${TRI_GPIO_WLAN_LED} 0 $Time" > ${led_proc_file}
        ;;
        "blink")
        echo "${TRI_GPIO_WLAN_LED} 2 250 $Time" > ${led_proc_file}
        ;;
        *)
        echo "wlan_11N_led_handle() input invalid param:$1"
        ;;
    esac
}

wps_led_handle()
{
    if [ "${TRI_GPIO_WPS_LED}" == "" ];then
        echo "gpio config of wps led is empty!"
        return
    fi
    if [ "$1" = "" ];then
        get_led_status ${TRI_GPIO_WPS_LED}
        return
    fi
    case "$1" in
        "on")
        echo "${TRI_GPIO_WPS_LED} 1 $Time" > ${led_proc_file}
        ;;
        "off")
        echo "${TRI_GPIO_WPS_LED} 0 $Time" > ${led_proc_file}
        ;;
        "processing")
        echo "${TRI_GPIO_WPS_LED} 2 300 0" > ${led_proc_file}
        ;;
        "err")
        echo "${TRI_GPIO_WPS_LED} 2 150 120000" > ${led_proc_file}
        ;;
        "ok")
        echo "${TRI_GPIO_WPS_LED} 1 120000" > ${led_proc_file}
        ;;
        "blink")
        echo "${TRI_GPIO_WPS_LED} 2 250 $Time" > ${led_proc_file}
        ;;
        *)
        echo "wps_led_handle() input invalid param:$1"
        ;;
    esac
}

usb_led_handle()
{
    case "$1" in
        "0")
        led=${TRI_GPIO_USB0_LED}
        ;;
        "1")
        led=${TRI_GPIO_USB1_LED}
        ;;
        *)
        echo "usb_led_handle() input invalid param:$1 $2"
        ;;
    esac
    if [ "${led}" == "" ];then
        echo "gpio config of usb $1 led is empty!"
        return
    fi
    if [ "$2" = "" ];then
        get_led_status ${led}
        return
    fi
    case "$2" in
        "on")
        echo "${led} 1 $Time" > ${led_proc_file}
        ;;
        "off")
        echo "${led} 0 $Time" > ${led_proc_file}
        ;;
        "blink")
        echo "${led} 2 250 $Time" > ${led_proc_file}
        ;;
        *)
        echo "usb_led_handle() input invalid param:$2"
        ;;
    esac
}

power_led_handle()
{
    if [ "${TRI_GPIO_POWER_LED}" == "" ];then
        echo "gpio config of power led is empty!"
        return
    fi
    if [ "$1" = "" ];then
        get_led_status ${TRI_GPIO_POWER_LED}
        return
    fi
    case "$1" in
        "on")
        echo "${TRI_GPIO_POWER_LED} 1 $Time" > ${led_proc_file}
        ;;
        "off")
        echo "${TRI_GPIO_POWER_LED} 0 $Time" > ${led_proc_file}
        ;;
        "blink")
        echo "${TRI_GPIO_POWER_LED} 2 250 $Time" > ${led_proc_file}
        ;;
        *)
        echo "power_led_handle() input invalid param:$1"
        ;;
    esac
}

power_nok_led_handle()
{
    if [ "${TRI_GPIO_POWER_NOK_LED}" == "" ];then
        echo "gpio config of power_nok led  is empty!"
        return
    fi
    if [ "$1" = "" ];then
        get_led_status ${TRI_GPIO_POWER_NOK_LED}
        return
    fi
    case "$1" in
        "on")
        echo "${TRI_GPIO_POWER_NOK_LED} 1 $Time" > ${led_proc_file}
        ;;
        "off")
        echo "${TRI_GPIO_POWER_NOK_LED} 0 $Time" > ${led_proc_file}
        ;;
        "blink")
        echo "${TRI_GPIO_POWER_NOK_LED} 2 250 $Time" > ${led_proc_file}
        ;;
        *)
        echo "power_nok_led_handle() input invalid param:$1"
        ;;
    esac
}

pots_led_handle()
{
    case "$1" in
        "0")
        led=${TRI_GPIO_POST1_LED}
        ;;
        "1")
        led=${TRI_GPIO_POST2_LED}
        ;;
        *)
        echo "pots_led_handle() input invalid param:$1 $2"
        ;;
    esac

    if [ "${led}" == "" ];then
        echo "gpio config of pots $1 led is empty!"
        return
    fi

    if [ "$2" = "" ];then
        get_led_status ${led}
        return
    fi
    
    case "$2" in
        "on")
        echo "${led} 1 $Time" > ${led_proc_file}
        ;;
        "off")
        echo "${led} 0 $Time" > ${led_proc_file}
        ;;
        "blink")
        echo "${led} 2 250 $Time" > ${led_proc_file}
        ;;
        *)
        echo "pots_led_handle() input invalid param:$2"
        ;;
    esac
}

##################################################### internet led start#########################################################
internet_led_handle()
{
    if [ "${TRI_GPIO_INTERNET_LED}" == "" ];then
        echo "gpio config of internet led is empty!"
        return
    fi
    if [ "$1" = "" ];then
        get_led_status ${TRI_GPIO_INTERNET_LED}
        return
    fi
    case "$1" in
        "on")
        echo "${TRI_GPIO_INTERNET_LED} 1 $Time" > ${led_proc_file}
        ;;
        "off")
        echo "${TRI_GPIO_INTERNET_LED} 0 $Time" > ${led_proc_file}
        ;;
        "fastblink")
        echo "${TRI_GPIO_INTERNET_LED} 2 250 $Time" > ${led_proc_file}
        ;;
        "slowblink")
        echo "${TRI_GPIO_INTERNET_LED} 2 500 $Time" > ${led_proc_file}
        ;;
        "blink")
        echo "${TRI_GPIO_INTERNET_LED} 2 250 $Time" > ${led_proc_file}
        ;;
        *)
        echo "internet_led_handle() input invalid param:$1"
        ;;
    esac
}

internet_nok_led_handle()
{
    if [ "${TRI_GPIO_INTERNET_NOK_LED}" == "" ];then
        echo "gpio config of internet_nok led is empty!"
        return
    fi
    if [ "$1" = "" ];then
        get_led_status ${TRI_GPIO_INTERNET_NOK_LED}
        return
    fi
    case "$1" in
        "on")
        echo "${TRI_GPIO_INTERNET_NOK_LED} 1 $Time" > ${led_proc_file}
        ;;
        "off")
        echo "${TRI_GPIO_INTERNET_NOK_LED} 0 $Time" > ${led_proc_file}
        ;;
        "blink")
        echo "${TRI_GPIO_INTERNET_NOK_LED} 2 250 $Time" > ${led_proc_file}
        ;;
        *)
        echo "internet_nok_led_handle() input invalid param:$1"
        ;;
    esac
}

##################################################### internet led end#########################################################

TGP_Log ${TGP_LOG_INFO} "led=${1}, action=$2, parameter=$3, time=$4"
case "$1" in
    "dsl")
        set_ledtime $3
        dsl_led_handle $2
        ;;
    "wlan_n")
        set_ledtime $3
        wlan_11N_led_handle $2
        ;;
    "wlan_ac")
        set_ledtime $3
        wlan_11AC_led_handle $2
        ;;
    "wps")
        set_ledtime $3
        wps_led_handle $2
        ;;
    "usb")
        set_ledtime $4
        usb_led_handle $2 $3
        ;;
    "internet") 
        set_ledtime $3
        internet_led_handle $2
        ;;
    "power")
        set_ledtime $3
        power_led_handle $2
        ;;
    "power_nok")
        set_ledtime $3
        power_nok_led_handle $2
        ;;
    "internet_nok")
        set_ledtime $3
        internet_nok_led_handle $2
        ;;
    "pots")
        set_ledtime $4
        pots_led_handle $2 $3
        ;;
    *)
        echo led.sh input invalid param:"$1"
    ;;
esac
