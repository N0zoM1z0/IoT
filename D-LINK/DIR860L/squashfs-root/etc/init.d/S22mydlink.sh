#!/bin/sh
MYDLINK=`cat /etc/config/mydlinkmtd`
domount=`xmldbc -g /mydlink/mtdagent` 
if [ "$domount" != "" ]; then 
	mount -t squashfs $MYDLINK /mydlink
fi
 
# HuanYao: Support mydlink uid 2015.11
# hard code in interface.
uid=`devdata get -e dev_uid`
# uid="dont write uid for temporal."
if [ "$uid" == "" ] ; then
	mac=`devdata get -e lanmac`
	if [ "$mac" == "" ] ; then
		echo "[$0] cannot get lanmac" > /dev/console
		exit 1;
	fi
	uid=`mydlinkuid $mac`
	if [ "$uid" == "" ] ; then
		echo "[$0] cannot generate mydlink uid." > /dev/console
		exit 1;
	fi
	
	echo "[$0] Generate mydlink uid $uid" > /dev/console
	devdata set -e dev_uid=$uid
fi

