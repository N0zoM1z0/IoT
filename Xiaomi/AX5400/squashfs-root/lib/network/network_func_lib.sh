#!/bin/sh


# const vars
DEFAULT_WAN_PORT="5"
DEFAULT_WAN_IFNAME="eth1.5"
IFACE_WAN="wan"
IFACE_LAN="lan"



# global vars
wan_device="$DEFAULT_WAN_IFNAME"
lan_device="eth0.1 eth1.2 eth1.3 eth1.4"
list_ifname="eth0.1 eth1.2 eth1.3 eth1.4 eth1.5"

log() {
    echo "[network_func] $@" > /dev/console
}

set_network_config() {
	case "$1" in
		"normal")
			uci -q batch <<EOF
				set network.vlan4.ports='3 6t'
				set network.vlan2.ports='1 6t'
				commit network
EOF
			;;

		"lag")
			uci -q batch <<EOF
				set network.vlan4.ports='3 6t'
				set network.vlan2.ports='1 4t'
				commit network
EOF
			;;

		"dualwan")
			uci -q batch <<EOF
				set network.vlan4.ports='3 4t'
				set network.vlan2.ports='1 6t'
				commit network
EOF
			;;

		"dualwan_lag")
			uci -q batch <<EOF
				set network.vlan4.ports='3 4t'
				set network.vlan2.ports='1 6t'
				commit network
EOF
			;;
	esac
}

set_route_net_mode() {
	local lag_enable=$(uci -q get lag.lag.enable)
	local dualwan_enable=$(uci -q get dualwan.common.enable)
	[ "$lag_enable" == "0" -a "$dualwan_enable" == "0" ] && {
		lan_device=$(uci -q get portmap.normal.lan_ifname)
		list_ifname=$(uci -q get portmap.normal.default_list_ifname)
		set_network_config normal
	}
	[ "$lag_enable" == "1" -a "$dualwan_enable" == "0" ] && {
		lan_device=$(uci -q get portmap.lag.lan_ifname)
		list_ifname=$(uci -q get portmap.lag.default_list_ifname)
		set_network_config lag
	}
	[ "$lag_enable" == "0" -a "$dualwan_enable" == "1" ] && {
		lan_device=$(uci -q get portmap.dualwan.lan_ifname)
		list_ifname=$(uci -q get portmap.dualwan.default_list_ifname)
		set_network_config dualwan
	}
	[ "$lag_enable" == "1" -a "$dualwan_enable" == "1" ] && {
		lan_device=$(uci -q get portmap.dualwan_lag.lan_ifname)
		list_ifname=$(uci -q get portmap.dualwan_lag.default_list_ifname)
		set_network_config dualwan_lag
	}
}

#$1: ifname
#$2: iface status, "up" or "down"
util_iface_status_set() {
    local ifname="$1"
    local status="$2"
    
    case "$status" in
        up)
            [ -f "/proc/portmap/10" ] && {
                echo "$ifname" > /proc/portmap/10
            }
            ;;
        down)
            [ -f "/proc/portmap/20" ] && {
                echo "$ifname" > /proc/portmap/20
            }
            ;;
        *)
            return
            ;;
    esac
    return
}

#$1: port
#$2: ifname
util_portmap_set() {
    local port="$1"
    local ifname="$2"

    [ -n "$ifname" -a -n "$port" ] && {
        [ -f "/proc/portmap/$port" ] && {
            echo "$ifname" > /proc/portmap/"$port"
        }
    }
    return
}

util_portmap_set_dft() {
    local count=0
    for port in $lan_device
    do
        util_portmap_set $count "$port"
        count=$(expr $count + 1)
    done
    util_portmap_set 5 "eth1.5"
    return
}

#$1: port
util_portmap_clear() {
    local port="$1"

    [ -n "$port" ] && {
        [ -f "/proc/portmap/$port" ] && {
            echo "0" > /proc/portmap/"$port"
        }
    }
    return
}

# clear all portmap, force all iface keep up
util_portmap_reset() {
    local list_ports="0 1 2 3 5"
    
    for port in $list_ports
    do
        util_portmap_clear "$port"
    done
    
    util_portmap_set_dft
        
    for ifname in $list_ifname
    do
        util_iface_status_set "$ifname" "up"
    done
    return
}

#$1: ifname
#$2: "lan" or "wan"
util_mac_set() {
    local ifname="$1"
    local mac=$(getmac "$2")

    [ -z "$ifname" -o -z "$mac" ] && return

    ifconfig "$ifname" down
    ifconfig "$ifname" hw ether "$mac"
    ifconfig "$ifname" up
    return
}

util_mac_set_default() {
    for ifname in $lan_device
    do
        util_mac_set "$ifname" "$IFACE_LAN"
    done
    util_mac_set "eth1.5" "$IFACE_WAN"
    return
}

util_mac_set_all_to_lan() {
    for ifname in $list_ifname
    do
        util_mac_set "$ifname" "$IFACE_LAN"
    done
    return
}
#******** common funcs end       ********#


#******** wifi ap funcs start    ********#
wifiap_open() {
    return
}

wifiap_close_default() {
    return
}

wifiap_close(){
    return
}
#******** wifi ap funcs end      ********#


#******** bridge ap funcs start  ********#
bridgeap_open() {
    echo "#######################bridgeap_open_rb04###############"

    uci -q batch <<-EOF >/dev/null
        delete network.wan
        delete network.wan_6
        delete network.vpn
        set network.lan.ifname='$list_ifname'
        delete network.lan.ip6class
        delete network.lan.ip6assign
        delete network.lan.ip6addr
        delete network.lan.ipv6
        set network.switch1.enable_vlan='1'
        commit network

        set dhcp.lan.ignore=1
        commit dhcp
EOF

    nvram set mode=AP
    nvram commit
    util_mac_set "$wan_device" "$IFACE_LAN"
    util_portmap_reset
    return
}


bridgeap_close(){
    echo "#######################bridgeap_close_rb04###############"

    local router_backup_file="/etc/config/.network.mode.router"

    [ ! -f "$router_backup_file" ] &&  bridgeap_close_default && return;

    mv $router_backup_file "/etc/config/network"

    uci -q batch <<-EOF >/dev/null
        delete network.wan.auto
        delete network.wan_6.auto
        commit network
        delete dhcp.lan.ignore
        commit dhcp
EOF
    mwlp_network=$(uci -q get network.mwlp)
    if [ -z $mwlp_network ]; then
    uci -q batch <<EOF
        delete network.mwlp
        set network.mwlp=interface
        set network.mwlp.ifname="eth1.7"
        set network.mwlp.type="bridge"
        set network.mwlp.mtu="1450"
        set network.mwlp.proto="static"
        set network.mwlp.ipaddr="192.168.34.1"
        set network.mwlp.netmask="255.255.255.0"
        commit network
EOF
    fi
    nvram set mode=Router
    nvram commit
    util_mac_set "$DEFAULT_WAN_IFNAME" "$IFACE_WAN"
    util_portmap_reset
    util_portmap_set "$DEFAULT_WAN_PORT" "$DEFAULT_WAN_IFNAME"
    return
}

bridgeap_close_default() {
    echo "#######################bridgeap_close_ra74_default###############"

    uci -q batch <<-EOF >/dev/null
        set network.loopback=interface
        set network.loopback.ifname='lo'
        set network.loopback.proto='static'
        set network.loopback.ipaddr='127.0.0.1'
        set network.loopback.netmask='255.0.0.0'
        set network.lan=interface
        set network.lan.type='bridge'
        set network.lan.ifname='$lan_device'
        set network.lan.proto='static'
        set network.lan.ipaddr='192.168.31.1'
        set network.lan.netmask='255.255.255.0'
        set network.wan='interface'
        set network.wan.proto='dhcp'
        set network.wan.ifname='eth1.5'
        set network.switch1.enable_vlan='1'
        commit network

        delete dhcp.lan.ignore
        commit dhcp
EOF

    util_mac_set "$DEFAULT_WAN_IFNAME" "$IFACE_WAN"
    util_portmap_reset
    util_portmap_set "$DEFAULT_WAN_PORT" "$DEFAULT_WAN_IFNAME"
    return
}

util_plugin_restart() {
    /etc/init.d/pluginmanager start
    return
}

network_re_mode()
{
    log "=== set re mode config ==="

    util_plugin_restart
    uci -q batch <<-EOF >/dev/null
        delete network.wan
        delete network.wan_6
        delete network.vpn
        delete network.lan.ip6class
        delete network.lan.ip6assign
        delete network.lan.ip6addr
        delete network.lan.ipv6
        set network.lan.ifname='$list_ifname'
        commit network

        set dhcp.lan.ignore=1
        commit dhcp
EOF

    util_mac_set "$wan_device" "$IFACE_LAN"
    util_portmap_set_dft
    return
}

network_init_mac() {
	local lan_mac
	local wan_mac
	local wan_mac_cfg

	# set lan eth0 and eth1's macaddr to lan macaddr
	lan_mac=$(getmac lan)
	[ -n "$lan_mac" ] && {
		uci set network.lan.macaddr="$lan_mac"
		uci set network.@device[0].macaddr="$lan_mac"
		uci set network.@device[1].macaddr="$lan_mac"
		uci commit network
	}

	# set wan macaddr
	wan_mac=$(getmac wan)
	wan_mac_cfg=$(uci -q get network.wan.macaddr)
	[ -n "$wan_mac" -a -z "$wan_mac_cfg" ] && {
		uci set network.wan.macaddr="$wan_mac"
		uci commit network
	}
	return
}

network_init_arch() {
    local mode=$(uci -q get xiaoqiang.common.NETMODE)
    set_route_net_mode

    case "$mode" in
        "whc_re")
            util_mac_set_all_to_lan
            util_portmap_set_dft
            ;;

        ""|"router"|"whc_cap")
            util_mac_set_default
            util_portmap_reset
            util_portmap_set "$DEFAULT_WAN_PORT" "$DEFAULT_WAN_IFNAME"
            # set eth1 linkup always
            # echo eth1 > /proc/portmap/10
            ;;

        "wifiapmode"|"lanapmode")
            util_mac_set_all_to_lan
            util_portmap_reset
            return
            ;;

        *)
            #KEEP log to avoid any escaped cases.
            log "WARNING: not supported NETMODE: $mode ."
            ;;
    esac

    network_init_mac
    return
}
