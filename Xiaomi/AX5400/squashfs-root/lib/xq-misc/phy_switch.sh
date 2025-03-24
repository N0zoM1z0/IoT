#!/bin/sh


QCA_SWITCH_DEV=""
MTK_SWITCH_DEV=""

PORT_SOC=""
PORT_DRIVER=""
PORT_WAN=$(uci -q get misc.sw_reg.sw_wan_port)
LIST_PORTS="0 1 2 3 5"

# power off ports
# $1 ports list, ex: "1 2 3"
sw_poweroff_ports() {
	local ori_value
	local set_value
	for p in $1; do
		# read original value of register 0
		ori_value=$(switch phy cl22 r $p 0 | awk -F'=' '{print $3}')

		# register 0, bit 11 is power down control bit, set to 1
		set_value=$(($ori_value | 0x800))
		switch phy cl22 w $p 0 $set_value
	done
}

# power on ports
# $1 ports list, ex: "1 2 3"
sw_poweron_ports() {
	local ori_value
	local set_value
	for p in $1; do
		# read original value of register 0
		ori_value=$(switch phy cl22 r $p 0 | awk -F'=' '{print $3}')

		# register 0, bit 11 is power down control bit, set to 0
		set_value=$(($ori_value & ~0x800))
		switch phy cl22 w $p 0 $set_value
	done
}

# power off all lan port
sw_stop_lan() {
	config_get lan_ports sw_reg sw_lan_ports
	sw_poweroff_ports "$lan_ports"
}

# power on all lan port
sw_start_lan() {
	config_get lan_ports sw_reg sw_lan_ports
	sw_poweron_ports "$lan_ports"
}

#-------- mtk --------#
sw_mtk_set_devid() {
    local port="$1"
    MTK_SWITCH_DEV="switch1"
    return
}

sw_mtk_port_restart_neg() {
    local port="$1"
    local read=""
    local write=""

    read=$(switch phy cl22 r "$port" 0 | awk -F'=' '{print $3}')
    write=$((read | 0x200))
    switch phy cl22 w "$port" 0 "$write"
    return
}

sw_mtk_port_link_detect() {
    local port="$1"
    swconfig dev "$MTK_SWITCH_DEV" port "$port" get link | grep -q "link:up"
}

sw_mtk_port_is_100m() {
    local port="$1"
    local read=""

    read=$(switch phy cl22 r "$port" 4 | awk -F'=' '{print $3}')
    [ $((read & 0x180)) != 0 ] && true || false
}

sw_mtk_port_is_giga() {
    local port="$1"
    local read
    local isGiGa=0
    
    read=$(switch phy cl22 r "$port" 0 | awk -F'=' '{print $3}')
    # bit 12 is Auto-negotiation Enable
    if [ $((read & 0x1000)) != 0 ]; then
        # Auto-negotiation is enabled
        # read original value of register 9 1000BASE-T Control Register
        read=$(switch phy cl22 r "$port" 9 | awk -F'=' '{print $3}')
        # bit 8 is 1000M HDX, bit 9 is 1000M FDX
        [ $((read & 0x300)) != 0 ] && isGiGa=1
    else
        # Auto-negotiation is disabled
        # Forced Speed Selection MSB = bit6, LSB = bit13. 00:10Mbps 01:100Mbps 10:1000Mbps 11:Reserved
        [ $((read & 0x2040)) != 64 ] || isGiGa=1
    fi
    [ ${isGiGa} -eq 1 ] && true || false
}

sw_mtk_port_is_2500() {
    false
}

sw_mtk_port_set_an() {
    local port="$1"
    local mode="$2"
    local read=""
    local write=""

    read=$(switch phy cl22 r "$port" 0 | awk -F'=' '{print $3}')
    [ "$mode" = "on" ] && write=$((read | 0x1000)) || write=$((read & ~0x1000))
    switch phy cl22 w "$port" 0 "$write"
    return
}

sw_mtk_port_set_100m() {
    local port="$1"
    local mode="$2"
    local read=""
    local write=""

    read=$(switch phy cl22 r "$port" 4 | awk -F'=' '{print $3}')

    case "$mode" in
    disable)
        # disable 100M, disable 10M
        write=$((read & ~0x180))
        write=$((read & ~0x60))
        ;;
    auto)
        # enable 100M, enable 10M
        write=$((read | 0x180))
        write=$((read | 0x60))
        ;;
    10)
        # disable 100M, enable 10M
        write=$((read & ~0x180))
        write=$((read | 0x60))
        ;;
    100)
        # enable 100M, disable 10M
        write=$((read | 0x180))
        write=$((read & ~0x60))
        ;;
    *)
        echo "unsupport speed!"
        return 1
        ;;
    esac

    switch phy cl22 w "$port" 4 "$write"
    return
}

sw_mtk_port_set_giga() {
    local port="$1"
    local mode="$2"
    local read=""
    local write=""

    read=$(switch phy cl22 r "$port" 9 | awk -F'=' '{print $3}')
    [ "$mode" = "on" ] && write=$((read | 0x300)) || write=$((read & ~0x300))
    switch phy cl22 w "$port" 9 "$write"
    return
}

sw_mtk_port_set_neg_speed() {
    local port="$1"
    local speed="$2"

    case "$speed" in
        0)
            sw_mtk_port_set_an   "$port" on
            sw_mtk_port_set_100m "$port" auto
            sw_mtk_port_set_giga "$port" on
            ;;
       10)
            sw_mtk_port_set_an   "$port" on
            sw_mtk_port_set_100m "$port" 10
            sw_mtk_port_set_giga "$port" off
        ;;
      100) 
            sw_mtk_port_set_an   "$port" on
            sw_mtk_port_set_100m "$port" 100
            sw_mtk_port_set_giga "$port" off
        ;;
     1000) 
            sw_mtk_port_set_an   "$port" on
            sw_mtk_port_set_100m "$port" disable
            sw_mtk_port_set_giga "$port" on
        ;;
        *)
           echo "unsupport speed!"
           return 1
        ;;
    esac

    sw_mtk_port_restart_neg "$port"
    return
}


#-------- qca --------#
sw_qca_set_devid() {
    local port="$1"
    [ "$port" = "3" ] && QCA_SWITCH_DEV="switch0" && echo 0 > /sys/ssdk/dev_id && return
}

sw_qca_port_restart_neg() {
    local port="$1"
    ssdk_sh port autoNeg restart "$port" > /dev/null 2>&1
    return
}

sw_qca_port_link_detect() {
    local port="$1"
    swconfig dev "$QCA_SWITCH_DEV" port "$port" get link | grep -q "link:up"
}

sw_qca_port_is_100m() {
    local port="$1"
    swconfig dev "$QCA_SWITCH_DEV" port "$port" get link | grep -q "speed:100b"
}

sw_qca_port_is_giga() {
    local port="$1"
    swconfig dev "$QCA_SWITCH_DEV" port "$port" get link | grep -q "speed:1000b"
}

sw_qca_port_is_2500() {
    local port="$1"
    swconfig dev "$QCA_SWITCH_DEV" port "$port" get link | grep -q "speed:2500b"
}

sw_qca_port_set_neg_speed() {
    local port="$1"
    local speed="$2"
    local write=""
    
    case "$speed" in
        0) write=0x123f;;   #support 2.5G/1G/100/10 autoNeg
       10) write=0x033;;
      100) write=0x03c;;
     1000) write=0x230;;
     2500) write=0x1030;;
        *)
           echo "unsupport speed!"
           return 1;;
    esac

    ssdk_sh port autoAdv set "$port" "$write"  > /dev/null 2>&1
    ssdk_sh port autoNeg restart "$port"  > /dev/null 2>&1
    return 0
}


#-------- main --------#
# RB04:
#   silk screen :  0 1 2 3    5(8081)
#   switch soc  :   mtk        qca
#  driver port  :  0 1 2 3       3
# switch dev id : switch1    switch0
sw_check_port() {
    local port="$1"
    if [ "$port" = "5" ]; then
        PORT_SOC="QCA"
        PORT_DRIVER="3"
        sw_qca_set_devid "$PORT_DRIVER"
    else
        PORT_SOC="MTK"
        PORT_DRIVER="$port"
        sw_mtk_set_devid "$PORT_DRIVER"
    fi
    return
}

sw_is_wan_2500() {
    sw_check_port "$PORT_WAN"
    if [ "$PORT_SOC" = "QCA" ]; then
        sw_qca_port_is_2500 "$PORT_DRIVER"
    else
        sw_mtk_port_is_2500 "$PORT_DRIVER"
    fi
}

sw_is_wan_giga() {
    sw_check_port "$PORT_WAN"
    if [ "$PORT_SOC" = "QCA" ]; then
        sw_qca_port_is_giga "$PORT_DRIVER"
    else
        sw_mtk_port_is_giga "$PORT_DRIVER"
    fi
}

sw_is_wan_100m() {
    sw_check_port "$PORT_WAN"
    if [ "$PORT_SOC" = "QCA" ]; then
        sw_qca_port_is_100m "$PORT_DRIVER"
    else
        sw_mtk_port_is_100m "$PORT_DRIVER"
    fi
}

sw_set_wan_neg_speed() {
    local speed="$1"
    sw_check_port "$PORT_WAN"
    if [ "$PORT_SOC" = "QCA" ]; then
        sw_qca_port_set_neg_speed "$PORT_DRIVER" "$speed"
    else
        sw_mtk_port_set_neg_speed "$PORT_DRIVER" "$speed"
    fi
}

sw_wan_link_detect() {
    sw_check_port "$PORT_WAN"
    if [ "$PORT_SOC" = "QCA" ]; then
        sw_qca_port_link_detect "$PORT_DRIVER"
    else
        sw_mtk_port_link_detect "$PORT_DRIVER"
    fi
}

sw_restart_port() {
    local port="$1"
    sw_check_port "$port"
    if [ "$PORT_SOC" = "QCA" ]; then
        sw_qca_port_restart_neg "$PORT_DRIVER" "$speed"
    else
        sw_mtk_port_restart_neg "$PORT_DRIVER" "$speed"
    fi
}

sw_restart_lan() {
    local port=""

    for port in $LIST_PORTS
    do
        [ "$port" != "$PORT_WAN" ] && sw_restart_port "$port"
    done
    return
}

sw_port_set_neg_speed() {
    local port="$1"
    local speed="$2"

    sw_check_port "$port"
    if [ "$PORT_SOC" = "QCA" ]; then
        sw_qca_port_set_neg_speed "$PORT_DRIVER" "$speed"
    else
        sw_mtk_port_set_neg_speed "$PORT_DRIVER" "$speed"
    fi
}
