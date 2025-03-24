#######################################################
# this script was used to initialize firewall structure
#######################################################
#!/bin/sh
#
# usage: firewall.init.sh
#

. /usr/syscfg/firewall.param.sh

#######################################################
#set default policy in filter table
iptables -t filter -P INPUT DROP
iptables -t filter -P FORWARD ACCEPT
iptables -t filter -P OUTPUT ACCEPT
#delete all rules in filter table
iptables -t filter -F
#delete all user defined chains in filter table
iptables -t filter -X
#set default policy in nat table
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT
iptables -t nat -P OUTPUT ACCEPT
#delete all rules in nat table
iptables -t nat -F
#delete all user defined chains in nat table
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

#create new chain in filter table
iptables -t filter -N ${QOS_LMT_TCP_CHAIN}
iptables -t filter -N ${FLOW_ACCEL_CHAIN}
iptables -t filter -N ${WEB_FILTER_CHAIN}
iptables -t filter -N ${URL_FILTER_CHAIN}
iptables -t filter -N ${IPPORT_FILTER_CHAIN}
iptables -t filter -N ${LAN_FILTER_CHAIN}
iptables -t filter -N ${WAN_FILTER_CHAIN}
iptables -t filter -N ${ANTI_ATTACK_TARGET}
iptables -t filter -N ${ANTI_ATTACK_CHAIN}
iptables -t filter -N ${SCL_ACCESS_CHAIN}
iptables -t filter -N ${SCL_FILTER_ACCESS_CHAIN}
iptables -t filter -N ${SCL_LIMIT_CHAIN}
iptables -t filter -N ${UPNP_BLACKLIST_CHAIN}
#iptables -t filter -N ${HIJACK}
iptables -t filter -N ${BIND_POLICY_CHAIN}
iptables -t filter -N IP_BIND_POLICY_DEFAULT
iptables -t filter -N ${SERVICES_CHAIN}
iptables -t filter -N ${DHCPRELAY_CHAIN}
iptables -t filter -N ${DHCPPORTMAP_CHAIN}
iptables -t filter -N ${GRETUNNEL_CHAIN}
iptables -t filter -N ${L2TPTUNNEL_CHAIN}
iptables -t filter -N ${FWD_SERVICE_LIST}
iptables -t filter -N ${MC_REPORT_LIST}
iptables -t filter -N ${MARK_DIAL_ON_DEMAND_CHAIN}
iptables -t filter -N ${ALG_FILTER_CHAIN}
iptables -t filter -N ${FWD_IPSEC_VPN}
iptables -t filter -N ${IPSEC_VPN}
iptables -t filter -N ${PARENTAL_CONTROL_MAC}
iptables -t filter -N ${FWD_LAN_TIMELIMIT_CHAIN}
iptables -t filter -N ${DUALLAN_FILTER_CHAIN}

iptables -t filter -A FORWARD -j ${FWD_IPSEC_VPN}
iptables -t filter -A FORWARD -p tcp --tcp-flags SYN SYN -j TCPMSS --clamp-mss-to-pmtu
iptables -t filter -A FORWARD -j ${QOS_LMT_TCP_CHAIN}
iptables -t filter -A FORWARD -j ${ALG_FILTER_CHAIN}
iptables -t filter -A FORWARD -j ${BIND_POLICY_CHAIN}
iptables -t filter -A FORWARD -j ${ANTI_ATTACK_CHAIN}
#iptables -t filter -A FORWARD -j ${HIJACK}
iptables -t filter -A FORWARD -j ${FWD_SERVICE_LIST}
iptables -t filter -A FORWARD -j ${WEB_FILTER_CHAIN}
iptables -t filter -A FORWARD -i br0 -p tcp --tcp-flags PSH PSH --dport 80 -j ${URL_FILTER_CHAIN}
iptables -t filter -A FORWARD -i br0 -j ${FWD_LAN_TIMELIMIT_CHAIN}
iptables -t filter -A FORWARD -j ${PARENTAL_CONTROL_MAC}
iptables -t filter -A FORWARD -j ${FLOW_ACCEL_CHAIN}
iptables -t filter -A FORWARD -j ${DUALLAN_FILTER_CHAIN}

#关闭bootp相关报文的加速，解决"Bug 4927 - 关闭DHCP作为下级设备级联时，切换频段获取不到DHCP的问题"
iptables -A ${FLOW_ACCEL_CHAIN} -p udp --dport 67 --sport 68 -j MARK --set-mark 0x70000000/0xf0000000
iptables -A ${FLOW_ACCEL_CHAIN} -p udp --dport 68 --sport 67 -j MARK --set-mark 0x70000000/0xf0000000
flowaccel add 0x70000000/0xf0000000 no


# bypass packets been NATed
iptables -t filter -A FORWARD -m conntrack --ctstate SNAT,DNAT -j ACCEPT
iptables -t filter -A FORWARD -j ${IPPORT_FILTER_CHAIN}
# later rules just check not established streams
iptables -t filter -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# accept igmp query from upstreams.
iptables -t filter -A INPUT -m pkttype --pkt-type multicast -j ACCEPT

iptables -t filter -A INPUT -j ${IPSEC_VPN}
iptables -t filter -A INPUT -j ${ANTI_ATTACK_CHAIN}
iptables -t filter -A INPUT -j ${SCL_FILTER_ACCESS_CHAIN}
iptables -t filter -A INPUT -j ${SCL_LIMIT_CHAIN}
iptables -t filter -A INPUT -j ${UPNP_BLACKLIST_CHAIN}
iptables -t filter -A INPUT -j ${DHCPPORTMAP_CHAIN}
iptables -t filter -A INPUT -j ${SERVICES_CHAIN}
iptables -t filter -A INPUT -j ${DHCPRELAY_CHAIN}
iptables -t filter -A INPUT -j ${GRETUNNEL_CHAIN}
iptables -t filter -A INPUT -j ${L2TPTUNNEL_CHAIN}
# restrict cpe to send igmp 'membership report' packets in lan internet
iptables -t filter -A OUTPUT -j ${MC_REPORT_LIST}
iptables -t filter -A OUTPUT -j ${MARK_DIAL_ON_DEMAND_CHAIN}
iptables -A ${MARK_DIAL_ON_DEMAND_CHAIN} -p udp --dport 53 -j MARK --set-mark ${SKB_MARK_ACTIVE_DIAL} 

iptables -t filter -A ${SERVICES_CHAIN} -i lo -j ACCEPT
iptables -t filter -A ${SERVICES_CHAIN} -i br0 -j ACCEPT
iptables -t filter -A ${SERVICES_CHAIN} -m state --state RELATED,ESTABLISHED -j ACCEPT


iptables -A ${IPPORT_FILTER_CHAIN} -i br0 -j ${LAN_FILTER_CHAIN}
iptables -A ${IPPORT_FILTER_CHAIN} -i br1 -j ${LAN_FILTER_CHAIN}

#create new chain in nat table
iptables -t nat -N ${SERVICES_CHAIN}
iptables -t nat -N ${SERVICES_LOCAL_CHAIN}
iptables -t nat -N ${DMZ_CHAIN}
iptables -t nat -N ${DMZ_INTERNET_CHAIN}
iptables -t nat -N ${PORT_FORWARD_CHAIN}
iptables -t nat -N ${IPSEC_VPN}
iptables -t nat -N ${PORT_FORWARD_INTERNET_CHAIN}
iptables -t nat -N ${PORT_FORWARD_LOOPBACK_CHAIN}
iptables -t nat -N ${PORT_TRIGGER_CHAIN}
iptables -t nat -N ${PORT_TRIGGER_INTERNET_CHAIN}
iptables -t nat -N ${MULTINAT_CHAIN}
iptables -t nat -N ${MULTINAT_INTERNET_CHAIN}
iptables -t nat -N ${DUALLAN_NAT_CHAIN}

#We use -I instead of -A here to prevent from default MASQUERADE NAT rule 
#being in front of us.
#So "remote management chain" has the highest priority in the system, "port forward chain" is the second one and "DMZ chain" is the third one.
iptables -t nat -A PREROUTING -j ${SERVICES_CHAIN}
iptables -t nat -A ${SERVICES_CHAIN} -j ${SERVICES_LOCAL_CHAIN}
iptables -t nat -A PREROUTING -j ${PORT_FORWARD_CHAIN}
iptables -t nat -A PREROUTING -j ${DMZ_CHAIN}
iptables -t nat -I PREROUTING 1 -j ${PORT_TRIGGER_CHAIN}
iptables -t nat -I PREROUTING 2 -j ${PORT_TRIGGER_INTERNET_CHAIN}
# these rules have higher priviledge and should be inserted before MASQUERADE rules
iptables -t nat -A POSTROUTING -j ${IPSEC_VPN}
iptables -t nat -A POSTROUTING -j ${PORT_FORWARD_LOOPBACK_CHAIN}
iptables -t nat -A POSTROUTING -j ${MULTINAT_CHAIN}
iptables -t nat -A POSTROUTING -j ${DUALLAN_NAT_CHAIN}
iptables -t nat -A ${PORT_FORWARD_CHAIN} -i br+ -j ${PORT_FORWARD_INTERNET_CHAIN}

# p2p nat session limit
#iptables -t mangle -A PREROUTING -m ndpi --bittorrent -j MARK --set-mark 27
#iptables -t mangle -A PREROUTING -m ndpi --http_download -j MARK --set-mark 27
#iptables -t mangle -A PREROUTING -m ndpi --thunder -j MARK --set-mark 27
#iptables -t mangle -A PREROUTING -m ndpi --directconnect -j MARK --set-mark 27
#iptables -t mangle -A PREROUTING -m ndpi --fasttrack -j MARK --set-mark 27
#iptables -t mangle -A PREROUTING -m ndpi --gnutella  -j MARK --set-mark 27
#iptables -t mangle -A PREROUTING -m ndpi --edonkey -j MARK --set-mark 27
#
## limit to 2000
#iptables -t mangle -A PREROUTING -m mark --mark 27 -m connlimit --connlimit-above 2000 -j DROP
#iptables -t mangle -A POSTROUTING -m mark --mark 27 -j CONNMARK --save-mark


#
##### firewall init for IPv6 #####
#
ip6tables -t filter -P INPUT ACCEPT
ip6tables -t filter -P FORWARD ACCEPT
ip6tables -t filter -P OUTPUT ACCEPT

ip6tables -t filter -N ${IPPORT_FILTER_CHAIN}
ip6tables -t filter -N ${LAN_FILTER_CHAIN}
ip6tables -t filter -N ${WAN_FILTER_CHAIN}
ip6tables -t filter -N ${SERVICES_CHAIN}
ip6tables -t filter -N ${BIND_POLICY_CHAIN}
ip6tables -t filter -N IP6_BIND_POLICY_DEFAULT
ip6tables -t filter -N ${FLOW_ACCEL_CHAIN}
ip6tables -t filter -N ${DUALLAN_FILTER_CHAIN}
ip6tables -t filter -N ${SCL_ACCEPT_CHAIN_V6}
ip6tables -t filter -N ${SCL_FILTER_ACCEPT_CHAIN_V6}
ip6tables -t filter -N ${SCL_DROP_CHAIN_V6}
ip6tables -t filter -N ${MARK_DIAL_ON_DEMAND_CHAIN}

ip6tables -t filter -A OUTPUT -j ${MARK_DIAL_ON_DEMAND_CHAIN}
ip6tables -A ${MARK_DIAL_ON_DEMAND_CHAIN} -p udp --dport 53 -j MARK --set-mark ${SKB_MARK_ACTIVE_DIAL} 

ip6tables -t filter -A FORWARD -p tcp --tcp-flags SYN SYN -j TCPMSS --clamp-mss-to-pmtu
ip6tables -t filter -A FORWARD -j ${BIND_POLICY_CHAIN}
ip6tables -t filter -A FORWARD -j ${IPPORT_FILTER_CHAIN}
ip6tables -t filter -A FORWARD -j ${FLOW_ACCEL_CHAIN}
ip6tables -t filter -A FORWARD -j ${DUALLAN_FILTER_CHAIN}

ip6tables -t filter -A INPUT -j ${SCL_FILTER_ACCEPT_CHAIN_V6}
ip6tables -t filter -A INPUT -j ${SCL_DROP_CHAIN_V6}
ip6tables -t filter -A INPUT -j ${SERVICES_CHAIN}

ip6tables -t filter -A ${SERVICES_CHAIN} -i lo -j ACCEPT
ip6tables -t filter -A ${SERVICES_CHAIN} -i br0 -j ACCEPT
ip6tables -t filter -A ${SERVICES_CHAIN} -m state --state RELATED,ESTABLISHED -j ACCEPT

ip6tables -A ${IPPORT_FILTER_CHAIN} -i br0 -j ${LAN_FILTER_CHAIN}
ip6tables -A ${IPPORT_FILTER_CHAIN} -i br1 -j ${LAN_FILTER_CHAIN}

