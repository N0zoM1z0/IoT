#!/bin/sh
#
# usage: ebtables.init.sh
#

. /usr/syscfg/ebtables.param.sh

#######################################################
ebtables -t filter -N ${ARP_FILTER_CHAIN}
ebtables -t filter -N ${BIND_POLICY_CHAIN}
ebtables -t filter -N ${VLAN_BIND_CHIAN}
ebtables -t filter -N ${WAN_BRIDGED_CHAIN}
ebtables -t filter -N ${WAN_BRIDGED_SERVICE_CHAIN}
ebtables -t filter -N ${TIME_RESTRICTION_CHAIN}
ebtables -t filter -N ${BR_MC_IGMP_FILTER}
ebtables -t filter -N EBTABLES_BIND_POLICY_DEFAULT -P RETURN

ebtables -t filter -P ${ARP_FILTER_CHAIN} RETURN
ebtables -t filter -P ${BIND_POLICY_CHAIN} RETURN
ebtables -t filter -P ${VLAN_BIND_CHIAN} RETURN
ebtables -t filter -P ${WAN_BRIDGED_CHAIN} RETURN
ebtables -t filter -P ${WAN_BRIDGED_SERVICE_CHAIN} RETURN
ebtables -t filter -P ${TIME_RESTRICTION_CHAIN} RETURN
ebtables -t filter -P ${BR_MC_IGMP_FILTER} RETURN

ebtables -t filter -A INPUT -j ${TIME_RESTRICTION_CHAIN}
ebtables -t filter -A FORWARD -j ${ARP_FILTER_CHAIN}
ebtables -t filter -A FORWARD -j ${BR_MC_IGMP_FILTER}
ebtables -t filter -A FORWARD -j ${WAN_BRIDGED_CHAIN}
ebtables -t filter -A FORWARD -j ${TIME_RESTRICTION_CHAIN}
ebtables -t filter -A FORWARD -j ${BIND_POLICY_CHAIN}
ebtables -t filter -I ${BIND_POLICY_CHAIN} -j ${VLAN_BIND_CHIAN}

# drop wan to wan 2015-7-2
ebtables -t filter -I FORWARD 1 --dst ff:ff:ff:ff:ff:ff --in-if ip+ --out-if ip+ -j DROP
ebtables -t filter -I FORWARD 2 --dst Multicast --in-if ip+ --out-if ip+ -j DROP

ebtables -t filter -A OUTPUT -j ${WAN_BRIDGED_SERVICE_CHAIN}

ebtables -t broute -N ${SETMARK_CHAIN}
ebtables -t broute -P ${SETMARK_CHAIN} RETURN
ebtables -t broute -A BROUTING -j ${SETMARK_CHAIN}
ebtables -t broute -N ${VLAN_SETMARK_CHAIN}
ebtables -t broute -A BROUTING -j ${VLAN_SETMARK_CHAIN}
ebtables -t broute -P ${VLAN_SETMARK_CHAIN} RETURN

ebtables -t nat -N ${MAC_FILTER_CHAIN}
ebtables -t nat -P ${MAC_FILTER_CHAIN} RETURN
ebtables -t nat -A PREROUTING -i eth0+ -j ${MAC_FILTER_CHAIN}
ebtables -t nat -A PREROUTING -i wlan+ -j ${MAC_FILTER_CHAIN}
#ebtables -t nat -A PREROUTING -i nas1 -j ${MAC_FILTER_CHAIN}
