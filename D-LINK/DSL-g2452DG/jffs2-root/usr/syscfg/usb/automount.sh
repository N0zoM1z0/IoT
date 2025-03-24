#! /bin/sh
#*****************************************************
# automount.sh
#
# (root) device: sda;
# partition: sda1, sda2, sda3
#
#*****************************************************

. /usr/syscfg/usb/utils.sh

g_report_dev_name=$1 # U盘分区的名称，比如sda1
g_report_action=$2


g_dev_mount_dir=""
g_root_dev_name=`GetRootDeviceName $g_report_dev_name` # 整个U盘名称，比如sda
g_root_dev_syspath="`find /sys/block -name $g_root_dev_name`/device"



#################################################################################################
#描述：生成mount目录名称
#参数：
#    $1 - 分区名称，比如sda1
#返回：生成的目录名称
#################################################################################################
GetDeviceMountDirName()
{
    local dev=$1
    local ret=""
    local str_i=""
    local num_i=""
    local str_j=""
    local disk_type=""
    local dev_syspath="`find /sys/block -name $dev`"

    disk_type=${dev:0:2}
    if [ "${disk_type}" == "sd" ]; then
        ret=`cat $g_root_dev_syspath/vendor`
        ret="$ret-`cat $g_root_dev_syspath/model`"
        ret="$ret-`cat $g_root_dev_syspath/rev`"
        ret="$ret-`cat $dev_syspath/dev`"

        ret=`echo $ret | sed 's/://g'`
        ret=`echo $ret | sed 's/ //g'`

    elif [ "${disk_type}" == "mm" ]; then
        p_flag=`echo $dev | cut -b 8`
        if [ "${p_flag}" == "p" ]; then
            str_i=`echo "$dev" | cut -b 7`
            str_j=`echo "$dev" | sed 's/mmcblk[0-9]p\([0-9]*\)/\1/'`
            ret="usb${str_i}_${str_j}"
        else
            str_i=1
            str_j=`echo "$dev" | sed 's/mmcblk\([0-9]*\)/\1/'`
            ret="usb${str_i}_${str_j}"
        fi
    else
        ret=""
    fi

    echo "${ret}"
}

ConfigGetPartitionInstance()
{
    local dev=$1
    local dev_inst=$2

    local part_inst=`cfgcmd get_max_obj "${DMP_STORAGE}.${dev_inst}.Partitions."`
    while [ $part_inst -gt 0 ]
    do
        local ret=`cfgcmd check_obj "${DMP_STORAGE}.${dev_inst}.Partitions.${part_inst}."`
        if [ $ret -eq 0 ]; then
            local SDName=`cfgcmd get "${DMP_STORAGE}.${dev_inst}.Partitions.${part_inst}.SDName"`
			if [ "${dev}" == "${SDName}" ]; then
				break
			fi
        fi
		let part_inst--
    done
    echo $part_inst
}

ConfigGetDeviceInstance()
{
    local root=$1; #sda, sdb
    local inst=0
	
    local inst=`cfgcmd get_max_obj "${DMP_STORAGE}."`
    while [ $inst -gt 0 ]
    do
        local ret=`cfgcmd check_obj "${DMP_STORAGE}.${inst}."`
        if [ $ret -ne 0 ]; then
			let inst--
			continue
		fi

		local SDName=`cfgcmd get "${DMP_STORAGE}.${inst}.Partitions.1.SDName"`
		local name=`GetRootDeviceName $SDName`
		if [ "${root}" == "${name}" ]; then
			break
		fi
		let inst--
    done

    echo $inst
}

MountSaveDiskPartitionInfo()
{
    local dev=$1
    local root_dev_path="/dev/${g_root_dev_name}"
    local dev_inst=$2

    local part_inst=`ConfigGetPartitionInstance $dev $dev_inst`
    if [ $part_inst -le 0 ]; then
		part_inst=`cfgcmd add_obj_nosave $DMP_STORAGE.${dev_inst}.Partitions.`
	fi

	local obj="${DMP_STORAGE}.${dev_inst}.Partitions.${part_inst}"
			
	local PartitionsSDName=$dev
	cfgcmd sset "${obj}.SDName" $PartitionsSDName
	
	local boot_flag=`fdisk -u | grep "/dev/${dev}" | awk '{print $2}'`
	if [ "$boot_flag" == "*" ]; then
		cfgcmd sset "${obj}.Boot" "1"
	else
		cfgcmd sset "${obj}.Boot" "0"
	fi
    
	local PartitionsFileSystem=""
	local dev_info=`fdisk -l | grep $dev`
	local is_fat=`echo "${dev_info}" | grep "FAT" | wc -l`
	if [ "$is_fat" == "1" ]; then
		PartitionsFileSystem=`fdisk -l | grep "/dev/${dev}" | awk '{for(i=NF;i>0;i--)if($i~/^[fF][aA][tT]/)print $i}'`
	else
		PartitionsFileSystem=`fdisk -l | grep "^\/dev\/${dev:0:3}" | awk '{print $NF}'`
	fi

	if [ "$PartitionsFileSystem" != "" -a "$PartitionsFileSystem" != "Unknown" ]; then
		cfgcmd sset "${obj}.FileSystem" "$PartitionsFileSystem"
	else
		cfgcmd sset "${obj}.FileSystem" "FAT32"
	fi

	local PartitionsSizeMB=`df -m | grep "/dev/${dev}" | awk '{print $2}'`
	cfgcmd sset "${obj}.SizeMB" "$PartitionsSizeMB"

	local PartitionsMountPoint=`GetDeviceMountPoint $dev`
	cfgcmd sset "${obj}.MountPoint" "$PartitionsMountPoint"
	if [ "${PartitionsMountPoint}" != "" ]; then
		cfgcmd sset "${obj}.Mounted" "1"
	else
		cfgcmd sset "${obj}.Mounted" "0"
	fi

	local ret=`/usr/syscfg/backup.sh "restore_judge" "${PartitionsMountPoint}"`
	if [ "${ret:0:3}" != "err" ]; then
		cfgcmd sset "${obj}.CfgBackupFileExist" "1"
	else
		cfgcmd sset "${obj}.CfgBackupFileExist" "0"
	fi
	return 0
}

MountSaveDiskInfo()
{
    local dev=$1
    local path="/dev/$dev"

    local inst=`ConfigGetDeviceInstance ${g_root_dev_name}`
	if [ $inst -ne 0 ]; then
		return $inst
	fi
	inst=`cfgcmd add_obj_nosave $DMP_STORAGE.`

    local obj="${DMP_STORAGE}.${inst}"

    local DiskSizeB=`fdisk -l ${path} | grep "^Disk" | cut -d ' ' -f 5`
    local DiskSizeMB=`expr ${DiskSizeB} / 1000000`
    cfgcmd sset "${obj}.DiskSizeMB" $DiskSizeMB
	
	local PartitionSum=`fdisk -l ${path} | grep "^${path}" | wc -l`
    cfgcmd sset "${obj}.PartitionSum" $PartitionSum

    local Vendor=`cat ${g_root_dev_syspath}/vendor`
    cfgcmd sset "${obj}.Vendor" "${Vendor}"
    
	local Model=`cat ${g_root_dev_syspath}/model`
    cfgcmd sset "${obj}.Model" "${Model}"
    
	return $inst
}

ConfigDelDeviceInstance()
{
	local inst=`ConfigGetDeviceInstance $g_root_dev_name`
	if [ -z $inst -o $inst -eq 0 ]; then
		return
	fi
	
	cfgcmd del_obj_nosave "$DMP_STORAGE.$inst"
}

UnmountDevice()
{
    local dev=$1

    local retry=5
	local mounted=`CheckDeviceMounted $g_dev_mount_dir`
    while [ $mounted -ge 1 -a $retry -gt 0 ]
    do
		local pids=`fuser -mk $g_dev_mount_dir`
		Log "$dev: @$g_dev_mount_dir used processes($pids) which are killed for umounting."

		umount -f "$g_dev_mount_dir"
        mounted=`CheckDeviceMounted $g_dev_mount_dir`
        let retry--
    done

    if [ $mounted -ne 0 ]; then
		return 1
    fi
	
	rmdir $g_dev_mount_dir
	return 0
}

UnmountProcess()
{
    local dev=$1
    local ret=0
	
	g_dev_mount_dir=`GetDeviceMountPoint $dev`
	if [ -z "$g_dev_mount_dir" ]; then
		Log "$dev: is not mounted, do not need to umount."
		return 1
	fi

	UnmountDevice $dev
    if [ $? -ne 0 ]; then
		Log "$dev: @$g_dev_mount_dir umount failed."
        return 1
    fi

    ConfigDelDeviceInstance ${dev}
    if [ $? -ne 0 ]; then
		Log "$dev: delete config info failed."
        return 1
    fi
    return 0
}

MountDevice()
{
    local dev=$1

    if [ ! -d "$g_dev_mount_dir" ]; then
        mkdir -p "$g_dev_mount_dir"
    fi

    local retry=5
	local mounted=`CheckDeviceMounted $g_dev_mount_dir`
    while [ $mounted -lt 1 -a $retry -gt 0 ]
    do
        dev_info=`fdisk -l | grep $dev`
        if [ -z $dev_info ]; then
            mount.ntfs-3g -o big_writes,codepage=cp936,iocharset=cp936 "/dev/$dev" "$g_dev_mount_dir"
        else
	    is_ntfs=`echo "$dev_info" | grep NTFS | wc -l`
            if [ "$is_ntfs" == "1" ]; then
                mount.ntfs-3g -o big_writes,codepage=cp936,iocharset=cp936 "/dev/$dev" "$g_dev_mount_dir"
            else
                mount -o codepage=936,iocharset=cp936 "/dev/$dev" "$g_dev_mount_dir"
            fi
        fi
        mounted=`CheckDeviceMounted $g_dev_mount_dir`
        let retry--
    done

    if [ $mounted -eq 0 ]; then
		rmdir $g_dev_mount_dir
		return 1
    fi
	return 0
}

MountProcess()
{
    local dev=$1
    local dev_inst=0
    local ret=0	

	g_dev_mount_dir="/mnt/`GetDeviceMountDirName $dev`"
	if [ "$g_dev_mount_dir" == "/mnt/---" ]; then
		Log "$dev: @$g_dev_mount_dir does not really exist."
		return 1
	fi

	MountDevice $dev
    if [ $? -ne 0 ]; then
		Log "$dev: @$g_dev_mount_dir mount failed."
        return 1
    fi

    MountSaveDiskInfo "$dev"; dev_inst=$?
	if [ $dev_inst -eq 0 ]; then
		Log "$dev: save dev info failed."
		return 1
	fi
    MountSaveDiskPartitionInfo ${dev} $dev_inst
	if [ $? -ne 0 ]; then
		Log "$dev: save partition info failed."
		return 1
	fi
    return 0
}

#****************************************************************
#Automount.sh command start execute
#****************************************************************
while [ 1 ]
do
	if [ -d $USB_LOCK_DIR ]; then
		Log "$USB_LOCK_DIR is existed!"
		sleep 1
	else
		mkdir $USB_LOCK_DIR
		break
	fi
done


case "$g_report_action" in
    "add")
		MountProcess ${g_report_dev_name}; ret=$?
		if [ $ret -eq 0 ]; then
			handle_usbled "on"
			Enable=`cfgcmd get InternetGatewayDevice.Services.ServiceTFTP.Enable`
			cfgcmd oset InternetGatewayDevice.Services.ServiceTFTP.Enable "$Enable"
			/usr/syscfg/media.sh dlna
		fi
        ;;
    "remove")
		UnmountProcess ${g_report_dev_name}; ret=$?
		if [ $ret -eq 0 ]; then
			handle_usbled "off"
			total_mounted_num=`mount | grep "^\/dev\/sd" | wc -l`
			if [ $total_mounted_num == 0 ]; then
				ConfigClearDeviceInsts
				killall -q minidlna
			fi
		fi
        ;;
    *)
		Log "$g_report_dev_name with action $g_report_action is not supported."
        ;;
esac

rmdir $USB_LOCK_DIR

#****************************************************************
#Automount.sh command execute end
#****************************************************************
