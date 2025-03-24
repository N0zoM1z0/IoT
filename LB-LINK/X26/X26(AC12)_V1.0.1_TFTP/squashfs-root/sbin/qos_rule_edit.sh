#!/bin/sh

action=$1
edit_rule_file="/tmp/edit_rule_file"

wan_if="eth0.2"
lan_if="br-lan"

DOWN_SPEED="1000Mbit"
UP_SPEED="1000Mbit"

TC_DOWN="tc qdisc add dev $lan_if"
TC_DOWN_CLASS="tc class add dev $lan_if"
TC_DOWN_FILTER="tc filter add dev $lan_if"

TC_DOWN_DEL="tc qdisc delete dev $lan_if"
TC_DOWN_CLASS_DEL="tc class delete dev $lan_if"
TC_DOWN_FILTER_DEL="tc filter delete dev $lan_if"

TC_UP="tc qdisc add dev $wan_if"
TC_UP_CLASS="tc class add dev $wan_if"
TC_UP_FILTER="tc filter add dev $wan_if"

TC_UP_DEL="tc qdisc delete dev $wan_if"
TC_UP_CLASS_DEL="tc class delete dev $wan_if"
TC_UP_FILTER_DEL="tc filter delete dev $wan_if"

IPTABLES="iptables -t mangle -A PREROUTING"
IPTABLES_DEL="iptables -t mangle -D PREROUTING"

qos_mac=`cat $edit_rule_file | cut -f 1 -d " "`
bandwidth_up=`cat $edit_rule_file | cut -f 3 -d " "`
bandwidth_dl=`cat $edit_rule_file | cut -f 4 -d " "`
mark=`cat $edit_rule_file | cut -f 5 -d " "`

mac=`echo $qos_mac | sed 's/\://g'`
down_mac1="0x"`echo $mac | cut -c 1-4`
down_mac2="0x"`echo $mac | cut -c 5-12`

add_new_rule()
{
	#set bandwidth_dl
	$TC_DOWN_CLASS parent 100:1 classid 100:$mark cbq bandwidth $DOWN_SPEED rate ${bandwidth_dl}kbps allot 1514 weight 100Kbit prio 5 cell 8 maxburst 8 avpkt 1000 bounded
	$TC_DOWN parent 100:$mark sfq quantum 1514b perturb 10
	$TC_DOWN_FILTER parent 100:0 protocol ip prio 5 u32 match u16 0x0800 0xffff at -2 match u32 $down_mac2 0xffffffff at -12 match u16 $down_mac1 0xffff at -14 flowid 100:$mark				
	
	#set bandwidth_up
	$TC_UP_CLASS parent 200:1 classid 200:$mark cbq bandwidth $UP_SPEED rate ${bandwidth_up}kbps allot 1514 weight 100Kbit prio 5 cell 8 maxburst 8 avpkt 1000 bounded
	$TC_UP parent 200:$mark sfq quantum 1514b perturb 10
	$TC_UP_FILTER parent 200:0 protocol ip prio 5 handle $mark fw classid 200:$mark
	$IPTABLES -m mac --mac-source $qos_mac -j MARK --set-mark $mark
	$IPTABLES -m mac --mac-source $qos_mac -j RETURN
}

del_rule()
{
	#set bandwidth_dl
	handle=`tc filter list dev $lan_if | grep "flowid 100:$mark" | awk '{print $10}'`
	$TC_DOWN_FILTER_DEL parent 100: protocol ip prio 5 handle ${handle} u32
	$TC_DOWN_DEL parent 100:$mark sfq quantum 1514b perturb 10	
	$TC_DOWN_CLASS_DEL parent 100:1 classid 100:$mark cbq bandwidth $DOWN_SPEED rate ${bandwidth_dl}kbps allot 1514 weight 100Kbit prio 5 cell 8 maxburst 8 avpkt 1000 bounded
	
	#set bandwidth_up
	$IPTABLES_DEL -m mac --mac-source $qos_mac -j RETURN
	$IPTABLES_DEL -m mac --mac-source $qos_mac -j MARK --set-mark $mark
	$TC_UP_FILTER_DEL parent 200:0 protocol ip prio 5 handle $mark fw classid 200:$mark
	$TC_UP_DEL parent 200:$mark sfq quantum 1514b perturb 10
	$TC_UP_CLASS_DEL parent 200:1 classid 200:$mark cbq bandwidth $UP_SPEED rate ${bandwidth_up}kbps allot 1514 weight 100Kbit prio 5 cell 8 maxburst 8 avpkt 1000 bounded
}

case "$action" in
	add)
		add_new_rule
		;;
	del)
		del_rule
		;;										
	*) 
		exit 1
		;;
esac	

rm -rf $edit_rule_file			
	
