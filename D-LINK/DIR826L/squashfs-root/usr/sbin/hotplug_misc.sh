#!/bin/sh

# SAMBA
SMBCONF=/usr/sbin/sxsambaconf
SMBD=/sbin/smbd
#APP_DRWS_FILE=/var/tmp/drws

#echo "$ACTION" > /tmp/log

case "$ACTION" in
"MOUNT")
	;;
"UMOUNT")
	if [ -f $APP_DRWS_FILE ]; then
		rm -f $APP_DRWS_FILE
  	fi
	;;
"BEFOREMNT")
	;;
"AFTERMNT")
	$SMBCONF -c "${DEVPATH}/smb.dir.conf" -d "/etc/samba/smb.def.conf"
	MNTPOINT=`grep path /tmp/smb.dir.conf`

	if [ -f /var/locks/smbd-smb.conf.pid ]; then
		echo "kill samba server"
		killall smbd
		rm /var/locks/smbd-smb.conf.pid
	fi

	echo "start samba server"
	$SMBD -s "/etc/samba/smb.conf" -D
	STORAGEPATH=`grep path /tmp/smb.dir.conf | sed s/path=//`
	rm /tmp/storage
	ln -s $STORAGEPATH /tmp/storage
	
	# Call DRWS 
#  	if [ ! -f $APP_DRWS_FILE ]; then
#		echo 1 > $APP_DRWS_FILE
#		app_sync 1050 0 act="scan" &
#  	fi

	;;
esac
