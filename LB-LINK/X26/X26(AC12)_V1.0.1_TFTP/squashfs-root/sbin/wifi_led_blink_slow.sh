#!/bin/sh

if [ ! -f /tmp/udp_batch_upgrade ];then
	exit 0
fi

ifconfig ra0 up

while true 
do
	iwpriv ra0 set led=20
	sleep 1
	iwpriv ra0 set led=22
	sleep 1
done
