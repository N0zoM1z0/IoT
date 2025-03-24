#!/bin/sh

PORT_SOC="qca"
PORT_DRIVER=""
QCA_SWITCH_DEV="switch1"

[ "$(cat /sys/ssdk/dev_id)" != "1" ] && echo 1 > /sys/ssdk/dev_id

sw_qca_port_restart_neg() {
    local port="$1"
    ssdk_sh port autoNeg restart "$port" >/dev/null 2>&1
    return
}

sw_qca_port_set_neg_speed() {
    local port="$1"
    local speed="$2"
    local write=""

    # RN02's 1 2 3 4 port are 2.5G
    [ "$port" -le "4" ] && [ "$speed" -gt "2500" ] && return 1

    case "$speed" in
    0) write=0x123F ;;
    10) write=0x033 ;;
    100) write=0x03C ;;
    1000) write=0x230 ;;
    2500) write=0x1030 ;;
    *)
        return 1
        ;;
    esac

    ssdk_sh port autoAdv set "$port" "$write" >/dev/null 2>&1
    ssdk_sh port autoNeg restart "$port" >/dev/null 2>&1
    return 0
}

sw_qca_port_get_link_speed() {
    local port="$1"
    local speed=""

    speed=$(swconfig dev "$QCA_SWITCH_DEV" port "$port" get link | cut -d " " -f 3 | tr -cd "\[0-9\]")
    [ -z "$speed" ] && echo "0" || echo "$speed"
}

sw_qca_port_get_neg_speed() {
    local port="$1"
    local autoAdv=""

    autoAdv=$(ssdk_sh port autoAdv get "$port" | grep "autoneg" | cut -d ":" -f 2)
    echo "$autoAdv" | grep -Eq '1000T.*100T' && echo "0" && return 0
    echo "$autoAdv" | cut -d '|' -f 1 | tr -cd "0-9"
}

sw_qca_port_get_link_status() {
    local port="$1"
    local status=""

    status=$(swconfig dev "$QCA_SWITCH_DEV" port "$port" get link | cut -d ' ' -f 2 | cut -d ':' -f 2)
    [ -n "$status" ] && echo "$status"
}

sw_qca_port_get_link_duplex() {
    local port="$1"
    local status=""

    duplex=$(swconfig dev switch1 port "$port" get link | grep duplex | cut -d " " -f 4 | cut -d '-' -f 1)
    [ -n "$duplex" ] && echo "$duplex"
}

sw_qca_port_power_on() {
    local port="$1"
    ssdk_sh port poweron set "$port" >/dev/null 2>&1
}

sw_qca_port_power_off() {
    local port="$1"
    ssdk_sh port poweroff set "$port" >/dev/null 2>&1
}

sw_check_port() {
    PORT_DRIVER=$(port_map config get "$port" phy_id)
    return
}

arch_phy_eth_port_restart() {
    local port="$1"

    sw_check_port "$port"
    eval sw_"$PORT_SOC"_port_restart_neg "$PORT_DRIVER"
}

arch_phy_eth_port_mode_set() {
    local port="$1"
    local speed="$2"

    sw_check_port "$port"
    eval sw_"$PORT_SOC"_port_set_neg_speed "$PORT_DRIVER" "$speed"
}

arch_phy_eth_port_mode_get() {
    local port="$1"

    sw_check_port "$port"
    eval sw_"$PORT_SOC"_port_get_neg_speed "$PORT_DRIVER"
}

arch_phy_eth_port_link_status() {
    local port="$1"

    sw_check_port "$port"
    eval sw_"$PORT_SOC"_port_get_link_status "$PORT_DRIVER"
}

arch_phy_eth_port_link_speed() {
    local port="$1"

    sw_check_port "$port"
    eval sw_"$PORT_SOC"_port_get_link_speed "$PORT_DRIVER"
}

arch_phy_eth_port_link_duplex() {
    local port="$1"

    sw_check_port "$port"
    eval sw_"$PORT_SOC"_port_get_link_duplex "$PORT_DRIVER"
}

arch_phy_eth_port_mib_info() {
    local port="$1"
    local que="$2"
    local res
    que=$(echo "$que" | awk '{print toupper($0)}')

    res=$(swconfig dev switch1 port "$port" get mib | grep "$que" | awk -F ':' '{print $2}' | xargs)
    echo "$res"
}

arch_phy_eth_port_power_on() {
    local port="$1"

    sw_check_port "$port"
    eval sw_"$PORT_SOC"_port_power_on "$PORT_DRIVER"
}

arch_phy_eth_port_power_off() {
    local port="$1"

    sw_check_port "$port"
    eval sw_"$PORT_SOC"_port_power_off "$PORT_DRIVER"
}

arch_phy_eth_port_fdb_mac() {
    local mac="$1"
    local portno ifname port

    mac=$(echo "$mac" |tr A-Z a-z)
    portno=$(brctl showmacs br-lan | grep "$mac" | xargs | cut -d ' ' -f 0)
    [ -z "$portno" ] && return

    ifname=$(brctl showstp br-lan | grep "($portno)" | cut -d ' ' -f 0)
    [ "${ifname:0:3}" != "eth" ] && [ "${ifname:0:3}" != "ae_" ] && return # only deal with wired network

    port=$(port_map port iface "$ifname")

    echo "$port"
}
