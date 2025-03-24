#!/bin/sh

# SAMBA
SMBCONF=/usr/sbin/sxsambaconf
SMBD=/usr/sbin/smbd
NMBD=/usr/sbin/nmbd
MINIDLNA=/usr/bin/minidlna
MTDAAPD=/usr/sbin/mt-daapd
WEBFILE_STATE_FILE=/var/tmp/web_file

# test code
# DMSG="${ACTION}:${SHAREPATH}:${DEVPATH}"
# echo "hotplug.misc ${DMSG}" | logger -p 4

if [ -s /tmp/hotplug_misc.sh ];then
	/tmp/hotplug_misc.sh
	exit $?
fi
case "$ACTION" in
"MOUNT")
	;;
"UMOUNT")
	;;
"BEFOREMNT")
	;;
"AFTERMNT")
	$SMBCONF -c "${DEVPATH}/smb.dir.conf" -d "/etc/samba/smb.def.conf"
	MNTPOINT=`grep path /tmp/smb.dir.conf`
	if [ "$MNTPOINT" = "" ]; then
		#Fix ntfs-3g deadlock with dlna enable when usb umounted.
		killall ntfs-3g
		sleep 1
		if [ -f /var/run/minidlna.pid ]; then
			echo "kill minidlna"
			killall minidlna
			sed /^media_dir/d -i /tmp/etc/minidlna.conf
			sed /^db_dir/d -i /tmp/etc/minidlna.conf
		fi
		if [ -f /var/run/mt-daapd.pid ]; then
			echo "kill mt-daapd"
			sed "s,^mp3_dir=.*,mp3_dir=\/tmp\/silex,g" -i /tmp/etc/mt-daapd.conf
			killall mt-daapd
			rm /var/run/mt-daapd.pid
			rm /var/mt-daapd/songs3.db
		fi
		if [ -f /var/locks/smbd-smb.conf.pid ]; then
			echo "kill samba server"
#			killall nmbd
			killall smbd
			rm /var/locks/smbd-smb.conf.pid
#			rm /var/locks/nmbd-smb.conf.pid
		fi
		rm $WEBFILE_STATE_FILE
		killall wcnd
	else
		if [ "`nvram get samba_enable`" = "1" ]; then
			echo "start samba server"
			$SMBD -s "/tmp/samba/smb.conf" -D
			$NMBD -s "/tmp/samba/smb.conf" -D
			STORAGEPATH=`grep path /tmp/smb.dir.conf | sed s/path=//`
			rm /tmp/storage
			ln -s $STORAGEPATH /tmp/storage
		fi
		if [ "`nvram get file_access_enable`" = "1" ]; then
			cli service lighttpd restart-wa
			echo 1 > $WEBFILE_STATE_FILE
			rm -rf /tmp/storage/.web_upload
			mkdir /tmp/storage/.web_upload
		fi
		if [ "`nvram get minidlna_enable`" = "1" ]; then
			echo "start minidlna"
			for SHAREPATH in `grep path /tmp/smb.dir.conf | sed s/path/media_dir/`;do
				echo $SHAREPATH >> /tmp/etc/minidlna.conf
			done
			#SHAREPATH=`grep path /tmp/smb.dir.conf | sed s/path/media_dir/`
			#echo $SHAREPATH >> /tmp/etc/minidlna.conf
			DBPATH=`grep path /tmp/smb.dir.conf | sed '1!d' | sed s/path/db_dir/`
			echo $DBPATH >> /tmp/etc/minidlna.conf
#			echo "db_dir=/tmp/etc" >> /tmp/etc/minidlna.conf
			$MINIDLNA -f /tmp/etc/minidlna.conf -R
		fi
		if [ "`nvram get mt_daapd_enable`" = "1" ]; then
			echo "start mt-daapd"
			MP3PATH=`grep path /tmp/smb.dir.conf | sed s/path/mp3_dir/`/Music
			sed "s,^mp3_dir=.*,$MP3PATH,g" -i /tmp/etc/mt-daapd.conf
			$MTDAAPD -c /tmp/etc/mt-daapd.conf -r -m
		fi
		wcnd -m `nvram get lan_mac` &
	fi
	;;
esac
