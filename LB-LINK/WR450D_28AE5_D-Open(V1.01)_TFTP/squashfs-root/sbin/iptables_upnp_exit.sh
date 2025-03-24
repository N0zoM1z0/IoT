#! /bin/sh
# $Id: //WIFI_SOC/TRUNK/RT288x_SDK/source/user/miniupnpd-1.6/netfilter/iptables_init.sh#1 $
IPTABLES=iptables

#change this parameters :
EXTIF=$1

#delete the MINIUPNPD chain for nat
$IPTABLES -t nat -F MINIUPNPD
$IPTABLES -t nat -X MINIUPNPD
#delete the rule to MINIUPNPD
$IPTABLES -t nat -D PREROUTING -i $EXTIF -j MINIUPNPD

#delete the MINIUPNPD chain for filter
$IPTABLES -t filter -F MINIUPNPD
$IPTABLES -t filter -X MINIUPNPD
#delete the rule to MINIUPNPD
$IPTABLES -t filter -D FORWARD -i $EXTIF ! -o $EXTIF -j MINIUPNPD
