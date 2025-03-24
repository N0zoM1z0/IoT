#!/bin/sh 
link_type=wire
soc=
wan_if="eth1"
g5_type=`uci get wireless.@wifi-device[1].type | tr -d '\n'`
init_info()
{
	machine=$(cat /proc/cpuinfo | grep -i MT76)
	case $machine in
    	*"MT7621"*)
        	soc="MT7621"
            	wan_if="eth1"
        ;;
    	*"MT7628"*)
        	soc="MT7628"
		wan_if="eth0.2"
        ;;
	*)
       		return
       	;;
	esac

	if [ "$link_type" == "wire" ]; then
		uci set wireless.mt7603e.apclienable=0
        uci set wireless.$g5_type.apclienable=0
        uci commit wireless
		
        is_up=`ifconfig apcli0 | grep 'UP'`
        [ "$is_up" ] && ifconfig apcli0 down
        iwpriv apcli0 set ApCliEnable=0

        is_up=`ifconfig apclii0 | grep 'UP'`
        [ "$is_up" ] && ifconfig apclii0 down
        iwpriv apclii0 set ApCliEnable=0
	else
		local wisptype=`uci get internet.config.wisptype -q | tr -d '\n'`
		if [ "$wisptype" == "1" ]; then
			local auth_encry=`uci -q get internet.config.auth`
	        uci set wireless.$g5_type.apclienable=1
	        uci set wireless.$g5_type.apclissid="`uci -q get internet.config.ssid`"
	        uci set wireless.$g5_type.apcliwpapsk=`uci -q get internet.config.wirelesspwd`
			# auth_encry= WPA2PSK/AES | WPAPSKWPA2PSK/TKIPAES | WPAPSKWPA2PSK/AES | OPEN/NONE 
			
			case "${auth_encry}" in
			*2*)
            			authmode="WPA2PSK";;
        		*WPA*)
            			authmode="WPAPSK";;
        		*OPEN*)
            			authmode="OPEN";;
    			esac

    			case "${auth_encry}" in
        		*AES*)
            			enc="AES";;
        		*TKIP*)
            			enc="WPAPSK";;
        		*NONE*)
            			enc="NONE";;
    			esac
	        	uci set wireless.$g5_type.apcliencryptype=${enc}
			uci set wireless.$g5_type.apcliauthmode=${authmode}
		else
			local auth_encry=`uci -q get internet.config.auth`
        	uci set wireless.mt7603e.apclienable=1
        	uci set wireless.mt7603e.apclissid="`uci -q get internet.config.ssid`"
        	uci set wireless.mt7603e.apcliwpapsk=`uci -q get internet.config.wirelesspwd`
			# auth_encry= WPA2PSK/AES | WPAPSKWPA2PSK/TKIPAES | WPAPSKWPA2PSK/AES | OPEN/NONE 

			case "${auth_encry}" in
			*2*)
            			authmode="WPA2PSK";;
        		*WPA*)
            			authmode="WPAPSK";;
        		*OPEN*)
            			authmode="OPEN";;
    			esac

    			case "${auth_encry}" in
        		*AES*)
            			enc="AES";;
        		*TKIP*)
            			enc="WPAPSK";;
        		*NONE*)
            			enc="NONE";;
    			esac
	        	uci set wireless.mt7603e.apcliencryptype=${enc}
			uci set wireless.mt7603e.apcliauthmode=${authmode}
		fi
        	uci commit wireless
	fi
	
	if [ "$set_wan_type" == "bridgestatic" ] || [ "$set_wan_type" == "bridgedhcp" ] || [ "$set_wan_type" == "autodhcp" ] || [ "$set_wan_type" == "routerwisp" ]; then
	    # when switch router mode to bridge mode, should disable mac clone. 
	    local factory_mac=`eth_mac r wan`
	    local wan_mac=`uci get network.wan.macaddr`  
	    if [ "$wan_mac" ] && [ "$wan_mac" != "$factory_mac" ]; then
	        uci del network.wan.macaddr
	        uci commit network
	    fi
	fi
}

set_5g_repeater()
{
    local channel=`uci get wireless.${g5_type}.channel`
    
    ifconfig apclii0 up
    ifconfig rai0 up
    iwpriv rai0 set Channel=$channel

    iwpriv apclii0 set ApCliEnable=0
    iwpriv apclii0 set ApCliAuthMode=`uci get wireless.${g5_type}.apcliauthmode`
    iwpriv apclii0 set ApCliEncrypType=`uci get wireless.${g5_type}.apcliencryptype`
    iwpriv apclii0 set ApCliWPAPSK=`uci get wireless.${g5_type}.apcliwpapsk`
    iwpriv apclii0 set ApCliSsid=`uci get wireless.${g5_type}.apclissid`
    #iwpriv apclii0 set ApCliBssid=
    iwpriv apclii0 set ApCliEnable=1
}


remove_wan()
{
	uci -q get network.wan && uci set network.wan.ifname=''
}

add_wan()
{
    uci -q get network.wan
    if [ $? -eq 0 ]; then
             uci set network.wan.ifname="$wan_if"
    else
            . /lib/functions/uci-defaults.sh
            ucidef_set_interface_wan "$wan_if"
            wan_mac=`eth_mac r wan`
            [ -n "$wan_mac" ] && uci set network.wan.macaddr=$wan_mac
    fi
}

auto_dhcp()
{
 	remove_wan 
        uci set network.lan.proto='dhcp'
        if [ "$soc" == "MT7628" ]; then
                uci set network.lan.ifname="eth0.1 eth0.2 apcli0"
        elif [ "$soc" == "MT7621" ]; then
                uci set network.lan.ifname="eth0 eth1 apcli0"
        fi
                                                                         
        uci set system.board.type='bridge'
        uci set system.board.uplink_detect=''
        uci set dhcp.lan.ignore='1'
        uci set andlink.qlink.stat=""
        uci commit 
	    rm /tmp/uplink_init

        /etc/init.d/odhcpd disable
        /etc/init.d/odhcpd stop
        /etc/init.d/firewall disable
        /etc/init.d/firewall stop
		
}

bridge_dhcp()
{
 	remove_wan 
    uci set network.lan.proto='dhcp'
    if [ "$soc" == "MT7628" ]; then
                uci set network.lan.ifname="eth0.1 eth0.2 apcli0"
    elif [ "$soc" == "MT7621" ]; then
                uci set network.lan.ifname="eth0 eth1 apcli0"
    fi

    uci set system.board.type='bridge'
	uci set system.board.uplink_detect=wire 
    uci set dhcp.lan.ignore='1'
    uci commit 

    /etc/init.d/odhcpd disable
    /etc/init.d/odhcpd stop
    /etc/init.d/firewall disable
    /etc/init.d/firewall stop
}

bridge_static()
{
	remove_wan
    ipaddr=`uci -q get internet.config.bridgeipaddr`
    netmask=`uci -q get internet.config.bridgenetmask`
    gateway=`uci -q get internet.config.bridgegateway` 

	if [ "$soc" == "MT7628" ]; then           
		uci set network.lan.ifname="eth0.1 eth0.2 apcli0"
	elif [ "$soc" == "MT7621" ]; then
		uci set network.lan.ifname="eth0 eth1 apcli0"
	fi
	
	uci set dhcp.lan.ignore='1'
	uci set network.lan.proto='static'
	uci set network.lan.ipaddr="$ipaddr"
	uci set network.lan.netmask="$netmask"
	uci set network.lan.gateway="$gateway"

	uci set system.board.type='bridge'
	uci set system.board.uplink_detect=wire 
    uci commit

	/etc/init.d/odhcpd disable
	/etc/init.d/odhcpd stop
	/etc/init.d/firewall disable
	/etc/init.d/firewall stop
}

router_static()
{
    add_wan
    ipaddr=`uci -q get internet.config.routeripaddr`
    netmask=`uci -q get internet.config.routernetmask`
    gateway=`uci -q get internet.config.routergateway`
    dns1=`uci -q get internet.config.routerdns1`
    dns2=`uci -q get internet.config.routerdns2`

	disable_br_lan1.sh 2>/dev/null 
	uci set network.lan.proto='static'
	if [ "$soc" == "MT7628" ]; then           
		uci set network.lan.ifname="eth0.1"
		uci set network.wan.ifname="eth0.2"
	elif [ "$soc" == "MT7621" ]; then
		uci set network.lan.ifname="eth0"
		uci set network.wan.ifname="eth1"
	fi 

	uci -q delete network.lan.gateway
		
	uci set dhcp.lan.ignore='0'
	uci set network.wan.proto='static'
	uci set network.wan.ipaddr="$ipaddr"
	uci set network.wan.netmask="$netmask"
	uci set network.wan.gateway="$gateway"
	uci set network.wan.dns="$dns1 $dns2"

	uci set system.board.type='router'
	uci set system.board.uplink_detect=wire 
    uci commit

	/etc/init.d/odhcpd enable
	/etc/init.d/odhcpd start
	/etc/init.d/firewall enable
	/etc/init.d/firewall stop
}

router_dhcp()
{
	add_wan
	disable_br_lan1.sh 2>/dev/null 
	uci set network.lan.proto='static'
	if [ "$soc" == "MT7628" ]; then           
		uci set network.lan.ifname="eth0.1"
		uci set network.wan.ifname="eth0.2"
	elif [ "$soc" == "MT7621" ]; then
		uci set network.lan.ifname="eth0"
		uci set network.wan.ifname="eth1"
	fi 
	
	uci -q delete network.lan.gateway
                
	uci del network.wan.ipaddr
	uci del network.wan.netmask
	uci del network.wan.gateway
	
	uci set dhcp.lan.ignore='0'
	uci set network.wan.proto='dhcp'
        
	uci set system.board.type='router'
	uci set system.board.uplink_detect=wire 
    uci commit

	/etc/init.d/odhcpd enable
	/etc/init.d/odhcpd start
	/etc/init.d/firewall enable
	/etc/init.d/firewall start
}

router_wisp()
{
	remove_wan
	if [ "$soc" == "MT7628" ]; then           
		uci set network.lan.ifname="eth0.1 eth0.2 apcli0 apclii0"
	elif [ "$soc" == "MT7621" ]; then
		uci set network.lan.ifname="apcli0 eth0 eth1 apclii0"
	fi
 
	uci set network.lan.proto='dhcp'
	uci set dhcp.lan.ignore='1'
	
	uci set system.board.type='bridge'
	uci set system.board.uplink_detect=wireless 
	uci commit

 	# special handle for mt7612e/mt7663e.
    local wisptype=`uci get internet.config.wisptype -q | tr -d '\n'`
    if [ "$wisptype" == "1" ]; then
        is_up=`ifconfig apcli0 | grep 'UP'`
        [ $is_up ] && ifconfig apcli0 down

        set_5g_repeater
    else
        is_up=`ifconfig apclii0 | grep 'UP'`
        [ $is_up ] && ifconfig apclii0 down
        iwpriv apclii0 set ApCliEnable=0
    fi

	/etc/init.d/odhcpd disable
	/etc/init.d/odhcpd stop
	/etc/init.d/firewall disable
	/etc/init.d/firewall stop
}
        
router_pppoe()
{
	add_wan
    username=`uci -q get internet.config.id`
    password=`uci -q get internet.config.pwd` 

	disable_br_lan1.sh 2>/dev/null 
	uci set network.lan.proto='static'
	#uci set network.lan.ipaddr='192.168.10.1'
	#uci set network.lan.netmask='255.255.255.0'
	uci -q delete network.lan.gateway
	uci set dhcp.lan.ignore='0'

	uci set network.wan.proto="pppoe"
	uci set network.wan.username="$username"
	uci set network.wan.password="$password"
	if [ "$soc" == "MT7628" ]; then           
		uci set network.lan.ifname="eth0.1"
		uci set network.wan.ifname="eth0.2"
	elif [ "$soc" == "MT7621" ]; then
		uci set network.lan.ifname="eth0"
		uci set network.wan.ifname="eth1"
	fi 
	
	uci set system.board.type='router'
	uci set system.board.uplink_detect=wire 
	uci commit
	
	/etc/init.d/firewall enable
	/etc/init.d/firewall start
}

set_wan_type=`uci -q get internet.config.mode`                                             
[ $? -ne 0 ] && exit                                                                       

if [ "$set_wan_type" == "routerwisp" ]; then
        link_type=wireless
else
        link_type=wire
fi

#MapEnable=$(wificonf -f /etc/wireless/mt7603/mt7603.dat get MapMode)
#DeviceRole=$(wificonf -f /etc/map/mapd_cfg get DeviceRole)
#if [ "$DeviceRole" = "2" ] && [ "$MapEnable" = "1" ] ; then
#    uci set internet.config.mode="bridgedhcp"
#    uci set system.board.type="bridge"
#    set_wan_type="bridgedhcp"
#fi

init_info

[ "$set_wan_type" != "autodhcp" ] && rm -rf /etc/reg.*

case "$set_wan_type" in
	"autodhcp")
		auto_dhcp
		;;
        "bridgestatic")
                bridge_static
                ;;
        "bridgedhcp")
                bridge_dhcp
                ;;
        "routerstatic")
                router_static
                ;;
        "routerdhcp")
                router_dhcp
                ;;
        "routerpppoe")
                router_pppoe
                ;;
        "routerwisp")
                router_wisp
                ;;
	*)
		echo "wan type must be bridgestatic|bridgedhcp|routerstatic|routerdhcp|routerpppoe"
		exit 0
		;;
esac


rm -rf /var/client 2>/dev/null
/etc/init.d/network stop                   
sleep 1 
/etc/init.d/network start
echo "###################  !!***********************!!!!!!!!!!!!!!!" >/dev/console

