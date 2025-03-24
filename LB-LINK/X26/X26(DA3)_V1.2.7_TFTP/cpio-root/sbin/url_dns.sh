#!/bin/sh
# add by wgl 20170209
# name:url_dns.sh

dhcp=`nvram_get 2860 dhcpEnabled`
if [ "$dhcp" = "1" ]; then
    start=`nvram_get 2860 dhcpStart`
    end=`nvram_get 2860 dhcpEnd`
    mask=`nvram_get 2860 lan_netmask`
    pd=`nvram_get 2860 dhcpPriDns`
    sd=`nvram_get 2860 dhcpSecDns`
    gw=`nvram_get 2860 dhcpGateway`
    lease=`nvram_get 2860 dhcpLease`
	lan_if="br0"

    config-udhcpd.sh -s $start
    config-udhcpd.sh -e $end
    config-udhcpd.sh -i $lan_if
    config-udhcpd.sh -m $mask
    if [ "$pd" != "" -o "$sd" != "" ]; then
        config-udhcpd.sh -d $pd $sd
    fi
    if [ "$gw" != "" ]; then
        config-udhcpd.sh -g $gw
    fi
    if [ "$lease" != "" ]; then
        config-udhcpd.sh -t $lease
    fi

    config-udhcpd.sh -r 1
else
    rm /etc/udhcpd.conf -rf
    config-udhcpd.sh -r 1
fi

