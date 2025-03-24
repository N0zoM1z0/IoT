#!/bin/sh
arp_table=`cat /proc/net/arp > /tmp/arplist`
local i=1
table_height=`cat /tmp/arplist |wc -l`
local data=""
local ip=""
local hp=""
local device=""
while [ $i -le $table_height ]
do 
	if [ $i -ne 1 ]; then
		ip=`cat /tmp/arplist | sed -n ${i}p | awk '{print $1}'`
		flags=`cat /tmp/arplist | sed -n ${i}p | awk '{print $3}'`
		hp=`cat /tmp/arplist | sed -n ${i}p | awk '{print $4}'`
		device=`cat /tmp/arplist | sed -n ${i}p | awk '{print $NF}'`
		if [ "0x0" != ${flags} -a "00:00:00:00:00:00" != "${hp}" ]; then
	 		data=${data}${ip}[-]${hp}[-]${device}[+]
		fi
	fi
	i=`expr $i + 1`
done 
echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: text/html"
echo ""
echo "${data}"
