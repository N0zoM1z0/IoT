#!/bin/sh

sleep 25 

cnt=0
k=0
while [ "$cnt" -lt 20 ]; do
    ifcs=`brctl  show  | grep -E 'ra0|eth0.1' | awk 'END{print NR}' | tr -d '\n'`
    if [ "$ifcs" == "2" ]; then
        k=$(($k+1)) 
    else
        k=0
    fi

    # bridge is established.  
    if [ "$k" == "4" ];then
        break
    fi

    cnt=$(($cnt+1))
    sleep 1
done

echo "[ enable_ipv6.sh ] --------!!!!!!!!!!--------"  > /dev/console

machine=$(cat /proc/cpuinfo | grep -i MT76)
case $machine in   
    *"MT7621"*)        
        wan_if="eth1"  
        ;;             
    *"MT7628"*)        
        wan_if="eth0.2"                                                       
    ;;                                                                        
    *)                                                                        
        wan_if="eth1"                                                         
    ;;                                                                        
esac 

local curr_mode=`uci get internet.config.mode | tr -d '\n'`
if [ "$curr_mode" = "routerdhcp" ]; then
    local br_traverse_ipv6=`uci get network.lan.br_traverse_ipv6 | tr -d '\n'`
    if [ "$br_traverse_ipv6" = "1" ];then
        lua /sbin/svctl.lua rcd_ifc_info

        brctl addif br-lan $wan_if
        ifconfig $wan_if down
        sleep 1
        ifconfig $wan_if up
        
        ebtables -t broute -D BROUTING -i br-lan -p ! ipv6 -j DROP
        ebtables -t broute -D BROUTING -i $wan_if   -p ! ipv6 -j DROP
        ebtables -t broute -A BROUTING -i br-lan -p ! ipv6 -j DROP
        ebtables -t broute -A BROUTING -i $wan_if   -p ! ipv6 -j DROP
    else
        brctl delif br-lan $wan_if
    	ebtables -t broute -F	 
    fi
else
    ebtables -t broute -F
fi

local type=`uci get system.board.type | tr -d '\n'`
if [ "$type" = "router" ]; then
    # sh /sbin/start_br_dnsmasq.sh 0 &
    
    /etc/init.d/dnsmasq stop
    sleep 1
    /etc/init.d/dnsmasq reload

    local ext_ifname
    if [ "$curr_mode" = "routerpppoe" ]; then
        ext_ifname="pppoe-wan"
    else
        ext_ifname=$wan_if
    fi
        
    lanmac=`mac r lan | awk -F' ' '{print $1$2$3$4$5$6}'`
    oui=`echo $lanmac | cut -b 1-6`
    lastdigit=`echo $lanmac | cut -b 7-12`
    
    nv_sn=`nvram get blink SN | tr -d '\n'`
    if [ "$nv_sn" = "" ]; then
        nv_sn="DL180110011367$lastdigit"
    fi
    nv_sn=`echo $nv_sn | tr "[a-z]" "[A-Z]"`
    
    uci set easycwmp.@local[0].interface="${ext_ifname}"
    uci set easycwmp.@device[0].oui="$oui"
    uci set easycwmp.@device[0].serial_number="$nv_sn"
    uci set easycwmp.@device[0].software_version="v1.01"
    uci commit easycwmp
    killall easycwmpd
    
    # STUN
    killall caStun
    sleep 1
    caStun &
    
    cwmp_wanport=`uci get easycwmp.@local[0].port`
    uci set firewall.@rule[0].dest_port="$cwmp_wanport"
    uci commit firewall
    /etc/init.d/firewall restart

    local upnp_en=`uci get misc.upnp.enable | tr -d '\n'`
    if [ "$upnp_en" = "1" ]; then
        iptables_upnp_exit.sh $wan_if
        iptables_upnp_init.sh $wan_if
        
        local lanIP=`uci get network.lan.ipaddr | tr -d '\n'`
        sed -i "s|^[#]*[ ]*listening_ip\([ ]*\)=.*|listening_ip=${lanIP}|" /etc/miniupnpd.conf
        sed -i "s|^[#]*[ ]*presentation_url\([ ]*\)=.*|presentation_url=http://${lanIP}/|" /etc/miniupnpd.conf
        sed -i "s|^[#]*[ ]*ext_ifname\([ ]*\)=.*|ext_ifname=${ext_ifname}|" /etc/miniupnpd.conf
        
        killall miniupnpd
        sleep 1
        miniupnpd -G
    else
        killall miniupnpd
        iptables_upnp_exit.sh $wan_if
    fi
else
    # bridge mode.
    if [ "$curr_mode" = "routerwisp" ]
    then
        start_mt7628_repeater.sh
    fi
    
    ifconfig br-lan 0.0.0.0
    killall -USR1 udhcpc
    sleep 3

    cnt=0
    while [ "$cnt" -lt 20 ]; do
        brlan_ipaddr=`ifconfig br-lan | grep "inet addr:" | awk -F' ' '{print $2}' | awk -F':' '{print $2}'`
        if [ "$brlan_ipaddr" != "" ]; then
            flow_ipaddr=$brlan_ipaddr
            rmmod flow_manage
            insmod flow_manage.ko ipaddr="$flow_ipaddr"
            
            echo "curr-mode=bridgedhcp, flow_ipaddr=$flow_ipaddr  ----------------"  >  /dev/console
            echo "[ check_repeater_result ] ---cnt="$cnt", finished!!! ----------"  > /dev/console
            break
        fi
    
        cnt=$(($cnt+1))
        sleep 1
        echo "[ check_repeater_result ] ---cnt="$cnt"----------"  > /dev/console
    done
    
    # br-lan backup IP.        
    ifconfig br-lan:1 192.168.0.50
fi

# set switch lan ports led and 2.4g wifi led, disable led blink.
switch reg w a4 0x0                                                  
switch reg w a8 0x0                                        
switch reg w ac 0x0                                     
switch reg w b0 0x0                                                           
                                         
ra0_disable=`uci get wireless.@wifi-iface[0].disabled`
[ "$ra0_disable" == "0" ] && iwpriv ra0 set WlanLed=0

#local wan_at_port=4
#local wanport_speed=`uci get misc.wanport.speed | tr -d '\n'`
#if [ "$wanport_speed" = "0" ] || [ "$wanport_speed" = "1" ]
#then
#    # auto 
#    mii_mgr -s -p $wan_at_port -r 0 -v 0x3100
#elif [ "$wanport_speed" = "2" ]
#then
#    # forced 100M
#    mii_mgr -s -p $wan_at_port -r 0 -v 0x2100
#else
#    # forced 10M
#    mii_mgr -s -p $wan_at_port -r 0 -v 0x0100
#fi
  
# remove rebooting flag.
rm /tmp/net_rebooting -rf

if [ -f /tmp/router_booting ]; then          
	# remove booting flag.
	rm /tmp/router_booting -rf  
else                                
	# reset lan ports of switch.
	lan-reset.sh
fi

