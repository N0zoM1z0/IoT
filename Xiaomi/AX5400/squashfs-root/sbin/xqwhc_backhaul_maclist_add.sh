#!/bin/sh

### add new mac to 5g/2g maclist for cap node for mesh version 3
### backhaul macfilter not enabled but need save config to compatible with old
### mesh version node

LOGI()
{
    logger -s -p 1 -t "xqwhc_maclist" "$1"
}

__backhaul_maclist_config()
{
    local ifa="$1"
    local mac1="$2"
    local mac2="$3"

    iface_index=`uci show wireless|grep -w ifname=\'$ifa\'|awk -F "." '{print $2}'`
    [ "$iface_index" == "" ] && return 1

    local maclist_old=$(uci -q get wireless.$iface_index.maclist)
    if [ -z "$maclist_old" ]; then
        uci -q add_list wireless.$iface_index.maclist=$mac1
        uci -q add_list wireless.$iface_index.maclist=$mac2
    else
        if [ "${maclist_old#*$mac1}" == "${maclist_old}" ]; then
            uci -q add_list wireless.$iface_index.maclist=$mac1
        fi
        if [ "${maclist_old#*$mac2}" == "${maclist_old}" ]; then
            uci -q add_list wireless.$iface_index.maclist=$mac2
        fi
    fi
    uci set wireless.$iface_index.macfilter='allow'
    uci commit wireless
}

mesh_support_ver4=$(mesh_cmd support_mesh_version 4)
[ "$mesh_support_ver4" != "1" ] && return

vap_mac_5g_1="$1"
vap_mac_5g_2="$2"
vap_mac_2g_1="$3"
vap_mac_2g_2="$4"

LOGI " 2G backhaul wifi macfilter [$vap_mac_2g_1,$vap_mac_2g_2] and 5G backhaul wifi macfilter [$vap_mac_5g_1,$vap_mac_5g_2] "

ifa=`uci -q get misc.backhauls.backhaul_5g_ap_iface`
if [ -n "$ifa" ];then
    __backhaul_maclist_config $ifa $vap_mac_5g_1 $vap_mac_5g_2
fi

ifa=`uci -q get misc.backhauls.backhaul_2g_ap_iface`
if [ -n "$ifa" ];then
    __backhaul_maclist_config $ifa $vap_mac_2g_1 $vap_mac_2g_2
fi
