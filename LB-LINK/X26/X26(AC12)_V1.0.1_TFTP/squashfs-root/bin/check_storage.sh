#!/bin/sh

mem_free=`cat /proc/meminfo | grep MemFree | awk -F ' ' '{print $2}'`
mem_threshold=10240

if [ $mem_free -lt $mem_threshold ];then
	logger -t check_storage "mem_free:$mem_free,do drop_caches"	
	sync
	echo 3 > /proc/sys/vm/drop_caches	
else
	logger -t check_storage "mem_free:$mem_free,do nothing"
fi


