#!/bin/sh

# ex: ftp_downloadstate=0
#
## modified for multilanguage
##
## "1" -- "Downloading..."
## "2" -- "Storage Error"
## "3" -- "Network Error"
## "4" -- "Count or Password Error"
## "5" -- "No Such Directory"
## "6" -- "No Such File"
## "7" -- "Download Done"
#
local ftp_downloadstate=`cfgcmd get $1DownloadState`

if [ "$ftp_downloadstate" == "1" ] || [ "$ftp_downloadstate" == "0" ] || [ "$ftp_downloadstate" == "2" ]; then 
	local ftp_downurl=`cfgcmd get $1URL`
	# sometimes, found the url is null, but it's not, 
	while test -z ${ftp_downurl}
	do
		ftp_downurl=`cfgcmd get $1URL`
	done
	
	local ftp_usbpartition=`cfgcmd get $1UsbPartion`
	while test -z ${ftp_usbpartition}
	do
		ftp_usbpartition=`cfgcmd get $1UsbPartion`
	done

	local ftp_savepath=`cfgcmd get $1SavePath`
	while test -z ${ftp_savepath}
	do
		ftp_savepath=`cfgcmd get $1SavePath`
	done

	local file_name=`basename "${ftp_downurl}"`
	local logfile="${ftp_usbpartition}/${ftp_savepath}/${file_name}.ftplog"
	local tmpfile="/tmp/${1:41}delSh"
	if [ -f "${tmpfile}" ]; then 
		test ! -d "${ftp_usbpartition}/${ftp_savepath}" && STATUS="2" && cfgcmd set $1DownloadState ${STATUS} && exit 1
		local PROGRESS=`grep "[0-9]*%" "${logfile}" | awk 'END {print}' | awk '{print $(NF-2)}'`
		grep -i "failed" "${logfile}" && STATUS="3" || STATUS="1"
		grep -i "No space left on device"  "${logfile}" && STATUS="10"
		grep -i "Login incorrect" "${logfile}" && STATUS="4"
		grep -i "No such directory" "${logfile}" && STATUS="5"
		grep -i "No such file" "${logfile}" && STATUS="6"
		grep -i "(.*).*saved" "${logfile}" && STATUS="7" && PROGRESS="100%"
		grep -i "File has already been retrieved" "${logfile}" && STATUS="9"
		[ "${STATUS}" != "1" ] && rm -f "${logfile}" "${tmpfile}"
		cfgcmd set $1Progress ${PROGRESS}
		cfgcmd set $1DownloadState ${STATUS}
			
		local pid=`ps | grep "${ftp_usbpartition}/${ftp_savepath}/${file_name}" | grep -v "grep" | awk '{print $1}'`
		if [  "$pid" == "" -a -f "${tmpfile}" ]; then
			## process terminate, download error
			rm -f "${logfile}" "${tmpfile}"
			cfgcmd set $1DownloadState 8
		fi
	else
	  if [ "$ftp_downloadstate" == "1" ] || [ "$ftp_downloadstate" == "0" ]; then
	  	cfgcmd set $1DownloadState 8
	  fi
	fi
fi
nvram commit
exit 0
