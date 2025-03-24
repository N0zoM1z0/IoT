#!/bin/sh
#
# $Id: //V3/release/SDK_x_x_x_1/source/user/app/scripts/mdev.sh $
#
# usage: mdev.sh
#



#################################################################################################
#1、生成/etc/mdev.conf
#2、向内核注册hotplug
#################################################################################################
setMDEV()
{
	local mdev_conf_file="/etc/mdev.conf"

	#Linux2.6 uses mdev instead of devfs, we have to create static dev node by myself.
	echo "# <device regex> <uid>:<gid> <octal permissions> [<@|$|*> <command>]" > ${mdev_conf_file}
	echo "# The special characters have the meaning:" >> ${mdev_conf_file}
	echo "# @ Run after creating the device." >> ${mdev_conf_file}
	echo "# $ Run before removing the device." >> ${mdev_conf_file}
	echo "# * Run both after creating and before removing the device." >> ${mdev_conf_file}
	echo "sd[a-z][1-9] 0:0 0660 * /usr/syscfg/usb/pre_automount.sh" >> ${mdev_conf_file}
	echo "#mmcblk[0-9]p[0-9] 0:0 0660 */usr/syscfg/pre_automount.sh \$MDEV" >> ${mdev_conf_file}
	echo "#mmcblk[0-9] 0:0 0660 */usr/syscfg/pre_automount.sh \$MDEV" >> ${mdev_conf_file}
	
	#enable usb hot-plug feature
	echo "/sbin/mdev" > /proc/sys/kernel/hotplug
}


############################################### main #################################################
/usr/syscfg/usb/init.sh

setMDEV
mdev -s

