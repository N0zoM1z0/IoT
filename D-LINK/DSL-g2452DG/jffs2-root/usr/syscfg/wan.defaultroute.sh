#!/bin/sh 
. /usr/syscfg/api_log.sh
. /usr/syscfg/wan.comm.param.sh
. /usr/syscfg/wan.utils.sh
local base_path="/tmp/.tri_defaultroute"
local delrt_path="/tmp/.tri_defaultroute/delrt"
local dr_en=`cfgcmd get InternetGatewayDevice.X_TRI_DefautlRoute.Enabled`
local dr_inf=`cfgcmd get InternetGatewayDevice.X_TRI_DefautlRoute.WanInterface`
local if_list=""
local wan_ifname=""
local wan_folder=""

if [ "$dr_en" != "1" ]; then
	return
fi

if [ -f "${delrt_path}" ]; then
	sh ${delrt_path}
	rm ${delrt_path}
fi

local wan_list=`echo $dr_inf | tr "," " "`
for if_list in ${wan_list}
do
	wan_folder=`gen_wanconn_folder ${if_list}`
	wan_ifname=`get_wanconn_ifname ${wan_folder}`
	if [ -z "${wan_ifname}" ]; then
		continue
	fi
	rt_path="${base_path}/${wan_ifname}"
	if [ -f "${rt_path}" ]; then
		sh 	${rt_path}
		cp ${rt_path} ${delrt_path}
		sed -i "s/add/del/g" ${delrt_path}
		return
	fi
done

local wan_list=`ls ${base_path}`
for wan_ifname in ${wan_list}
do
	rt_path="${base_path}/${wan_ifname}"
	if [ -f "${rt_path}" ]; then
		sh 	${rt_path}
		cp ${rt_path} ${delrt_path}
		sed -i "s/add/del/g" ${delrt_path}
		return
	fi
done


