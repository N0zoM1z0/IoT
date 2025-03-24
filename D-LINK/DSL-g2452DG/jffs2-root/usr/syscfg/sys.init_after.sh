#!/bin/sh
#
# usage: sys.init_after.sh
#

sysmgr &
srvcmgr &
utils &
neighevent 1>/dev/null 2>/dev/null &

uhttpd -n 10 -f -D -p :80 -h /www -s :443 -K /etc/uhttpd.key.us -C /etc/uhttpd.crt  &


/usr/syscfg/mdev.sh

/usr/syscfg/p2p_punish.sh &

ramonitor&

#创建vlan ebtables规则
vlan_policy_init.sh &

