#!/bin/sh
# Copyright (C) 2006-2014 OpenWrt.org

pid=$(ps | grep "hostapd_2g" | head -n 1| awk '{print $1}') && kill -9 $pid
pid=$(ps | grep "hostapd_5g" | head -n 1| awk '{print $1}') && kill -9 $pid

# For wifi6 driver, should all vap down for caldata effect
devList=$(iw dev | grep Interface | cut -d' ' -f2)

for ifname in ${devList}; do (
	ifconfig $ifname down
); done