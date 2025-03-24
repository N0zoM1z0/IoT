#! /bin/sh
# $Id: iptables_removeall.sh,v 1.9 2016/02/09 09:37:44 nanard Exp $
IPTABLES="`which iptables`" || exit 1
IP="`which ip`" || exit 1

#. /lib/functions/network.sh

EXTIF=$(uci -q get network.wan.ifname)
#network_get_ipaddr EXTIP "wan"

#removing the MINIUPNPD chain for nat
$IPTABLES -t nat -F MINIUPNPD
#rmeoving the rule to MINIUPNPD
#$IPTABLES -t nat -D PREROUTING -d $EXTIP -i $EXTIF -j MINIUPNPD
$IPTABLES -t nat -D PREROUTING -i $EXTIF -j MINIUPNPD
$IPTABLES -t nat -X MINIUPNPD

#removing the MINIUPNPD chain for mangle
$IPTABLES -t mangle -F MINIUPNPD
$IPTABLES -t mangle -D PREROUTING -i $EXTIF -j MINIUPNPD
$IPTABLES -t mangle -X MINIUPNPD

#removing the MINIUPNPD chain for filter
$IPTABLES -t filter -F MINIUPNPD
#adding the rule to MINIUPNPD
$IPTABLES -t filter -D FORWARD -i $EXTIF ! -o $EXTIF -j MINIUPNPD
$IPTABLES -t filter -X MINIUPNPD

#removing the MINIUPNPD-POSTROUTING chain for nat
$IPTABLES -t nat -F MINIUPNPD-POSTROUTING
#removing the rule to MINIUPNPD-POSTROUTING
$IPTABLES -t nat -D POSTROUTING -o $EXTIF -j MINIUPNPD-POSTROUTING
$IPTABLES -t nat -X MINIUPNPD-POSTROUTING
