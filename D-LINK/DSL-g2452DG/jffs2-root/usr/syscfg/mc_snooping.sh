#!/bin/sh

. /usr/syscfg/api_log.sh
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/comm.utils.sh

for para in $*
do
    export $para
done

### Make path form 'XX.XX.XX.XX.' to 'XX.XX.XX.XX' ###
path=`echo $path | sed 's;\.$;;'`

ipv4_mc_mac="01:00:5e:00:00:00/ff:ff:ff:80:00:00"
ipv6_mc_mac="33:33:00:00:00:00/ff:ff:00:00:00:00"

setmcmac_cmd="home/cli/api/intf/setmcmac"
api_mc_path="/home/cli/api/mc"
debug_mc_path="home/cli/debug/app/mc"
add_member_cmd="add_member"
del_member_cmd="del_member"
set_wan_filter_cmd="set_wan_filter"
del_wan_filter_cmd="del_wan_filter"
set_ipv4_snooping_cmd="set_ipv4_snooping"
set_ipv6_snooping_cmd="set_ipv6_snooping"
clear_grpusr_info_cmd="clear_grpusr_info"
dsl_wan_path="InternetGatewayDevice.WANDevice.1.WANConnectionDevice"
eth_wan_path="InternetGatewayDevice.WANDevice.2.WANConnectionDevice"
two_type_wan_path_list="$dsl_wan_path $eth_wan_path"
igmpsnooping_path="InternetGatewayDevice.X_CT-COM_Multicast.IGMPSnooping"
mldsnooping_path="InternetGatewayDevice.X_CT-COM_Multicast.MLDSnooping"
script_file="script/ip_down/001.mc_snooping.sh"
ipv4_rule_file="script/ip_down/ipv4.ebtables.sh"
ipv6_rule_file="script/ip_down/ipv6.ebtables.sh"

help()
{
    echo ""
    echo "Usage: `basename $0`  action=<set> type=<ipv4|ipv6>"
    echo "      action=<if_up|if_down> path=XXX"
}

ebtables_prerouting_add()
{
    local wan_ifname=$1
    local multicast_mac=$2
    local script=$3

    # 桥ACCEPT所有组播控制报文
    if [ "$multicast_mac" = "$ipv4_mc_mac" ]; then
        ebtables -t nat -I PREROUTING 1 --in-if $wan_ifname --dst $ipv4_mc_mac -p ipv4 --ip-proto 2 -j ACCEPT
        if [ ! -e $script ]; then
            echo "#!/bin/sh" > $script
            echo "ebtables -t nat -D PREROUTING --in-if $wan_ifname --dst $ipv4_mc_mac -p ipv4 --ip-proto 2 -j ACCEPT" >> $script
        fi
    else
        ebtables -t nat -I PREROUTING 1 --in-if $wan_ifname --dst $ipv6_mc_mac -p ipv6 --ip6-proto 58 --ip6-icmp-type 130:132 -j ACCEPT
        ebtables -t nat -I PREROUTING 2 --in-if $wan_ifname --dst $ipv6_mc_mac -p ipv6 --ip6-proto 58 --ip6-icmp-type 143 -j ACCEPT
        if [ ! -e $script ]; then
            echo "#!/bin/sh" > $script
            echo "ebtables -t nat -D PREROUTING --in-if $wan_ifname --dst $ipv6_mc_mac -p ipv6 --ip6-proto 58 --ip6-icmp-type 130:132 -j ACCEPT" >> $script
            echo "ebtables -t nat -D PREROUTING --in-if $wan_ifname --dst $ipv6_mc_mac -p ipv6 --ip6-proto 58 --ip6-icmp-type 143 -j ACCEPT" >> $script
        fi
    fi


    # 增加可执行权限
    chmod +x $script
}


gen_down_script()
{
    local mc_group=$1
    local wan_ifname=$2
    local script=$3

    if [ ! -e $script ]; then
        echo "#!/bin/sh" > $script
        echo "cs_cli $debug_mc_path/$clear_grpusr_info_cmd -v ifname $wan_ifname" >> $script
        echo "cs_cli $api_mc_path/$del_member_cmd -v grpid $mc_group ifname $wan_ifname upflag 1" >> $script
        echo "cs_cli $api_mc_path/$del_wan_filter_cmd -v ifname $wan_ifname" >> $script
        echo "cs_cli $setmcmac_cmd -v ifname $wan_ifname mac 00:00:00:00:00:00" >> $script
        chmod +x $script
    fi
}
### Call this func must keep the wan is up or the 'wan_ifname' will empty.
set_bridge_mc_conf()
{
    local wan_path=$1
    local wan_up_type=$2
    local igmpsnoopingenable=$3
    local mldsnoopingenable=$4
    local mc_group=0
    local bridge="br0"

    local wan_folder=`gen_wanconn_folder $wan_path`
    local wan_ifname=`get_wan_l2_ifname_by_path $wan_path`
    local wan_ipmode=`cfgcmd get $wan_path.X_CT-COM_IPMode`
    local down_script="/tmp/$wan_folder/$script_file"
    local v4_down_script="/tmp/$wan_folder/$ipv4_rule_file"
    local v6_down_script="/tmp/$wan_folder/$ipv6_rule_file"

    local service_mode=`cfgcmd get $wan_path.X_CT-COM_ServiceList`
    if [ "$service_mode" = "OTHER" ]; then
        mc_group=1
        bridge="br1"
    fi

    local bridge_mac=`get_bridge_mac $bridge`
    if [ $wan_ipmode -eq $WP_IPMODE_IPV4 ]; then
        if [ $igmpsnoopingenable -eq 1 ]; then
            if [ ! -e $v4_down_script ]; then
                ebtables_prerouting_add $wan_ifname $ipv4_mc_mac $v4_down_script
                cs_cli $setmcmac_cmd -v ifname $wan_ifname mac $bridge_mac
                cs_cli $api_mc_path/$add_member_cmd -v grpid $mc_group ifname $wan_ifname upflag 1
                cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 0 ipv6 1
                gen_down_script $mc_group $wan_ifname $down_script
            fi
        fi
    elif [ $wan_ipmode -eq $WP_IPMODE_IPV6 ]; then
        if [ $mldsnoopingenable -eq 1 ]; then
            if [ ! -e $v6_down_script ]; then
                ebtables_prerouting_add $wan_ifname $ipv6_mc_mac $v6_down_script
                cs_cli $setmcmac_cmd -v ifname $wan_ifname mac $bridge_mac
                cs_cli $api_mc_path/$add_member_cmd -v grpid $mc_group ifname $wan_ifname upflag 1
                cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 1 ipv6 0
                gen_down_script $mc_group $wan_ifname $down_script
            fi
        fi
    elif [ $wan_ipmode -eq $WP_IPMODE_IPV4_IPV6 ]; then
        if [ $igmpsnoopingenable -eq 1 -a "$wan_up_type" = "ipv4_up" ]; then
            if [ ! -e $v4_down_script ]; then
                ebtables_prerouting_add $wan_ifname $ipv4_mc_mac $v4_down_script
                cs_cli $setmcmac_cmd -v ifname $wan_ifname mac $bridge_mac
                cs_cli $api_mc_path/$add_member_cmd -v grpid $mc_group ifname $wan_ifname upflag 1
                cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 0 ipv6 1
                gen_down_script $mc_group $wan_ifname $down_script
            fi
        fi
        if [ $mldsnoopingenable -eq 1 -a "$wan_up_type" = "ipv6_up" ]; then
            if [ ! -e $v6_down_script ]; then
                ebtables_prerouting_add $wan_ifname $ipv6_mc_mac $v6_down_script
                cs_cli $setmcmac_cmd -v ifname $wan_ifname mac $bridge_mac
                cs_cli $api_mc_path/$add_member_cmd -v grpid $mc_group ifname $wan_ifname upflag 1
                cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 1 ipv6 0
                gen_down_script $mc_group $wan_ifname $down_script
            fi
        fi
    fi
}

del_bridge_mc_conf()
{
    local wan_path=$1

    local wan_folder=`gen_wanconn_folder $wan_path`
    local down_script="/tmp/$wan_folder/$script_file"

    if [ -e $down_script ]; then
        $down_script
        rm -rf $down_script
    fi
}

del_ebtales_rule()
{
    local wan_path=$1
    local ipversion=$2

    local wan_folder=`gen_wanconn_folder $wan_path`
    if [ "$ipversion" = "ipv4" ]; then
        local down_script="/tmp/$wan_folder/$ipv4_rule_file"
    elif [ "$ipversion" = "ipv6" ]; then
        local down_script="/tmp/$wan_folder/$ipv6_rule_file"
    else
        echo "Invalid parameter, must be ipv4 or ipv6"
        return
    fi

    if [ -e $down_script ]; then
        $down_script
        rm -rf $down_script
    fi
}

hotplug_down_del_rule()
{
    local wan_path=$1
    local wan_ipmode=""
    local ret

    # 如果是删除wan连接,此时节点已经不存在了,直接返回. 由wan.ipconnection.sh会执行相应的操作
    ret=`cfgcmd check_obj $wan_path.X_CT-COM_IPMode`
    if [ $ret -eq -1 ]; then
        TGP_Log ${TGP_LOG_WARNING} "$wan_path has been deleted"
        return
    fi

    wan_ipmode=`cfgcmd get $wan_path.X_CT-COM_IPMode`
    if [ $WP_IPMODE_IPV4 -eq $wan_ipmode ]; then
        del_ebtales_rule $wan_path "ipv4"
    elif [ $WP_IPMODE_IPV4 -eq $wan_ipmode ]; then
        del_ebtales_rule $wan_path "ipv6"
    else
        del_ebtales_rule $wan_path "ipv4"
        del_ebtales_rule $wan_path "ipv6"
    fi
}

check_bridge_wan_conn()
{
    local wan_path=$1
    wan_path=`echo $wan_path | sed 's;\.$;;'`

    local wan_is_bridged=`is_Bridged_Conn $wan_path.`
    if [ $wan_is_bridged -eq 0 ];then
        return
    fi

    local ipv4_wan_up=`check_ipv4_wan_is_up_by_path $wan_path`
    local ipv6_wan_up=`check_ipv6_wan_is_up_by_path $wan_path`
    local mldsnoopingenable=`cfgcmd get ${mldsnooping_path}.Enable`
    local igmpsnoopingenable=`cfgcmd get ${igmpsnooping_path}.Enable`

    if [ 1 -eq $ipv4_wan_up ]; then
        set_bridge_mc_conf $wan_path "ipv4_up" $igmpsnoopingenable $mldsnoopingenable
    fi

    if [ 1 -eq $ipv6_wan_up ]; then
        set_bridge_mc_conf $wan_path "ipv6_up" $igmpsnoopingenable $mldsnoopingenable
    fi

    if [ 1 -eq $ipv4_wan_up -a 1 -eq $ipv6_wan_up -a $mldsnoopingenable -eq 1 -a $igmpsnoopingenable -eq 1 ]; then
        local wan_ifname=`get_wan_l2_ifname_by_path $wan_path`
        cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 0 ipv6 0
    fi
}

set_snooping()
{
    local ipversion=$1
    local wan_instance=0
    local wan_path=""
    local igmpsnoopingenable=`cfgcmd get $igmpsnooping_path.Enable`
    local mldsnoopingenable=`cfgcmd get $mldsnooping_path.Enable`

    if [ "$ipversion" = "ipv4" ]; then
        cs_cli $api_mc_path/$set_ipv4_snooping_cmd -v mode $igmpsnoopingenable
    else
        cs_cli $api_mc_path/$set_ipv6_snooping_cmd -v mode $mldsnoopingenable
    fi


    for wan_dev_path in $two_type_wan_path_list
    do
        local wandev_count=`cfgcmd get_max_obj $wan_dev_path`
        wan_instance=1
        while [ $wan_instance -le $wandev_count ]
        do
            local ppp_wan_path="$wan_dev_path.$wan_instance.WANPPPConnection.1"
            local ppp_conn_flag=`cfgcmd check_obj $ppp_wan_path`
            if [ 0 -eq $ppp_conn_flag ]; then
                wan_path=$ppp_wan_path
            fi

            local ip_wan_path="$wan_dev_path.$wan_instance.WANIPConnection.1"
            local ip_conn_flag=`cfgcmd check_obj $ip_wan_path`
            if [ 0 -eq $ip_conn_flag ]; then
                wan_path=$ip_wan_path
            fi

            local wan_is_up=`check_wan_is_up_by_path $wan_path`
            if [ $wan_is_up -eq 0 ]; then
                wan_instance=`expr $wan_instance + 1`
                continue
            fi
            
            local wan_is_bridged=`is_Bridged_Conn $wan_path.`
            if [ $wan_is_bridged -eq 0 ];then
                wan_instance=`expr $wan_instance + 1`
                continue
            fi

            local wan_ipmode=`cfgcmd get $wan_path.X_CT-COM_IPMode`
            if [ "$ipversion" = "ipv4" ]; then
                if [ $igmpsnoopingenable -eq 1 ]; then
                    if [ $WP_IPMODE_IPV4 -eq $wan_ipmode -o $WP_IPMODE_IPV4_IPV6 -eq $wan_ipmode ]; then
                        check_bridge_wan_conn $wan_path
                    fi
                else
                    if [ $WP_IPMODE_IPV4 -eq $wan_ipmode ]; then
                        del_bridge_mc_conf $wan_path
                        del_ebtales_rule $wan_path "ipv4"
                    elif [ $WP_IPMODE_IPV4_IPV6 -eq $wan_ipmode ]; then
                        if [ $mldsnoopingenable -eq 0 ];then
                            del_bridge_mc_conf $wan_path
                            del_ebtales_rule $wan_path "ipv6"
                        else
                            local wan_ifname=`get_wan_l2_ifname_by_path $wan_path`
                            cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 1 ipv6 0
                        fi
                        del_ebtales_rule $wan_path "ipv4"
                    fi
                fi
            else
                if [ $mldsnoopingenable -eq 1 ]; then
                    if [ $WP_IPMODE_IPV6 -eq $wan_ipmode -o $WP_IPMODE_IPV4_IPV6 -eq $wan_ipmode ]; then
                        check_bridge_wan_conn $wan_path
                    fi
                else
                    if [ $WP_IPMODE_IPV6 -eq $wan_ipmode ]; then
                        del_bridge_mc_conf $wan_path
                        del_ebtales_rule $wan_path "ipv6"
                    elif [ $WP_IPMODE_IPV4_IPV6 -eq $wan_ipmode ]; then
                        if [ $igmpsnoopingenable -eq 0 ];then
                            del_bridge_mc_conf $wan_path
                            del_ebtales_rule $wan_path "ipv4"
                        else
                            local wan_ifname=`get_wan_l2_ifname_by_path $wan_path`
                            cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 0 ipv6 1
                        fi
                        del_ebtales_rule $wan_path "ipv6"
                    fi
                fi
            fi
            wan_instance=`expr $wan_instance + 1`
        done
    done
}

case $action in
    "set")
        case $type in
            "ipv4")
                set_snooping $type
            ;;
            "ipv6")
                set_snooping $type
            ;;
            *)
                echo "This command must specfic type option."
                echo "Like this: `basename $0` action=set type=ipv4"
            ;;
        esac
    ;;
    "if_up")
        check_bridge_wan_conn $path
    ;;
    "if_down")
        del_bridge_mc_conf $path
        hotplug_down_del_rule $path
    ;;
    *)
        help
    ;;
esac
