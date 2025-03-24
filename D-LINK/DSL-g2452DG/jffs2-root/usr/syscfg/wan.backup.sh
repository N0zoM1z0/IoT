#!/bin/sh
. /usr/syscfg/api_log.sh
. /usr/syscfg/wan.comm.param.sh
. /usr/syscfg/wan.utils.sh



# 获取dongle的wand path
get_dongle_wand_path()
{    
    local wandIndexs=`cfgcmd get_idxes InternetGatewayDevice.WANDevice.`
    local WANAccessType=""
    for i in $wandIndexs; do
        WANAccessType=`cfgcmd get InternetGatewayDevice.WANDevice.${i}.WANCommonInterfaceConfig.WANAccessType`
        if [ "${WANAccessType}" = "Dongle" ] ; then            
            echo "InternetGatewayDevice.WANDevice.${i}."
            return
        fi
    done

    echo ""
}




######################################################## main ############################################################
#入参
path=${1} #比如InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANPPPConnection.1.
action=${2} #up/down

#本地参数
donglePath=""
isBridge=""
tmp=""
EnabledForInternet=""

TGP_Log $TGP_LOG_WARNING "path=${path}, action=${action}"

#如果是桥不处理
isBridge=`is_Bridged_Conn $path`
if [ $isBridge -eq 1 ];then
    TGP_Log $TGP_LOG_WARNING "is bridge"
    exit 0
fi


#如果是dongle的wan连接，不处理
dongleWandPath=`get_dongle_wand_path`
if [ -z  "$dongleWandPath" ]; then
    TGP_Log $TGP_LOG_WARNING "dongle is not configured!"
    exit 0
fi

tmp=`echo ${path} |grep ${dongleWandPath}`
if [ -n "${tmp}" ];then
    TGP_Log $TGP_LOG_WARNING "current wan is dongle wan!"
    exit 0
fi


#如果非dongle路由连接上线，dongle下线；反之亦然
EnabledForInternet=`cfgcmd get ${dongleWandPath}WANCommonInterfaceConfig.EnabledForInternet`
if [ "${action}" = "up" ]; then
    if [ "${EnabledForInternet}" = "1" -a `ExistedDefaultGateway` -eq 1 ]; then
        cfgcmd oset ${dongleWandPath}WANCommonInterfaceConfig.EnabledForInternet 0 &
    else
        TGP_Log $TGP_LOG_WARNING "dongle wan has already been down!"
    fi
else
    if [ `ExistedDefaultGateway` -eq 0 ]; then
        cfgcmd oset ${dongleWandPath}WANCommonInterfaceConfig.EnabledForInternet 1 &
    else
        TGP_Log $TGP_LOG_WARNING "I am not the last internet wan!"
    fi
fi
