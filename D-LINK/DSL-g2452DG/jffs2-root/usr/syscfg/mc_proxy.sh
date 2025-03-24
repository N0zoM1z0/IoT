#!/bin/sh

. /usr/syscfg/wan.utils.sh
. /usr/syscfg/comm.utils.sh

for para in $*
do
    export $para
done

### Make path form 'XX.XX.XX.XX.' to 'XX.XX.XX.XX' ###
path=`echo $path | sed 's;\.$;;'`

setmcmac_cmd="home/cli/api/intf/setmcmac"
api_mc_path="/home/cli/api/mc"
debug_mc_path="home/cli/debug/app/mc"
add_member_cmd="add_member"
del_member_cmd="del_member"
set_wan_filter_cmd="set_wan_filter"
del_wan_filter_cmd="del_wan_filter"
clear_grpusr_info_cmd="clear_grpusr_info"
igmpproxy_path="InternetGatewayDevice.X_CT-COM_Multicast.IGMPProxy"
mldproxy_path="InternetGatewayDevice.X_CT-COM_Multicast.MLDProxy"
script_file="script/ip_down/002.mc_proxy.sh"

help()
{
    echo ""
    echo "Usage: `basename $0`  action=<set> type=<ipv4|ipv6>"
    echo "      action=<if_up|if_down> path=XXX"
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

### Call this func, must keep the wan is up, or the 'wan_ifname' will be empty.
set_route_mc_conf()
{
    local wan_path=$1
    local wan_up_type=$2
    local igmpproxyenable=$3
    local mldproxyenable=$4
    local mc_group=0
    local bridge="br0"

    local wan_folder=`gen_wanconn_folder $wan_path`
    local wan_ifname=`get_wan_l2_ifname_by_path $wan_path`
    local wan_ipmode=`cfgcmd get $wan_path.X_CT-COM_IPMode`
    local down_script="/tmp/$wan_folder/$script_file"

    local bridge_mac=`get_bridge_mac $bridge`
    if [ $wan_ipmode -eq $WP_IPMODE_IPV4 ]; then
        if [ $igmpproxyenable -eq 1 ]; then
            cs_cli $setmcmac_cmd -v ifname $wan_ifname mac $bridge_mac
            cs_cli $api_mc_path/$add_member_cmd -v grpid $mc_group ifname $wan_ifname upflag 1
            cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 0 ipv6 1
            gen_down_script $mc_group $wan_ifname $down_script
        fi
    elif [ $wan_ipmode -eq $WP_IPMODE_IPV6 ]; then
        if [ $mldproxyenable -eq 1 ]; then
            cs_cli $setmcmac_cmd -v ifname $wan_ifname mac $bridge_mac
            cs_cli $api_mc_path/$add_member_cmd -v grpid $mc_group ifname $wan_ifname upflag 1
            cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 1 ipv6 0
            gen_down_script $mc_group $wan_ifname $down_script
        fi
    elif [ $wan_ipmode -eq $WP_IPMODE_IPV4_IPV6 ]; then
        if [ $igmpproxyenable -eq 1 -a "$wan_up_type" = "ipv4" ]; then
            if [ ! -e $down_script ]; then
                cs_cli $setmcmac_cmd -v ifname $wan_ifname mac $bridge_mac
                cs_cli $api_mc_path/$add_member_cmd -v grpid $mc_group ifname $wan_ifname upflag 1
                gen_down_script $mc_group $wan_ifname $down_script
            fi
            cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 0 ipv6 1
        fi
        if [ $mldproxyenable -eq 1 -a "$wan_up_type" = "ipv6" ]; then
            if [ ! -e $down_script ]; then
                cs_cli $setmcmac_cmd -v ifname $wan_ifname mac $bridge_mac
                cs_cli $api_mc_path/$add_member_cmd -v grpid $mc_group ifname $wan_ifname upflag 1
                gen_down_script $mc_group $wan_ifname down_script
            fi
            cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 1 ipv6 0
        fi
    fi
}

del_route_mc_conf()
{
    local wan_path=$1

    local wan_folder=`gen_wanconn_folder $wan_path`
    local down_script="/tmp/$wan_folder/$script_file"

    if [ -e $down_script ]; then
        $down_script
        rm -rf $down_script
    fi
}

# Check this wan path is substring of igmp/mld proxy node 'WANPathName' value.
wan_is_proxy_path()
{
    local wan_path=$1
    local proxy_path=$2

    local proxy_wan_path=`cfgcmd get $proxy_path.WANPathName`
    is_substr=`strIsSubstring $wan_path $proxy_wan_path`
    echo -n $is_substr
}

check_route_wan_conn()
{
    local wan_path=$1

    ### This check bridge wan connection must be have (all wan hotplug will run). ###    
    local wan_is_bridged=`is_Bridged_Conn $wan_path.`
    if [ $wan_is_bridged -eq 1 ];then
        return
    fi

    local mldproxyenable=`cfgcmd get $mldproxy_path.Enable`
    local igmpproxyenable=`cfgcmd get $igmpproxy_path.Enable`
    local ipv4_wan_up=`check_ipv4_wan_is_up_by_path $wan_path`
    local ipv6_wan_up=`check_ipv6_wan_is_up_by_path $wan_path`
    local is_igmp_path=`wan_is_proxy_path $wan_path $igmpproxy_path`
    local is_mld_path=`wan_is_proxy_path $wan_path $mldproxy_path`

    if [ $ipv4_wan_up -eq 1 -a $is_igmp_path -eq 1 ]; then
        set_route_mc_conf $wan_path "ipv4" $igmpproxyenable $mldproxyenable
    fi

    if [ $ipv6_wan_up -eq 1 -a $is_mld_path -eq 1 ]; then
        set_route_mc_conf $wan_path "ipv6" $igmpproxyenable $mldproxyenable
    fi

    if [ $ipv4_wan_up -eq 1 -a $igmpproxyenable -eq 1 -a $ipv6_wan_up -eq 1 -a $mldproxyenable -eq 1 -a $is_igmp_path -eq 1 -a $is_mld_path -eq 1 ]; then
        local wan_ifname=`get_wan_l2_ifname_by_path $wan_path`
        cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 0 ipv6 0
    fi
}

set_proxy()
{
    local ipversion=$1
    local wan_path=""
    local multi_path_str=""
    local multi_delwan_path_str=""

    local mldproxyenable=`cfgcmd get $mldproxy_path.Enable`
    local igmpproxyenable=`cfgcmd get $igmpproxy_path.Enable`

    if [ "$ipversion" = "ipv4" ]; then
        multi_path_str=`cfgcmd get $igmpproxy_path.WANPathName`
        multi_delwan_path_str=`cfgcmd get $igmpproxy_path.DELWANPathName`
    else
        multi_path_str=`cfgcmd get $mldproxy_path.WANPathName`
        multi_delwan_path_str=`cfgcmd get $mldproxy_path.DELWANPathName`
    fi

    local delwan_path_list=`echo $multi_delwan_path_str | tr "," " "`
    for wan_path in $delwan_path_list
    do
        wan_path=`echo $wan_path | sed 's;\.$;;'`
        local wan_is_up=`check_wan_is_up_by_path $wan_path`
        if [ $wan_is_up -eq 0 ]; then
            continue
        fi

        local wan_ipmode=`cfgcmd get $wan_path.X_CT-COM_IPMode`
        if [ $WP_IPMODE_IPV4_IPV6 -eq $wan_ipmode ]; then
            if [ "$ipversion" = "ipv4" ]; then
                local is_mld_path=`wan_is_proxy_path $wan_path $mldproxy_path`
                if [ $is_mld_path -eq 1 ]; then
                    local wan_ifname=`get_wan_l2_ifname_by_path $wan_path`
                    cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 1 ipv6 0
                else
                    del_route_mc_conf $wan_path
                fi
            else
                local is_igmp_path=`wan_is_proxy_path $wan_path $igmpproxy_path`
                if [ $is_igmp_path -eq 1 ]; then
                    local wan_ifname=`get_wan_l2_ifname_by_path $wan_path`
                    cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 0 ipv6 1
                else
                    del_route_mc_conf $wan_path
                fi
            fi
        else
            del_route_mc_conf $wan_path
        fi
    done

    local wan_path_list=`echo $multi_path_str | tr "," " "`
    for wan_path in $wan_path_list
    do
        wan_path=`echo $wan_path | sed 's;\.$;;'`
        local wan_is_up=`check_wan_is_up_by_path $wan_path`
        if [ $wan_is_up -eq 0 ]; then
            continue
        fi

        local wan_ipmode=`cfgcmd get $wan_path.X_CT-COM_IPMode`
        if [ "$ipversion" = "ipv4" ]; then
            if [ $WP_IPMODE_IPV6 -eq $wan_ipmode ]; then
                continue
            fi

            if [ $igmpproxyenable -eq 1 ]; then
                check_route_wan_conn $wan_path
            else
                if [ $WP_IPMODE_IPV4 -eq $wan_ipmode ]; then
                    del_route_mc_conf $wan_path
                elif [ $WP_IPMODE_IPV4_IPV6 -eq $wan_ipmode ]; then
                    if [ $mldproxyenable -eq 0 ]; then
                        del_route_mc_conf $wan_path
                    else
                        local wan_ifname=`get_wan_l2_ifname_by_path $wan_path`
                        cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 1 ipv6 0
                    fi
                fi
            fi
        else
            if [ $WP_IPMODE_IPV4 -eq $wan_ipmode ]; then
                continue
            fi

            if [ $mldproxyenable -eq 1 ]; then
                check_route_wan_conn $wan_path
            else
                if [ $WP_IPMODE_IPV6 -eq $wan_ipmode ]; then
                    del_route_mc_conf $wan_path
                elif [ $WP_IPMODE_IPV4_IPV6 -eq $wan_ipmode ]; then
                    if [ $igmpproxyenable -eq 0 ]; then
                        del_route_mc_conf $wan_path
                    else
                        local wan_ifname=`get_wan_l2_ifname_by_path $wan_path`
                        cs_cli $api_mc_path/$set_wan_filter_cmd -v ifname $wan_ifname ipv4 0 ipv6 1
                    fi
                fi
            fi
        fi
    done
}

case $action in
    "set")
    case $type in
        "ipv4")
            set_proxy $type
        ;;
        "ipv6")
            set_proxy $type
        ;;
        *)
            echo "This command must specfic type option."
            echo "Like this: `basename $0` action=set type=ipv4"
        ;;
    esac
    ;;
    "if_up")
        check_route_wan_conn $path
    ;;
    "if_down")
        del_route_mc_conf $path
    ;;
    *)
    help
    ;;
esac
