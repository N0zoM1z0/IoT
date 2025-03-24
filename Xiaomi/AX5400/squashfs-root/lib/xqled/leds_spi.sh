#!/bin/sh

. /lib/functions.sh

THIS_MODULE="led"
STYPE_COLOR="color"
STYPE_FUNC="func"
TRIGGER_BLINK="blink"
TRIGGER_ON="on"
TRIGGER_OFF="off"

config_load "$THIS_MODULE"

LED_GLOBAL_CTL=`uci -q get xiaoqiang.common.BLUE_LED`

# log
LED_DBG=1

TAG="led"
LED_LOGI()
{
    [ "$LED_DBG" -gt 1 ] && sout="-s"
    logger "$sout" -p 2 -t "$TAG" "$1"
}

LED_LOGE()
{
    [ "$LED_DBG" -gt 1 ] && sout="-s"
    logger "$sout" -p 1 -t "$TAG" "$1"
}

LED_LOGD()
{
    [ "$LED_DBG" -gt 1 ] && {
        sout="-s"
        logger "$sout" -p 2 -t "$TAG" "$1"
    }
}

# get the all te support func sect-name
__slist_get()
{
    local stype="$1"
    local list=""

__func_get()
{ append list "$1"; }

    config_foreach __func_get $stype
    echo -n "$list"
}

led_func_list=$(__slist_get "$STYPE_FUNC")
color_func_list=$(__slist_get "$STYPE_COLOR")

__validate_func()
{
    local func="$1"

    # check func is support in the list
    list_contains led_func_list "$func" || {
        LED_LOGE "led func [$func] NOT defined!"
        return 11
    }

    return 0
}

__validate_color()
{
    local color="$1"

    # check func is support in the list
    list_contains color_func_list "$color" || {
        LED_LOGE "led color [$color] NOT defined!"
        return 11
    }
}

xqled_func_act()
{
    local func="$1"

    __validate_func "$func" || return $?

    local color=$(config_get $func color)
    __validate_color "$color" || return $?

    local trg=$(config_get $func trigger)

    [ -z "$color" -o -z "$trg" ] && {
        LED_LOGE " xqled [$func] option inv $color, $trg"
        return 22
    }

    if [ "$LED_GLOBAL_CTL" = "0" -a "$trg" != "$TRIGGER_OFF" ]; then
        LED_LOGI " xqled ignore func [$func] for xiaoqiang.common.BLUE_LED "
        return 0
    fi

    R=$(config_get $color R)
    G=$(config_get $color G)
    B=$(config_get $color B)

    # if led is blinking disable blink first
    echo 0 0 0 0 0 0 > /proc/hm0807a/rgbled
    echo $G $R $B $G $R $B > /proc/hm0807a/rgbled

    if [ "$trg" = "$TRIGGER_BLINK" ]; then
        blinkon=$(config_get $func msec_on)
        blinkoff=$(config_get $func msec_off)
	
	while :
        do
		echo 0 0 0 0 0 0 > /proc/hm0807a/rgbled
		usleep $(($blinkoff*1000))
		echo $G $R $B $G $R $B > /proc/hm0807a/rgbled
		usleep $(($blinkon*1000))
	done
    fi

    return $?

}
