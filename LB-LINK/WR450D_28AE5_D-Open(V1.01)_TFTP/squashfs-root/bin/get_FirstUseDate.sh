#!/bin/sh

while true
do
	ping -c 3 -W 5 8.8.8.8

	if [ "$?" == "0" ];then
		date -u "+%Y-%m-%d %H:%M:%S" > /tmp/FirstUseDate
		date "+%Y-%m-%dT%H:%M:%SZ" > /tmp/VendorConfigFile
		break;
	else
		echo "network nok"		
	fi		

	sleep 5
done


