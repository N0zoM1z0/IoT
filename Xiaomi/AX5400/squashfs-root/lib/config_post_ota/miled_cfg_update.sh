#!/bin/sh

timer_status=$(uci -q get miled.settings.XLED_TIMER)

if [ -z "$timer_status" ];then
    uci set miled.settings.XLED_TIMER=0
    uci set miled.settings.XLED_TIMER_OPEN="00:00"
    uci set miled.settings.XLED_TIMER_CLOSE="00:00"
    uci commit miled
fi
