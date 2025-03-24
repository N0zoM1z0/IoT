#!/bin/sh

if [ $# -lt 1 ]; then
	exit 0
fi

. /usr/syscfg/wan.utils.sh

conn_folder=$1
conn_code=`basename ${conn_folder}`

wan_up=`is_wan_up ${conn_code}`
while [ "${wan_up}" == "0" ]; do
	exit 0
done

cat "${conn_folder}/${USER_DEFINED_DNS}" > "${conn_folder}/${PPPOE_PROXY_DNS}"
cat "${conn_folder}/${SERVER_ASSIGNED_DNS}" >> "${conn_folder}/${PPPOE_PROXY_DNS}"
cat "${conn_folder}/${IP_ADDRESS}" >> "${conn_folder}/${PPPOE_PROXY_DNS}"

exit 1

