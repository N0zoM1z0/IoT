#!/bin/sh
try_ttyusb()
{
	local dev=$1
	local result
	lte_log_file_path="/tmp/lte_log"
	if [ -f ${lte_log_file_path} ]; then
		rm ${lte_log_file_path}
	fi
	/usr/sbin/chat -s -v ABORT 'ERROR' TIMEOUT 2 '' AT OK 0<${dev} 1>${dev} 2>${lte_log_file_path}
	result=`cat ${lte_log_file_path} | grep "got it"`
	if [ -z "$result" ]; then
		#if failed, try again
		/usr/sbin/chat -s -v ABORT 'ERROR' TIMEOUT 2 '' AT OK 0<${dev} 1>${dev} 2>${lte_log_file_path}
		result=`cat ${lte_log_file_path} | grep "got it"`
		if [ -z "$result" ]; then
			echo -n 0
		else
			echo -n 1
		fi
	else
		echo -n 1
	fi
}

local dongle_K3765=`lsusb | grep '19d2:2002'`
local dongle_K3520=`lsusb | grep '19d2:0055'`
local dongle_E3372=`lsusb | grep '12d1:1506'`
local dongle_MA260=`lsusb | grep '2357:9000'`
local dongle_DWM_157_D1=`lsusb | grep '2001:7600'`

if [ -n "$dongle_E3372" -o  -n "$dongle_DWM_157_D1" ];then
    cfgcmd sset InternetGatewayDevice.WANDevice.3.WANDongleInterfaceConfig.X_TRI_TTYDEV "/dev/ttyUSB1"
elif [ -n "$dongle_K3520" -o -n "$dongle_MA260" ];then
    cfgcmd sset InternetGatewayDevice.WANDevice.3.WANDongleInterfaceConfig.X_TRI_TTYDEV "/dev/ttyUSB2"
elif [ -n "$dongle_K3765" ];then
    cfgcmd sset InternetGatewayDevice.WANDevice.3.WANDongleInterfaceConfig.X_TRI_TTYDEV "/dev/ttyUSB3"
else
	local DEVF="/dev/ttyUSB0"
	local count=0
	local has_ttyUSB=`ls /dev/ttyUSB* | grep ttyUSB`
	if [ -z "${has_ttyUSB}" ]; then
		return
	fi
	while [ ${count} -lt "100" ]; do
    		if [ -e "/dev/ttyUSB${count}" ];then
            		DEVF="/dev/ttyUSB${count}"
           			if [ `try_ttyusb $DEVF` -eq 1 ]; then
					cfgcmd sset InternetGatewayDevice.WANDevice.3.WANDongleInterfaceConfig.X_TRI_TTYDEV "$DEVF"				
					return
        			fi
    		fi
    		let "count+=1"
	done  
fi
