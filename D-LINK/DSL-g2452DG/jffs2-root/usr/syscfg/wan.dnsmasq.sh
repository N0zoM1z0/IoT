#!/bin/sh
. /usr/syscfg/api_log.sh
. /usr/syscfg/wan.utils.sh


#use all dns files which store in ${dns_files_path} to regenerate resolv.conf
regenerate_resolv()
{
	local lanifnames=""
	local DNS_FILES=""
	local wanifname=""

	if [ -f ${dns_files_path} ]; then
		source ${dns_files_path}
	else
		DNS_FILES=""
	fi
	echo -n > ${dns_global_path}
	echo "nameserver 127.0.0.1" >> ${dns_global_path}

	if [ -n "${DNS_FILES}" ]; then
		for i in ${DNS_FILES}
		do
			cat $i | while read dns_server
			do

				#get port bind lan if names
				lanifnames=""
				wanifname=""
				conn_dir=`echo ${i} |cut -d '/' -f 3`			
				path=`cat /tmp/${conn_dir}/path`
				lanpath=`cfgcmd get ${path}X_CT-COM_LanInterface`
				lanpaths=`echo ${lanpath} |  tr ',' ' '`
				for j in ${lanpaths}
				do   
					lanifname=`cfgcmd get ${j}.Name`
					if [ -z "${lanifnames}" ]; then
						lanifnames=${lanifname}
					else           
						lanifnames=${lanifnames},${lanifname}
					fi
				done
				#end		
	
				if [ -z "${lanifnames}" ]; then
					dns_server1=`echo "${dns_server}" | cut -d ' ' -f 1`
					dns_server2=`echo "${dns_server}" | cut -d ' ' -f 2`
					echo "nameserver ${dns_server1}" >> ${dns_global_path}
					if [ -n "${dns_server2}" -a "${dns_server1}" != "${dns_server2}" ]; then
						echo "nameserver ${dns_server2}" >> ${dns_global_path}
					fi
				else
					#get wan if name
					wanifname=`get_wanconn_ifname ${conn_dir}`
					dns_server1=`echo "${dns_server}" | cut -d ' ' -f 1`
					dns_server2=`echo "${dns_server}" | cut -d ' ' -f 2`
					echo "nameserver ${dns_server1}@${wanifname}:${lanifnames}" >> ${dns_global_path}
					if [ -n "${dns_server2}" -a "${dns_server1}" != "${dns_server2}" ]; then
						echo "nameserver ${dns_server2}@${wanifname}:${lanifnames}" >> ${dns_global_path}
					fi
				fi
			done
		done
	fi
}


##################################################### main ############################################
#waiting for dns operation unlock
while [ -f ${dns_operate_lock_path} ]; do
    usleep 100
done
#lock dns operation
touch ${dns_operate_lock_path}

TGP_Log ${TGP_LOG_WARNING} "action=$1"
case "${1}" in
    "regenerate_resolv")
        regenerate_resolv
        ;;
    *)
        #Unknow
        ;;
esac

rm -f ${dns_operate_lock_path}