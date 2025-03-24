#!/bin/sh

lighttpd_status=`ps | grep lighttpd | grep -v grep`

if [ -z "$lighttpd_status" ];then
	mkdir -m 0775 -p /var/log/lighttpd
	chgrp www-data /var/log/lighttpd

	/usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf &
fi

sys_daemon_status=`ps | grep sys_daemon | grep -v grep`

if [ "$sys_daemon_status" == "" ];then
        /etc/init.d/sys_daemon disable
        /etc/init.d/sys_daemon stop
        killall -9 sys_daemon
        sleep 1
        /etc/init.d/sys_daemon enable
        /etc/init.d/sys_daemon start
fi

igmpproxy_status=`ps | grep igmpproxy | grep -v grep`

if [ "$igmpproxy_status" == "" ];then
	/usr/bin/igmpproxy.sh br-lan eth0.2
	/usr/bin/igmpproxy &
fi

Blink_Cloud_status=`ps | grep Blink_Cloud | grep -v grep`

if [ "$Blink_Cloud_status" == "" ];then
	/etc/init.d/Blink_Cloud disable
	/etc/init.d/Blink_Cloud stop
	killall -9 Blink_Cloud
	sleep 1
	/etc/init.d/Blink_Cloud enable
	/etc/init.d/Blink_Cloud start
fi



