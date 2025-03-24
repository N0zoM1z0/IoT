#!/bin/sh
. /usr/syscfg/api_log.sh
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/ebtables.param.sh

HextoDec()
{
   local index=$1

   case $index in
      "a")
        index=10
      ;;
      "b")
        index=11
      ;;
      "c")
        index=12
      ;;
      "d")
        index=13
      ;;
      "e")
        index=14
      ;;
      "f")
        index=15
      ;;
   esac
   echo $index
}



gen_stop_script_laninterface_policy_routing_ipv4()
{
    local script=$1
    local wan_ifname=$2
    local mark=$3
    local table_id=$4
    local laninterface=$5
    local if_list=""

    echo "#!/bin/sh" > ${script}
    echo ". /usr/syscfg/api_log.sh" >> ${script}
    echo 'TGP_Log ${TGP_LOG_WARNING} "I am been run"' >> ${script}
    

    #laninterface可能为空
    if [ "${laninterface}" != "" ]; then
        if_list=$(get_interface_list ${laninterface})
        echo "ip rule del fwmark ${mark} table ${table_id}" >>${script}
        echo "ip route flush table ${table_id}" >>${script}

        echo "ebtables -t broute -D ${SETMARK_CHAIN} -j ${SETMARK_CHAIN}_${wan_ifname}" >>${script}
        echo "ebtables -t broute -F ${SETMARK_CHAIN}_${wan_ifname}" >>${script}
        echo "ebtables -t broute -X ${SETMARK_CHAIN}_${wan_ifname}" >>${script}
    fi
    
    echo "iptables -t filter -D ${BIND_POLICY_CHAIN} -o ${wan_ifname} -j ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}" >>${script}
    echo "iptables -t filter -F ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}" >>${script}
    echo "iptables -t filter -X ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}" >>${script}
    for i in $if_list
    do
        echo "ebtables -t filter -D EBTABLES_BIND_POLICY_DEFAULT --in-if ${i} -j DROP" >>${script}
        echo "ebtables -t filter -D EBTABLES_BIND_POLICY_DEFAULT --out-if ${i} -j DROP" >>${script}
        echo "iptables -t filter -D IP_BIND_POLICY_DEFAULT -m physdev --physdev-in ${i} -j DROP" >>${script}        
    done

    chmod +x ${script}
}



laninterface_policy_routing_ipv4()
{
    local path=$1
    local conn_folder=`gen_wanconn_folder $path`
    local wan_ifname=`get_wanconn_ifname $conn_folder`
    local gateway=`get_wan_gw $conn_folder`
    local laninterface=`cfgcmd get ${path}X_CT-COM_LanInterface`
    local if_list=""
    local handle_index=0
    lanmask=`ifconfig br0 | grep Mask | awk '{print $4}' | cut -d ":" -f 2`
    lanip=`ifconfig br0 | grep "inet addr" | awk '{print $2}' | cut -d : -f 2`
    lannet=$(get_net_from_ip $lanip $lanmask)

    script_ip_down_path=`expr /tmp/${conn_folder}"/script/ip_down"`
    
    TGP_Log ${TGP_LOG_WARNING} "conn_folder=$conn_folder, wan_ifname=$wan_ifname, laninterface=$laninterface, gateway=$gateway, script_ip_down_path=$script_ip_down_path"

    if [ -x "${script_ip_down_path}/${laninterface_policy_routing_ipv4_script}" ]; then
        TGP_Log ${TGP_LOG_ERROR} "${script_ip_down_path}/${laninterface_policy_routing_ipv4_script} is existed!"
    fi

    #laninterface不为空时生成策略路由
    if [ "${laninterface}" != "" ]; then
        if_list=$(get_interface_list ${laninterface})
        handle_index=$(get_handle_index ${laninterface})
        local mark="0x${handle_index}000"
        local index=$(HextoDec $handle_index)
        local table_id=`expr 200 + $index`

        ip route add default via ${gateway} dev ${wan_ifname} table ${table_id}

        ip route add $lannet/$lanmask dev br0 table ${table_id}
        
        ip rule add fwmark ${mark}/0xf000 table ${table_id}

        ebtables -t broute -N ${SETMARK_CHAIN}_${wan_ifname}
        ebtables -t broute -P ${SETMARK_CHAIN}_${wan_ifname} RETURN
        ebtables -t broute -A ${SETMARK_CHAIN} -j ${SETMARK_CHAIN}_${wan_ifname}
    fi


    gen_stop_script_laninterface_policy_routing_ipv4 "${script_ip_down_path}/${laninterface_policy_routing_ipv4_script}" ${wan_ifname} ${mark} ${table_id} "$laninterface"
    iptables -t filter -N ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}
    #add this rule for pppoe proxy
    iptables -t filter -A ${BIND_POLICY_CHAIN}_OUT_${wan_ifname} -i ppp+ -j RETURN
    for i in ${if_list}
    do
        iptables -t filter -A ${BIND_POLICY_CHAIN}_OUT_${wan_ifname} -m physdev --physdev-in ${i} -j RETURN
        ebtables -t filter -A EBTABLES_BIND_POLICY_DEFAULT --in-if ${i} -j DROP
        ebtables -t filter -A EBTABLES_BIND_POLICY_DEFAULT --out-if ${i} -j DROP
        iptables -t filter -A IP_BIND_POLICY_DEFAULT -m physdev --physdev-in ${i} -j DROP

        ebtables -t broute -A ${SETMARK_CHAIN}_${wan_ifname} --in-if ${i} -j mark --mark-or ${mark} --mark-target CONTINUE
    done
    iptables -t filter -A ${BIND_POLICY_CHAIN}_OUT_${wan_ifname} -j IP_BIND_POLICY_DEFAULT
    iptables -t filter -A ${BIND_POLICY_CHAIN} -o ${wan_ifname} -j ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}
}

gen_stop_script_laninterface_policy_routing_ipv6()
{
    local script=$1
    local wan_ifname=$2
    local mark=$3
    local table_id=$4
    local laninterface=$5
    local if_list=""

    echo "#!/bin/sh" > ${script}
    echo ". /usr/syscfg/api_log.sh" >> ${script}
    echo 'TGP_Log ${TGP_LOG_WARNING} "I am been run"' >> ${script}

    #laninterface可能为空
    if [ "${laninterface}" != "" ]; then
        if_list=$(get_interface_list ${laninterface})
        echo "ip -6 rule del fwmark ${mark} table ${table_id}" >>${script}
        echo "ip -6 route flush table ${table_id}" >>${script}

        echo "ebtables -t broute -D ${SETMARK_CHAIN} -j ${SETMARK_CHAIN}_${wan_ifname}" >>${script}
        echo "ebtables -t broute -F ${SETMARK_CHAIN}_${wan_ifname}" >>${script}
        echo "ebtables -t broute -X ${SETMARK_CHAIN}_${wan_ifname}" >>${script}
    fi


    echo "ip6tables -t filter -D ${BIND_POLICY_CHAIN} -o ${wan_ifname} -j ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}" >>${script}
    echo "ip6tables -t filter -F ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}" >>${script}
    echo "ip6tables -t filter -X ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}" >>${script}
    for i in $if_list
    do
        echo "ebtables -t filter -D EBTABLES_BIND_POLICY_DEFAULT --in-if ${i} -j DROP" >>${script}
        echo "ebtables -t filter -D EBTABLES_BIND_POLICY_DEFAULT --out-if ${i} -j DROP" >>${script}
        echo "ip6tables -t filter -D IP6_BIND_POLICY_DEFAULT -m physdev --physdev-in ${i} -j DROP" >>${script}      
    done

    chmod +x ${script}
}

laninterface_policy_routing_ipv6()
{
    local path=$1
    local conn_folder=`gen_wanconn_folder $path`
    local wan_ifname=`get_wanconn_ifname $conn_folder`
    local gateway6=`get_ip6_wan_gw $conn_folder`
    local laninterface=`cfgcmd get ${path}X_CT-COM_LanInterface`
    local if_list=""
    local handle_index=1
    script_ip_down_path=`expr /tmp/${conn_folder}"/script/ip_down"`

    TGP_Log ${TGP_LOG_WARNING} "conn_folder=$conn_folder, wan_ifname=$wan_ifname, laninterface=$laninterface, gateway6=$gateway6, script_ip_down_path=$script_ip_down_path"

    if [ -x "${script_ip_down_path}/${laninterface_policy_routing_ipv6_script}" ]; then
        TGP_Log ${TGP_LOG_ERROR} "${script_ip_down_path}/${laninterface_policy_routing_ipv6_script} is existed!"
    fi

    #laninterface可能为空
    if [ "${laninterface}" != "" ]; then
        if_list=$(get_interface_list ${laninterface})
        handle_index=$(get_handle_index ${laninterface})
        local mark="0x${handle_index}000"
        local index=$(HextoDec $handle_index)
        local table_id=`expr 200 + $index`
        ip -6 route add default via ${gateway6} dev ${wan_ifname} table ${table_id}
        ip -6 rule add fwmark ${mark}/0xf000 table ${table_id}

        ebtables -t broute -N ${SETMARK_CHAIN}_${wan_ifname}
        ebtables -t broute -P ${SETMARK_CHAIN}_${wan_ifname} RETURN
        ebtables -t broute -A ${SETMARK_CHAIN} -j ${SETMARK_CHAIN}_${wan_ifname}
    fi

    
    gen_stop_script_laninterface_policy_routing_ipv6 "${script_ip_down_path}/${laninterface_policy_routing_ipv6_script}" ${wan_ifname} ${mark} ${table_id} "$laninterface"
    ip6tables -t filter -N ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}
    #add this rule for pppoe proxy
    ip6tables -t filter -A ${BIND_POLICY_CHAIN}_OUT_${wan_ifname} -i ppp+ -j RETURN
    for i in ${if_list}
    do
        ip6tables -t filter -A ${BIND_POLICY_CHAIN}_OUT_${wan_ifname} -m physdev --physdev-in ${i} -j RETURN
        ebtables -t filter -A EBTABLES_BIND_POLICY_DEFAULT --in-if ${i} -j DROP
        ebtables -t filter -A EBTABLES_BIND_POLICY_DEFAULT --out-if ${i} -j DROP
        ip6tables -t filter -A IP6_BIND_POLICY_DEFAULT -m physdev --physdev-in ${i} -j DROP

        ebtables -t broute -A ${SETMARK_CHAIN}_${wan_ifname} --in-if ${i} -j mark --mark-or ${mark} --mark-target CONTINUE
    done
    ip6tables -t filter -A ${BIND_POLICY_CHAIN}_OUT_${wan_ifname} -j IP6_BIND_POLICY_DEFAULT
    ip6tables -t filter -A ${BIND_POLICY_CHAIN} -o ${wan_ifname} -j ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}
}


gen_stop_script_laninterface_policy_bridge()
{
    local script=$1
    local wan_ifname=$2
    local laninterface=$3
    local ServiceList=$4
    local if_list=""
    local if_mc_list=""

    #laninterface可能为空
    if [ "${laninterface}" != "" ]; then
        if_list=$(get_interface_list ${laninterface})
        if_mc_list=`get_interface_ext_list ${laninterface}`
    fi

    echo "#!/bin/sh" > ${script}
    echo ". /usr/syscfg/api_log.sh" >> ${script}
    echo 'TGP_Log ${TGP_LOG_WARNING} "I am been run"' >> ${script}
    echo "ebtables -t filter -D ${BIND_POLICY_CHAIN} --in-if ${wan_ifname} -j ${BIND_POLICY_CHAIN}_IN_${wan_ifname}" >>${script}
    echo "ebtables -t filter -D ${BIND_POLICY_CHAIN} --out-if ${wan_ifname} -j ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}" >>${script}
    echo "ebtables -t filter -F ${BIND_POLICY_CHAIN}_IN_${wan_ifname}" >>${script}
    echo "ebtables -t filter -F ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}" >>${script}
    echo "ebtables -t filter -X ${BIND_POLICY_CHAIN}_IN_${wan_ifname}" >>${script}
    echo "ebtables -t filter -X ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}" >>${script}
    for i in ${if_list}
    do
        echo "ebtables -t filter -D EBTABLES_BIND_POLICY_DEFAULT --in-if ${i} -j DROP" >>${script}
        echo "ebtables -t filter -D EBTABLES_BIND_POLICY_DEFAULT --out-if ${i} -j DROP" >>${script}
        echo "iptables -t filter -D IP_BIND_POLICY_DEFAULT -m physdev --physdev-in ${i} -j DROP" >>${script}
        echo "ip6tables -t filter -D IP6_BIND_POLICY_DEFAULT -m physdev --physdev-in ${i} -j DROP" >>${script}
    done

    if [ "${ServiceList}" == "OTHER" ]; then
        for i in ${if_list}
        do
            echo "brctl delif br1 ${i}" >>${script}
            echo "brctl addif br0 ${i}" >>${script}
        done
        for i in ${if_mc_list}
        do
            echo "cs_cli /home/cli/api/mc/del_member -v grpid 1 ifname ${i} upflag 0" >>${script}
            echo "cs_cli /home/cli/api/mc/add_member -v grpid 0 ifname ${i} upflag 0" >>${script}
        done
    fi

	# VOIP　TR069
    if [ "${ServiceList}" == "VOIP" -o "${ServiceList}" == "TR069" ]; then
		local conn_folder=`gen_wanconn_folder $path`
		local brIf="`cat /tmp/${conn_folder}/ConBrOutIf`"
        for i in ${if_list}
        do
            echo "brctl delif ${brIf} ${i}" >> ${script}
            echo "brctl addif br0 ${i}" >> ${script}
        done
	fi
    chmod +x ${script}
}

#桥连接端口绑定处理
laninterface_policy_bridge()
{
    local path=$1
    local conn_folder=`gen_wanconn_folder $path`
    local wan_ifname=`get_wanconn_ifname $conn_folder`
    local laninterface=`cfgcmd get ${path}X_CT-COM_LanInterface`
    local ServiceList=`cfgcmd get ${path}X_CT-COM_ServiceList`
    local brIf="br1" #other bridge
    local if_list=""
    local if_mc_list=""
    script_ip_down_path=`expr /tmp/${conn_folder}"/script/ip_down"`

    TGP_Log ${TGP_LOG_WARNING} "conn_folder=$conn_folder, wan_ifname=$wan_ifname, laninterface=$laninterface, ServiceList=$ServiceList, script_ip_down_path=$script_ip_down_path"

    #laninterface可能为空
    if [ "${laninterface}" != "" ]; then
        if_list=$(get_interface_list ${laninterface})
        if_mc_list=`get_interface_ext_list ${laninterface}`
    fi


    #生成stop脚本
    gen_stop_script_laninterface_policy_bridge "${script_ip_down_path}/${laninterface_bind_policy_script}" ${wan_ifname} "${laninterface}" ${ServiceList}

    
    # 新建wan口相关的链(比如BIND_POLICY_IN_ip_1_1_1)，并将这些链加入到BIND_POLICY中
    ebtables -t filter -N ${BIND_POLICY_CHAIN}_IN_${wan_ifname} -P RETURN
    ebtables -t filter -N ${BIND_POLICY_CHAIN}_OUT_${wan_ifname} -P RETURN
    ebtables -t filter -A ${BIND_POLICY_CHAIN} --in-if ${wan_ifname} -j ${BIND_POLICY_CHAIN}_IN_${wan_ifname}
    ebtables -t filter -A ${BIND_POLICY_CHAIN} --out-if ${wan_ifname} -j ${BIND_POLICY_CHAIN}_OUT_${wan_ifname}
    
    # 1. 将所有绑定的端口加入到wan口相关的链(比如BIND_POLICY_IN_ip_1_1_1)，默认accept
    # 2. 将所有绑定的端口加入EBTABLES_BIND_POLICY_DEFAULT, IP_BIND_POLICY_DEFAULT, IP6_BIND_POLICY_DEFAULT，默认drop
    for i in ${if_list}
    do
        ebtables -t filter -A ${BIND_POLICY_CHAIN}_IN_${wan_ifname} --out-if ${i} -j ACCEPT
        ebtables -t filter -A ${BIND_POLICY_CHAIN}_OUT_${wan_ifname} --in-if ${i} -j ACCEPT
        ebtables -t filter -A EBTABLES_BIND_POLICY_DEFAULT --in-if ${i} -j DROP
        ebtables -t filter -A EBTABLES_BIND_POLICY_DEFAULT --out-if ${i} -j DROP
        iptables -t filter -A IP_BIND_POLICY_DEFAULT -m physdev --physdev-in ${i} -j DROP
        ip6tables -t filter -A IP6_BIND_POLICY_DEFAULT -m physdev --physdev-in ${i} -j DROP
    done

    # EBTABLES_BIND_POLICY_DEFAULT必须加入到wan口相关的链(比如BIND_POLICY_IN_ip_1_1_1)的最后
    ebtables -t filter -A ${BIND_POLICY_CHAIN}_IN_${wan_ifname} -j EBTABLES_BIND_POLICY_DEFAULT
    ebtables -t filter -A ${BIND_POLICY_CHAIN}_OUT_${wan_ifname} -j EBTABLES_BIND_POLICY_DEFAULT

	# VOIP　TR069
    if [ "${ServiceList}" == "VOIP" -o "${ServiceList}" == "TR069" ]; then
		brIf="`cat /tmp/${conn_folder}/ConBrOutIf`"
    fi
    for i in ${if_list}
    do
        brctl delif br0 ${i}
        brctl addif ${brIf} ${i}
    done
}



##################################################### main ############################################
port_binding_lock_path=/var/tgp/lock/port_binding

#waiting for dns operation unlock
while [ -f ${port_binding_lock_path} ]; do
    usleep 100
done
#lock dns operation
touch ${port_binding_lock_path}

TGP_Log ${TGP_LOG_WARNING} "path=$1, mode=$2"
case "${2}" in
    "bridge")
        laninterface_policy_bridge $1
        ;;
    "ipv4")
        laninterface_policy_routing_ipv4 $1
        ;;
    "ipv6")
        laninterface_policy_routing_ipv6 $1
        ;;
    *)
        #Unknow
        ;;
esac

ebtables -L EBTABLES_BIND_POLICY_DEFAULT >/tmp/dnsmasq_ebtables
rm ${port_binding_lock_path}
