#!/bin/sh
. /usr/syscfg/wan.utils.sh
#InternetGatewayDevice.WANDevice.1.WANConnectionDevice.2.WANPPPConnection.1.
GetIfName()
{
    local if_path=$1
    local if_type=""
    local wan_interface_folder=""
    local wan_type=""

    local if=""

    if [ "${if_path}" != "" ]; then
        if_type=`echo "$if_path" | /usr/bin/awk -F '.' '{print $2}'`
        if [ "${if_type}" == "WANDevice" ]; then
            wan_type=`echo "$if_path" | /usr/bin/awk -F '.' '{print $6}'`
            if [ "${wan_type}" == "WANIPConnection" ]; then
                wan_interface_folder=`gen_ipconn_folder ${if_path}`
                if [ -f "/tmp/${wan_interface_folder}/ifname" ];then
                    if=`/bin/cat "/tmp/${wan_interface_folder}/ifname"`
                fi
            else
                wan_interface_folder=`gen_pppconn_folder ${if_path}`
                if [ -f "/tmp/${wan_interface_folder}/ppp_ifname" ];then
                    if=`/bin/cat "/tmp/${wan_interface_folder}/ppp_ifname"`
                fi
            fi

#            if [ -f "/tmp/${wan_interface_folder}/ifname" ]; then
#                if=`/bin/cat "/tmp/${wan_interface_folder}/ifname"`
#            fi
        elif [ "${if_type}" == "LANDevice" ]; then
            if="br0"
        fi
    fi

    echo "${if}"
}
