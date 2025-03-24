#!/bin/sh
#util function for dualwan, call by dualwan.firewall

#name for rule tables
dns_check_table1="dnscheck1"
dns_check_table2="dnscheck2"
link_check_table1="linkcheck1"
link_check_table2="linkcheck2"
mark_dnscheck1="0x100/0x300"
mark_dnscheck2="0x200/0x300"
mark_linkcheck1="0x400/0xc00"
mark_linkcheck2="0x800/0xc00"
prio_link="98"
prio_dns="99"

add_dns_route()
{
    dns=$1
    nexthop=$2
    table=$3
    ip route add $dns/32 via $nexthop table $table
}

del_dns_route()
{
    table=$1
    nexthop=$2
    route=$(ip route show table $table)
    echo "$route" | while read line
    do
        blackhole=`echo $line | grep blackhole`
        if [ "x$blackhole" != "x" ]; then
            ip=${line#*blackhole }
            ip route del blackhole $ip table $table
        fi
        ip=${line%% *}
        ip route del $ip/32 via $nexthop table $table
    done
}

add_dns_rule()
{
    wan1_dns1=$1
    wan1_dns2=$2
    wan2_dns1=$3
    wan2_dns2=$4
    # wan1
    for wan_dns in $wan1_dns1 $wan1_dns2
    do
        if [ "$wan_dns" != "x" ]; then
            fwmarked=$(ip rule | grep fwmark | grep $dns_check_table1)
            if [ "x$fwmarked" == "x" ]; then
                ip rule add fwmark $mark_bind_dns1/$mask_bind_dns table $dns_check_table1 prio $prio_dns
	    fi
            if [ "x$nexthop1" != "x" ]; then
                add_dns_route $wan_dns $nexthop1 $dns_check_table1
            fi
        fi
        ipset -q add $ipset_dns1 $wan_dns
    done
    # wan2
    for wan2_dns in $wan2_dns1 $wan2_dns2
    do
        if [ "$wan2_dns" != "x" ]; then
            fwmarked=$(ip rule | grep fwmark | grep $dns_check_table2)
            if [ "x$fwmarked" == "x" ]; then
                ip rule add fwmark $mark_bind_dns2/$mask_bind_dns table $dns_check_table2 prio $prio_dns
            fi
            if [ "x$nexthop2" != "x" ]; then
                add_dns_route $wan2_dns $nexthop2 $dns_check_table2
            fi
        fi
        ipset -q add $ipset_dns2 $wan2_dns
    done
}

del_dns_rule()
{
    # wan dns assign
    del_dns_route $dns_check_table1 $nexthop1
    ip rule del fwmark $mark_bind_wan1/$mask_bind_wan table $dns_check_table1
    ipset -q flush $ipset_dns1

    # wan2 dns assign
    del_dns_route $dns_check_table2 $nexthop2
    ip rule del fwmark $mark_bind_wan2/$mask_bind_wan table $dns_check_table2
    ipset -q flush $ipset_dns2
}

add_link_rule()
{
    # dual wan detect
    fwmarked1=$(ip rule | grep fwmark | grep $mark_linkcheck1)
    fwmarked2=$(ip rule | grep fwmark | grep $mark_linkcheck2)
    if [ "x$fwmarked1" == "x" ]; then
        ip rule add fwmark $mark_linkcheck1 table $link_check_table1 prio $prio_link
    fi
    if [ "x$fwmarked2" == "x" ]; then
        ip rule add fwmark $mark_linkcheck2 table $link_check_table2 prio $prio_link
    fi

    lan_addr=$(ipcalc.sh $lan_address $lan_mask |grep -o "NETWORK=[0-9.]*"|awk -F= '{print $2}')

    # default route for linkcheck1
    ip route replace default via $nexthop1 dev $l3_device1 table $link_check_table1
    ip route replace $lan_addr/$lan_mask dev $lan_device table $link_check_table1

    # default route for linkcheck2
    ip route replace default via $nexthop2 dev $l3_device2 table $link_check_table2
    ip route replace $lan_addr/$lan_mask dev $lan_device table $link_check_table2
}

del_link_rule()
{
    # dual wan detect
    ip rule del fwmark $mark_linkcheck1 table $link_check_table1
    ip rule del fwmark $mark_linkcheck2 table $link_check_table2
}

get_default_route()
{
    . /lib/network/config.sh
    ubus_call network.interface.wan status
    json_get_var l3_device1 "l3_device"
    json_select "route"
    __idx=1
    while json_is_a "$__idx" object; do
        json_select "$((__idx++))"
        json_get_var target1 "target"
        json_get_var mask1 "mask"
        json_get_var nexthop1 "nexthop"
        json_select ".."
    done
    json_select ".."
    json_select "ipv4-address"
    __idx=1
    while json_is_a "$__idx" object; do
        json_select "$((__idx++))"
        json_get_var address1 "address"
        json_select ".."
    done

    ubus_call network.interface.wan2 status
    json_get_var l3_device2 "l3_device"
    json_select "route"
    __idx=1
    while json_is_a "$__idx" object; do
        json_select "$((__idx++))"
        json_get_var target2 "target"
        json_get_var mask2 "mask"
        json_get_var nexthop2 "nexthop"
        json_select ".."
    done
    json_select ".."
    json_select "ipv4-address"
    __idx=1
    while json_is_a "$__idx" object; do
        json_select "$((__idx++))"
        json_get_var address2 "address"
        json_select ".."
    done

    ubus_call network.interface.lan status
    json_get_var lan_device "l3_device"
    json_select "ipv4-address"
    __idx=1
    while json_is_a "$__idx" object; do
        json_select "$((__idx++))"
        json_get_var lan_address "address"
        json_get_var lan_mask "mask"
        json_select ".."
    done
}

dual_wan_route()
{
    targetx="x$target1"
    maskx="x$mask1"
    nexthopx="x$nexthop1"
    if [ "$targetx" == "x" -o "$maskx" == "x" -o "$nexthopx" == "x" ]; then
        wan1up="FALSE"
    else
        wan1up="TRUE"
    fi

    targetx="x$target2"
    maskx="x$mask2"
    nexthopx="x$nexthop2"
    if [ "$targetx" == "x" -o "$maskx" == "x" -o "$nexthopx" == "x" ]; then
        wan2up="FALSE"
    else
        wan2up="TRUE"
    fi

    if [ "$wan1up" == "TRUE" -a "$wan2up" == "TRUE" ]; then
        weight1=$(uci -q get dualwan.common.weight_wan1)
        weight2=$(uci -q get dualwan.common.weight_wan2)
        if [ "x$weight1" == "x" ]; then
            weight1="1"
        fi
        if [ "x$weight2" == "x" ]; then
            weight2="1"
        fi
        ip route replace default scope global nexthop via $nexthop1 dev $l3_device1 weight $weight1  nexthop via $nexthop2 dev $l3_device2 weight $weight2
        echo 1 > /proc/sys/net/ipv4/fib_multipath_hash_policy
        del_link_rule
        add_link_rule
        ubus call wan_check reset
    elif [ "$wan1up" == "TRUE" -a "$wan2up" == "FALSE" ]; then
        ip route replace default via $nexthop1 dev $l3_device1
        del_link_rule
        del_dns_rule
        /usr/sbin/dualwan.lua reset_ip_rule
    elif [ "$wan1up" == "FALSE" -a "$wan2up" == "TRUE" ]; then
        ip route replace default via $nexthop2 dev $l3_device2
        del_link_rule
        del_dns_rule
        /usr/sbin/dualwan.lua reset_ip_rule
    fi
}
