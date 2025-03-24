#!/bin/sh

. /usr/syscfg/wan.utils.sh

for para in $*
do
    export $para
done 

wan_if_action=$action
wan_if_path=$path
wan_if_name=""
echo "$0 $wan_if_action $wan_if_path"

GetIfNameByPath()
{
    local if_path=$1
    local if_type=""
    local wan_interface_folder=""
    local wan_type=""
    local wan_ifname_file=""

    local if=""

    if [ "${if_path}" != "" ]; then
        if_type=`echo "$if_path" | awk -F '.' '{print $2}'`
        if [ "${if_type}" == "WANDevice" ]; then
            wan_type=`echo "$if_path" | awk -F '.' '{print $6}'`
            if [ "${wan_type}" == "WANIPConnection" ]; then
                wan_interface_folder=`gen_ipconn_folder ${if_path}`
		wan_ifname_file="ifname"
            else
                wan_interface_folder=`gen_pppconn_folder ${if_path}`
		wan_ifname_file="ppp_ifname"
            fi

            if [ -f "/tmp/${wan_interface_folder}/${wan_ifname_file}" ]; then
                if=`cat "/tmp/${wan_interface_folder}/${wan_ifname_file}"`
	    else
		if=""
            fi
        fi
    fi

    echo "${if}"
}

wan_if_name=`GetIfNameByPath ${wan_if_path}`

case "$action" in
    "ifup")
        /usr/syscfg/lanMgmt.sh "ipv4" "dhcprelay" "br0" "ifup" "${wan_if_name}" 
        ;;
    "ifdown")
        /usr/syscfg/lanMgmt.sh "ipv4" "dhcprelay" "br0" "ifdown" "${wan_if_name}" 
        ;;
    *)
        echo "unsupported action"
        ;;
esac

