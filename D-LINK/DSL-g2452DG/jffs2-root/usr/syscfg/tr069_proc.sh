#!/bin/sh
. /usr/syscfg/comm.utils.sh
. /usr/syscfg/api_dns.sh

TR069UpWANPath="InternetGatewayDevice.ManagementServer.X_TRI_TR069UpWAN"

Name=`cfgcmd get InternetGatewayDevice.DeviceInfo.ModelName`
default_config_file="backup_$Name.cfg"

upgrade_config()
{
	ret=`/usr/syscfg/backup.sh restore $1`
	echo "Upgrade Success"
}
get_upload_sta()
{
	if [ -f "/tmp/curl.log" ]; then
		sta=`cat /tmp/curl.log | grep "Failed FTP upload: 550"`
		if [ "${sta}" != "" ]; then
			echo 2
			return
		fi
		sta=`cat /tmp/curl.log | grep "Access denied: 530"`
		if [ "${sta}" != "" ]; then
			echo 1
			return
		fi
		
	else
		echo -1
		return
	fi
	echo 0
}
get_config_file()
{
	/usr/syscfg/backup.sh backup $1
}
get_log_file()
{
	log_filename="${1}"
    if [ -f "/data/log/debug.txt" ];then
        cp /data/log/debug.txt ${log_filename}
    else
        cp /tmp/log/debug.txt ${log_filename}
    fi
}
add_vendor_cfg_file_obj()
{
	local name="$1"
	local date="$2"
	local vendorPth="InternetGatewayDevice.DeviceInfo.VendorConfigFile"
	local indexes=`cfgcmd get_idxes $vendorPth`

	if [ "$indexes" == "0" ]; then
		break
	else
		for idx in $indexes ; do
			local cfg_name=`cfgcmd get $vendorPth.${idx}.Name`
			if [ "$cfg_name" == "$name" ]; then
				## update date
				cfgcmd fset "$vendorPth.${idx}.Date" $date
				nvram commit
				return
			fi
		done
	fi

	## add a new node
	local index=`cfgcmd add_obj "InternetGatewayDevice.DeviceInfo.VendorConfigFile."`
	if [ ${index} -gt 0 ]; then
		cfgcmd fset InternetGatewayDevice.DeviceInfo.VendorConfigFile.${index}.Name $name
		cfgcmd fset InternetGatewayDevice.DeviceInfo.VendorConfigFile.${index}.Date $date
		nvram commit
	fi
}
check_lan_ip()
{
	local ip1="$1"
	local ip2="$2"
	if [ -z "$ip1" -o -z "$ip2" ]; then
		echo -n 0
		return
	fi
	ip1=`echo $ip1 | cut -d '.' -f 1-3`
	ip2=`echo $ip2 | cut -d '.' -f 1-3`

	if [ "$ip1" = "$ip2" ]; then
		echo -n 1
	else
		echo -n 0
	fi

}
create_tr069_upload()
{
	CommandKey=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.CommandKey`
	FileType=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.FileType`
	URL=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.URL`
	Username=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.Username`
	Password=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.Password`
	DelaySeconds=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.DelaySeconds`
	ipaddr=""
	

	
	echo "CommandKey=$CommandKey"
	echo "FileType=$FileType"
	echo "URL=$URL"
	echo "Username=$Username"
	echo "Password=$Password"
	echo "DelaySeconds=$DelaySeconds"

	echo "sleep $DelaySeconds"
	sleep $DelaySeconds

	if [ "$URL" == "" ]; then
		return;
	fi
	StartTime=`date -Iseconds | cut -d "+" -f 1`
	echo "StartTime=$StartTime"
	cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.StartTime $StartTime

	if [ "${FileType}" == "1 Vendor Configuration File" ]; then
		filename=/tmp/$default_config_file
		get_config_file ${filename}
	elif [ "${FileType}" == "2 Vendor Log File" ]; then
		filename=/tmp/debug.txt
		get_log_file ${filename}
	fi	

	#http://user:passwd@ipordomain:port/file
	ipaddr=`echo ${URL} | cut -d '/' -f 3 | cut -d @ -f 2 | cut -d : -f 1`
	if [ `is_valid_ip $ipaddr` -eq 0 ]; then
		ipaddr=`dns_query_4 ${ipaddr} ${wanPath}`
	fi
	need_process_route=0
	if [ `is_valid_ip $ipaddr` -eq 1 ]; then
		lanip=`cfgcmd get InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1.IPInterfaceIPAddress`
		if [ `check_lan_ip $ipaddr $lanip` -eq 0 ]; then
			need_process_route=1
		fi	
	fi
	if [ "$need_process_route" = "1" ]; then
	add_static_route $ipaddr $wanPath
	fi

	curl -s --digest --trace-ascii /tmp/curl.log --upload-file ${filename} -u ${Username}:${Password} "${URL}"
	Result=`get_upload_sta`

	#delete static route
	if [ "$need_process_route" = "1" ]; then
		del_static_route $ipaddr $wanPath
	fi	
	
	CompleteTime=`date -Iseconds | cut -d "+" -f 1`
	echo "CompleteTime=$CompleteTime"
	cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.CompleteTime $CompleteTime

	if [ "$Result" == "0" ]; then
		cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.FaultCode 0
		cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.FaultString ""
	elif [ "$Result" == "-1" ]; then
		cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.FaultCode 9011
		cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.FaultString "Upload failure"
	elif [ "$Result" == "1" ]; then
		cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.FaultCode 9001
		cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.FaultString "Request denied"
	elif [ "$Result" == "2" ]; then
		cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.FaultCode 9012
		cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Upload.FaultString "File transfer server authentication failure"
	fi

	sleep 5
	cfgcmd manully_inform EV TC-$CommandKey Up-$CommandKey
	echo "cfgcmd manully_inform EV TC-$CommandKey Up-$CommandKey"
}

create_tr069_download()
{
	CommandKey=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.CommandKey`
	FileType=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.FileType`
	URL=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.URL`
	Username=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.Username`
	Password=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.Password`
	FileSize=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.FileSize`
	TargetFileName=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.TargetFileName`
	DelaySeconds=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.DelaySeconds`
	SuccessURL=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.SuccessURL`
	FailureURL=`cfgcmd get InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.FailureURL`
	ipaddr=""

	echo "CommandKey=$CommandKey"
	echo "FileType=$FileType"
	echo "URL=$URL"
	echo "Username=$Username"
	echo "Password=$Password"
	echo "FileSize=$FileSize"
	echo "TargetFileName=$TargetFileName"
	echo "DelaySeconds=$DelaySeconds"
	echo "SuccessURL=$SuccessURL"
	echo "FailureURL=$FailureURL"

	echo "sleep $DelaySeconds"
	sleep $DelaySeconds

	if [ "$URL" == "" ]; then
		return;
	fi

	if [ "$TargetFileName" == "" ]; then
		if [ "${FileType}" == "1 Firmware Upgrade Image" ]; then
			TargetFileName="vspm_image.bin"
		elif [ "${FileType}" == "3 Vendor Configuration File" ]; then
			TargetFileName=$default_config_file
		fi
	fi

	#http://user:passwd@ipordomain:port/file
	ipaddr=`echo ${URL} | cut -d '/' -f 3 | cut -d @ -f 2 | cut -d : -f 1`
	if [ `is_valid_ip $ipaddr` -eq 0 ]; then
		ipaddr=`dns_query_4 ${ipaddr} ${wanPath}`
	fi
	need_process_route=0
	if [ `is_valid_ip $ipaddr` -eq 1 ]; then
		lanip=`cfgcmd get InternetGatewayDevice.LANDevice.1.LANHostConfigManagement.IPInterface.1.IPInterfaceIPAddress`
		if [ `check_lan_ip $ipaddr $lanip` -eq 0 ]; then
			need_process_route=1
		fi	
	fi
	if [ "$need_process_route" = "1" ]; then
	add_static_route $ipaddr $wanPath
	fi
	
	
	ishttp=`echo $URL | grep http`
	if [ -n "$ishttp" ]; then
	  DownCmd="curl --anyauth -u $Username:$Password -o /tmp/$TargetFileName $URL"
	else
	  DownCmd="curl --digest -u $Username:$Password -o /tmp/$TargetFileName $URL"
	fi	
	
	echo "DownCmd=$DownCmd"

	StartTime=`date -Iseconds | cut -d "+" -f 1`
	echo "StartTime=$StartTime"
	cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.StartTime $StartTime

	DownResult=`$DownCmd`
	echo "DownResult=$DownResult"
	
	#delete static route
	if [ "$need_process_route" = "1" ]; then
		del_static_route $ipaddr $wanPath
	fi	
	
	if [ "${FileType}" == "1 Firmware Upgrade Image" ]; then
		DownResult=`upgrade_image /tmp/$TargetFileName`
		echo "upgrade_image /tmp/$TargetFileName"
	elif [ "${FileType}" == "3 Vendor Configuration File" ]; then
		DownResult=`upgrade_config /tmp/$TargetFileName`
		echo "upgrade_config /tmp/$TargetFileName"
	fi

	CompleteTime=`date -Iseconds | cut -d "+" -f 1`
	echo "CompleteTime=$CompleteTime"
	cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.CompleteTime $CompleteTime

	need_reboot="0"
	if [ "$DownResult" == "Upgrade Success" ]; then
		echo "set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.FaultCode 0"
		cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.FaultCode 0
		cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.FaultString ""
		need_reboot="1"
	fi
	if [ "$DownResult" == "Write to Flash Error" ]; then
		echo "set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.FaultCode 9002"
		cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.FaultCode 9002
	fi
	if [ "$DownResult" == "Check FW Error" ]; then
		echo "set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.FaultCode 9001"
		cfgcmd set InternetGatewayDevice.X_TR69_Transfer.X_TRI_Download.FaultCode 9001
	fi

	rm -f /tmp/.nvram
	sleep 10
	cfgcmd manully_inform EV TC-$CommandKey Dn-$CommandKey
	echo "cfgcmd manully_inform EV TC-$CommandKey Dn-$CommandKey"

	if [ "$need_reboot" == "1" ]; then
		add_vendor_cfg_file_obj "$TargetFileName" "$CompleteTime"
		sleep 10
		reboot
	fi
}

if [ "$0" == "tr069_proc.sh" -o "$0" == "./tr069_proc.sh" -o "$0" == "/usr/syscfg/tr069_proc.sh" ]; then
    wanPath=`cfgcmd get ${TR069UpWANPath}`
	if [ "$1" == "Upload" ]; then
		create_tr069_upload
	fi
	if [ "$1" == "Download" ]; then
		create_tr069_download
	fi
fi

