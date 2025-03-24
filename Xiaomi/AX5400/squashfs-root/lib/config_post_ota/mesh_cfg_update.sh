#!/bin/sh
# Copyright (C) 2020 Xiaomi

#update mesh config in xiaoqiang
version_list=$(uci -q get misc.mesh.version)
if [ -z "$version_list" ]; then
    return
fi

old_version=$(uci -q get xiaoqiang.common.MESH_VERSION)

max_version=1
for version in $version_list; do
    if [ $version -gt $max_version ]; then
        max_version=$version
    fi
done

uci set xiaoqiang.common.MESH_VERSION="$max_version"

netmod=$(uci -q get xiaoqiang.common.NETMODE)
if [ -z "$old_version" ] && [ "$netmod" = "whc_cap" -o "$netmod" = "whc_re" ]; then
    uci set xiaoqiang.common.CAP_MODE="router"
    backhaul_5g=$(uci -q get misc.backhauls.backhaul_5g_ap_iface)
    iface_5g=$(uci show wireless | grep -w "ifname=\'$backhaul_5g\'" | awk -F"." '{print $2}')
    if [ "$netmod" = "whc_cap" ]; then
        uci set wireless.$iface_5g.mesh_aplimit='9'
    fi
    uci set wireless.$iface_5g.mesh_ver="$max_version"

    lanmac=$(uci -q get network.lan.macaddr)
    uci set wireless.$iface_5g.mesh_apmac="$lanmac"

    #uci -q delete wireless.$iface_5g.macfilter
    #uci -q delete wireless.$iface_5g.maclist
    #uci commit wireless

    #generate NETWORK_ID FROM backhaul ap ssid
    network_id="`uci -q get wireless.$iface_5g.ssid | md5sum | cut -c 1-8`"
    uci set xiaoqiang.common.NETWORK_ID="$network_id"
fi

uci commit xiaoqiang

cap_mode=$(uci -q get xiaoqiang.common.CAP_MODE)
[ -z "$cap_mode" ] && cap_mode="router"
if [ "$netmod" = "whc_cap" -o "$netmod" = "whc_re" -o "$netmod" = "lanapmode" -a "$cap_mode" = "ap" ]; then

	ifname_bh_5g=$(uci -q get misc.backhauls.backhaul_5g_ap_iface)

	iface_bh_5g=$(uci show wireless | grep -w "ifname=\'$ifname_bh_5g\'" | awk -F"." '{print $2}')

	#uci -q delete wireless.$iface_bh_5g.macfilter
	#uci -q delete wireless.$iface_bh_5g.maclist
	#uci commit wireless
fi
