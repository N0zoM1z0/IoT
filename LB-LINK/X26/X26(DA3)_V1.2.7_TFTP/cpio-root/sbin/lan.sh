#!/bin/sh
#
# $Id: //WIFI_SOC/MP/SDK_4_2_0_0/RT288x_SDK/source/user/rt2880_app/scripts/lan.sh#1 $
#
# usage: wan.sh
#

. /sbin/config.sh
. /sbin/global.sh

# stop all
killall -q udhcpd
killall -q lld2d
killall -q igmpproxy
killall -q upnpd
killall -q pppoe-relay
killall -q dnsmasq
killall -q radvd
killall -q dnsproxy
killall -q miniupnpd
killall -q miniupnpc

rm -rf /var/run/lld2d-*
echo "" > /var/udhcpd.leases
rmmod domain_login
rmmod flow_manage
rmmod implant_ads

# ip address
ip=`nvram_get 2860 lan_ipaddr`
nm=`nvram_get 2860 lan_netmask`
ifconfig $lan_if down
ifconfig $lan_if $ip netmask $nm
opmode=`nvram_get 2860 OperationMode`
if [ "$opmode" = "0" ]; then
	gw=`nvram_get 2860 wan_gateway`
	pd=`nvram_get 2860 wan_primary_dns`
	sd=`nvram_get 2860 wan_secondary_dns`
	route del default
	route add default gw $gw
	config-dns.sh $pd $sd
fi

ifconfig "br0:9" down
ifconfig "eth2:9" down
lan2enabled=`nvram_get 2860 Lan2Enabled`
if [ "$lan2enabled" = "1" ]; then
	ip_2=`nvram_get 2860 lan2_ipaddr`
	nm_2=`nvram_get 2860 lan2_netmask`
	if [ "$opmode" = "0" ]; then
		ifconfig "br0:9" "$ip_2" netmask "$nm_2"
		echo "ifconfig "br0:9" "$ip_2" netmask "$nm_2""
	elif [ "$opmode" = "1" ]; then
		ifconfig "br0:9" "$ip_2" netmask "$nm_2"
		echo "ifconfig "br0:9" "$ip_2" netmask "$nm_2""
	elif [ "$opmode" = "2" ]; then
		ifconfig "eth2:9" "$ip_2" netmask "$nm_2"
		echo "ifconfig "eth2:9" "$ip_2" netmask "$nm_2""
	elif [ "$opmode" = "3" ]; then
		ifconfig "br0:9" "$ip_2" netmask "$nm_2"
		echo "ifconfig "br0:9" "$ip_2" netmask "$nm_2""
	fi
fi

# hostname
host=`nvram_get 2860 HostName`
if [ "$host" = "" ]; then
	host="ralink"
	nvram_set 2860 HostName ralink
fi
hostname $host
echo "127.0.0.1 localhost.localdomain localhost" > /etc/hosts
#echo "$ip $host.ralinktech.com $host" >> /etc/hosts
if [ "$CONFIG_MT_RUSSIAN_PROJECT" = "y" ];then
	echo "$ip mtlinkwifi.com $host" >> /etc/hosts
else
	echo "$ip blinkwifi.cn $host" >> /etc/hosts
fi
#iptables -t nat -A PREROUTING -p udp -i br0 --dport 53 -j DNAT --to-destination $ip:53
#iptables -t nat -I PREROUTING -i eth0 -p udp --dport 53 -j DNAT --to-destination 1.2.3.4:53


# dhcp server
dhcp=`nvram_get 2860 dhcpEnabled`
if [ "$dhcp" = "1" ]; then
	start=`nvram_get 2860 dhcpStart`
	end=`nvram_get 2860 dhcpEnd`
	mask=`nvram_get 2860 lan_netmask`
	pd=`nvram_get 2860 dhcpPriDns`
	sd=`nvram_get 2860 dhcpSecDns`
	gw=`nvram_get 2860 dhcpGateway`
	lease=`nvram_get 2860 dhcpLease`


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


	# Deal with "super dmz".
	# udhcp has to lease the WAN ip/netmask/router settings to the 
	# "super dmz" host on LAN.
	dmz=`nvram_get 2860 DMZEnable`
	dmzaddress=`nvram_get 2860 DMZAddress`
	if [ "$dmz" = "2" -a "$dmzaddress" != "" -a "$opmode" != "0" ]; then
		# Super dmz enabled.
		# Get WAN IP/Netmask/Gateway
		wip=`ifconfig $wan_ppp_if | sed -n '/inet addr:/p' | sed 's/ *inet addr:\([0-9\.]*\)\ \ .*/\1/'`
		wnm=`ifconfig $wan_ppp_if | sed -n '/inet addr:/p' | sed 's/.*Mask:\([0-9\.]*\)$/\1/'`
		wgw=`route -n | grep "^0.0.0.0" | sed  's/[0-9.]*//' | sed 's/^[ ]*//' | sed 's/\([0-9.]*\)[ ]*[a-zA-Z0-9 .]*/\1/'`

		if [ "$wip" = "" -o "$wnm" = "" -o "$wgw" = "" ]; then
			echo "SuperDMZ: Can't get $wan_ppp_if ip/netmask/gateway currently."
		else
			config-udhcpd.sh -S $dmzaddress $wip
			config-udhcpd.sh -x $wnm
			config-udhcpd.sh -y $wgw
		fi
	fi
	config-udhcpd.sh -r 1
fi

# lltd
lltd=`nvram_get 2860 lltdEnabled`
if [ "$lltd" = "1" ]; then
	lld2d $lan_if
fi

# igmpproxy
igmp=`nvram_get 2860 igmpEnabled`
if [ "$igmp" = "1" ]; then
	config-igmpproxy.sh
fi

# upnp
if [ "$opmode" != "0" ]; then
	upnp=`nvram_get 2860 upnpEnabled`
	if [ "$upnp" = "1" ]; then
		if [ "$CONFIG_USER_MINIUPNPD" = "y" ]; then
			miniupnpd.sh init
            if [ "$CONFIG_USER_MINIUPNPC" = "y" ]; then
                miniupnpc -m br0 -t &
            fi
		else
			route add -net 239.0.0.0 netmask 255.0.0.0 dev $lan_if
			upnp_xml.sh $ip
			upnpd -f $wan_ppp_if $lan_if &
		fi
	fi
fi

# pppoe-relay
pppr=`nvram_get 2860 pppoeREnabled`
if [ "$pppr" = "1" ]; then
	pppoe-relay -S $wan_if -B $lan_if
fi

# dns proxy
dnsp=`nvram_get 2860 dnsPEnabled`
echo dnsp="$dnsp"
if [ "$dnsp" = "1" ]; then
    echo "dnsmasq start"
    killall -9 dnsmasq
    dnsmasq &
fi

if [ "$opmode" != "0" ]; then
echo "$ip" > /var/conf_ip
sleep 1
insmod -q /lib/modules/2.6.36/kernel/drivers/net/flow_manage/flow_manage.ko
sleep 1
insmod -q /lib/modules/2.6.36/kernel/drivers/net/BL_DNS/domain_login.ko
sleep 1
echo "ip $ip" > /proc/router_domain/dm_ip
platform=`nvram_get Platform`
if [ "$platform" = "AC12" ];then
    echo "dm blinklogin.cn" > /proc/router_domain/dm_ip
fi
fi
#####################################

