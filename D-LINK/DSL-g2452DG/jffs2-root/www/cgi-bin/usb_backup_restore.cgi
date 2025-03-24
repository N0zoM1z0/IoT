#!/bin/sh
action=`echo ${QUERY_STRING} | cut -d = -f 3 | cut -d ? -f 1`
mnt_name=`echo ${QUERY_STRING} | cut -d = -f 4 | cut -d ? -f 1`
sta_path=`echo ${QUERY_STRING} | cut -d = -f 5 | cut -d ? -f 1`
restore_enable=`echo ${QUERY_STRING} | cut -d = -f 6 | cut -d ? -f 1`

script="/usr/syscfg/backup.sh"
ERR_RESTORE_DISABLED="err_restore_disabled"

ack()
{
	local code=$1
	echo "Pragma: no-cache"
	echo "Cache-control: no-cache"
	echo "Content-type: text/html"
	echo ""
	echo -n $code
}


case "$action" in
	"backup_judge")
		ret=`$script backup_judge $mnt_name`
		ack $ret
	 	;;
	"backup")
		ret=`$script backup $mnt_name`
		ack $ret
		;;
	"restore_judge")
		ret=`$script restore_judge $mnt_name`
		ack $ret
	 	;;
	"restore")
		if [ "${restore_enable}" == "0" ]; then
			cfgcmd set InternetGatewayDevice.DeviceInfo.X_CT-COM_Restore.Enable 0
			ack $ERR_RESTORE_DISABLED
		else
			ret=`$script restore $mnt_name`
			if [ "${ret}" != "success" ]; then
			  cfgcmd set InternetGatewayDevice.DeviceInfo.X_CT-COM_Restore.Enable 1
			  nvram commit
			fi
			ack $ret
		fi
		;;
	"clean")
	   ret=`$script clean $mnt_name`
	   ack $ret
	   ;;
	"reboot")
	   reboot
	   ack "success"
	   ;;
esac
