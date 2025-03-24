#!/bin/sh
if [ $1 == "init" ]; then
	update_time.sh &
elif [ $1 == "set" ]; then
	killall update_time.sh
	killall sleep
	update_time.sh &
elif [ $1 == "remove" ]; then
	/usr/bin/killall update_time.sh
fi
