#!/bin/sh
# Copyright (C) 2020 Xiaomi
#

MILED_CONFIG="/etc/config/miled"
[ -e "$MILED_CONFIG" ] || return
timer_status=$(uci -q get miled.settings.XLED_TIMER)
if [ "$timer_status" = "0" ];then
	/usr/sbin/xlde_ctl xled_timer_off	
else
	timer_open=$(uci -q get miled.settings.XLED_TIMER_OPEN)
	timer_close=$(uci -q get miled.settings.XLED_TIMER_close)
	h_open=echo $timer_open|awk -F: '{print $1}'
	m_open=echo $timer_open|awk -F: '{print $2}'
	h_close=echo $timer_close|awk -F: '{print $1}'
	m_close=echo $timer_close|awk -F: '{print $2}'
	/usr/sbin/xlde_ctl xled_timer_on $h_open $m_open $h_close $m_close
fi

ubus call miled refresh '{}'



