#!/bin/sh
# Copyright (C) 2020 Xiaomi
# main
#wanlan_swap

wanlan_swap_log()
{
    logger -p debug -t wanlan_swap "$1"
}

wan_swap_lan()
{
	local wan_old=$(uci -q get network.wan.ifname)
	local wan6_exist=$(uci -q get network.wan_6.ifname)
	local wan_new="eth1.4"
	local lanmac=$(getmac lan)
	local wanmac=$(uci get network.wan.macaddr)
	[ -z "$wanmac" ] && wanmac=$(getmac wan)
	local node_name=$(echo $wan_new | sed 's/\./_/g')

    uci -q batch <<EOF
        set xiaoqiang.common.wan_port_type='1G'
        commit xiaoqiang

        set network.lan.ifname='eth0.1 eth1.2 eth1.3 '$wan_old
        set network.wan.ifname=$wan_new
        commit network

        set misc.sw_reg.sw_lan_ports='0 1 2 5'
        set misc.sw_reg.sw_wan2lan_port='5'
        set misc.sw_reg.sw_wan_port='3'
        commit misc
EOF

	[ -n "$wan6_exist" ] && uci set network.wan_6.ifname=$wan_new
}

lan_swap_wan()
{
	local wan_old=$(uci -q get network.wan.ifname)
	local wan6_exist=$(uci -q get network.wan_6.ifname)
	local wan_new="eth1.5"
	local wanmac=$(uci get network.wan.macaddr)
	[ -z "$wanmac" ] && wanmac=$(getmac wan)
	local node_name=$(echo $wan_old | sed 's/\./_/g')

    uci -q batch <<EOF
        set xiaoqiang.common.wan_port_type='2.5G'
        commit xiaoqiang


        set network.lan.ifname='eth0.1 eth1.2 eth1.3 '$wan_old
        set network.wan.ifname=$wan_new
        commit network

        delete misc.sw_reg.sw_wan2lan_port
        set misc.sw_reg.sw_lan_ports='0 1 2 3'
        set misc.sw_reg.sw_wan_port='5'
        commit misc
EOF

	[ -n "$wan6_exist" ] && uci set network.wan_6.ifname=$wan_new
}


OPT=$1
restart_flg=$2

wanlan_swap_log "$OPT"

case $OPT in
    toWan)
        lan_swap_wan
        [ -n "$restart_flg" -a "$restart_flg" != "0" ] && {
            /etc/init.d/network restart
            /etc/init.d/lag reset
            /etc/init.d/wan_check restart
        }
    ;;

    toLan)
        wan_swap_lan
        [ -n "$restart_flg" -a "$restart_flg" != "0" ] && {
            /etc/init.d/network restart
            /etc/init.d/lag reset
            /etc/init.d/wan_check restart
        }
    ;;

    ToWanCfg)
        lan_swap_wan
        /etc/init.d/network reconfig_switch
        brctl delif br-lan eth1.5
        brctl addif br-lan eth1.4
	;;

    ToLanCfg)
        wan_swap_lan
        /etc/init.d/network reconfig_switch
        brctl delif br-lan eth1.4
        brctl addif br-lan eth1.5
	;;
esac

return 0

