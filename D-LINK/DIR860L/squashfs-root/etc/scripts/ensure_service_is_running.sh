#!/bin/sh
sleep 20 
STATUS=`service $1 status`
while [ "$STATUS" != "running" ]
do
	service $1 restart
	sleep 3 
	STATUS=`service $1 status`
done
