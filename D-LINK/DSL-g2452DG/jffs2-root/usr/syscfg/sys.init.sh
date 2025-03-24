#!/bin/sh
#
# usage: sys.init.sh
#

##tgp ³õÊ¼»¯
mkdir -p /var/tgp/lock/
mkdir -p /var/tgp/log/
echo "warning" > /var/tgp/log/cur_level

##close GE PHY clock
insmod lib/ko/hi_kefuse.ko
insmod lib/ko/hi_kpower.ko
#cs_cli /home/cli/debug/test/power/set_ge_status -v mode 0

genSysFiles()
{
	login="admin"
	pass="admin"
	if [ "$login" != "" -a "$pass" != "" ]; then
		echo "$login::0:0:Adminstrator:/:/bin/sh" > /etc/passwd
		echo "$login:x:0:$login" > /etc/group
		chpasswd.sh $login $pass
	fi
}
#wireless.sh
genSysFiles
#add user nobody
echo "nobody:x:65534:65534:nobody:/nonexistent:/bin/sh" >>/etc/passwd
#init resolv.conf
echo "nameserver 127.0.0.1" >>/etc/resolv.conf
#init hosts
echo "127.0.0.1 localhost" >>/etc/hosts
echo "::1 localhost6" >>/etc/hosts

#disable ip_forward by default
echo 0 > /proc/sys/net/ipv4/ip_forward
# disable ipv6 DAD on all interfaces by default
echo "0" > /proc/sys/net/ipv6/conf/default/accept_dad
#telling kernel that it has a dynamic IP address. 
#Any packets which are originally sent from 10.64.64.64 will be redirected to the new IP address as soon as pppoe dail-on-demand connected
echo 1 > /proc/sys/net/ipv4/ip_dynaddr

#start sysmonitor
#xdsl_cli link --down
#sysmonitor -u /usr/syscfg/dsl.online.sh -d /usr/syscfg/dsl.offline.sh -b /usr/syscfg/key_press.sh&
#xdsl_cli link --up
#xdsl_cli sys --debug-level 0
/usr/syscfg/ebtables.init.sh
/usr/syscfg/firewall.init.sh

echo 1 > /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
echo 2 > /proc/sys/net/ipv6/conf/all/accept_dad
echo 1 > /proc/sys/net/ipv4/conf/all/arp_ignore
echo 300 >/proc/sys/net/netfilter/nf_conntrack_tcp_timeout_established
echo 70 > /proc/sys/net/netfilter/nf_conntrack_udp_timeout

#set special packet car
cs_cli /home/cli/api/qos/set_pkt_car -v type 1 igr 0 enable 1 limit 0xc8
cs_cli /home/cli/api/qos/set_pkt_car -v type 0 igr 0 enable 1 limit 0x32
cs_cli /home/cli/api/qos/set_pkt_car -v type 2 igr 0 enable 1 limit 0x32
cs_cli /home/cli/api/qos/set_pkt_car -v type 8 igr 0 enable 1 limit 0x64
#match the special packet and set it's egress queue's priority
cs_cli /home/cli/api/qos/set_pkt_pq -v type 0 enable 1 pq 0x0
cs_cli /home/cli/api/qos/set_pkt_pq -v type 1 enable 1 pq 0x0
cs_cli /home/cli/api/qos/set_pkt_pq -v type 2 enable 1 pq 0x0
cs_cli /home/cli/api/qos/set_pkt_pq -v type 3 enable 1 pq 0x0
cs_cli /home/cli/api/qos/set_pkt_pq -v type 4 enable 1 pq 0x0
cs_cli /home/cli/api/qos/set_pkt_pq -v type 5 enable 1 pq 0x0
cs_cli /home/cli/api/qos/set_pkt_pq -v type 6 enable 1 pq 0x0
cs_cli /home/cli/api/qos/set_pkt_pq -v type 7 enable 1 pq 0x0
cs_cli /home/cli/api/qos/set_pkt_pq -v type 8 enable 1 pq 0x0
cs_cli /home/cli/api/qos/set_pkt_pq -v type 9 enable 1 pq 0x0
cs_cli /home/cli/api/qos/set_pkt_pq -v type 0xa enable 1 pq 0x0
#match dsl erb packet and set it's egress queue's priority
cs_cli /home/cli/api/qos/set_pkt_pq -v type 0xb enable 1 pq 0x0

cs_cli /home/cli/debug/app/res/set_napt_limit -v mode 0 packets 0

echo "####  start AMS2.0  ####"
# startup ams2.0 manager task
tdsmgr &
