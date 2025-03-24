#!/bin/sh
network_apmode=`uci -q get xiaoqiang.common.NETMODE`
cat /etc/crontabs/root | grep ap_mode.sh 1>/dev/null 2>/dev/null
[ "$?" = "1" ] && [ "$network_apmode" == "lanapmode" ] && {
	echo "*/1 * * * * /usr/sbin/ap_mode.sh check_gw" >> /etc/crontabs/root
}
