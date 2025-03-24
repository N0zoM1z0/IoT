#!/bin/sh
PID_FILE=/var/run/openl2tpd.pid
echo "l2tp demand on">/dev/console
killall pppd
if [ -f "$PID_FILE" ]; then
	kill -SIGHUP  `cat $PID_FILE`
else
	openl2tpd
fi

