#!/bin/sh
#logger -p notice -t "hotplug.d" "10-phy_check.sh: run because of $INTERFACE $ACTION"

[ "$INTERFACE" = "wan" -a "$ACTION" = "ifup" ] && {
        wan_speed=$(uci -q get xiaoqiang.common.WAN_SPEED)
        [ -z "$wan_speed" -o $wan_speed -eq 0 ] && return

        wan_port=$(uci -q get misc.sw_reg.sw_wan_port)
        [ -z "$wan_port" ] && wan_port=1

        cur_wan_speed=$(swconfig dev switch1 port $wan_port get link |  cut -d ":" -f 4 | cut -d "b" -f 1)
        [ -z "$cur_wan_speed" ] && return

        [ "$cur_wan_speed" != "$wan_speed" ] && {
            . /lib/xq-misc/phy_switch.sh
            sw_set_wan_neg_speed $wan_speed
        }
}
