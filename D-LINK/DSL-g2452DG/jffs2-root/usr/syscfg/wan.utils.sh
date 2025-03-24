###################################################################
# this script include some useful functions.
# those functions will be used by wan related script.
###################################################################
. /usr/syscfg/api_log.sh
. /usr/syscfg/wan.comm.param.sh
. /usr/syscfg/firewall.param.sh

DEBUG=0
sh_debug()
{
	if [ "${DEBUG}" == "1" ]; then
		echo "$@"
	fi
}

gen_conn_folder()
{
	mkdir -p $1
}

del_conn_folder()
{
	rm -rf $1
}

#create an empty file
#params:
# 1: filename
emtpy_file()
{
	if [ $# -gt 0 ]; then
		echo > "$1"
	fi
}

#write content to file
#params:
# 1: filename
# 2: content
write_file()
{
	if [ $# == 2 ]; then
		echo "$2" > $1
	else
		echo "usage: write_file <file> <content>"
	fi
}

gen_uptime_file()
{
	uptime | sed 's/,.*$//' >$1
}

#ipv4分行生成dns文件，ipv6在同一行内生成dns文件
gen_dns_file()
{
	local file=$1
	local dns=$2
	local is_ipv6=""
	if [ "$#" -ge "2" ]; then
		dns_list=`echo $dns | tr "," " "`
		is_ipv6=`echo ${dns_list} | grep :`
		echo -n >$file
		if [ -z "${is_ipv6}" ]; then
			for i in $dns_list
			do
				echo ${i} >>$file
			done
		else
			echo "${dns_list}" >>$file
			echo gen_dns_file "${dns_list}" $file > /tmp/xx
		fi
	fi
}

save_connifname()
{
	local instance=$1
	local connifname=$2
	local file="`expr ${CONN_IFNAME_DIR}/${instance}`"

	mkdir -p ${CONN_IFNAME_DIR}
	echo ${connifname} > ${file}
}

get_connifname()
{
	local instance=$1
	local connifname=""
	local file="`expr ${CONN_IFNAME_DIR}/${instance}`"

	if [ -f ${file} ]; then
		connifname="`cat ${file}`"
	fi
	echo "${connifname}"
}

gen_connifname()
{
	local vpi=$1
	local vci=$2

	echo "nas0_${vpi}_${vci}"
}

gen_vlanifname()
{
	local instance=$1

	echo "nas0_vlan_${instance}"
}

#generate interface name based on vlan/dmac mapmode
gen_vd_ifname()
{
	local instance=$1

	echo "nas0_vd_${instance}"
}


#delete the path of user defined dns file or server assigned dns file from ${dns_files_path}
#$1: user defined dns file or server assigned dns file
del_dns()
{
	local NEW_DNS_FILES=""
	local DNS_FILES=""
	local dns_file=$1
	#check if the dns file exist
	if [ -n "${dns_file}" -a -f ${dns_file} ]; then
		#waiting for dns operation unlock
		while [ -f ${dns_operate_lock_path} ]; do
			usleep 100
		done
		#lock dns operation
		touch ${dns_operate_lock_path}
		if [ -f ${dns_files_path} ]; then
			source ${dns_files_path}
		else
			DNS_FILES=""
		fi
		for i in ${DNS_FILES}; do
			if [ "${dns_file}" == "$i" ]; then
				#find the dns file which we want to remove
				continue
			fi
			NEW_DNS_FILE="${NEW_DNS_FILE} ${i}"
		done
		echo "DNS_FILES=\"${NEW_DNS_FILE}\"" >${dns_files_path}		
		rm -f ${dns_operate_lock_path}

		#regenerate resolv.conf
		/usr/syscfg/wan.dnsmasq.sh regenerate_resolv
	fi
}

#add the path of user defined dns file or server assigned dns file to ${dns_files_path}
#$1: user defined dns file or server assigned dns file
add_dns()
{
    local exist=0
    local dns_file=$1
    local DNS_FILES=""

    #check if the dns file exist
    if [ -n "${dns_file}" -a -f ${dns_file} ]; then
        #waiting for dns operation unlock
        while [ -f ${dns_operate_lock_path} ]; do
                usleep 100
        done
        #lock dns operation
        touch ${dns_operate_lock_path}

        if [ -f ${dns_files_path} ]; then
            source ${dns_files_path}
        else
            DNS_FILES=""
        fi
        for i in ${DNS_FILES}
        do
            if [ "${dns_file}" == "$i" ]; then
                #the path already in ${DNS_FILES}
                exist=1
            fi
        done
        if [ "${exist}" != "1" ]; then
                echo "DNS_FILES=\"${DNS_FILES} ${dns_file}\"" >${dns_files_path}
        fi
        rm -f ${dns_operate_lock_path}

        #regenerate resolv.conf
        /usr/syscfg/wan.dnsmasq.sh regenerate_resolv
    fi
}

#generate ip connection folder
#params:
# 1: ipconnection tr069 path, such as "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1."
gen_ipconn_folder()
{
        local path=$1
        local folder=`echo "${path}" | /usr/bin/awk -F "." '{print "IP_"$3"_"$5"_"$7}'`
        echo "${folder}"
}


#generate ppp connection folder
#params:
# 1: pppconnection tr069 path.
gen_pppconn_folder()
{
        local path=$1
        local folder=`echo "${path}" | /usr/bin/awk -F "." '{print "PPP_"$3"_"$5"_"$7}'`
        echo "${folder}"
}


#名称： gen_wanconn_folder
#描述：根据path生成tmp下的wan连接目录名称，比如IP_1_1_1
#输入：$1 - 指wan path，比如InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.
#返回：成功：wan连接目录名称，比如IP_1_1_1 
#      失败：空
gen_wanconn_folder()
{
	if [ $# -lt 1 ]; then
		echo -n ""
		return
	fi
	local path=$1
	local folder=""
	local wan_type=`echo ${path} | awk -F '.' '{print $6}'`
	if [ "${wan_type}" == "WANIPConnection" ]; then
		folder=`echo "${path}" | awk -F "." '{print "IP_"$3"_"$5"_"$7}'`
	else
		folder=`echo "${path}" | awk -F "." '{print "PPP_"$3"_"$5"_"$7}'`
	fi
	echo "${folder}"
}


#名称： get_wandpath_by_wancpath
#描述：根据wanc的path获取WANDevice的path
#输入：$1 - wan path，比如InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.
#返回：wand的path
get_wandpath_by_wancpath()
{
	local wanc_path=$1
	local wand_path=`echo "$wanc_path" | cut -d '.' -f 1-3`
	#add '.' at the end of $wanconn_inst_path
	echo "${wand_path}."
}


#get WANConnectionDevice instance path
#params:
# 1: tr069 path, such as "InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1."
get_wanconn_inst_path()
{
        local path=$1
        local wanconn_inst_path=`echo "$path" | cut -d '.' -f 1-5`
	#add '.' at the end of $wanconn_inst_path
        echo "${wanconn_inst_path}."
}

#名称： get_wanconn_ifname
#描述：根据wan连接的目录名，获取wan连接接口，目前可以是ppp0/ppp_1_1_1/ip_1_1_1
#输入：$1 - wan连接的目录名，比如IP_1_1_1
#返回：成功：返回接口名称
#      失败：返回空
get_wanconn_ifname()
{
	if [ $# -lt 1 ]; then
		echo -n "";
		return
	fi
	local conn_folder=$1
	
	local wan_ifname=""
	
	local wan_ifn_file="/tmp/${conn_folder}/ppp_ifname"
	if [ -f "${wan_ifn_file}" ]; then
		wan_ifname=`cat ${wan_ifn_file}`
		echo -n ${wan_ifname}
		return
	fi

	wan_ifn_file="/tmp/${conn_folder}/ifname"
	if [ -f "${wan_ifn_file}" ]; then
		wan_ifname=`cat ${wan_ifn_file}`
		echo -n ${wan_ifname}
		return
	fi

	echo -n "";
}

get_wan_l2_ifname()
{
    local conn_folder=$1
    local wan_ifname=""

    local wan_ifn_file="/tmp/${conn_folder}/ifname"
    if [ -f "${wan_ifn_file}" ]; then
        wan_ifname=`cat ${wan_ifn_file}`
        echo -n ${wan_ifname}
        return
    fi

    echo -n "";
}

get_wan_l2_ifname_by_path()
{
    local wan_path=$1
    local wan_folder=`gen_wanconn_folder $wan_path`
    local wan_ifname=`get_wan_l2_ifname $wan_folder`
    echo -n $wan_ifname
}

#check if $1 is substr of $2
strIsSubstring()
{
	local x=0
	
	case "$2" in
		*$1*)
			x=1
			;;
	esac
	echo $x
}

#InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig.2,InternetGatewayDevice.LANDevice.1.WLANConfiguration.1
#use the minimal instance as handle index.
get_handle_index()
{
	local laninterface=$1
	local handle_index=1
	
	if [ "$(strIsSubstring "LANEthernetInterfaceConfig.1" ${laninterface})" -eq "1" ]; then
		handle_index=1
	elif [ "$(strIsSubstring "LANEthernetInterfaceConfig.2" ${laninterface})" -eq "1" ]; then
		handle_index=2
	elif [ "$(strIsSubstring "LANEthernetInterfaceConfig.3" ${laninterface})" -eq "1" ]; then
		handle_index=3
	elif [ "$(strIsSubstring "LANEthernetInterfaceConfig.4" ${laninterface})" -eq "1" ]; then
		handle_index=4
	elif [ "$(strIsSubstring "WLANConfiguration.1" ${laninterface})" -eq "1" ]; then
		handle_index=5
	elif [ "$(strIsSubstring "WLANConfiguration.2" ${laninterface})" -eq "1" ]; then
		handle_index=6
	elif [ "$(strIsSubstring "WLANConfiguration.3" ${laninterface})" -eq "1" ]; then
		handle_index=7
	elif [ "$(strIsSubstring "WLANConfiguration.4" ${laninterface})" -eq "1" ]; then
		handle_index=8
	elif [ "$(strIsSubstring "WLANConfiguration.5" ${laninterface})" -eq "1" ]; then
		handle_index=9
	elif [ "$(strIsSubstring "WLANConfiguration.6" ${laninterface})" -eq "1" ]; then
		handle_index=a
	elif [ "$(strIsSubstring "WLANConfiguration.7" ${laninterface})" -eq "1" ]; then
		handle_index=b
	elif [ "$(strIsSubstring "WLANConfiguration.8" ${laninterface})" -eq "1" ]; then
		handle_index=c
	fi
	echo ${handle_index}
}

get_interface_ext_list()
{
	local path_list=`echo $1 | tr "," " "`
	local if_list=""
	local if_name=""
	
	for i in ${path_list}
	do
        local lan_type=`echo ${i} | awk -F . '{print $4}'`
        if [ "$lan_type" == "WLANConfiguration" ]; then
            if_name="$(cfgcmd get ${i}.X_TRI_Name)"
        else
            if_name="$(cfgcmd get ${i}.Name)"
        fi
		if [ -n "${if_name}" ]; then
			if_list="${if_list} ${if_name}"
		fi
        if_name=""
	done
	echo "${if_list}"
}

get_interface_list()
{
	local path_list=`echo $1 | tr "," " "`
	local if_list=""
	local if_name=""
	
	for i in ${path_list}
	do
		if_name="$(cfgcmd get ${i}.Name)"
		if [ -n "${if_name}" ]; then
			if_list="${if_list} ${if_name}"
		fi
	done
	echo "${if_list}"
}

# $1: wan code: IP_1_1_1
is_wan_up()
{
    if [ $# -lt 1 ]; then
    	echo -n 0
		return
    fi

    local _wan=$1
	if [ -z "${_wan}" ]; then
    	echo -n 0
		return
	fi

	local file_uptime="/tmp/${_wan}/${UPTIME_FILE}"

    if [ -f "${file_uptime}" ]; then
        echo -n 1
	else
        echo -n 0
    fi
}

check_ipv4_wan_is_up_by_path()
{
    if [ $# -lt 1 ]; then
        echo -n 0
        return
    fi
    local wan_path=$1
    local wan_folder=`gen_wanconn_folder $wan_path`
    local up_state=`is_wan_up $wan_folder`
    echo -n $up_state
}
get_wan_gw()
{
    if [ $# -lt 1 ]; then
        echo -n ""
        return
    fi

    local _wan=$1
    if [ -z "${_wan}" ]; then
        echo -n ""
        return
    fi

    local file_gw="/tmp/${_wan}/${GATEWAY_FILE}"

    if [ -f "${file_gw}" ]; then
        cat ${file_gw}
    else
        local file_gw="/tmp/${_wan}/${PPP_IPREMOTE}"
        if [ -f "${file_gw}" ]; then
            cat ${file_gw}
        else
            echo -n ""
        fi
    fi
}

get_wan_ip()
{
    if [ $# -lt 1 ]; then
    	echo -n ""
		return
    fi

    local _wan=$1
	if [ -z "${_wan}" ]; then
    	echo -n ""
		return
	fi

	local file_ip="/tmp/${_wan}/${IPADDR_FILE}"

    if [ -f "${file_ip}" ]; then
		cat ${file_ip}
	else
		echo -n ""
    fi
}

get_wan_ppp_remote()
{
    if [ $# -lt 1 ]; then
    	echo -n ""
		return
    fi

    local _wan=$1
	if [ -z "${_wan}" ]; then
    	echo -n ""
		return
	fi

	local file_rmt="/tmp/${_wan}/${PPP_IPREMOTE}"

    if [ -f "${file_rmt}" ]; then
		cat ${file_rmt}
	else
		echo -n ""
    fi
}

#名称： get_wan_dns
#描述：根据wan连接的目录名，获取wan连接的dns列表
#输入：$1 - wan连接的目录名，比如IP_1_1_1
#返回：成功：dns列表，比如61.147.37.1,218.2.135.1
#      失败：返回空
get_wan_dns()
{
    if [ $# -lt 1 ]; then
    	echo -n ""
		return
    fi

    local _wan=$1
	
	if [ -z "${_wan}" ]; then
    	echo -n ""
		return
	fi

	local file_dns="/tmp/${_wan}/${USER_DEFINED_DNS}"

	if [ ! -f "${file_dns}" ]; then
		local file_dns="/tmp/${_wan}/${SERVER_ASSIGNED_DNS}"
	fi

    if [ -f "${file_dns}" ]; then
		cat ${file_dns} | tr "\n" " " | xargs echo -n | tr " " ","
	else
		echo -n ""
    fi
}

get_wan_first_dns()
{
    if [ $# -lt 1 ]; then
    	echo -n ""
		return
    fi

    local _wan=$1
	
	if [ -z "${_wan}" ]; then
    	echo -n ""
		return
	fi

	local file_dns="/tmp/${_wan}/${USER_DEFINED_DNS}"

	if [ ! -f "${file_dns}" ]; then
		local file_dns="/tmp/${_wan}/${SERVER_ASSIGNED_DNS}"
	fi

    if [ -f "${file_dns}" ]; then
		sed -n '1p' "${file_dns}"
	else
		echo -n ""
    fi
}

get_wan_second_dns()
{
    if [ $# -lt 1 ]; then
    	echo -n ""
		return
    fi

    local _wan=$1

	if [ -z "${_wan}" ]; then
    	echo -n ""
		return
	fi

	local file_dns="/tmp/${_wan}/${USER_DEFINED_DNS}"

	if [ ! -f "${file_dns}" ]; then
		local file_dns="/tmp/${_wan}/${SERVER_ASSIGNED_DNS}"
	fi

    if [ -f "${file_dns}" ]; then
		sed -n '2p' "${file_dns}"
	else
		echo -n ""
    fi
}

is_ip6_wan_up()
{
    if [ $# -lt 1 ]; then
    	echo -n 0
		return
    fi

    local _wan=$1
	if [ -z "${_wan}" ]; then
    	echo -n 0
		return
	fi
	local file_uptime="/tmp/${_wan}/${IP6_UPTIME}"

    if [ -f "${file_uptime}" ]; then
        echo -n 1
	else
        echo -n 0
    fi
}
check_ipv6_wan_is_up_by_path()
{
    if [ $# -lt 1 ]; then
        echo -n 0
        return
    fi
    local wan_path=$1
    local wan_folder=`gen_wanconn_folder $wan_path`
    local up_state=`is_ip6_wan_up $wan_folder`
    echo -n $up_state
}
check_wan_is_up_by_path()
{
    local wan_path=$1
    local v4_wan_is_up=`check_ipv4_wan_is_up_by_path $wan_path`
    local v6_wan_is_up=`check_ipv6_wan_is_up_by_path $wan_path`
    if [ $v4_wan_is_up -eq 0 -a $v6_wan_is_up -eq 0 ]; then
        echo -n 0
    else
        echo -n 1
    fi
}

get_ip6_wan_gw()
{
    if [ $# -lt 1 ]; then
        echo -n ""
        return
    fi

    local _wan=$1
    if [ -z "${_wan}" ]; then
        echo -n ""
        return
    fi

    local file_gw="/tmp/${_wan}/${IP6_GATEWAY_FILE}"

    if [ -f "${file_gw}" ]; then
        cat ${file_gw}
    else
        local file_gw="/tmp/${_wan}/${PPP6_LLREMOTE}"
        if [ -f "${file_gw}" ]; then
            cat ${file_gw}
        else
            echo -n ""
        fi
        echo -n ""
    fi
}

get_ip6_wan_dns()
{
    if [ $# -lt 1 ]; then
    	echo -n ""
		return
    fi

    local _wan=$1
	if [ -z "${_wan}" ]; then
    	echo -n ""
		return
	fi

	local file_dns="/tmp/${_wan}/${IP6_USER_DEFINED_DNS}"

	if [ ! -f "${file_dns}" ]; then
		local file_dns="/tmp/${_wan}/${IP6_SERVER_ASSIGNED_DNS}"
	fi

    if [ -f "${file_dns}" ]; then
		cat ${file_dns} | tr "\n" " " | xargs echo -n | tr " " ","
	else
		echo -n ""
    fi
}

get_ip6_wan_first_dns()
{
    if [ $# -lt 1 ]; then
    	echo -n ""
		return
    fi

    local _wan=$1
	if [ -z "${_wan}" ]; then
    	echo -n ""
		return
	fi

	local file_dns="/tmp/${_wan}/${IP6_USER_DEFINED_DNS}"

	if [ ! -f "${file_dns}" ]; then
		local file_dns="/tmp/${_wan}/${IP6_SERVER_ASSIGNED_DNS}"
	fi

    if [ -f "${file_dns}" ]; then
		sed -n '1p' "${file_dns}"
	else
		echo -n ""
    fi
}

get_ip6_wan_second_dns()
{
    if [ $# -lt 1 ]; then
    	echo -n ""
		return
    fi

    local _wan=$1
	if [ -z "${_wan}" ]; then
    	echo -n ""
		return
	fi

	local file_dns="/tmp/${_wan}/${IP6_USER_DEFINED_DNS}"

	if [ ! -f "${file_dns}" ]; then
		local file_dns="/tmp/${_wan}/${IP6_SERVER_ASSIGNED_DNS}"
	fi

    if [ -f "${file_dns}" ]; then
		sed -n '2p' "${file_dns}"
	else
		echo -n ""
    fi
}

get_random_EUI64()
{
	local tmp_id=
	tmp_id=`cat /proc/sys/kernel/random/uuid`
	tmp_id=${tmp_id##*-}
	tmp_id="02 ${tmp_id:2:2} ${tmp_id:4:2} FF FE ${tmp_id:6:2} ${tmp_id:8:2} ${tmp_id:10:2}"
	printf "::%2s%2s:%2s%2s:%2s%2s:%2s%2s" `echo ${tmp_id}`
}



#对于INTERNET类型桥,需要判断是否需要转发lan侧dhcp请求，保证lan侧dhcp请求要么到本地，要么到wan端，不会lan/wan都有一份
dhcp_transparent()
{
    local wan_ifname=$1
    local laninterface="$(cfgcmd get ${path}X_CT-COM_LanInterface)"
    local if_list=$(get_interface_list ${laninterface})
    local X_TRI_DhcpTransparent=`cfgcmd get ${path}X_TRI_DhcpTransparent`

    if [ "${X_TRI_DhcpTransparent}" == "1" -a -n "${if_list}" ]; then
        for i in ${if_list}
        do               
            ebtables -A INPUT -i ${i} -p IPv4 --ip-proto 17 --ip-dport 67 -j DROP
            #ebtables -A INPUT -i ${i} -p IPv6 --ip6-proto 17 --ip6-destination-port 546 -j DROP
            #ebtables -A INPUT -i ${i} -p IPv6 --ip6-protocol 58 --ip6-icmp-type router-advertisement -j DROP
            #echo "#!/bin/sh" > ${script_ip_down_path}/dhcp_transparent.sh
            echo "ebtables -D INPUT -i ${i} -p IPv4 --ip-proto 17 --ip-dport 67 -j DROP" >> ${script_ip_down_path}/dhcp_transparent.sh
            #echo "ebtables -D INPUT -i ${i} -p IPv6 --ip6-proto 17 --ip6-destination-port 546 -j DROP" >> ${script_ip_down_path}/dhcp_transparent.sh
            #echo "ebtables -D INPUT -i ${i} -p IPv6 --ip6-protocol 58 --ip6-icmp-type router-advertisement -j DROP" >> ${script_ip_down_path}/dhcp_transparent.sh
            chmod +x ${script_ip_down_path}/dhcp_transparent.sh
        done
    else
        ebtables -I FORWARD -p IPv4 -o ${wan_ifname} --ip-proto 17 --ip-dport 67 -j DROP
        #ebtables -A FORWARD -p IPv6 -o ${wan_ifname} --ip6-proto 17 --ip6-destination-port 546 -j DROP
        #ebtables -A FORWARD -p IPv6 -o ${wan_ifname} --ip6-protocol 58 --ip6-icmp-type router-advertisement -j DROP
        echo "#!/bin/sh" > ${script_ip_down_path}/dhcp_transparent.sh              
        echo "ebtables -D FORWARD -p IPv4 -o ${wan_ifname} --ip-proto 17 --ip-dport 67 -j DROP" >> ${script_ip_down_path}/dhcp_transparent.sh
        #echo "ebtables -D FORWARD -p IPv6 -o ${wan_ifname} --ip6-proto 17 --ip6-destination-port 546 -j DROP" >> ${script_ip_down_path}/dhcp_transparent.sh
        #echo "ebtables -D FORWARD -p IPv6 -o ${wan_ifname} --ip6-protocol 58 --ip6-icmp-type router-advertisement -j DROP" >> ${script_ip_down_path}/dhcp_transparent.sh
        chmod +x ${script_ip_down_path}/dhcp_transparent.sh
    fi
}





# $1: conn path
adjust_conn_path()
{
	echo $1 | cut -d '.' -f 1-7
}

# $1: wcd path
get_dsl_l2mode()
{
	local wcd_path=$1
    local WCD_Ptm_Enable=$(cfgcmd get ${wcd_path}WANPTMLinkConfig.Enable)
    local WCD_Atm_Enable=$(cfgcmd get ${wcd_path}WANDSLLinkConfig.Enable)
	
	if [ "${WCD_Ptm_Enable}" == "1" ]; then
		echo "ptm"
	elif [ "${WCD_Atm_Enable}" == "1" ]; then
		echo "atm"
	else
		echo "none"
	fi
}

# $1: wcd path
get_atm_ifname()
{
	local wcd_path=$1
	local dest=$(cfgcmd get  ${wcd_path}WANDSLLinkConfig.DestinationAddress)
	local PVC=`echo ${dest} | cut -d ':' -f 2`
	local vpi=`echo ${PVC} | cut -d '/' -f 1`
	local vci=`echo ${PVC} | cut -d '/' -f 2`
	local ifname=$(gen_connifname "${vpi}" "${vci}")
	echo ${ifname}
}

# $1: conn path
get_dsl_ifname()
{
	local conn_path=`adjust_conn_path $1`
	local wcd_path=`get_wanconn_inst_path ${conn_path}`
	local l2mode=`get_dsl_l2mode ${wcd_path}`
	local ifname=""

	if [ "${l2mode}" == "atm" ]; then
		ifname=`get_atm_ifname ${wcd_path}`
	elif [ "${l2mode}" == "ptm" ]; then
		ifname=${PTM_IFNAME}
	fi

	echo ${ifname}
}


#名称：is_Bridged_Conn
#描述：判断是否为桥连接
#输入：$1 - wan path，必须带点号，比如InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.
#返回：1-是桥连接，0-不是桥连接
is_Bridged_Conn()
{
	local conn_path=$1
	local conn_type=""
	local existed=0

	existed=`cfgcmd check_obj ${conn_path}ConnectionType`
	if [ ${existed} -eq -1 ]; then
		TGP_Log ${TGP_LOG_ERROR} "is_Bridged_Conn():${conn_path}ConnectionType is not existed"
		echo -n 0;
		return
	fi

	conn_type=`cfgcmd get ${conn_path}ConnectionType`
	if [ "${conn_type}" == "PPPoE_Bridged" -o "${conn_type}" == "IP_Bridged" -o "${conn_type}" == "Con_Bridged" ]; then
		echo -n 1;
	else
		echo -n 0;
	fi
}


setcap_lock_flag=`expr /tmp/setcap_lock_flag`
setcap_lock()
{
    while ! mkdir ${setcap_lock_flag} > /dev/null 2>&1;
    do
        usleep 100
    done
}

setcap_unlock()
{
    rm -rf ${setcap_lock_flag}
}

flush_hs_conntrack_entries()
{
    setcap_lock

	#flash hardware and software conntrack entries
	local cap=`cs_cli /home/cli/debug/app/res/getcap -v srvname napt | grep cap | awk '{ print "0x"$4}'`
	cs_cli /home/cli/debug/app/res/setcap -v srvname napt cap 0
	conntrack -F
	cs_cli /home/cli/debug/app/res/setcap -v srvname napt cap $cap

    setcap_unlock
}

gen_down_script_with_mc()
{
    local script=$1
    local act=$2
    local wan_path=$3

    echo "#!/bin/sh" > ${script}
    echo "/usr/syscfg/mc_snooping.sh action=${act} path=${wan_path}" >> ${script}
    echo "/usr/syscfg/mc_proxy.sh action=${act} path=${wan_path}" >> ${script}
    echo "/usr/syscfg/igmp_mld_init.sh action=${act} path=${wan_path}" >> ${script}

    chmod +x ${script}
}

other_wan_mc_setting()
{
    local script_path=$1
    local wan_path=$2

    gen_down_script_with_mc "${script_path}/600.mc_down.sh" "if_down" ${wan_path}
    /usr/syscfg/if_hotplug/600.mc.sh action=ifup path=${wan_path}
}

get_net_from_ip()
{
	ip_addr=$1
	mask=$2
	ip_str="`echo ${ip_addr} | tr "." " "`"
	ip_hex=`printf "%02X%02X%02X%02X" ${ip_str}`

	mask_str="`echo ${mask} | tr "." " "`"
	mask_hex=`printf "%02X%02X%02X%02X" ${mask_str}`

	ip_o=`printf "%08X" $((0x${mask_hex}&0x${ip_hex}))`
	ip_s=`printf "%d.%d.%d.%d" 0x${ip_o:0:2} 0x${ip_o:2:2} 0x${ip_o:4:2} 0x${ip_o:6:2}`
	echo $ip_s
}

search_str_from()
{
    local checkStr=$1
    local searchStr=$2

    result=`echo ${checkStr} | grep ${searchStr}`
    if [ -z "${result}" ]; then
        echo -n 0;
    else
        echo -n 1;
    fi
}

get_bridge_wan()
{
	local path=""
	local IPConn_folder=`expr "/tmp/IP_*"`
	local PPPConn_folder=`expr "/tmp/PPP_*"`

	for conn_dir in ${IPConn_folder} ${PPPConn_folder}
	do
		conn_path=""
		if [ -f ${conn_dir}/path ]; then
			conn_path=`cat ${conn_dir}/path`
		fi
		if [ -n "${conn_path}" ]; then
			local wan_is_bridged=`is_Bridged_Conn $conn_path`
			if [ $wan_is_bridged -eq 1 ]; then
				if [ -n "${path}" ]; then
					path="${path},${conn_path}"
				else
					path="${conn_path}"
				fi
			fi
		fi
	done
	echo "${path}"
}


# ExistedDefaultGateway
# 描述：判断存在默认网关
# 输入：无
# 返回：1-存在，0-不存在
ExistedDefaultGateway()
{
    local result=""    

    # ipv4默认网关查找
    result=`ip route |grep default`
    if [ -n "${result}" ]; then
        echo -n 1
        return
    fi

    # ipv6默认网关查找
    result=`ip -6 route |grep default`
    if [ -n "${result}" ]; then
        echo -n 1
        return
    fi

    #都没有找到返回0
    echo -n 0
}

# get_uplink_line_state
# 描述：返回上行口状态
# 输入：无
# 返回：0: DSL,Ethernet all link down
#		1: DSL Link up
#		2: Ethernet Link up
#		3: DSL,Ethernet all link up
get_uplink_line_state()
{
	local ret=0

	wanDevs=`cfgcmd get_idxes InternetGatewayDevice.WANDevice.`
	
	for i in ${wanDevs} ; do
		wanTypeStr=`cfgcmd get InternetGatewayDevice.WANDevice.$i.WANCommonInterfaceConfig.WANAccessType`
		case "${wanTypeStr}" in
			"Ethernet")
				state=`cfgcmd get InternetGatewayDevice.WANDevice.$i.WANEthernetInterfaceConfig.Status`
				if [ "${state}" == "Up" ]; then
					let "ret=$ret+2"
				fi
				;;
			"DSL")
				state=`cfgcmd get InternetGatewayDevice.WANDevice.$i.WANDSLInterfaceConfig.Status`
				if [ "${state}" == "Up" ]; then
					let "ret=$ret+1"
				fi
				;;
			"Dongle")
				;;
			*)
				echo "WARR: get_uplink_line_state() fail, can not get the WANAccessType!!!"
				;;
		esac
	done

	echo -n $ret
}



start_dual_lan_routed_normal_pppoe()
{
    local dl_path="$(cfgcmd get ${path}X_TRI_UnnumberLanPath)"
    local dl_en="$(cfgcmd get ${path}X_TRI_UnnumberEn)"


    if [ "${dl_en}" == "0" -o "${dl_path}" == "" ]; then
        return
    fi

    local pppoeip="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.IpAddr)"
    local lanip="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.IpUnnumberedAddr)"
    local lanmask="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.IpUnnumberedMask)"
    local lanstartip="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.LanStartIp)"
    local lanendip="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.LanEndIp)"
    local pridns="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.PrimaryDns)"
    local secdns="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.SecondaryDns)"
    local lanport="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.LanPort)"
    local wanconnpath="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.WanConnPath)"
    local lanname="$(cfgcmd get ${dl_path}BridgeName)"
    local if_list=$(get_interface_list ${lanport})

    # export by ip_up.sh
    local pppoe_dev="${IFNAME}"
    local remoteip="${IPREMOTE}"

    # skip SNAT for unnumbered lan -> PPPoE wan pkt 
    iptables  -t nat -A ${DUALLAN_NAT_CHAIN} --source ${lanip}/${lanmask} -o ${pppoe_dev} -j ACCEPT

    # accept PPPoE wan -> unnumbered lan pkt
    iptables -t filter -A ${DUALLAN_FILTER_CHAIN} -i ${pppoe_dev} --dst ${lanip}/${lanmask} -j ACCEPT

    # accept PPPoE wan -> unnumbered interface pkt
    iptables -t filter -A service_list -i ${pppoe_dev} --dst ${lanip} -j ACCEPT

    # add route
    local lan_root_path="InternetGatewayDevice.LANDevice.1"
    local hostCfgMgmt_path="${lan_root_path}.LANHostConfigManagement"
    local i_path="${hostCfgMgmt_path}.IPInterface.1"  
    local br0_ip="$(cfgcmd get ${i_path}.IPInterfaceIPAddress)"
    local br0_nm="$(cfgcmd get ${i_path}.IPInterfaceSubnetMask)"
    local br0_lannet=$(get_net_from_ip $br0_ip $br0_nm)
    local dl_lannet=$(get_net_from_ip $lanip $lanmask)

    local tbl_idx="$(ip rule show | grep fwmark | awk -F 'lookup' '{print $2}')"   # " 201"

    if [ "${tbl_idx}" != "" ]; then
        for id in $tbl_idx
        do
            ip route add ${dl_lannet}/${lanmask} dev ${lanname} table ${id}
            ip route add ${br0_lannet}/${br0_nm} dev br0 table ${id}
        done
    fi

    # disable HW accel to workaround PPPoE wan -> unnumber lan TCP traffic fail:
    # unnumber lan -> PPPoE wan direction will be NAT
    #cs_cli /home/cli/debug/app/res/setcap napt 0

    #  change FWD 2 to remove napt
    cs_cli /home/cli/api/intf/setfwd -v ifname ${ifname} fwd 2
    #  change FWD 0 to add pppoe header
    cs_cli /home/cli/api/intf/setfwd -v ifname ${ifname} fwd 0

}


stop_dual_lan_routed_normal_pppoe()
{
    local ppp_dir="$(dirname ${uptime_file_path})"
    local duallanpath_file=${ppp_dir}/duallanpath

    if [ ! -f ${duallanpath_file} ]; then
        return
    fi

    local dl_path=`cat ${duallanpath_file}`

    local pppoeip="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.IpAddr)"
    local lanip="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.IpUnnumberedAddr)"
    local lanmask="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.IpUnnumberedMask)"
    local lanstartip="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.LanStartIp)"
    local lanendip="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.LanEndIp)"
    local pridns="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.PrimaryDns)"
    local secdns="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.SecondaryDns)"
    local lanport="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.LanPort)"
    local wanconnpath="$(cfgcmd get ${dl_path}X_TRI_DualLanCfg.WanConnPath)"
    local lanname="$(cfgcmd get ${dl_path}BridgeName)"
    
    local if_list=$(get_interface_list ${lanport})

    # skip SNAT for unnumbered lan pkt 
    local pppoe_dev=""
    local remoteip=""

    # export by ip_up.sh
    local pppoe_dev="${IFNAME}"
    local remoteip="${IPREMOTE}"

    # skip SNAT for unnumbered lan -> PPPoE wan pkt 
    iptables  -t nat -D ${DUALLAN_NAT_CHAIN}  --source ${lanip}/${lanmask} -o ${pppoe_dev} -j ACCEPT

    # accept PPPoE wan -> unnumbered lan pkt
    iptables -t filter -D ${DUALLAN_FILTER_CHAIN} -i ${pppoe_dev} --dst ${lanip}/${lanmask} -j ACCEPT

    # accept PPPoE wan -> unnumbered interface pkt
    iptables -t filter -D service_list -i ${pppoe_dev} --dst ${lanip} -j ACCEPT

    # delete route, table 20x only exist after wan connection
    local lan_root_path="InternetGatewayDevice.LANDevice.1"
    local hostCfgMgmt_path="${lan_root_path}.LANHostConfigManagement"
    local i_path="${hostCfgMgmt_path}.IPInterface.1"  
    local br0_ip="$(cfgcmd get ${i_path}.IPInterfaceIPAddress)"
    local br0_nm="$(cfgcmd get ${i_path}.IPInterfaceSubnetMask)"
    local br0_lannet=$(get_net_from_ip $br0_ip $br0_nm)
    local dl_lannet=$(get_net_from_ip $lanip $lanmask)

    local tbl_idx="$(ip rule show | grep fwmark | awk -F 'lookup' '{print $2}')"   # " 201"
    if [ "${tbl_idx}" != "" ]; then
        for id in $tbl_idx
        do
            ip route del ${dl_lannet}/${lanmask} dev ${lanname} table ${id}
            ip route del ${br0_lannet}/${br0_nm} dev br0 table ${id}
        done
    fi

    # disable HW accel to workaround PPPoE wan -> unnumber lan TCP traffic fail:
    #   unnumber lan -> PPPoE wan direction will be NAT always
    #cs_cli /home/cli/debug/app/res/setcap napt 3
    cs_cli /home/cli/api/intf/setfwd -v ifname ${ifname} fwd 1
}


start_dual_lan_routed_normal_pppoe_v6()
{
    local dl_path="$(cfgcmd get ${path}X_TRI_UnnumberLanPath)"
    local dl_en="$(cfgcmd get ${path}X_TRI_UnnumberEn)"

    if [ "${dl_en}" == "0" -o "${dl_path}" == "" ]; then
        return
    fi

    local duallan_list=`brctl show  | grep ipunnum | awk '{print $1}'`

    if [ "${duallan_list}" == "" ]; then
        return
    fi

    for lan in ${duallan_list}
    do
        /usr/syscfg/radvd.sh set ${lan}
        # unnumbered lan is exported to wan 
        ip6tables -t filter -I wan_filter -o ${lan} -j ACCEPT
    done

    # add policy route for port bounding
    local tbl_idx="$(ip rule show | grep fwmark | awk -F 'lookup' '{print $2}')"   # " 201"
    local br0_net=`ifconfig br0 | grep "Scope:Global" | awk '{print $3}'`

    if [ "${tbl_idx}" != "" ]; then
        for id in $tbl_idx
        do
            for lan in ${duallan_list}
            do
                local unnum_net=`ifconfig ${lan} | grep "Scope:Global" | awk '{print $3}'`
                ip -6 route add ${unnum_net} dev ${lan} table ${id}
            done

            ip -6 route add ${br0_net} dev br0 table ${id}
        done
    fi
    # request from unnumbered lan -> lan is forbidden
    ip6tables -t filter -A ${DUALLAN_FILTER_CHAIN} -i bripunnum+ -o br+ -m state --state NEW -j REJECT

}

stop_dual_lan_routed_normal_pppoe_v6()
{
    local ppp_dir="$(dirname ${uptime_file_path})"
    local duallanpath_file=${ppp_dir}/duallanpath

    if [ ! -f ${duallanpath_file} ]; then
        return
    fi

    local duallan_list=`brctl show  | grep ipunnum | awk '{print $1}'`

    if [ "${duallan_list}" == "" ]; then
        return
    fi

    for lan in ${duallan_list}
    do
        /usr/syscfg/radvd.sh set ${lan}
        ip6tables -t filter -D wan_filter -o ${lan} -j ACCEPT
    done

    # delete policy route for port bounding
    local tbl_idx="$(ip rule show | grep fwmark | awk -F 'lookup' '{print $2}')"   # " 201"
    local br0_net=`ifconfig br0 | grep "Scope:Global" | awk '{print $3}'`

    if [ "${tbl_idx}" != "" ]; then
        for id in $tbl_idx
        do
            for lan in ${duallan_list}
            do
                local unnum_net=`ifconfig ${lan} | grep "Scope:Global" | awk '{print $3}'`
                ip -6 route delete ${unnum_net} dev ${lan} table ${id}
            done

            ip -6 route delete ${br0_net} dev br0 table ${id}
        done
    fi

    ip6tables -t filter -D ${DUALLAN_FILTER_CHAIN} -i bripunnum+ -o br+ -m state --state NEW -j REJECT
}

