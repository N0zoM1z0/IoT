#!/bin/sh
#firewall for dualwan mark bind, will be invoked by fw3

. /usr/sbin/dualwan.util.sh

#name for new chain for dualwan
dw_prerouting="dualwan_prerouting"
dw_postrouting="dualwan_postrouting"
dw_output="dualwan_output"

#mask for wan bind
mask_bind_wan="0x0C00"
#WAN flow mark on connmark
mark_bind_wan1="0x0400"
mark_bind_wan2="0x0800"
#mask for dns bind
mask_bind_dns="0x0300"
#DNS flow mark on connmark
mark_bind_dns1="0x0100"
mark_bind_dns2="0x0200"

#sport for dig
dig_check_port1="11431"
dig_check_port2="11432"
dns_port="53"

if_wan1=""
if_wan2=""

ip_wan1=""
ip_wan2=""

#ipset name
ipset_wan1="dualwan_ips_wan1"
ipset_wan2="dualwan_ips_wan2"
ipset_dns1="dualwan_dns_wan1"
ipset_dns2="dualwan_dns_wan2"

get_wan_iface(){
    iface=$1
    ifname=$(uci -q get network.$iface.ifname)
    proto=$(uci -q get network.$iface.proto)
    if [ "$proto" = "pppoe" ]; then
        echo "pppoe-$iface"
    else
        echo "$ifname"
    fi
}

get_wan_ip(){
    iface=$1
    ip=$(ifconfig $iface |grep -o "inet addr:[0-9.]*"|awk -F: '{print $2}')
    echo $ip
}

get_wan_info(){
    if_wan1=$(get_wan_iface wan)
    if_wan2=$(get_wan_iface wan2)

    ip_wan1=$(get_wan_ip $if_wan1)
    ip_wan2=$(get_wan_ip $if_wan2)
}

dualwan_ipset_init(){
    #try to create new ipset whatever any errors
    ipset -q create $ipset_wan1 hash:ip
    ipset -q create $ipset_wan2 hash:ip
    ipset -q create $ipset_dns1 hash:ip
    ipset -q create $ipset_dns2 hash:ip
}

dualwan_ipset_clear(){
    ipset -q flush $ipset_wan1
    ipset -q flush $ipset_wan2
    ipset -q flush $ipset_dns1
    ipset -q flush $ipset_dns2
}

dualwan_reset_firewall(){
    iptables -t mangle -D PREROUTING -j $dw_prerouting &>/dev/null
    iptables -t mangle -D POSTROUTING -j $dw_postrouting &>/dev/null
    iptables -t mangle -D OUTPUT -j $dw_output &>/dev/null
    
    iptables -t mangle -F $dw_prerouting &>/dev/null
    iptables -t mangle -X $dw_prerouting &>/dev/null
    iptables -t mangle -F $dw_postrouting &>/dev/null
    iptables -t mangle -X $dw_postrouting &>/dev/null
    iptables -t mangle -F $dw_output &>/dev/null
    iptables -t mangle -X $dw_output &>/dev/null
}

dualwan_set_firewall(){
    #new chain for dualwan
    iptables -t mangle -N $dw_prerouting
    iptables -t mangle -N $dw_postrouting
    iptables -t mangle -N $dw_output
    iptables -t mangle -A PREROUTING -j $dw_prerouting
    iptables -t mangle -A POSTROUTING -j $dw_postrouting
    iptables -t mangle -A OUTPUT -j $dw_output
    
    #===============prerouting=====================
    #restore mark from nfconmark
    iptables -t mangle -A $dw_prerouting -j CONNMARK --restore-mark --nfmask $mask_bind_wan --ctmask $mask_bind_wan
    
    #if bind to wan already set, just return with restored mark to do routing
    iptables -t mangle -A $dw_prerouting -m mark ! --mark 0x0/$mask_bind_wan -j RETURN
    
    #otherwise, try to set mark
    #set mark for sepcified iplist entries
    iptables -t mangle -A $dw_prerouting -m set --match-set $ipset_wan1 src -j MARK --set-xmark $mark_bind_wan1/$mask_bind_wan
    iptables -t mangle -A $dw_prerouting -m set --match-set $ipset_wan2 src -j MARK --set-xmark $mark_bind_wan2/$mask_bind_wan
    iptables -t mangle -A $dw_prerouting -p udp ! --sport $dig_check_port1:$dig_check_port2 --dport $dns_port -m set --match-set $ipset_dns1 dst -j MARK --set-xmark $mark_bind_dns1/$mask_bind_dns
    iptables -t mangle -A $dw_prerouting -p udp ! --sport $dig_check_port1:$dig_check_port2 --dport $dns_port -m set --match-set $ipset_dns2 dst -j MARK --set-xmark $mark_bind_dns2/$mask_bind_dns

    #set mark for input flow from wan
    iptables -t mangle -A $dw_prerouting -i $if_wan1 -j MARK --set-xmark $mark_bind_wan1/$mask_bind_wan
    iptables -t mangle -A $dw_prerouting -i $if_wan2 -j MARK --set-xmark $mark_bind_wan2/$mask_bind_wan

    #save mark to conntrack mark
    iptables -t mangle -A $dw_prerouting -j CONNMARK --save-mark --nfmask $mask_bind_wan --ctmask $mask_bind_wan

    #===============postrouting=====================
    iptables -t mangle -A $dw_postrouting -m mark ! --mark 0x0/$mask_bind_wan -j RETURN
    #save mark for output flow from wan
    iptables -t mangle -A $dw_postrouting -o $if_wan1 -j CONNMARK --set-xmark $mark_bind_wan1/$mask_bind_wan
    iptables -t mangle -A $dw_postrouting -o $if_wan2 -j CONNMARK --set-xmark $mark_bind_wan2/$mask_bind_wan

    #===============output=====================
    #set mark for output
    [ -n "$ip_wan1" ] && iptables -t mangle -A $dw_output -p udp -s $ip_wan1 --sport $dig_check_port1 -j MARK --set-xmark $mark_bind_wan1/$mask_bind_wan
    [ -n "$ip_wan2" ] && iptables -t mangle -A $dw_output -p udp -s $ip_wan2 --sport $dig_check_port2 -j MARK --set-xmark $mark_bind_wan2/$mask_bind_wan
    iptables -t mangle -A $dw_output -p udp ! --sport $dig_check_port1:$dig_check_port2 --dport $dns_port -m set --match-set $ipset_dns1 dst -j MARK --set-xmark $mark_bind_dns1/$mask_bind_dns
    iptables -t mangle -A $dw_output -p udp ! --sport $dig_check_port1:$dig_check_port2 --dport $dns_port -m set --match-set $ipset_dns2 dst -j MARK --set-xmark $mark_bind_dns2/$mask_bind_dns
}

cmd=$1
dualwan_enable=$(uci -q get dualwan.common.enable)
get_wan_info
#make sure dualwan ipset exist
dualwan_ipset_init

case $cmd in
    "reset")
        dualwan_reset_firewall
    ;;
    "set")
        dualwan_reset_firewall
        [ "$dualwan_enable" != "1" ] && {
            echo "dualwan disabled, so do not set dualwan firewall"
            exit 0
        }
        dualwan_set_firewall
    ;;
    "clean_set")
        dualwan_ipset_clear
    ;;
    "add_ip")
        ip_id=$2
        wan_id=$3
        [ -n "$ip_id" -a -n "$wan_id" ] && {
            [ "$wan_id" = "wan1" ] && ipset -q add $ipset_wan1 $ip_id
            [ "$wan_id" = "wan2" ] && ipset -q add $ipset_wan2 $ip_id
        }
    ;;
    "del_ip")
        ip_id=$2
        wan_id=$3
        [ -n "$ip_id" -a -n "$wan_id" ] && {
            [ "$wan_id" = "wan1" ] && ipset -q del $ipset_wan1 $ip_id
            [ "$wan_id" = "wan2" ] && ipset -q del $ipset_wan2 $ip_id
        }
    ;;
    "reset_dns_route")
	    [ "$dualwan_enable" != "1" ] && {
            echo "dualwan disabled, so do not reset dns route"
            exit 0
        }
        wan1_dns1=$2
        wan1_dns2=$3
        wan2_dns1=$4
        wan2_dns2=$5
        get_default_route
        del_dns_rule
        add_dns_rule $wan1_dns1 $wan1_dns2 $wan2_dns1 $wan2_dns2
    ;;
    "del_dns_route")
	    [ "$dualwan_enable" != "1" ] && {
            echo "dualwan disabled, so do not del dns route"
            exit 0
        }
        blackhole_nexthop=$2
        blackhole_table=$3
        get_default_route
        del_dns_route $dns_check_table1 $nexthop1
        del_dns_route $dns_check_table2 $nexthop2
        ip route add blackhole $blackhole_nexthop table $blackhole_table
    ;;
    "dual_wan_reset")
	    [ "$dualwan_enable" != "1" ] && {
            echo "dualwan disabled, so do not del dns route"
            exit 0
        }
        get_default_route
        dual_wan_route
    ;;
    "*")
        echo "dualwan: not support cmd: $cmd"
        exit -1
    ;;
esac

