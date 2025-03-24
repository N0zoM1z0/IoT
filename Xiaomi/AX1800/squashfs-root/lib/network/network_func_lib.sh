#!/bin/sh

wan_device=$(uci get network.wan.ifname)
[ "$wan_device" == "" ] && wan_device="eth1"
lan_device=$(uci get network.lan.ifname)
[ "$lan_device" == "" ] && lan_device="eth0"

config_get cmd_ifname_2G wireless ifname_2G &>/dev/null;
config_get cmd_ifname_5G wireless ifname_5G &>/dev/null;

log(){
	echo "[network_func] $@" > /dev/console
}

wifiap_open() {
    echo "#######################wifiap_open###############"
    local wanmac=$(getmac wan)

    uci -q batch <<-EOF >/dev/null
        delete network.wan
        delete network.wan_6
        delete network.vpn
        set network.lan.ifname='eth0 eth1 $cmd_ifname_2G $cmd_ifname_5G'
        set network.@device[0].macaddr=$wanmac
        delete network.lan.ip6class
        delete network.lan.ip6assign
        delete network.lan.ip6addr
        delete network.lan.ipv6
        delete network.@switch_vlan[3]
        delete network.@switch_vlan[2]
        delete network.@switch_vlan[1]
        delete network.@switch_vlan[0]
        delete network.eth0_2
        delete network.eth0_3
        delete network.eth0_4
        set network.switch0.enable_vlan='1'
        add network switch_vlan
        set network.@switch_vlan[0].device='switch0'
        set network.@switch_vlan[0].vlan='1'
        set network.@switch_vlan[0].ports='0 1 2 3 6'
        add network switch_vlan
        set network.@switch_vlan[1].device='switch0'
        set network.@switch_vlan[1].vlan='2'
        set network.@switch_vlan[1].ports='4 5'
        commit network
EOF
}

wifiap_close_default() {
    echo "#######################wifiap_close_default###############"
	uci -q batch <<-EOF >/dev/null
        delete network
        set network.$device[0]=device
        set network.$device[0].name='eth0'
        set network.@switch[0]=switch
        set network.@switch[0].name='switch0'
        set network.loopback=interface
        set network.loopback.ifname='lo'
        set network.loopback.proto='static'
        set network.loopback.ipaddr='127.0.0.1'
        set network.loopback.netmask='255.0.0.0'
        set network.lan=interface
        set network.lan.type='bridge'
        set network.lan.ifname='eth0'
        set network.lan.proto='static'
        set network.lan.ipaddr='192.168.31.1'
        set network.lan.netmask='255.255.255.0'
        set network.eth0=interface
        set network.eth0.ifname='eth0'
        set network.eth0.keepup='1'
        set network.eth1=interface
        set network.eth1.ifname='eth1'
        set network.eth1.keepup='1'		
        set network.wan='interface'
        set network.wan.proto='dhcp'
        set network.wan.ifname='eth1'
        set network.switch0.enable_vlan='1'        
        add network switch_vlan
        set network.@switch_vlan[0].device='switch0'
        set network.@switch_vlan[0].vlan='1'
        set network.@switch_vlan[0].ports='0 1 2 3 6'
        add network switch_vlan
        set network.@switch_vlan[1].device='switch0'
        set network.@switch_vlan[1].vlan='2'
        set network.@switch_vlan[1].ports='4 5'
        commit network
EOF
}

wifiap_close(){

    echo "#######################wifiap_close###############"

    local router_backup_file="/etc/config/.network.mode.router"

    [ ! -f "$router_backup_file" ] &&  wifiap_close_default && return;

    mv $router_backup_file "/etc/config/network"

	uci -q batch <<-EOF >/dev/null
        delete network.wan.auto
        delete network.wan_6.auto
        commit network
        delete dhcp.lan.ignore;
        commit dhcp
EOF
}

bridgeap_open() {
    echo "#######################bridgeap_open###############"
    local wanmac=$(getmac wan)

    uci -q batch <<-EOF >/dev/null
		set network.lan.ifname='$lan_device $cmd_ifname_2G $cmd_ifname_5G'
		set network.lan.type='bridge'
		set network.@switch_vlan[0].ports='0 1 2 3 4 5 6'
		set network.eth0=interface
		set network.eth0.ifname='eth0'
		set network.eth0.keepup='1'	
		delete network.wan
		delete network.vpn
		delete network.wan_6
		delete network.lan.ip6class
		delete network.lan.ip6assign
		delete network.lan.ip6addr
		delete network.lan.ipv6
		delete network.@switch_vlan[1]
		delete network.eth1
		commit network

        set dhcp.lan.ignore=1;
        commit dhcp
EOF
}

bridgeap_close(){

    echo "#######################bridgeap_close###############"

    local router_backup_file="/etc/config/.network.mode.router"

    [ ! -f "$router_backup_file" ] &&  bridgeap_close_default && return;

    mv $router_backup_file "/etc/config/network"

	uci -q batch <<-EOF >/dev/null
        delete network.wan.auto
        delete network.wan_6.auto
        commit network
        delete dhcp.lan.ignore;
        commit dhcp
EOF
}

bridgeap_close_default() {
    echo "#######################bridgeap_close_default###############"
	uci -q batch <<-EOF >/dev/null
		delete network
		set network.@device[0]=device
		set network.@device[0].name='eth0'
		set network.@device[0].mtu='1500'
		set network.@device[1]=device
		set network.@device[1].name='eth1'
		set network.@device[1].mtu='1500'
		set network.loopback=interface
		set network.loopback.ifname='lo'
		set network.loopback.proto='static'
		set network.loopback.ipaddr='127.0.0.1'
		set network.loopback.netmask='255.0.0.0'
		set network.lan=interface
		set network.lan.type='bridge'
		set network.lan.proto='static'
		set network.lan.ipaddr='192.168.31.1'
		set network.lan.netmask='255.255.255.0'
		set network.lan.ip6assign='60'
		set network.lan.ifname='eth0'
		set network.eth1=interface
		set network.eth1.ifname='eth1'
		set network.eth1.keepup='1'
		set network.@switch[0]=switch
		set network.@switch[0].name='switch0'
		set network.@switch[0].reset='1'
		set network.@switch[0].enable_vlan='1'
		set network.@switch_vlan[0]=switch_vlan
		set network.@switch_vlan[0].device='switch0'
		set network.@switch_vlan[0].vlan='1'
		set network.@switch_vlan[0].ports='0 1 2 3 6'
		set network.@switch_vlan[1]=switch_vlan
		set network.@switch_vlan[1].device='switch0'
		set network.@switch_vlan[1].vlan='2'
		set network.@switch_vlan[1].ports='4 5'
		set network.wan=interface
		set network.wan.proto='dhcp'
		set network.wan.mtu='1500'
		set network.wan.ifname='eth1'
		commit network

		delete dhcp.lan.ignore;
		commit dhcp

EOF
}

network_router_default()
{
	log "=== set default router config ==="
	uci -q batch <<-EOF >/dev/null
		delete network.eth0_3
		delete network.eth0_4
		delete network.eth0_5
		set network.@device[0]=device
		set network.@device[0].name='eth0'
		set network.@device[0].mtu='1500'
		set network.@device[1]=device
		set network.@device[1].name='eth1'
		set network.@device[1].mtu='1500'
		set network.loopback=interface
		set network.loopback.ifname='lo'
		set network.loopback.proto='static'
		set network.loopback.ipaddr='127.0.0.1'
		set network.loopback.netmask='255.0.0.0'
		set network.lan=interface
		set network.lan.type='bridge'
		set network.lan.proto='static'
		set network.lan.ipaddr='192.168.31.1'
		set network.lan.netmask='255.255.255.0'
		set network.lan.ip6assign='60'
		set network.lan.ifname='eth0'
		set network.eth1=interface
		set network.eth1.ifname='eth1'
		set network.eth1.keepup='1'
		set network.@switch[0]=switch
		set network.@switch[0].name='switch0'
		set network.@switch[0].reset='1'
		set network.@switch[0].enable_vlan='1'
		set network.@switch_vlan[0]=switch_vlan
		set network.@switch_vlan[0].device='switch0'
		set network.@switch_vlan[0].vlan='1'
		set network.@switch_vlan[0].ports='0 1 2 3 6'
		set network.@switch_vlan[1]=switch_vlan
		set network.@switch_vlan[1].device='switch0'
		set network.@switch_vlan[1].vlan='2'
		set network.@switch_vlan[1].ports='4 5'
		set network.wan=interface
		set network.wan.proto='dhcp'
		set network.wan.mtu='1500'
		set network.wan.ifname='eth1'
		commit network
EOF
}

network_re_mode()
{
    log "=== set re mode config ==="

    uci -q batch <<-EOF >/dev/null
        delete network.wan
        delete network.wan_6
        delete network.vpn
        delete network.lan.ip6class
        delete network.lan.ip6assign
        delete network.lan.ip6addr
        delete network.lan.ipv6
        delete network.eth0_2
        delete network.eth0_3
        delete network.eth0_4
        set network.eth0_3=interface
        set network.eth0_3.ifname='eth0.3'
        set network.eth0_4=interface
        set network.eth0_4.ifname='eth0.4'
        set network.eth0_5=interface
        set network.eth0_5.ifname='eth0.5'
        set network.lan.ifname='eth1 eth0 eth0.3 eth0.4 eth0.5'
        commit network

        set dhcp.lan.ignore=1;
        commit dhcp
EOF
}

re_get_port_vlan_member() {
	local port="$1"
	
	case $port in 
		"0")
			echo "10000010"
			;;
		"1")
			echo "01000010"
			;;
		"2")
			echo "00100010"
			;;
		"3")
			echo "00010010"
			;;
		*)
			return 1
	esac
	
	return 0
}

re_init_switch_lan_cpu_port() {
	local cpu_port="$1"

	switch vlan eg-tag-pcr $cpu_port 2
	
	switch vlan port-attr $cpu_port 0
	
	switch vlan set 0 1 00000000
}

re_init_switch_lan_panel_port() {
	local port="$1"
	local vid="$2"
	local vlan_member
	
	vlan_member="$(re_get_port_vlan_member $port)"
	if [ "$?" != "0" ]; then
		return 1
	fi

	switch vlan set $vid $vid $vlan_member
	
	switch vlan port-attr $port 0
	
	switch vlan pvid $port $vid
	
	switch vlan eg-tag-pcr $port 0
}

re_mode_init_switch() {
	local cpu_port="6"
	local panel_port="0 1 2 3"
	local vid=3
	local mode="$(uci -q get xiaoqiang.common.NETMODE)"
	local port
	
	if [ "$mode" != "whc_re" ]; then
		return 0
	fi
	
	for port in $panel_port
	do
		re_init_switch_lan_panel_port $port $vid

		let vid++
	done

	re_init_switch_lan_cpu_port $cpu_port
}

network_init_arch()
{
	local mode=$(uci -q get xiaoqiang.common.NETMODE)

	# config port and interface map
	for port in 0 1 2
	do
		[ -f /proc/portmap/$port ] && echo 0 > /proc/portmap/$port
	done
	echo eth1 > /proc/portmap/4

	case "$mode" in
		"whc_re")
			for port in 0 1 2
			do
				local vid="$(expr $port + 3)"
				[ -f /proc/portmap/$port ] && echo "eth0.${vid}" > /proc/portmap/$port
			done
			
			re_mode_init_switch
			;;

		""|"router")
			# set eth1 linkup always
			echo eth0 > /proc/portmap/10
			
			#network_router_default 0
			;;

		"wifiapmode"|"lanapmode")
			# config port and interface map
			[ -f /proc/portmap/4 ] && echo 0 > /proc/portmap/4
			
			# set eth0,eth1 linkup always
			echo eth0 > /proc/portmap/10
			echo eth1 > /proc/portmap/10
			;;

		*)
			;;
	esac
}