#!/bin/sh

. /lib/miwifi/arch/lib_arch_accel.sh

arch_ps_rebuild_network() {
    ubus call network reload
    swconfig dev switch1 load network &
}

arch_ps_check_service() {
    local service="$1"

    if [ "$service" = "lag" ]; then
        local lag_enable=$(uci -q get port_service.lag.enable)
        local lag_ports=$(uci -q get port_service.lag.ports)
        local port_2_base_iface=$(uci -q get port_map.2.base_iface)
        if [ "$lag_enable" = "1" ] && [ "$lag_ports" = "1 2" -o "$lag_ports" = "3 4" ]; then
            [ "eth1" = "$port_2_base_iface" ] && return
        else
            [ "eth0" = "$port_2_base_iface" ] && return
        fi
        LIST_SERVICES="lag game iptv wan wan_2"
    fi
}

arch_ps_post_start_service() {
    [ "whc_re" = "$(uci -q get xiaoqiang.common.NETMODE)" ] && {
        # in re mode, the topomon must restart when user change the lag's config
        /etc/init.d/topomon restart
    }
    util_portmap_update
}

arch_ps_setup_wan() {
    local service="$1"
    local wan_port="$2"
    local wan_proto="$3"
    local old_wan_port="$4"
    local wan_ifname wan_curr_type
    local wan6_pass wan6_ifname pass_ifname
    local list_ifnames_lan list_ifnames_final_lan

    # reconfig network wan and lan
    wan_ifname=$(port_map config get "$wan_port" ifname)
    wan_curr_type=$(uci -q get network."$service".proto)
    [ -z "$wan_curr_type" ] && wan_curr_type=$wan_type
    list_ifnames_lan=$(uci -q get network.lan.ifname)
    for ifname in $list_ifnames_lan; do
        [ "$ifname" != "$wan_ifname" ] && append list_ifnames_final_lan "$ifname"
    done

    wan6_ifname="$wan_ifname"
    wan6_pass=$(uci -q get network.${service/n/n6}.passthrough)
    [ "$wan6_pass" = "1" ] && {
        wan6_ifname="br-lan"
        pass_ifname="$wan_ifname"
    }

    uci -q batch <<-EOF
        set network."$service".proto="$wan_curr_type"
        set network."$service".ifname="$wan_ifname"
        set network."${service/n/n6}".ifname="$wan6_ifname"
        set network."${service/n/n6}".pass_ifname="$pass_ifname"
        set network."macv_${service/n/n6}".ifname="$wan_ifname"
        set network.lan.ifname="$list_ifnames_final_lan"
        commit network
	EOF

    # reload network
    ubus call network reload
    ubus call network.interface."$service" up
    [ "$wan6_pass" = "1" ] && ubus call network.interface."${service/n/n6}" up

    # reload iptv and voip service
    [ "$service" = "wan" ] && ps_media_ctl add_wan "$wan_port" "$wan_ifname"

    # reload other services
    {
        /etc/init.d/wan_check restart > /dev/null 2>&1
        /etc/init.d/miqos restart  > /dev/null 2>&1
        /etc/init.d/dnsmasq restart > /dev/null 2>&1
        /etc/init.d/messagingagent.sh restart > /dev/null 2>&1
        [ "$(uci -q get miqos.settings.enabled)" = "1" ] && {
            arch_accel_event_qos_update
        }
    } &
}

arch_ps_reset_lan() {
    local service="$1"
    local wan_port="$2"
    local wan_ifname list_ifnames_lan

    [ -z "$wan_port" ] && return

    wan_ifname=$(port_map config get "$wan_port" ifname)
    list_ifnames_lan=$(uci -q get network.lan.ifname)
    append list_ifnames_lan "$wan_ifname"

    arch_ps_reset_passthrough "$wan_ifname"

    # reload iptv and voip service
    [ "$service" = "wan" ] && ps_media_ctl del_wan "$wan_port" "$wan_ifname"

    # reconfig network
    uci -q batch <<-EOF
        delete network."$service".ifname
        delete network."${service/n/n6}".ifname
        delete network."${service/n/n6}".pass_ifname
        delete network."macv_${service/n/n6}".ifname
        set network.lan.ifname="$list_ifnames_lan"
        commit network
	EOF

    # reload network
    ip addr flush dev "$wan_ifname"
    util_set_mac "$wan_ifname" lan
    ubus call network.interface."$service" down
    ubus call network reload
    util_portmap_update "$wan_port"
    [ "$(uci -q get miqos.settings.enabled)" = "1" ] && {
        arch_accel_event_qos_update
    }

    return
}

arch_ps_reset_passthrough() {
    local ifname="$1"
    pconfig del "${ifname}_6" > /dev/null 2>&1
}

arch_ps_iptv_config() {
    [ "$(uci -q get miqos.settings.enabled)" = "1" ] && {
        arch_accel_event_qos_update
    }
}