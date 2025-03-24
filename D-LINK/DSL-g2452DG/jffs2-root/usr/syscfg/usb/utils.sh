#!/bin/sh

DMP_STORAGE="InternetGatewayDevice.X_CT-COM_USBDevice.Storage"
USB_INFO_PATH="/tmp/.usb"
USB_LOCK_DIR="$USB_INFO_PATH/automount.lock"
USB_LOG_FILE="$USB_INFO_PATH/log"

Log()
{
	echo "`date`: $*" >> $USB_LOG_FILE
}

DeviceMount()
{
	local dev=$1
	local dir=$2
	local ret=0

	local retry=5
	while [ $retry -gt 0 ]
	do
		mount /dev/$dev $dir
		if [ $? -eq 0 ]; then
			return 0
		fi
		usleep 100
		let retry--
	done
	return 1
}

DeviceUmount()
{
	local dev=$1

	local retry=5
	while [ $retry -gt 0 ]
	do
		umount -f /dev/$dev
		if [ $? -eq 0 ]; then
			return 0
		fi
		usleep 100
		let retry--
	done
	return 1
}

DeviceTryMount()
{
	local dev=$1
	local dir="$USB_INFO_PATH/.mnt.$dev"
	local ret=0

	mkdir -p $dir

	DeviceMount $dev $dir
	if [ $? -ne 0 ]; then
		Log "$dev: @$dir try to mount failed."
		rmdir $dir
		return 1
	fi

	DeviceUmount $dev
	if [ $? -ne 0 ]; then
		Log "$dev: @$dir can not be unmounted."
		ret=1
	fi

	rmdir $dir
	return $ret

}

GetRootDeviceName()
{
    local dev=$1
    local disk_type=""
    local ret=""

    disk_type=${dev:0:2}
    if [ "${disk_type}" == "sd" ]; then
        ret=${dev:0:3}
    elif [ "${disk_type}" == "mm" ]; then
        p_flag=${dev:7:1}
        if [ "${p_flag}" == "p" ]; then
            ret=${dev:0:8}
        else
            ret="$dev"
        fi
    else
        ret=""
    fi
    echo $ret
}

GetPartitionNum()
{
    local dev=$1
    local disk_type=""
    local ret=""

    disk_type=${dev:0:2}
    if [ "${disk_type}" == "sd" ]; then
        ret=${dev:3}
    elif [ "${disk_type}" == "mm" ]; then
        p_flag=${dev:7:1}
        if [ "${p_flag}" == "p" ]; then
            ret=${dev:8}
        else
            ret=${dev:6}
        fi
    else
        ret=""
    fi
    echo $ret
}

CheckDeviceMounted()
{
	local mount_point=$1
	mount | grep -w $mount_point | wc -l
}

GetDeviceMountPoint()
{
    local dev=$1
	
	local PartitionsMountPoint=`mount | grep /dev/$dev | cut -d ' ' -f 3`
	echo $PartitionsMountPoint
}

handle_usbled()
{
   local flag=$1
   local pathsd=""

   if [ "${flag}" == "on" ];then
       pathsd=`find /sys/bus/usb/devices -name "*-1"`
       if [ "$pathsd" != "" ]; then
           /usr/syscfg/led.sh usb 0 on
       fi

       pathsd=`find /sys/bus/usb/devices -name "*-2"`
       if [ "$pathsd" != "" ]; then
           /usr/syscfg/led.sh usb 1 on
       fi
   fi

   if [ "${flag}" == "off" ];then
       pathsd=`find /sys/bus/usb/devices -name "*-1"`
       if [ "$pathsd" = "" ]; then
           /usr/syscfg/led.sh usb 0 off
       fi

       pathsd=`find /sys/bus/usb/devices -name "*-2"`
       if [ "$pathsd" = "" ]; then
           /usr/syscfg/led.sh usb 1 off
       fi
   fi
}

ConfigClearDeviceInsts()
{
    local i=1
    local storage_count=`cfgcmd get_max_obj "${DMP_STORAGE}."`

    while [ $i -le $storage_count ]
    do
        result=`cfgcmd check_obj "${DMP_STORAGE}.${i}"`
        if [ "${result}" == "0" ]; then
                cfgcmd del_obj_nosave "${DMP_STORAGE}.${i}"
        fi
        i=`expr $i + 1`
    done
}


