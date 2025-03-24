#!/bin/sh


action=$1
ifname=$2

ap_mode=$(uci -q get xiaoqiang.common.NETMODE)
dualwifi_enable=$(uci -q get dualwifi.settings.enabled)
ipaddr=$(uci -q get network.mwlp.ipaddr)
ifname_2G=$(uci -q get misc.wireless.ifname_2G)
ifname_5G=$(uci -q get misc.wireless.ifname_5G)
iface_2G=$(uci show wireless | grep -w "ifname=\'$ifname_2G\'" | awk -F"." '{print $2}')
iface_5G=$(uci show wireless | grep -w "ifname=\'$ifname_5G\'" | awk -F"." '{print $2}')
kernel_version=$(uname -r)
dev="br-mwlp"
DSCP="0x30"

usage() {
    echo "usage:
	dualwifi.sh set_wifi ifname
	"
}

log(){
	echo "[DUALWIFI_LIB] $@" > /dev/console
}

set_wifi_tid_on() {
	cfg80211tool $ifname_2G hlos_tidoverride 1
	cfg80211tool $ifname_5G hlos_tidoverride 1
}

set_wifi_tid_off() {
	cfg80211tool $ifname_2G hlos_tidoverride 0
	cfg80211tool $ifname_5G hlos_tidoverride 0
}

set_wifi_flag() {
	if [ -z $ifname ]; then
		return
	fi
    if [ "$ap_mode" = "wifiapmode" -o "$ap_mode" = "lanapmode" -o "$ap_mode" = "whc_re" -o "$ap_mode" = "whc_cap" ]; then
        return 0
    fi
	if [ -n "$dualwifi_enable" ] && [ "1" = "$dualwifi_enable" ]; then
		wlanconfig "$ifname" vendorie add len 5 oui 8cbebe pcap_data 1034 ftype_map 08
		if [ "wl0" = "$ifname" -o "wl1" = "$ifname" ]; then
			echo 1 > /sys/class/net/$ifname/queues/rx-0/rps_cpus
			#echo 2 > /sys/class/net/$ifname/queues/rx-1/rps_cpus
			#echo 1 > /sys/class/net/$ifname/queues/rx-2/rps_cpus
			#echo 2 > /sys/class/net/$ifname/queues/rx-3/rps_cpus
		fi
		ip=$(uci -q get network.mwlp.ipaddr | cut -b 1-3)
		cat /proc/sys/net/mwlp/ip_forward_table | grep $ip
		if [ "$?" = "0" ] ; then
			set_wifi_tid_on
		fi
	fi

}


set_wifi_on() {
    wlanconfig "$ifname_2G" vendorie add len 5 oui 8cbebe pcap_data 1034 ftype_map 08
    wlanconfig "$ifname_5G" vendorie add len 5 oui 8cbebe pcap_data 1034 ftype_map 08
    echo 1 > /sys/class/net/$ifname_2G/queues/rx-0/rps_cpus
    echo 1 > /sys/class/net/$ifname_5G/queues/rx-0/rps_cpus
}

set_wifi_off() {
    wlanconfig "$ifname_2G" vendorie remove len 4 oui 8cbebe pcap_data 10
    wlanconfig "$ifname_5G" vendorie remove len 4 oui 8cbebe pcap_data 10
    echo 0 > /sys/class/net/$ifname_2G/queues/rx-0/rps_cpus
    echo 0 > /sys/class/net/$ifname_5G/queues/rx-0/rps_cpus
    set_wifi_tid_off
}

start_sfe() {
    rmmod shortcut_fe_drv;
    [ -e "/lib/modules/$kernel_version/shortcut-fe.ko" ] && {
        [ -d /sys/module/shortcut_fe ] || insmod shortcut-fe
    }

    [ -e "/lib/modules/$kernel_version/shortcut-fe-ipv6.ko" ] && {
        [ -d /sys/module/shortcut_fe_ipv6 ] || insmod shortcut-fe-ipv6
    }

    [ -e "/lib/modules/$kernel_version/shortcut-fe-cm.ko" ] && {
        [ -d /sys/module/shortcut_fe_cm ] || insmod shortcut-fe-cm
    }
}

stop_sfe() {
    rmmod shortcut-fe
    rmmod shortcut-fe-ipv6
    rmmod shortcut-fe-cm
    [ -e "/lib/modules/$kernel_version/shortcut-fe-drv.ko" ] && {
        [ -d /sys/module/shortcut_fe_drv ] || insmod shortcut-fe-drv
    }
}

on() {
	uci -q batch <<EOF
        set dualwifi.settings.enabled='1'
        commit dualwifi
EOF
    return 0
}

off() {
	uci -q batch <<EOF
        set dualwifi.settings.enabled='0'
        commit dualwifi
EOF
    return 0
}

start() {
    if [ "$dualwifi_enable" == "0" ]; then
        return 0
    fi

    if [ "$ap_mode" = "wifiapmode" -o "$ap_mode" = "lanapmode" -o "$ap_mode" = "whc_re" -o "$ap_mode" = "whc_cap" ]; then
        return 0
    fi

    [ -f /proc/sys/net/mwlp/enable_mwlp ] && {
        echo 1 > /proc/sys/net/mwlp/enable_mwlp
    }
    set_wifi_on
    s_addr=${ipaddr%.*}
    s_addr=${s_addr}".0/24"
    iptables -t mangle -D PREROUTING -s ${s_addr} -j CONNMARK --set-mark 0x20/0x20
    iptables -t mangle -I PREROUTING -s ${s_addr} -j CONNMARK --set-mark 0x20/0x20
    logger stat_points_none dualwifi_enabled=1
    start_sfe
    return 0
}

stop() {
    [ -f /proc/sys/net/mwlp/enable_mwlp ] && {
        echo 0 > /proc/sys/net/mwlp/enable_mwlp
        echo 1 > /proc/sys/net/mwlp/reset_mwlp
    }
    set_wifi_off
    s_addr=${ipaddr%.*}
    s_addr=${s_addr}".0/24"
    iptables -t mangle -D PREROUTING -s ${s_addr} -j CONNMARK --set-mark 0x20/0x20
    #iptables -t mangle -D POSTROUTING -o $dev -m comment --comment mwlp_wmm -j DSCP --set-dscp $DSCP
    logger stat_points_none dualwifi_enabled=0
    stop_sfe
    return 0
}

shutdown() {
    [ -f /proc/sys/net/mwlp/reset_mwlp ] && echo 1 > /proc/sys/net/mwlp/reset_mwlp
}

boot() {
    start
    return 0
}

set_firewall() {
    [ "$dualwifi_enable" == "1" ] && {
        s_addr=${ipaddr%.*}
        s_addr=${s_addr}".0/24"
        iptables -t mangle -D PREROUTING -s ${s_addr} -j CONNMARK --set-mark 0x20/0x20
        iptables -t mangle -I PREROUTING -s ${s_addr} -j CONNMARK --set-mark 0x20/0x20
        #iptables -t mangle -D POSTROUTING -o $dev  -m comment --comment mwlp_wmm -j DSCP --set-dscp $DSCP
        #iptables -t mangle -I POSTROUTING -o $dev  -m comment --comment mwlp_wmm -j DSCP --set-dscp $DSCP
    }
    return 0
}

set_chanutil() {
    if [ "$dualwifi_enable" == "0" ]; then
        return 0
    fi
    wifi1=$(uci get misc.wireless.if_5G)
    chanutil=$(iwpriv $wifi1 g_chanutil|cut -f 2 -d ':')
    [ -f /proc/xiaoqiang/5G_chanutil ] && {
        echo "$chanutil" > /proc/xiaoqiang/5G_chanutil
    }
}

#log "dual wifi lib $action $ifname"
case ${action} in

"on")
    on
    ;;

"off")
    off
    ;;

"start")
    start
    ;;

"stop")
    stop
    ;;

"set_wifi")
	set_wifi_flag
    ;;

"shutdown")
	shutdown
    ;;

"boot")
	boot
    ;;

"set_firewall")
    set_firewall
    ;;

"set_chanutil")
    set_chanutil
    ;;

"set_wifi_tid_on")
	set_wifi_tid_on
    ;;

"set_wifi_tid_off")
	set_wifi_tid_off
    ;;

*)
    usage
    ;;
esac

return 0
