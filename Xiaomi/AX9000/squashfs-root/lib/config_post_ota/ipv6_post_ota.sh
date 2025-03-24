#!/bin/sh
# Copyright (C) 2015 Xiaomi
. /lib/functions.sh

enable=$(uci -q get ipv6.settings.enabled)
mode=$(uci -q get ipv6.settings.mode)

[ "$enable" = "1" ] && {
	[ "$mode" = "nat" -o "$mode" = "native" ] && {
		auto=$(uci -q get network.wan_6.auto)
		[ "$auto" = "0" ] && {
			uci delete network.wan_6.auto
			uci commit network
		}
	}
}