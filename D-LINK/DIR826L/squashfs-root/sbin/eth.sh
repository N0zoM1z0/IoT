#!/bin/sh

Usage()
{
	echo "Usage: $0 <side> <op> [mac_address]"
	echo "  <side>: lan or wan (access LAN or WAN MAC address)"
	echo "  <op>: -r or -w (Read or Write action)"
	echo "  [mac_address]: MAC[1] MAC[2] MAC[3] MAC[4] MAC[5] MAC[6] (only for write action)"
	echo "Example:"
	echo "	$0 lan -r"
	echo "	$0 lan -w 000c43685556"
	exit 1
}

GetMac()
{
	if [ "$1" == "lan" ]; then
		B1=`flash -r 40028 -c 1 | sed 's/^.*: //g'`
		B2=`flash -r 40029 -c 1 | sed 's/^.*: //g'`
		B3=`flash -r 4002A -c 1 | sed 's/^.*: //g'`
		B4=`flash -r 4002B -c 1 | sed 's/^.*: //g'`
		B5=`flash -r 4002C -c 1 | sed 's/^.*: //g'`
		B6=`flash -r 4002D -c 1 | sed 's/^.*: //g'`
		echo "$B1$B2$B3$B4$B5$B6"
	elif [ "$1" == "wan" ]; then
		B1=`flash -r 4002E -c 1 | sed 's/^.*: //g'`
		B2=`flash -r 4002F -c 1 | sed 's/^.*: //g'`
		B3=`flash -r 40030 -c 1 | sed 's/^.*: //g'`
		B4=`flash -r 40031 -c 1 | sed 's/^.*: //g'`
		B5=`flash -r 40032 -c 1 | sed 's/^.*: //g'`
		B6=`flash -r 40033 -c 1 | sed 's/^.*: //g'`
		echo "$B1$B2$B3$B4$B5$B6"
	elif [ "$1" == "sn" ]; then
		B1=`flash -r 40000 -c 1 | sed 's/^.*: //g'`
		B2=`flash -r 40001 -c 1 | sed 's/^.*: //g'`
		B3=`flash -r 40002 -c 1 | sed 's/^.*: //g'`
		B4=`flash -r 40003 -c 1 | sed 's/^.*: //g'`
		B5=`flash -r 40004 -c 1 | sed 's/^.*: //g'`
		B6=`flash -r 40005 -c 1 | sed 's/^.*: //g'`
		B7=`flash -r 40006 -c 1 | sed 's/^.*: //g'`
		B8=`flash -r 40007 -c 1 | sed 's/^.*: //g'`
		B9=`flash -r 40008 -c 1 | sed 's/^.*: //g'`
		echo "$B1$B2$B3$B4$B5$B6$B7$B8$B9"
	fi
}

_SetMac()
{
	if [ "$1" == "lan" ]; then
		flash -w 0x40028 -o $2 1>/dev/null 2>&1
		flash -w 0x40029 -o $3 1>/dev/null 2>&1
		flash -w 0x4002A -o $4 1>/dev/null 2>&1
		flash -w 0x4002B -o $5 1>/dev/null 2>&1
		flash -w 0x4002C -o $6 1>/dev/null 2>&1
		flash -w 0x4002D -o $7 1>/dev/null 2>&1
	elif [ "$1" == "wan" ]; then
		flash -w 0x4002E -o $2 1>/dev/null 2>&1
		flash -w 0x4002F -o $3 1>/dev/null 2>&1
		flash -w 0x40030 -o $4 1>/dev/null 2>&1
		flash -w 0x40031 -o $5 1>/dev/null 2>&1
		flash -w 0x40032 -o $6 1>/dev/null 2>&1
		flash -w 0x40033 -o $7 1>/dev/null 2>&1
	fi
}

SetMac()
{
        if [ "$1" == "lan" ]; then
                flash -w 0x40028 -o `echo $2 | awk '{ print substr($0,0,2)}'` 1>/dev/null 2>&1
                flash -w 0x40029 -o `echo $2 | awk '{ print substr($0,3,2)}'` 1>/dev/null 2>&1
                flash -w 0x4002A -o `echo $2 | awk '{ print substr($0,5,2)}'` 1>/dev/null 2>&1
                flash -w 0x4002B -o `echo $2 | awk '{ print substr($0,7,2)}'` 1>/dev/null 2>&1
                flash -w 0x4002C -o `echo $2 | awk '{ print substr($0,9,2)}'` 1>/dev/null 2>&1
                flash -w 0x4002D -o `echo $2 | awk '{ print substr($0,11,2)}'` 1>/dev/null 2>&1
        elif [ "$1" == "wan" ]; then
                flash -w 0x4002E -o `echo $2 | awk '{ print substr($0,0,2)}'` 1>/dev/null 2>&1
                flash -w 0x4002F -o `echo $2 | awk '{ print substr($0,3,2)}'` 1>/dev/null 2>&1
                flash -w 0x40030 -o `echo $2 | awk '{ print substr($0,5,2)}'` 1>/dev/null 2>&1
                flash -w 0x40031 -o `echo $2 | awk '{ print substr($0,7,2)}'` 1>/dev/null 2>&1
                flash -w 0x40032 -o `echo $2 | awk '{ print substr($0,9,2)}'` 1>/dev/null 2>&1
                flash -w 0x40033 -o `echo $2 | awk '{ print substr($0,11,2)}'` 1>/dev/null 2>&1
        elif [ "$1" == "sn" ]; then
                flash -w 0x40000 -o `echo $2 | awk '{ print substr($0,0,2)}'` 1>/dev/null 2>&1
                flash -w 0x40001 -o `echo $2 | awk '{ print substr($0,3,2)}'` 1>/dev/null 2>&1
                flash -w 0x40002 -o `echo $2 | awk '{ print substr($0,5,2)}'` 1>/dev/null 2>&1
                flash -w 0x40003 -o `echo $2 | awk '{ print substr($0,7,2)}'` 1>/dev/null 2>&1
                flash -w 0x40004 -o `echo $2 | awk '{ print substr($0,9,2)}'` 1>/dev/null 2>&1
                flash -w 0x40005 -o `echo $2 | awk '{ print substr($0,11,2)}'` 1>/dev/null 2>&1
                flash -w 0x40006 -o `echo $2 | awk '{ print substr($0,13,2)}'` 1>/dev/null 2>&1
                flash -w 0x40007 -o `echo $2 | awk '{ print substr($0,15,2)}'` 1>/dev/null 2>&1
                flash -w 0x40008 -o `echo $2 | awk '{ print substr($0,17,2)}'` 1>/dev/null 2>&1
                #flash -w 0x40009 -o `echo $2 | awk '{ print substr($0,19,2)}'` 1>/dev/null 2>&1
        fi
}


if [ "$1" != "lan" -a "$1" != "wan" -a "$1" != "sn" ]; then
	Usage
fi

if [ "$2" == "-r" ]; then
	GetMac $1	
	exit 0
elif [ "$2" == "-w" ]; then
	SetMac $1 $3
else
	echo "Unknown command!"
	exit 1
fi

