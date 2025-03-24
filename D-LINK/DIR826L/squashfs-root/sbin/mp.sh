#!/bin/sh

if [ -f /flash/mp ]; then
	sleep 30
	echo "Entry MP Mode"
	killall -9 resetd &
	killall -9 wps_daemon &
	killall -9 rt2860apd &
	killall -9 wscd &
	mpd &
	telnetd -l /bin/sh &
	/mydlink/opt.local stop
	echo "EfuseBufferMode=1" >> /etc/Wireless/RT2860AP/RT2860AP0.dat;ifconfig ra0 down;ifconfig ra0 up;
	killall ated;ated -i ra0 &
	uenv set ipaddr 192.168.0.1
fi

