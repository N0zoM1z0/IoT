#!/bin/sh

aton()  { 
        echo $1|awk '{c=256;split($0,str,".");print str[4]+str[3]*c+str[2]*c^2+str[1]*c^3}'
}

is_same_net()  {
        local _ip=$1
        local _mask=$2
        local _gw=$3

        _ipn=$(aton $_ip)
        _maskn=$(aton $_mask)
        _gwn=$(aton $_gw)

        num1=$(($_ipn & $_maskn))
        num2=$(($_gwn & $_maskn))
        if [ $num1 -eq $num2 ];then
                return 1
        else
                return 0
        fi
}

check_ip_conflict_with_miot() {
        local lan_ip=$1
        local lan_netmask=$2

        local miot_ip=$(uci -q get network.miot.ipaddr)
        local miot_netmask=$(uci -q get network.miot.netmask)
        if [ -z "$miot_ip" -o -z "$miot_netmask" ];then
                echo "ERR: miot config is null" > /dev/console
                return
        fi
        #检测br-lan和br-miot是否网段冲突
        is_same_net "$lan_ip" "$lan_netmask" "$miot_ip"
        flag1=`echo $?`
        is_same_net "$lan_ip" "$miot_netmask" "$miot_ip"
        flag2=`echo $?`
        if [ "$flag1" = "1" -o "$flag1" = "1" ];then
                echo "br-lan and br-miot IP conflict" > /dev/console
                local ip1=`echo $miot_ip|awk '{split($0,str,".");print str[1]}'`
                local ip2=`echo $miot_ip|awk '{split($0,str,".");print str[2]}'`
                local ip3=`echo $miot_ip|awk '{split($0,str,".");print str[3]}'`
                local ip4=`echo $miot_ip|awk '{split($0,str,".");print str[4]}'`
                local new_ip3_tmp=$(($ip3+10))
                local new_ip3=$(($new_ip3_tmp%254))
                local new_ip=$ip1.$ip2.$new_ip3.$ip4
                uci set network.miot.ipaddr=$new_ip
                uci commit network
                echo "set br-miot new IP: $new_ip" > /dev/console
                ifup br-miot
        fi
}
