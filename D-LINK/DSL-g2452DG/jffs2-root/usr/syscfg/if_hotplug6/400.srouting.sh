#!/bin/sh

. /usr/syscfg/wan.utils.sh

for para in $*
do
    export $para
done 

wan_if_action=$action
wan_if_path=$path

wan_folder_name=""
wan_type=""

TGP_Log ${TGP_LOG_WARNING} "wan_if_action=$wan_if_action wan_if_path=$wan_if_path"

wan_type=`echo "$wan_if_path" | awk -F '.' '{print $6}'`
if [ "${wan_type}" == "WANIPConnection" ]; then
   wan_folder_name=`gen_ipconn_folder ${wan_if_path}`
else
   wan_folder_name=`gen_pppconn_folder ${wan_if_path}`
fi

echo "sRouting6.sh ${wan_if_action} ${wan_folder_name}" >> /tmp/s6
/usr/syscfg/sRouting6.sh "${wan_if_action}" "${wan_folder_name}"

