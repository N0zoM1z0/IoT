#! /bin/sh

# this script has three usages:
# 1. start udhcpc client, rent an ip address and other info from a DHCP server.
# 2. a call back script of udhcpc, set DHCP information to /etc/config/network
# 3. restart lan swtich port to trigger client DHCP resending.

usage () {
    echo "$0 start [interface]"
    echo -e "\t default interface is apcli0"
    echo "$0 restart lan"
    echo "$0 help"
    exit 1
}


router_config_backup() {
    local backup_file="/etc/config/.network.mode.router"
    [ -f $backup_file ] || cp /etc/config/network $backup_file
}

setup_interface () {
    [ -z "$ip" ] && exit 1
    netmask="${subnet:-255.255.255.0}"
    mtu="${mtu:-1500}"
    dns="${dns:-$router}"
    ap_hostname_tmp=${vendorinfo:7}
    ap_hostname_tmp=${ap_hostname_tmp%%-*}
    ap_hostname=MiWiFi-${ap_hostname_tmp}-srv

    old_ip=$(uci -q get network.lan.ipaddr)

    uci -q batch <<EOF >/dev/null
        set xiaoqiang.common.ap_hostname=$ap_hostname
        set xiaoqiang.common.vendorinfo=$vendorinfo
        commit xiaoqiang
        set network.lan=interface
        set network.lan.type=bridge
        set network.lan.proto=static
        set network.lan.ipaddr=$ip
        set network.lan.netmask=$netmask
        set network.lan.gateway=$router
        set network.lan.mtu=$mtu
        del network.lan.dns
        del network.vpn
EOF
    for d in $dns
    do
        uci -q add_list network.lan.dns=$d
    done
    uci commit network

    if [ "$old_ip" != "$ip" ]; then
        /usr/sbin/ip_conflict.sh miot $ip ${netmask:-255.255.255.0}

        local xqbc_exist=$(ps | grep xqbc | grep -v grep | wc -l)
        [ "$xqbc_exist" != "0" ] && /etc/init.d/xqbc restart

        mesh_version=$(uci -q get xiaoqiang.common.MESH_VERSION)
        netmode=$(uci -q get xiaoqiang.common.NETMODE)
        cap_mode=$(uci -q get xiaoqiang.common.CAP_MODE)
        if [ "$mesh_version" -ge "2" -a "$netmode" = "lanapmode" -a "$cap_mode" = "ap" ]; then
            /etc/init.d/mosquitto restart
            /etc/init.d/xq_info_sync_mqtt restart
            /usr/sbin/topomon_action.sh cap_init
        fi
    fi

    exit 0
}

start_dhcp () {
    local model=$(uci -q get misc.hardware.model)
    [ -z "$model" ] && model=$(cat /proc/xiaoqiang/model)
    local hostname="MiWiFi-$model"
    local mypath=`dirname $0`
    cd $mypath >/dev/null
    local abspath=`pwd`
    cd - >/dev/null
    local ifname="$1"
    local wan_mac=$(getmac wan)
    local client_id="01:$wan_mac"

    local i=1
    while [[ $i -le 10 ]]
    do
        ifconfig $ifname >/dev/null 2>&1
        [ $? -eq 0 ] && break
        i=`expr $i + 1`
        sleep 1
    done

    udhcpc -q -s $abspath/`basename $0` -t 3 -T 2 -i "$ifname" -H "$hostname" -x 0x3d:$client_id >/dev/null 2>&1
    exit $?
}

restart_lan () {
    exec /usr/sbin/phyhelper restart
    return $?
}

case "$1" in
    start)
        start_dhcp "$2"
    ;;
    restart)
        restart_lan
        exit $?
    ;;
    renew|bound)
        #if xq already in ap mode,it don't need to backup route config file
        local ap_mode=`uci get network.ap_mode 2>/dev/null`
        [ "$ap_mode" != "bridgeap" ] && router_config_backup

        setup_interface
    ;;
    *)
        usage
    ;;
esac
