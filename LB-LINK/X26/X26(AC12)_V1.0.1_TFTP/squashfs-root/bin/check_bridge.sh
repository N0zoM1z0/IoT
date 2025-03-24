#!/bin/sh

ra0_enable=`uci get system.route.switch_2g`
ra1_enable=`uci get system.route.switch_2g_guest`
rai0_enable=`uci get system.route.switch_5g`
rai1_enable=`uci get system.route.switch_5g_guest`

ra0_exist=`brctl show | grep ra0`
ra1_exist=`brctl show | grep ra1`
rai0_exist=`brctl show | grep rai0`
rai1_exist=`brctl show | grep rai1`

if [ "$ra0_enable" == "1" ];then
	if [ "$ra0_exist" == "" ];then
		echo "ra0 not exist"
		brctl addif br-lan ra0
fi
fi

if [ "$ra1_enable" == "1" ];then
	if [ "$ra1_exist" == "" ];then
		echo "ra1 not exist"
	  brctl addif br-lan ra1
	fi
fi

if [ "$rai0_enable" == "1" ];then
	if [ "$rai0_exist" == "" ];then
		echo "rai0 not exist"
		brctl addif br-lan rai0
	fi
fi

if [ "$rai1_enable" == "1" ];then
	if [ "$rai1_exist" == "" ];then
		echo "rai1 not exist"
		brctl addif br-lan rai1
	fi
fi
exit 0


