#! /bin/sh
#
## init args
# these things should be ASAP
# for recording of the event. 
dev=${MDEV} # sda1, sdb2
action=${ACTION} # add, remove

# if boot with USB devices, action=""
if [ "${action}" == "" ]; then
	action="add"
fi

if [ ! -z $1 ]; then
	dev=$1
fi

if [ ! -z $2 ]; then
	action=$2
fi

USB_INFO_PATH="/tmp/.usb"
if ! mkdir $USB_INFO_PATH/$dev.$action; then
	exit 0
fi


## do mounting stuffs
. /usr/syscfg/usb/utils.sh

AutoMount()
{
	local d=$1
	local a=$2

	if [ ${a} == "add" ]; then
		Log "$dev: will be mounted."
	else
		Log "$dev: will be umounted."
	fi

	/usr/syscfg/usb/automount.sh $d $a
}


############################################### main #################################################
Log "**********dev=$dev, action=$action**********"
AutoMount $dev $action

rmdir $USB_INFO_PATH/$dev.$action

