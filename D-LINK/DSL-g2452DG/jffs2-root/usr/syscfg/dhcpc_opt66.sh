#!/bin/sh

. /usr/syscfg/wan.comm.param.sh
. /usr/syscfg/wan.utils.sh

for para in $*
do
	    export $para
done

if [ -z ${path} ]; then
	echo "no wan path"
	exit 0
fi

local wan_folder=`gen_wanconn_folder ${path}`
local tftp_log_file="/tmp/tftp.err"
local global_file="Global.cfg"
local cfg_file_path="/tmp/restore.cfg"
local sys_cfg_file_path="sys_backup.cfg"
local backup_sh="/usr/syscfg/backup.sh"
local cmp_log="/tmp/cmp_log.err"
local restore_log="/tmp/restore.err"

tftp_get_cfg_file()
{
	local tftp_addr_path=""
	local tftp_addr=""
	local mac_file=""
	local err=""

	tftp_addr_path=`expr /tmp/${wan_folder}/${SERVER_ASSIGNED_TFTP_ADDR}`
	tftp_addr=`cat ${tftp_addr_path}`

	local if_mac=`ifconfig br0 | grep HWaddr | awk '{print $NF}'`
		
	if [ "${if_mac}" != "" ]; then
		local mac=`echo $if_mac | cut -d ':' -f 1``echo $if_mac | cut -d ':' -f 2``echo $if_mac | cut -d ':' -f 3``echo $if_mac | cut -d ':' -f 4``echo $if_mac | cut -d ':' -f 5``echo $if_mac | cut -d ':' -f 6`
		mac_file="${mac}".cfg
	fi

	if [ "${tftp_addr}" != "" ]; then
		tftp -l ${cfg_file_path} -r ${global_file} -g ${tftp_addr} > ${tftp_log_file} 2>&1
		if [ ! -f "${cfg_file_path}" ]; then
			tftp -l ${cfg_file_path} -r ${mac_file} -g ${tftp_addr} > ${tftp_log_file} 2>&1
		fi
		
		if [ -f "${cfg_file_path}" ]; then
			rm "/tmp/${sys_cfg_file_path}"
			rm ${tftp_log_file}

			${backup_sh} backup /tmp /tmp ${sys_cfg_file_path}

			cmp "${cfg_file_path}" "/tmp/${sys_cfg_file_path}" > ${cmp_log}

			if [ -s ${cmp_log} ]; then
				${backup_sh} restore / / ${cfg_file_path} > ${restore_log}
				err=`cat ${restore_log} | grep err`
				if [ -z $err ];then
					sleep 3
					reboot
				fi
			fi
			
			rm "/tmp/${sys_cfg_file_path}"
			rm "${cfg_file_path}"
			rm ${cmp_log}
			rm ${tftp_log_file}
			rm ${restore_log}
		fi
	fi
}


case $action in
	"if_up")
		tftp_get_cfg_file
		;;
	"if_down")
		;;
	*)
		help
		;;
esac
