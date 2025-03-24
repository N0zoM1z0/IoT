#!/bin/sh

. /usr/syscfg/wan.comm.param.sh

PPP_INTERFACE_FILE="/tmp/.ppp.interfaces"
PPP_DIRS=`ls -d /tmp/PPP_*`

echo -n > $PPP_INTERFACE_FILE

for d in $PPP_DIRS
do
	if [ ! -e $d/uptime ]; then
		continue
	fi

	ifname=`cat $d/$PPP_IFNAME`
	path="`cat $d/path`"
	user=`cfgcmd get ${path}Username`
	pass=`cfgcmd get ${path}Password`
	proto=`cfgcmd get ${path}PPPAuthenticationProtocol`
	ifindex=`ip link show dev $ifname | grep $ifname | cut -d : -f 1`

	echo $ifindex $ifname $user $pass $proto $path >> $PPP_INTERFACE_FILE
done


