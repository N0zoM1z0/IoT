#!/bin/sh
. /usr/syscfg/getifname.sh
. /usr/syscfg/api_log.sh

DDNS_CTL_PATH="InternetGatewayDevice.X_CT-COM_DDNS"
DDNS_CONFIG_PATH="InternetGatewayDevice.WANDevice"
DDNS_ENABLE=`/usr/sbin/cfgcmd get ${DDNS_CTL_PATH}.Enable`

update_dns()
{
    DDNS_PATH="${1}"
    DDNS_enabled=${DDNS_ENABLE}
    DDNS_prov=`/usr/sbin/cfgcmd get ${DDNS_PATH}.DDNSProvider`
    DDNS_username=`/usr/sbin/cfgcmd get ${DDNS_PATH}.DDNSUsername`
    DDNS_password=`/usr/sbin/cfgcmd get ${DDNS_PATH}.DDNSPassword`
    DDNS_domainname=`/usr/sbin/cfgcmd get ${DDNS_PATH}.DDNSHostName`
    DDNS_interface=""
    DDNS_ipaddr=""

    TGP_Log ${TGP_LOG_WARNING} "update_dns ${1}"

    if [ "${DDNS_enabled}" == "0" ];then
        cfgcmd sset ${DDNS_PATH}.DDNSState Unsynchronized
        return
    elif [ "${DDNS_enabled}" == "1" ];then
        interface_path=`/usr/sbin/cfgcmd get ${DDNS_PATH}.X_CT-COM_ConnectedDeviceName`
        DDNS_interface=`GetIfName "${interface_path}"`
        if [ ${#DDNS_interface} -gt 0 ];then
            DDNS_ipaddr=`/sbin/ifconfig "${DDNS_interface}" | /bin/grep "inet addr"|/usr/bin/awk '{printf$2}'|/usr/bin/cut -d : -f 2`
            if [ ${#DDNS_ipaddr} -le 1 ];then
                cfgcmd sset ${DDNS_PATH}.DDNSState Unsynchronized
                TGP_Log ${TGP_LOG_WARNING} "get wan ${DDNS_interface} ip error!"
                return
            fi
        else
            cfgcmd sset ${DDNS_PATH}.DDNSState Unsynchronized
            TGP_Log ${TGP_LOG_WARNING} "wan corresponding (${DDNS_PATH}) down!"
            return
        fi
    fi

    if [ ${DDNS_prov} != "" ];then
        /usr/syscfg/ddns_update.sh "${DDNS_username}" "${DDNS_password}" "${DDNS_domainname}" "${DDNS_interface}" "${DDNS_PATH}" "${DDNS_ipaddr}" "${DDNS_prov}" &
    else
        cfgcmd sset ${DDNS_PATH}.DDNSState Unsynchronized
    fi
}
ddns_set()
{
    WANDevice_count=`/usr/sbin/cfgcmd get_max_obj ${DDNS_CONFIG_PATH}`
    if [ $WANDevice_count -lt 1 ];then
        TGP_Log ${TGP_LOG_WARNING} "WANDevice_count == 0"
        return
    fi

    i=1
    while [ $i -le $WANDevice_count ]
    do
        WANCONDEVICE_PATH="${DDNS_CONFIG_PATH}.${i}.WANConnectionDevice"
        WANCONDEVICE_count=`/usr/sbin/cfgcmd get_max_obj ${WANCONDEVICE_PATH}`
        if [ $WANCONDEVICE_count -lt 1 ];then
            TGP_Log ${TGP_LOG_WARNING} "${WANCONDEVICE_PATH}.count = 0"
            i=`/usr/bin/expr $i + 1`
            continue
        fi
        
        j=1
        while [ $j -le $WANCONDEVICE_count ]
        do
            WANPPPCON_PATH="${WANCONDEVICE_PATH}.${j}.WANPPPConnection"
            WANPPPCON_count=`/usr/sbin/cfgcmd get_max_obj ${WANPPPCON_PATH}`
            WANIPCON_PATH="${WANCONDEVICE_PATH}.${j}.WANIPConnection"
            WANIPCON_count=`/usr/sbin/cfgcmd get_max_obj ${WANIPCON_PATH}`
            if [ $WANPPPCON_count -gt 0 ];then
                k=1             
                while [ $k -le $WANPPPCON_count ]
                do 
                    DDNSCONFIG_PATH="${WANPPPCON_PATH}.${k}.X_CT-COM_DDNSConfiguration"
                    DDNSCONFIG_count=`/usr/sbin/cfgcmd get_max_obj ${DDNSCONFIG_PATH}`
                    if [ $DDNSCONFIG_count -lt 1 ];then
                        TGP_Log ${TGP_LOG_WARNING} "${DDNSCONFIG_PATH}.count = 0"
                        k=`/usr/bin/expr $k + 1`
                        continue
                    fi
                    n=1
                    while [ $n -le $DDNSCONFIG_count ]
                    do
                        X_CT_DDNSCONF_PATH=${DDNSCONFIG_PATH}.${n}
                        update_dns $X_CT_DDNSCONF_PATH
                        n=`/usr/bin/expr $n + 1`
                    done
                    k=`/usr/bin/expr $k + 1`
                done
            fi
            
            if [ $WANIPCON_count -gt 0 ];then
                k=1
                while [ $k -le $WANIPCON_count ]
                do 
                    DDNSCONFIG_PATH="${WANIPCON_PATH}.${k}.X_CT-COM_DDNSConfiguration"
                    DDNSCONFIG_count=`/usr/sbin/cfgcmd get_max_obj ${DDNSCONFIG_PATH}`
                    if [ $DDNSCONFIG_count -lt 1 ];then
                        TGP_Log ${TGP_LOG_WARNING} "${DDNSCONFIG_PATH}.count = 0"
                        k=`/usr/bin/expr $k + 1`
                        continue
                    fi
                    n=1
                    while [ $n -le $DDNSCONFIG_count ]
                    do
                        X_CT_DDNSCONF_PATH=${DDNSCONFIG_PATH}.${n}
                        update_dns $X_CT_DDNSCONF_PATH
                        n=`/usr/bin/expr $n + 1`
                    done
                    k=`/usr/bin/expr $k + 1`
                done
            fi
            j=`/usr/bin/expr $j + 1`
        done    
        i=`/usr/bin/expr $i + 1`
    done
}

ddns_handle_with_wan()
{
    local DDNS_WANPATH="${2}X_CT-COM_DDNSConfiguration"
    local DDNS_count=`cfgcmd get_max_obj ${DDNS_WANPATH}`

    if [ $DDNS_count -lt 1 ]; then
        return
    fi

    n=1
    while [ $n -le $DDNS_count ]
    do
        local X_CT_DDNS_PATH=$DDNS_WANPATH.${n}
        if [ "$1" == "0" ];then
            cfgcmd sset ${X_CT_DDNS_PATH}.DDNSState Unsynchronized
        else
            update_dns $X_CT_DDNS_PATH
        fi
        n=`/usr/bin/expr $n + 1`
    done
}

if [ "$1" == "ddns_set" ];then
    TGP_Log ${TGP_LOG_WARNING} "ddns_setting.sh ddns_set ${DDNS_ENABLE}"
    ddns_set
elif [ "$1" == "config_set" ];then
    update_dns $2
elif [ "$1" == "config_del" ];then
    TGP_Log ${TGP_LOG_WARNING} "delete current DDNS config"
elif [ "$1" == "ifup" ];then
    ddns_handle_with_wan 1 $2
elif [ "$1" == "ifdown" ];then
    ddns_handle_with_wan 0 $2
fi
