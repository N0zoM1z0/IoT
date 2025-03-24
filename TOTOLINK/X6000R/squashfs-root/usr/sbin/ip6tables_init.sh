#! /bin/sh
# $Id: ip6tables_init.sh,v 1.1 2012/04/24 22:13:41 nanard Exp $
IPTABLES="`which ip6tables`" || exit 1

#change this parameters :
EXTIF=$(uci -q get network.wan.ifname)

#adding the MINIUPNPD chain for filter
$IPTABLES -t filter -N MINIUPNPD
#adding the rule to MINIUPNPD
$IPTABLES -t filter -A FORWARD -i $EXTIF ! -o $EXTIF -j MINIUPNPD

