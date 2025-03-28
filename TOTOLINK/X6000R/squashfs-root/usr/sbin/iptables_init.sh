#! /bin/sh
# $Id: iptables_init.sh,v 1.9 2016/02/09 09:37:44 nanard Exp $
IPTABLES="`which iptables`" || exit 1

#. /lib/functions/network.sh

EXTIF=$(uci -q get network.wan.ifname)
#network_get_ipaddr EXTIP "wan"
#echo "External IP = $EXTIP"

#adding the MINIUPNPD chain for nat
$IPTABLES -t nat -N MINIUPNPD
#adding the rule to MINIUPNPD
#$IPTABLES -t nat -A PREROUTING -d $EXTIP -i $EXTIF -j MINIUPNPD
$IPTABLES -t nat -A PREROUTING -i $EXTIF -j MINIUPNPD

#adding the MINIUPNPD chain for mangle
$IPTABLES -t mangle -N MINIUPNPD
$IPTABLES -t mangle -A PREROUTING -i $EXTIF -j MINIUPNPD

#adding the MINIUPNPD chain for filter
$IPTABLES -t filter -N MINIUPNPD
#adding the rule to MINIUPNPD
$IPTABLES -t filter -A FORWARD -i $EXTIF ! -o $EXTIF -j MINIUPNPD

#adding the MINIUPNPD chain for nat
$IPTABLES -t nat -N MINIUPNPD-POSTROUTING
$IPTABLES -t nat -A POSTROUTING -o $EXTIF -j MINIUPNPD-POSTROUTING
