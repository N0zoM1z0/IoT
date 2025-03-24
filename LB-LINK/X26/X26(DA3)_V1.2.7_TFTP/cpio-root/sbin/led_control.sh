#!/bin/sh
#
. /sbin/config.sh
usage()
{
	echo "Usage:"
	echo "  $0 community_name"
	echo "Example:"
	echo "  $0 1/0"
	exit 1
}
ledon=`nvram_get 2860 ledon`

reg s 0
if [ "$ledon" = "1" ];then
	reg w 60 0x55144451
fi

if [ "$CONFIG_TWO_LED" = "y" ];then
if [ "$1" = "1" ]; then    #red	
	echo "red led is on"
	#reg w 60 0x55144451
	reg w 600 10
	reg w 620 3c20
	# while :
	# do
	# reg w 620 3c20
	# usleep 300000
	# reg w 620 0003c30
	# usleep 300000
	# done
elif [ "$1" = "0" ]; then   #green
	echo "green led is on"
	#reg w 60 0x55144451
	reg w 600 20
	reg w 620 3c10

elif [ "$1" = "2" ]; then
	echo "red led and green all off"
	reg w 60 55044410
	reg w 600 0
	reg w 620 0003c30

else
	echo "$0: insufficient arguments"
	usage $0
fi
fi




