#!/bin/sh

mwlp_network=$(uci -q get network.mwlp)
if [ -z $mwlp_network ]; then
uci -q batch <<EOF
    set network.mwlp=interface
    set network.mwlp.ifname="eth1.7"
    set network.mwlp.type="bridge"
    set network.mwlp.mtu="1470"
    set network.mwlp.proto="static"
    set network.mwlp.ipaddr="192.168.34.1"
    set network.mwlp.netmask="255.255.255.0"
    commit network
EOF
fi
mwlp_firewall=$(uci -q get firewall.dualwifi)
if [ -z $mwlp_firewall ]; then
uci -q batch <<EOF
    set firewall.dualwifi=include
    set firewall.dualwifi.reload="1"
    set firewall.dualwifi.type="script"
    set firewall.dualwifi.path="/usr/sbin/dualwifi.sh set_firewall"
    commit firewall
EOF
fi

cat /etc/crontabs/root | grep set_chanutil
if [ "$?" = "1" ] ; then
	echo "*/5 * * * * /usr/sbin/dualwifi.sh set_chanutil >/dev/null 2>&1" >> /etc/crontabs/root
fi
