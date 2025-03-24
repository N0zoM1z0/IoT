#!/bin/sh

macaddr_add() {
	local mac=$1
	local val=$2
	local oui=${mac%:*:*:*}
	local nic=${mac#*:*:*:}

	nic=$(printf "%06x" $((0x${nic//:/} + $val & 0xffffff)) | sed 's/^\(.\{2\}\)\(.\{2\}\)\(.\{2\}\)/\1:\2:\3/')
	echo $oui:$nic
}

if [ "$1" == "lan" ];then
	cat /sys/class/net/eth0/address
elif [ "$1" == "wan" ];then
	lan_mac=$(cat /sys/class/net/eth0/address)
	wan_mac=$(macaddr_add "$lan_mac" 1)
	echo "$wan_mac"
fi


