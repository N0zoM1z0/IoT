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
    bh_tag=$(uci -q get misc.backhauls.backhaul)
    [ -z "$bh_tag" ] && bh_tag="game"
    ifname_bh=$(uci -q get misc.backhauls.backhaul_${bh_tag}_ap_iface)
    iface_bh=$(uci show wireless | grep "ifname=\'$ifname_bh\'" | awk -F"." '{print $2}')
    if [ "$netmod" = "whc_cap" ]; then
        uci set wireless.$iface_bh.mesh_aplimit='9'
    fi
    uci set wireless.$iface_bh.mesh_ver="$max_version"

    lanmac=$(uci -q get network.lan.macaddr)
    uci set wireless.$iface_bh.mesh_apmac="$lanmac"

    uci -q delete wireless.$iface_bh.macfilter
    uci -q delete wireless.$iface_bh.maclist
    uci commit wireless

    #generate NETWORK_ID FROM backhaul ap ssid
    network_id="`uci -q get wireless.$iface_bh.ssid | md5sum | cut -c 1-8`"
    uci set xiaoqiang.common.NETWORK_ID="$network_id"
fi

if [ -n "$netmod" ] && [ "$netmod" = "whc_re" ]; then
    bh_caps=$(uci -q get misc.backhauls.backhaul_caps)
    [ -z "$bh_caps" ] && {
        uci set misc.backhauls.backhaul_caps="game 5g"
        uci commit misc
    }
    ifname_ap_bh=$(uci -q get misc.backhauls.backhaul_game_ap_iface)
    iface_ap_bh=$(uci show wireless | grep "ifname=\'$ifname_ap_bh\'" | awk -F"." '{print $2}')
    uci -q delete wireless.$iface_ap_bh.macfilter
    uci -q delete wireless.$iface_ap_bh.maclist
    uci commit wireless

    ifname_bh_ap_sec=$(uci -q get misc.backhauls.backhaul_5g_ap_iface)
    uci show wireless | grep -qw "$ifname_bh_ap_sec"
    [ $? -ne 0 ] && {
        ifname_sta_bh=$(uci -q get misc.backhauls.backhaul_game_sta_iface)
        iface_sta_bh=$(uci show wireless | grep "ifname=\'$ifname_sta_bh\'" | awk -F"." '{print $2}')
        ssid_bh=$(uci -q get wireless.$iface_ap_bh.ssid)
        mgmt_bh=$(uci -q get wireless.$iface_ap_bh.encryption)
        pswd_bh=$(uci -q get wireless.$iface_ap_bh.key)
        apmac_bh=$(uci -q get wireless.$iface_ap_bh.mesh_apmac)
        eth_init_bh=$(uci -q get wireless.$iface_sta_bh.disabled)

        bh_radio_device_sec=$(uci -q get misc.wireless.if_5G)
        index_bh_ap_sec=$(cat /etc/config/wireless | grep -c -w 'config wifi-iface')
        ifname_bh_sta_sec=$(uci -q get misc.backhauls.backhaul_5g_sta_iface)
        index_bh_sta_sec=$((index_bh_ap_sec+1))
        ii=$index_bh_ap_sec
        uci -q batch <<-EOF >/dev/null
add wireless wifi-iface
set wireless.@wifi-iface[$ii].device="$bh_radio_device_sec"
set wireless.@wifi-iface[$ii].ifname="$ifname_bh_ap_sec"
set wireless.@wifi-iface[$ii].network='lan'
set wireless.@wifi-iface[$ii].mode='ap'
set wireless.@wifi-iface[$ii].channel_block_list='36,40,44,48,52,56,60,64,165'
set wireless.@wifi-iface[$ii].ssid="$ssid_bh"
set wireless.@wifi-iface[$ii].encryption="$mgmt_bh"
set wireless.@wifi-iface[$ii].key="$pswd_bh"
set wireless.@wifi-iface[$ii].hidden='1'
set wireless.@wifi-iface[$ii].backhaul='1'
set wireless.@wifi-iface[$ii].backhaul_ap='1'
set wireless.@wifi-iface[$ii].wds='1'
set wireless.@wifi-iface[$ii].wps_pbc='1'
set wireless.@wifi-iface[$ii].wps_pbc_enable='0'
set wireless.@wifi-iface[$ii].wps_pbc_start_time='0'
set wireless.@wifi-iface[$ii].wps_pbc_duration='120'
set wireless.@wifi-iface[$ii].group='0'
set wireless.@wifi-iface[$ii].athnewind='1'
set wireless.@wifi-iface[$ii].mesh_ver='2'
set wireless.@wifi-iface[$ii].mesh_apmac="$apmac_bh"
set wireless.@wifi-iface[$ii].miwifi_mesh='0'
EOF
        ii=$index_bh_sta_sec
        uci -q batch <<-EOF >/dev/null
add wireless wifi-iface
set wireless.@wifi-iface[$ii]=wifi-iface
set wireless.@wifi-iface[$ii].device="$bh_radio_device_sec"
set wireless.@wifi-iface[$ii].ifname="$ifname_bh_sta_sec"
set wireless.@wifi-iface[$ii].network='lan'
set wireless.@wifi-iface[$ii].mode='sta'
set wireless.@wifi-iface[$ii].ssid="$ssid_bh"
set wireless.@wifi-iface[$ii].encryption="$mgmt_bh"
set wireless.@wifi-iface[$ii].key="$pswd_bh"
set wireless.@wifi-iface[$ii].wds='1'
set wireless.@wifi-iface[$ii].wps_pbc='1'
set wireless.@wifi-iface[$ii].wps_pbc_enable='0'
set wireless.@wifi-iface[$ii].wps_pbc_start_time='0'
set wireless.@wifi-iface[$ii].wps_pbc_duration='120'
set wireless.@wifi-iface[$ii].disabled='$eth_init_bh'
set wireless.@wifi-iface[$ii].backhaul='1'
set wireless.@wifi-iface[$ii].group='0'
set wireless.@wifi-iface[$ii].athnewind='1'
EOF
        uci commit wireless
    } || {
        iface_bh_ap_sec=$(uci show wireless | grep "ifname=\'$ifname_bh_ap_sec\'" | awk -F"." '{print $2}')
        uci -q delete wireless.$iface_bh_ap_sec.macfilter
        uci -q delete wireless.$iface_bh_ap_sec.maclist
        uci commit wireless
    }
fi
cap_mode=$(uci -q get xiaoqiang.common.CAP_MODE)
[ -z "$cap_mode" ] && cap_mode="router"
if [ "$netmod" = "whc_cap" -o "$netmod" = "lanapmode" -a "$cap_mode" = "ap" ]; then
    ifname_ap_bh=$(uci -q get misc.backhauls.backhaul_game_ap_iface)
    iface_ap_bh=$(uci show wireless | grep "ifname=\'$ifname_ap_bh\'" | awk -F"." '{print $2}')
    uci -q delete wireless.$iface_ap_bh.macfilter
    uci -q delete wireless.$iface_ap_bh.maclist
    uci commit wireless
fi

uci commit xiaoqiang
