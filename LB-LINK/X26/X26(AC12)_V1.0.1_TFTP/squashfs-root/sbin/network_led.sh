#!/bin/sh

action=$1

regs m 0x10000060 0x1 20 2
regs m 0x10000600 0x3 4 2
regs m 0x10000620 0x2 4 2

WIFI2_START=`ifconfig -a | grep ra0`
WIFI5_START=`ifconfig -a | grep rai0`

if [ -z "$WIFI2_START" -o -z "$WIFI5_START" ];then
	exit 0
fi

if [ "$action" == "on" ];then
	regs m 0x10000620 0x1 4 2
else
	regs m 0x10000620 0x2 4 2
fi
