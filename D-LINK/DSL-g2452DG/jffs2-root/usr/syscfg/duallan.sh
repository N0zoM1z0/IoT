#!/bin/sh
. /usr/syscfg/wan.comm.param.sh
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/api_log.sh
. /usr/syscfg/firewall.param.sh

path=$1
action=$2

duallan_help()
{
	echo "-------------------------------------------------------"
	echo "Usage: `basename $0` <string path> <action start|stop>"
	echo "-------------------------------------------------------"
}

get_eth_list()
{
    local path_list=$1 
    local if_list=""
    local if_name=""
    local i=1
    local eth_cnt=4

    while [ $i -le $eth_cnt ] 
    do
        if_name="$(cfgcmd get ${path_list}.${i}.Name)"
        if [ -n "${if_name}" ]; then
            if_list="${if_list} ${if_name}"
        fi
        i=`expr $i + 1` 
    done

    echo "${if_list}"
}

duallan_stop()
{
    # get from /tmp/PPP_1_1_1/duallanpath
    local dl_path="${path}"
    local lanname="$(cfgcmd get ${dl_path}BridgeName)"
    local lan_dir="/tmp/${lanname}"
    local cfg_bk="${lan_dir}/cfg.bk"

    if [ ! -f ${cfg_bk} ]; then
        echo "Can't find dual lan cfg file ${cfg_bk} !!!!!!!!!!"
        return
    fi

    # restore dual lan cfg
    local pppoeip="$(cat ${cfg_bk} | grep "pppoeip" | awk '{print $2}')"
    local lanip="$(cat ${cfg_bk} | grep "lanip" | awk '{print $2}')"
    local lanmask="$(cat ${cfg_bk} | grep "lanmask" | awk '{print $2}')"
    local lanstartip="$(cat ${cfg_bk} | grep "lanstartip" | awk '{print $2}')"
    local lanendip="$(cat ${cfg_bk} | grep "lanendip" | awk '{print $2}')"
    local pridns="$(cat ${cfg_bk} | grep "pridns" | awk '{print $2}')"
    local secdns="$(cat ${cfg_bk} | grep "secdns" | awk '{print $2}')"
    local wanconnpath="$(cat ${cfg_bk} | grep "wanconnpath" | awk '{print $2}')"
    local if_list="$(cat ${cfg_bk} | grep "if_list" | awk -F '=' '{print $2}')"
    local lanname_1="$(cat ${cfg_bk} | grep "lanname" | awk '{print $2}')"
    local br0_network="$(cat ${cfg_bk} | grep "br0_network" | awk '{print $2}')"
    
    if [ "${lanname}" != "${lanname_1}" ]; then
        echo "wrong dual lan cfg in file ${cfg_bk} !!!!!!!!!!"
        return
    fi

    # stop dhcp
    local pid=`cat ${lan_dir}/udhcpd.pid`
    kill -9 ${pid} 
    rm -rf ${lan_dir}

    # rm bridge ports
    for i in ${if_list}
    do
        brctl delif ${lanname} ${i}
        brctl addif br0 ${i}
    done

    # unset ip and mask
    ifconfig ${lanname} down
    
    # remove IPTABLE rules
    iptables -t filter -D service_list -i ${lanname} -j ACCEPT
    iptables -t nat -D ${DUALLAN_NAT_CHAIN}  -s ${br0_network} -o ${lanname} -j SNAT --to-source  ${lanip}
    iptables -t filter -D ${DUALLAN_FILTER_CHAIN}  -s ${lanip}/${lanmask} -o br0  -m state --state NEW -j DROP

    # add bridge
    brctl delbr ${lanname}

    # delete route

    # del xml obj
    local del=$1
    if [ "${del}" == "1" ]; then
        cfgcmd  del_obj ${dl_path}
    fi

    # change fwd mode revert unnumbered lan->lan HW accel fail cfg
    local eth_list=$(get_eth_list InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig)
    local exist=""
    for i in ${eth_list}
    do
        exist=`echo ${if_list} | grep ${i}`
        # if not a unnumbered port, change fwd mode
        if [ "${exist}" == "" ]; then
            cs_cli /home/cli/api/intf/setfwd -v ifname ${i} fwd 0
        fi
    done
}

duallan_start()
{
    local dl_path="${path}"

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
    

    # if already started, stop first
    local up=`ifconfig ${lanname} 2>/dev/null | grep 'inet addr:'`
    if [ "${up}" != "" ]; then
        duallan_stop 0
    fi

    # add bridge
    brctl addbr ${lanname} 
    # add bridge ports
    for i in ${if_list}
    do
        brctl delif br0 ${i}
        brctl addif ${lanname} ${i} 
    done
    
    # set ip and mask
    ifconfig ${lanname} ${lanip} netmask ${lanmask} up

    local lan_dir="/tmp/${lanname}"
    mkdir -p ${lan_dir}
    # backup dual lan cfg
    echo "pppoeip ${pppoeip}" > ${lan_dir}/cfg.bk
    echo "lanip ${lanip}" >> ${lan_dir}/cfg.bk
    echo "lanmask ${lanmask}" >> ${lan_dir}/cfg.bk
    echo "lanstartip ${lanstartip}" >> ${lan_dir}/cfg.bk
    echo "lanendip ${lanendip}" >> ${lan_dir}/cfg.bk
    echo "pridns ${pridns}" >> ${lan_dir}/cfg.bk
    echo "secdns ${secdns}" >> ${lan_dir}/cfg.bk
    echo "wanconnpath ${wanconnpath}" >> ${lan_dir}/cfg.bk
    echo "lanname ${lanname}" >> ${lan_dir}/cfg.bk
    echo "if_list=${if_list}" >> ${lan_dir}/cfg.bk

    # prepare dhcp cfg file: udhcpd /tmp/udhcpd.conf
    touch ${lan_dir}/udhcpd.conf
    touch ${lan_dir}/udhcpd.leases
    touch ${lan_dir}/udhcpd.pid

    echo "server ${lanip}" >> ${lan_dir}/udhcpd.conf
    echo "start ${lanstartip}" >> ${lan_dir}/udhcpd.conf
    echo "end ${lanendip}" >> ${lan_dir}/udhcpd.conf
    echo "opt domain localhost" >> ${lan_dir}/udhcpd.conf
    echo "opt lease 86400" >> ${lan_dir}/udhcpd.conf
    echo "opt subnet ${lanmask}" >> ${lan_dir}/udhcpd.conf
    echo "opt router ${lanip}" >> ${lan_dir}/udhcpd.conf
    echo "opt dns ${pridns}" >> ${lan_dir}/udhcpd.conf
    echo "opt dns ${secdns}" >> ${lan_dir}/udhcpd.conf
    echo "lease_file ${lan_dir}/udhcpd.leases" >> ${lan_dir}/udhcpd.conf
    echo "interface ${lanname}" >> ${lan_dir}/udhcpd.conf
    echo "pidfile ${lan_dir}/udhcpd.pid" >> ${lan_dir}/udhcpd.conf

    # start dhcpd
    udhcpd ${lan_dir}/udhcpd.conf &

    # accept new bridge incoming pkt
    iptables -t filter -A service_list -i ${lanname} -j ACCEPT

    # lan -> unnumbered lan SNAT
    local lan_root_path="InternetGatewayDevice.LANDevice.1"
    local hostCfgMgmt_path="${lan_root_path}.LANHostConfigManagement"
    local i_path="${hostCfgMgmt_path}.IPInterface.1"  
    local br0_ip="$(cfgcmd get ${i_path}.IPInterfaceIPAddress)"
    local br0_nm="$(cfgcmd get ${i_path}.IPInterfaceSubnetMask)"
    iptables  -t nat -A ${DUALLAN_NAT_CHAIN} -s ${br0_ip}/${br0_nm} -o ${lanname} -j SNAT --to-source  ${lanip}
    # backup br lan cfg
    echo "br0_network ${br0_ip}/${br0_nm}" >> ${lan_dir}/cfg.bk

    iptables  -t filter -A ${DUALLAN_FILTER_CHAIN}  -s ${lanip}/${lanmask} -o br0  -m state --state NEW -j DROP 

    # add route

    # change fwd mode to fix unnumbered lan->lan HW accel fail
    local eth_list=$(get_eth_list InternetGatewayDevice.LANDevice.1.LANEthernetInterfaceConfig)
    local exist=""
    for i in ${eth_list}
    do
        exist=`echo ${if_list} | grep ${i}`
        # if not a unnumbered port, change fwd mode
        if [ "${exist}" == "" ]; then
            cs_cli /home/cli/api/intf/setfwd -v ifname ${i} fwd 2
        fi
    done
}


case "$action" in
	"start")
        duallan_start
		;;
	"stop")
        # the param tells whether to del xml node
        duallan_stop 1
		;;
	*)
    duallan_help	
		;;
esac

