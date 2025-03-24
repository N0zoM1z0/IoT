#!/bin/sh

wan_if="eth0.2"
lan_if="br-lan"

DOWN_SPEED="1000Mbit"
UP_SPEED="1000Mbit"

tc qdisc del dev $wan_if root 
tc qdisc del dev $lan_if root

system_operationmode=`uci get system.route.operationmode`
if [ "$system_operationmode" == "repeater" -o "$system_operationmode" == "AP" ];then
	exit 0
fi


TC_DOWN="tc qdisc add dev $lan_if"
TC_DOWN_CLASS="tc class add dev $lan_if"
TC_DOWN_FILTER="tc filter add dev $lan_if"

TC_UP="tc qdisc add dev $wan_if"
TC_UP_CLASS="tc class add dev $wan_if"
TC_UP_FILTER="tc filter add dev $wan_if"

IPTABLES="iptables -t mangle -A PREROUTING"
IPTABLES_DEL="iptables -t mangle -D PREROUTING"

#Down set
$TC_DOWN root handle 100: cbq bandwidth $DOWN_SPEED avpkt 1000
$TC_DOWN_CLASS parent 100:0 classid 100:1 cbq bandwidth $DOWN_SPEED rate $DOWN_SPEED allot 1514 weight $DOWN_SPEED prio 4 cell 8 maxburst 8 avpkt 1000 bounded

#Up set
$TC_UP root handle 200: cbq bandwidth $UP_SPEED avpkt 1000
$TC_UP_CLASS parent 200:0 classid 200:1 cbq bandwidth $UP_SPEED rate $UP_SPEED allot 1514 weight $UP_SPEED prio 4 cell 8 maxburst 8 avpkt 1000 bounded

while read line
do
	if [ "$line" != "" ];then
		qos_mac=`echo $line | cut -f 1 -d " "`
		bandwidth_up=`echo $line | cut -f 3 -d " "`
		bandwidth_dl=`echo $line | cut -f 4 -d " "`
		mark=`echo $line | cut -f 5 -d " "`
		
		mac=`echo $qos_mac | sed 's/\://g'`
		down_mac1="0x"`echo $mac | cut -c 1-4`
		down_mac2="0x"`echo $mac | cut -c 5-12`
		
		#set bandwidth_dl
		$TC_DOWN_CLASS parent 100:1 classid 100:$mark cbq bandwidth $DOWN_SPEED rate ${bandwidth_dl}kbps allot 1514 weight 100Kbit prio 5 cell 8 maxburst 8 avpkt 1000 bounded
		$TC_DOWN parent 100:$mark sfq quantum 1514b perturb 10
		$TC_DOWN_FILTER parent 100:0 protocol ip prio 5 u32 match u16 0x0800 0xffff at -2 match u32 $down_mac2 0xffffffff at -12 match u16 $down_mac1 0xffff at -14 flowid 100:$mark				

		#set bandwidth_up
		$TC_UP_CLASS parent 200:1 classid 200:$mark cbq bandwidth $UP_SPEED rate ${bandwidth_up}kbps allot 1514 weight 100Kbit prio 5 cell 8 maxburst 8 avpkt 1000 bounded
		$TC_UP parent 200:$mark sfq quantum 1514b perturb 10
		$TC_UP_FILTER parent 200:0 protocol ip prio 5 handle $mark fw classid 200:$mark
		$IPTABLES_DEL -m mac --mac-source $qos_mac -j MARK --set-mark $mark 2>/dev/null
		$IPTABLES -m mac --mac-source $qos_mac -j MARK --set-mark $mark
		$IPTABLES_DEL -m mac --mac-source $qos_mac -j RETURN 2>/dev/null
		$IPTABLES -m mac --mac-source $qos_mac -j RETURN					
	fi
done < /etc/qos_limit_list
