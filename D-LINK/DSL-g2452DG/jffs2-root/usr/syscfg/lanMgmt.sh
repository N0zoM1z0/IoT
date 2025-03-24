#!/bin/sh
#*****************************************************
#lan.sh
#
#Author:hongqing.xu
#*****************************************************
. /usr/syscfg/firewall.param.sh
. /usr/syscfg/ebtables.param.sh
. /usr/syscfg/wan.utils.sh

lan_root_path="InternetGatewayDevice.LANDevice.1"
hostCfgMgmt_path="${lan_root_path}.LANHostConfigManagement"
wandevice_path="InternetGatewayDevice.WANDevice.1.WANConnectionDevice"

dev_model_path="InternetGatewayDevice.DeviceInfo.ModelName"
manufacturer_path="InternetGatewayDevice.DeviceInfo.Manufacturer"

usage()
{
    case "$2" in
    "ipv4")
    echo "Usage:"
    echo "    $0 <protocol> <action> <lan interface name> <ifup/ifdown>"
    echo "Example:"
    echo "    $0 ipv4 ipintf/dhcp br0"
    ;;
    "ipv6")
    echo "Usage:"
    echo "    $0 <protocol> <>"
    echo "Example:"
    echo "    $0 ipv6"
    ;;
    *)
    ;;
    esac
}
#lan config prepare init
LanConfigPrepare()
{
    return 0
}

#ip addr
SetLanIPInterface()
{
    local ethx=$1
    local i_path="${hostCfgMgmt_path}.IPInterface.1"
    local ip="$(cfgcmd get ${i_path}.IPInterfaceIPAddress)"
    local nm="$(cfgcmd get ${i_path}.IPInterfaceSubnetMask)"
 
    if [ "${ip}" != "" -a "${nm}" != "" ]; then
        ifconfig ${ethx} ${ip} netmask ${nm}
	ebtables -t filter -F ${ARP_FILTER_CHAIN}
	ebtables -t filter -A ${ARP_FILTER_CHAIN} -p arp --arp-opcode 1 --arp-ip-dst ${ip} -j DROP
        #/usr/syscfg/miniupnpd.sh upnp_server
        echo "Lan Configure Success" 
    else    
        echo "Lan Configure Fail" 
    fi    
}
#dhcp relay
SetDhcpRelay()
{
    local action=$2
    local client_if=$3
    local server_ip=$4
    local wan_if_name=$5
    local dhcpfwd_conf="/var/dhcp-fwd.conf"
    local dhcpfwd_pidfile="/var/dhcp-fwd.pid"
    local fwdpid=""

    local connflag=0
    local ip_mode=0
    local wancount=`cfgcmd get_max_obj ${wandevice_path}.`
    local wan_folder=""
    local wan_name=""
    local i=1

    if [ ! -f "${dhcpfwd_conf}" ]; then
       touch "${dhcpfwd_conf}" 
    fi
    if [ -f "${dhcpfwd_pidfile}" ]; then
       fwdpid=`cat "${dhcpfwd_pidfile}"`
       kill -9 ${fwdpid}
    fi

    iptables -F ${DHCPPORTMAP_CHAIN}

    case "$1" in
    "enable")
        if [ "${action}" == "init" ]; then       
            echo "user            0" > "${dhcpfwd_conf}"
            echo "group           0" >> "${dhcpfwd_conf}"
            echo "chroot          /" >> "${dhcpfwd_conf}"
            echo "pidfile         /var/dhcp-fwd.pid" >> "${dhcpfwd_conf}"
            echo "ulimit core     0" >> "${dhcpfwd_conf}"
            echo "ulimit stack    64K" >> "${dhcpfwd_conf}"
            echo "ulimit data     32K" >> "${dhcpfwd_conf}"
            echo "ulimit rss      200K" >> "${dhcpfwd_conf}"
            echo "ulimit nproc    0" >> "${dhcpfwd_conf}"
            echo "ulimit nofile   0" >> "${dhcpfwd_conf}"
            echo "ulimit as       0" >> "${dhcpfwd_conf}"
            echo "ulimit as       0" >> "${dhcpfwd_conf}"
            echo "if ${client_if} true false true" >> "${dhcpfwd_conf}"
            echo "server  ip      ${server_ip}" >> "${dhcpfwd_conf}"
            while [ $i -le $wancount ]
            do
            connflag=`cfgcmd check_obj ${wandevice_path}.${i}.WANIPConnection.1.`
            if [ "$connflag" == "0" ]; then
                ip_mode=`cfgcmd get ${wandevice_path}.${i}.WANIPConnection.1.X_CT-COM_IPMode`
                if [ "${ip_mode}" = "1" -o "${ip_mode}" = "3" ]; then
                    wan_folder=`gen_wanconn_folder ${wandevice_path}.${i}.WANIPConnection.1.`
                    wan_name=`get_wanconn_ifname $wan_folder`
                    if [ "$wan_name" != "" ]; then
                        echo "if $wan_name false true true" >> $dhcpfwd_conf
                    fi
                fi 
            fi
            i=`expr $i + 1`
            done

            i=1
            while [ $i -le $wancount ]
            do
            connflag=`cfgcmd check_obj ${wandevice_path}.${i}.WANPPPConnection.1.`
            if [ "$connflag" == "0" ]; then
                ip_mode=`cfgcmd get ${wandevice_path}.${i}.WANPPPConnection.1.X_CT-COM_IPMode`
                if [ "${ip_mode}" = "1" -o "${ip_mode}" = "3" ]; then
                    wan_folder=`gen_wanconn_folder ${wandevice_path}.${i}.WANPPPConnection.1.`
                    wan_name=`get_wanconn_ifname $wan_folder`
                    if [ "$wan_name" != "" ]; then
                        echo "if $wan_name false true true" >> $dhcpfwd_conf
                    fi
                fi 
            fi
            i=`expr $i + 1`
            done
        fi
        
        if [ "${action}" == "ifup" ]; then       
            gw_if=${wan_if_name}
            sed -i "/${gw_if}/d" "${dhcpfwd_conf}"
            echo "if ${gw_if} false true true" >> "${dhcpfwd_conf}"
        fi

        if [ "${action}" == "ifdown" ]; then       
            gw_if=${wan_if_name}
            sed -i "/${gw_if}/d" "${dhcpfwd_conf}"
        fi
        iptables -F ${DHCPRELAY_CHAIN}
        iptables -A ${DHCPRELAY_CHAIN} -p udp --dport 67 -j ACCEPT
        dhcp-fwd -c /var/dhcp-fwd.conf -n&
    ;;
    "disable")
        if [ -f "${dhcpfwd_pidfile}" ]; then
            iptables -F ${DHCPRELAY_CHAIN}
            pid=`cat ${dhcpfwd_pidfile}`
            if [ -n "${pid}" ]; then
                kill ${pid}
            fi
        fi
        rm -f "${dhcpfwd_conf}"
        rm -f "${dhcpfwd_pidfile}"
    ;;
    *)
    ;;
    esac
}


DhcpPhyPortCfg()
{
    local i_path="${hostCfgMgmt_path}"        
    local laninterface=`cfgcmd get ${i_path}.X_CT-COM_DhcpBlockPorts`
    local if_list=""

    if [ "${laninterface}" != "" ]; then
        if_list=$(get_interface_list ${laninterface})
    fi

    iptables -F ${DHCPPORTMAP_CHAIN}

    for i in ${if_list}
    do
        iptables -A ${DHCPPORTMAP_CHAIN} -m physdev --physdev-in ${i} -p udp --dport 67  -j REJECT
    done
}


#ipv4 dhcp server configure
IPv4DHCPServerCfg()
{
    local if_name="${2}"
    local path_conf="/var/udhcpd.conf"
    local path_lease_file="/var/udhcpd.leases"
    local path_pidfile="/var/run/udhcpd.pid"
    
    local i_path="${hostCfgMgmt_path}"        
    local productclass=`cfgcmd get InternetGatewayDevice.DeviceInfo.ProductClass`
    local sn=`cfgcmd get InternetGatewayDevice.DeviceInfo.SerialNumber`
    local oui=`cfgcmd get InternetGatewayDevice.DeviceInfo.ManufacturerOUI`
    local Server_ip=`cfgcmd get ${i_path}.IPInterface.1.IPInterfaceIPAddress`
    local Cmput_start=`cfgcmd get ${i_path}.MinAddress`    
    local Cmput_end=`cfgcmd get ${i_path}.MaxAddress`    
    local STB_start=`cfgcmd get ${i_path}.X_CT-COM_STB-MinAddress`    

    local DomainName=`cfgcmd get ${i_path}.DomainName`
    local SubnetMask=`cfgcmd get ${i_path}.SubnetMask`
    local IPRouters=`cfgcmd get ${i_path}.IPRouters`
    local DHCPLeaseTime=`cfgcmd get ${i_path}.DHCPLeaseTime`
    local DNSServers=`cfgcmd get ${i_path}.DNSServers`

    local dev_model=`cfgcmd get $dev_model_path`
#   local manufacturer=`cfgcmd get $manufacturer_path`
    local internet_vlan=-1
    local iptv_vlan=-1
    local itms_vlan=-1
    local voice_vlan=-1
    local wancount=`cfgcmd get_max_obj ${wandevice_path}.`
    local wan_num=1
    local conn_flag=0


    case "$1" in
    "enable")
        if [ -f "${path_conf}" ]; then
            rm -f "${path_conf}"
        fi
        touch "${path_conf}"
   
        echo "server ${Server_ip}" >> "${path_conf}"
        echo "start ${Cmput_start}" >> "${path_conf}"
        echo "end ${Cmput_end}" >> "${path_conf}"

        #add static ip address
        obj_index=`cfgcmd get_idxes ${i_path}.DHCPStaticAddress`
        if [ "${obj_index}" != "0" ]; then
            local obj_num=0
            for obj_count in ${obj_index} ; do
                local obj_enable=`cfgcmd get ${i_path}.DHCPStaticAddress.${obj_count}.Enable`
                if [ "${obj_enable}" == "1" ]; then
                    obj_chaddr=`cfgcmd get ${i_path}.DHCPStaticAddress.${obj_count}.Chaddr`
                    obj_yiaddr=`cfgcmd get ${i_path}.DHCPStaticAddress.${obj_count}.Yiaddr`
            
                    echo "static_lease ${obj_chaddr} ${obj_yiaddr}" >> "${path_conf}"
                fi
            done
        fi

        if [ "${DomainName}" != "" ]; then
            echo "opt domain ${DomainName}" >> "${path_conf}"
        fi
        if [ "${DHCPLeaseTime}" != "" ]; then
            echo "opt lease ${DHCPLeaseTime}" >> "${path_conf}"
        fi
        if [ "${SubnetMask}" != "" ]; then
            echo "opt subnet ${SubnetMask}" >> "${path_conf}"
        fi        
        if [ "${IPRouters}" != "" ]; then
            echo "opt router ${IPRouters}" >> "${path_conf}"
        fi
        if [ "${DNSServers}" != "" ]; then
            echo "opt dns ${DNSServers}" >> "${path_conf}"
        fi

        #add option user defined
        obj_index=`cfgcmd get_idxes ${i_path}.DHCPOption`
        if [ "${obj_index}" != "0" ]; then
            for obj_count in ${obj_index} ; do
                local obj_enable=`cfgcmd get ${i_path}.DHCPOption.${obj_count}.Enable`
                if [ "${obj_enable}" == "1" ]; then
                    obj_tag=`cfgcmd get ${i_path}.DHCPOption.${obj_count}.Tag`
                    obj_value=`cfgcmd get ${i_path}.DHCPOption.${obj_count}.Value`
                    echo "opt ${obj_tag} ${obj_value}" >> "${path_conf}"
                fi
            done
        fi

        #echo "vendor_addrpool classname 192.168.1.20 192.168.1.30 opt<lease 8640 subnet 255.255.255.0 router 192.168.1.1 dns 192.168.1.5,192.168.1.8>" >> "${path_conf}"
        #add vendor_addrpool
        obj_index=`cfgcmd get_idxes ${i_path}.DHCPConditionalServingPool`
        if [ "${obj_index}" != "0" ]; then
            for obj_count in ${obj_index} ; do
                local obj_enable=`cfgcmd get ${i_path}.DHCPConditionalServingPool.${obj_count}.Enable`
                if [ "${obj_enable}" == "1" ]; then
                    classID=`cfgcmd get ${i_path}.DHCPConditionalServingPool.${obj_count}.VendorClassID`
                    classIDMode=`cfgcmd get ${i_path}.DHCPConditionalServingPool.${obj_count}.VendorClassIDMode`
                    minAddress=`cfgcmd get ${i_path}.DHCPConditionalServingPool.${obj_count}.MinAddress`
                    maxAddress=`cfgcmd get ${i_path}.DHCPConditionalServingPool.${obj_count}.MaxAddress`
                    subnetMask=`cfgcmd get ${i_path}.DHCPConditionalServingPool.${obj_count}.SubnetMask`
                    dNSServers=`cfgcmd get ${i_path}.DHCPConditionalServingPool.${obj_count}.DNSServers`
                    iPRouters=`cfgcmd get ${i_path}.DHCPConditionalServingPool.${obj_count}.IPRouters`
                    leaseTime=`cfgcmd get ${i_path}.DHCPConditionalServingPool.${obj_count}.DHCPLeaseTime`
                    vendor_addrpool_str="vendor_addrpool <${classID}:${classIDMode}> ${minAddress} ${maxAddress}"
                    vendor_addrpool_str="${vendor_addrpool_str} opt<lease ${leaseTime} subnet ${subnetMask} router ${iPRouters} dns ${dNSServers}"

                    #add option user defined
                    option_index=`cfgcmd get_idxes ${i_path}.DHCPConditionalServingPool.${obj_count}.DHCPOption`
                    if [ "${option_index}" != "0" ]; then
                    for option_count in ${option_index} ; do
                            local option_enable=`cfgcmd get ${i_path}.DHCPConditionalServingPool.${obj_count}.DHCPOption.${option_count}.Enable`
                            if [ "${option_enable}" == "1" ]; then
                                option_tag=`cfgcmd get ${i_path}.DHCPConditionalServingPool.${obj_count}.DHCPOption.${option_count}.Tag`
                                option_value=`cfgcmd get ${i_path}.DHCPConditionalServingPool.${obj_count}.DHCPOption.${option_count}.Value`
                                vendor_addrpool_str="${vendor_addrpool_str} ${option_tag} ${option_value}"
                            fi
                        done
                    fi

                    vendor_addrpool_str="${vendor_addrpool_str}>"
                    echo "${vendor_addrpool_str}" >> "${path_conf}"
                fi
            done
        fi
                
        echo "lease_file ${path_lease_file}" >> "${path_conf}"
        echo "interface ${if_name}" >> "${path_conf}"
        echo "pidfile ${path_pidfile}" >> "${path_conf}"

        echo "oui $oui" >> "${path_conf}"
        echo "sn $sn" >> "${path_conf}"
        echo "productclass $productclass" >> "${path_conf}"

        echo "vendor_spec name " >> "${path_conf}"
        echo "vendor_spec variety HGW-CT" >> "${path_conf}"
        if  [ -z $dev_model ]; then
            dev_model="Unknow device model"
        fi
        echo "vendor_spec model $dev_model" >> "${path_conf}"
        while [ $wan_num -le $wancount ]
        do
            conn_flag=`cfgcmd check_obj ${wandevice_path}.$wan_num.WANPPPConnection.1.`
            if [ $conn_flag -eq 0 ]; then
                local servicemode=`cfgcmd get ${wandevice_path}.$wan_num.WANPPPConnection.1.X_CT-COM_ServiceList`
                if [ "$servicemode" = "INTERNET" ]; then
                    internet_vlan=`cfgcmd get ${wandevice_path}.$wan_num.WANPPPConnection.1.X_TRI_VlanID`
                elif [ "$servicemode" = "OTHER" ]; then
                    iptv_vlan=`cfgcmd get ${wandevice_path}.$wan_num.WANPPPConnection.1.X_TRI_VlanID`
                fi
            fi

            conn_flag=`cfgcmd check_obj ${wandevice_path}.$wan_num.WANIPConnection.1.`
            if [ $conn_flag -eq 0 ]; then
                local servicemode=`cfgcmd get ${wandevice_path}.$wan_num.WANIPConnection.1.X_CT-COM_ServiceList`
                if [ "$servicemode" = "INTERNET" ]; then
                    internet_vlan=`cfgcmd get ${wandevice_path}.$wan_num.WANIPConnection.1.X_TRI_VlanID`
                elif [ "$servicemode" = "OTHER" ]; then
                    iptv_vlan=`cfgcmd get ${wandevice_path}.$wan_num.WANIPConnection.1.X_TRI_VlanID`
                elif [ "$servicemode" = "TR069" ]; then
                    itms_vlan=`cfgcmd get ${wandevice_path}.$wan_num.WANIPConnection.1.X_TRI_VlanID`
                fi
            fi
            wan_num=`expr $wan_num + 1`
        done
        echo "vendor_spec internet $internet_vlan" >> "${path_conf}"
        echo "vendor_spec iptv $iptv_vlan" >> "${path_conf}"
        echo "vendor_spec itms $itms_vlan" >> "${path_conf}"
        echo "vendor_spec voice $voice_vlan" >> "${path_conf}"

        if [ -e ${path_pidfile} ]; then
            kill `cat $path_pidfile`
        else
            killall udhcpd
        fi
        rm -f ${path_pidfile}
        touch ${path_lease_file}
        DhcpPhyPortCfg
        udhcpd ${path_conf}
    ;;
    "disable")
        iptables -F ${DHCPPORTMAP_CHAIN}
        if [ -e ${path_pidfile} ]; then
            kill `cat $path_pidfile`
            rm -f "${path_pidfile}"
        else
            killall udhcpd
        fi
    ;;
    *)
    ;;
    esac    

}

DNSRelay()
{
    local dnsrelay=`cfgcmd get "${hostCfgMgmt_path}.X_CT-COM_DNSRelayEnable"`
    local pid=""
    local ip=""

    # 如果dnsmasq已经运行，则要先退出
    pid=`pidof dnsmasq | grep [0-9]`
    if [ -n "${pid}" ]; then
        killall -15 dnsmasq

        # 死循环等待dnsmasq退出，否则下面的启动会失败
        while [ -n "${pid}" ]; do
            usleep 100
            pid=`pidof dnsmasq | grep [0-9]`
        done
    fi

    # 启动dnsmasq
    if [ "${dnsrelay}" == "1" ]; then
        ip=`cfgcmd get "${hostCfgMgmt_path}.IPInterface.1.IPInterfaceIPAddress"`
        echo "${ip} localhost" > /var/dnsmasq.hosts
        dnsmasq --addn-host=/var/dnsmasq.hosts  --address=/#/${ip}
        sleep 1 # sleep一秒，确保dnsmasq能够完成启动
    fi
}


#dhcp relay wan hotplug
HotplugDhcpRelay()
{
    local lanethx=$1
    local hotaction=$2
    local wanifname=$3
    local i_path="${hostCfgMgmt_path}"
    local relayEnable=`cfgcmd get ${i_path}.DHCPRelay`    

    if [ "${relayEnable}" == "1" ]; then
        echo "Hotplug Dhcp Relay Re-init"
        relayIP=`cfgcmd get ${i_path}.X_CT-COM_DHCPRelayAddress`
        SetDhcpRelay "enable" "${hotaction}" "${lanethx}" "${relayIP}" "${wanifname}"
    fi
}

ClearDhcpClientStatusObj()
{
    local client_status_path="InternetGatewayDevice.LANDevice.1.Hosts.Host"
    local obj_count=`cfgcmd get_max_obj ${client_status_path}.`
    local index=1
    local check_ret=-1
     
    while [ ${index} -le ${obj_count} ]
    do
        check_ret=`cfgcmd check_obj ${client_status_path}.${index}`
        if [ "${check_ret}" == "0" ]; then
            cfgcmd del_obj "${client_status_path}.${index}"
        fi
        index=`expr $index + 1`
    done
}

#dhcp server
SetDhcpServer()
{
    local ethx=$1
    local i_path="${hostCfgMgmt_path}"
    local relayEnable=`cfgcmd get ${i_path}.DHCPRelay`    
    local serverEnable=`cfgcmd get ${i_path}.DHCPServerEnable`    
   
    ClearDhcpClientStatusObj

    if [ "${relayEnable}" == "1" ]; then
        echo "Dhcp Relay Enable"
        relayIP=`cfgcmd get ${i_path}.X_CT-COM_DHCPRelayAddress`
        SetDhcpRelay "enable" "init" "${ethx}" "${relayIP}"
    else
        echo "Dhcp Relay Disable"
        SetDhcpRelay "disable"
    fi

    if [ "${serverEnable}" == "1" ]; then
        echo "Dhcp Server Enable"
        IPv4DHCPServerCfg "enable" "${ethx}"
    else
        echo "Dhcp Server Disable"
        IPv4DHCPServerCfg "disable" "${ethx}"
    fi
}

case "$1" in  
    "ipv4")
    echo "ipv4 setup start..."
    #Setup IPInterface
    if [ $# -gt 5  -o $# -le 0 ]; then
        usage $0 "ipv4"
        exit 1
    fi
    
    action=$2
    LanConfigPrepare
    if [ "${action}" == "ipintf" ]; then
        SetLanIPInterface $3
        DNSRelay
        SetDhcpServer $3
    fi
    if [ "${action}" == "dhcp" ]; then
        DNSRelay
        SetDhcpServer $3
    fi

    if [ "${action}" == "dhcprelay" ]; then
        HotplugDhcpRelay $3 $4 $5 
    fi

    echo "ipv4 setup end"
    ;;
    "ipv6")
    echo "ipv6 setup start..."
    LanConfigPrepare
    if [ $# -gt 4  -o $# -le 0 ]; then
        usage $0 "ipv6"
        exit 1
    fi
    echo "Do nothing now"
    echo "ipv6 setup end"
    ;;
    "-h")
    usage $0 "ipv4"
    usage $0 "ipv6"
    ;;
    *)
    usage $0 "ipv4"
    usage $0 "ipv6"
    ;;
esac
