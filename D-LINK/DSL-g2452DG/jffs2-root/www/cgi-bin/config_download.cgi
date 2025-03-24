#!/bin/sh
action=`echo ${QUERY_STRING} | cut -d = -f 2`

Name=`cfgcmd get InternetGatewayDevice.DeviceInfo.ModelName`
backup_config_path="/tmp/backup_$Name.cfg"
script="/usr/syscfg/backup.sh"

ack_msg()
{
	local code=$1
	echo "Pragma: no-cache"
	echo "Cache-control: no-cache"
	echo "Content-type: text/html"
	echo ""
	echo -n $code
}

ack_file()
{
	file_name=$1
	echo "Pragma: no-cache\n"
	echo "Cache-control: no-cache\n"
	echo "Content-type: application/octet-stream"
	echo "Content-Transfer-Encoding: binary"
	echo "Content-Disposition: attachment; filename=\"${file_name}.cfg\""
	echo ""
	$script dump $backup_config_path
}

case "$action" in
	"download")
		$script clean $backup_config_path
		$script backup $backup_config_path
		ack_file default
		$script clean $backup_config_path
        ;;
	"Spec")
		$script clean $backup_config_path
		$script backup $backup_config_path	
		local if_mac=`ifconfig br0 | grep HWaddr | awk '{print $NF}'`
		local filename=`echo $if_mac | cut -d ':' -f 1``echo $if_mac | cut -d ':' -f 2``echo $if_mac | cut -d ':' -f 3``echo $if_mac | cut -d ':' -f 4``echo $if_mac | cut -d ':' -f 5``echo $if_mac | cut -d ':' -f 6`
		ack_file ${filename}
		$script clean $backup_config_path
       ;;
	"Global")
		$script clean $backup_config_path
		$script backup $backup_config_path
		ack_file Global
		$script clean $backup_config_path
        ;;
  "save_xml")
    cfgcmd save /tmp/tr098_config.xml
    echo "Pragma: no-cache\n"
	  echo "Cache-control: no-cache\n"
	  echo "Content-type: application/octet-stream"
	  echo "Content-Transfer-Encoding: binary"
	  echo "Content-Disposition: attachment; filename=tr098_config.xml"
	  echo ""
	  cat /tmp/tr098_config.xml
    ;;
esac

