#!/bin/sh
#
# $Id: /user/syscfg/StorageAdaptor.sh $
#
# usage: StorageAdaptor.sh as an adaptor course will be execution via specfied files <DlnaApp sambaApp ftpdApps>
#
#
#PART1=`mount | grep "/media/" | sed 's/^.*media/\/media/g' | sed 's/ type.*$//g' | sed -n '1p'`
PART1="/mnt"
PART2=`mount | grep "/mnt/" | sed 's/^.*mnt/\/mnt/g' | sed 's/ type.*$//g' | sed -n '1p'`
echo "PART1:"$PART1""
CONFIG_PATH=/var
EXEC_PATH=/etc
# TR098 access path
TR098_STORAGE_PATH=InternetGatewayDevice.X_CT-COM_UserInfo.UserList
TR098_SAMBA_PATH=InternetGatewayDevice.Services.ServiceSamba
TR098_DLNA_PATH=InternetGatewayDevice.Services.ServiceDLNA


###########################################################################
SambaInitialization()
{
	echo "SambaInitialization"
	smbnetbios=`cfgcmd get $TR098_SAMBA_PATH.NetBIOSName`
	smbwg=`cfgcmd get $TR098_SAMBA_PATH.NetWorkGroup`
	echo "samba.sh "$smbnetbios" "$smbwg" "$PART1""
	samba.sh "$smbnetbios" "$smbwg" "$PART1"
	smbusers=""

	local accounts=`cfgcmd get_idxes $TR098_STORAGE_PATH`
	if [ "$accounts" != "0" ]; then
		for a in $accounts ; do
			local user=`cfgcmd get $TR098_STORAGE_PATH.$a.UserName`
			local passwd=`cfgcmd get $TR098_STORAGE_PATH.$a.Password_realtext`
			echo "smbpasswd -a "$user" "$passwd""
			smbpasswd -a "$user" "$passwd"
			smbusers="$smbusers $user"
		done
	fi
	
	echo "samba_add_dir.sh Public "$PART2" "$smbusers""
	samba_add_dir.sh Public "$PART2" "$smbusers"
}

###########################################################################
# Setting storage for user access account : samba ftp dlna
case "$1" in
	"samba")
		killall -q smbd
		killall -q nmbd
		if [ ! -e "$PART2" ]; then
			echo "1st usb partition does not exist"
			cfgcmd sset $TR098_SAMBA_PATH.Enable 0
			exit 0
		fi
		smbenable=`cfgcmd get $TR098_SAMBA_PATH.Enable`
		if [ "$smbenable" == "1" ]; then
			touch /var/smbpasswd
			SambaInitialization
			nmbd -s /var/smb.conf
			smbd -s /var/smb.conf
		fi
		;;
	"dlna")
		DlnaEnable=`cfgcmd get $TR098_DLNA_PATH.Enable`
		if [ "$DlnaEnable" == "1" ]; then
			killall -q minidlna
			SerialNumber=`cfgcmd get "InternetGatewayDevice.DeviceInfo.SerialNumber"`
			MediaDir=`cfgcmd get $TR098_DLNA_PATH.MediaDIR`
			echo "DlnaEnable:"$DlnaEnable""
			DlnaName=`cfgcmd get "InternetGatewayDevice.DeviceInfo.ModelName"`
			echo "minidlnaconf.sh minidlna br0 "${PART1}/${MediaDir}" "$DlnaName" "$SerialNumber""
			minidlnaconf.sh minidlna br0 "${PART1}/${MediaDir}" "$DlnaName" "$SerialNumber"
			echo "minidlna -f $CONFIG_PATH/minidlna.conf"
			sleep 1
			minidlna -R -f $CONFIG_PATH/minidlna.conf
		fi
		;;
esac
