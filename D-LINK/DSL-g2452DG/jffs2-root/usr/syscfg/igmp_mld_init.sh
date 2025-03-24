#!/bin/sh

. /usr/syscfg/wan.utils.sh
. /usr/syscfg/comm.utils.sh
. /usr/syscfg/ebtables.param.sh

for para in $*
do
    export $para
done

igmpproxy_path="InternetGatewayDevice.X_CT-COM_Multicast.IGMPProxy"
mldproxy_path="InternetGatewayDevice.X_CT-COM_Multicast.MLDProxy"

igmpproxy_conf="/var/igmpproxy.conf"

help()
{
    echo "Usage:"
    echo "Usage: `basename $0`  action=<set> type=<ipv4|ipv6>"
    echo "      action=<if_up|if_down> path=XXX"
}

mask2suffix()
{
  local nMask=0

  local aa=`printf $1 | awk -F"." '{print $1,$2,$3,$4}'`

  for i in $aa
  do
      if [ $i == 255 ]; then
          nMask=`expr $nMask + 8`
      elif [ $i == 254 ]; then
          nMask=`expr $nMask + 7`
      elif [ $i == 252 ]; then
          nMask=`expr $nMask + 6`
      elif [ $i == 248 ]; then
          nMask=`expr $nMask + 5`
      elif [ $i == 240 ]; then
          nMask=`expr $nMask + 4`
      elif [ $i == 224 ]; then
          nMask=`expr $nMask + 3`
      elif [ $i == 192 ]; then
          nMask=`expr $nMask + 2`
      elif [ $i == 128 ]; then
          nMask=`expr $nMask + 1`
      fi
  done

  echo "$nMask"
}

make_config()
{
    local downstream_br0="br0"

    echo "##------------------------------------------------------" > $igmpproxy_conf
    echo "## Enable Quickleave mode (Sends Leave instantly)" >> $igmpproxy_conf
    echo "##------------------------------------------------------" >> $igmpproxy_conf
	local FastLeave=`cfgcmd get ${igmpproxy_path}.FLEnable`
	echo "quickleave $FastLeave" >> $igmpproxy_conf

    echo "##------------------------------------------------------" >> $igmpproxy_conf
    echo "## Configuration for eth0 (Upstream Interface)" >> $igmpproxy_conf
    echo "##------------------------------------------------------" >> $igmpproxy_conf

    echo "phyint $wan_ifname upstream  ratelimit 0  threshold 1" >> $igmpproxy_conf
    echo "altnet $wan_v4_ip/$wan_ipmask" >> $igmpproxy_conf

    echo "##------------------------------------------------------" >> $igmpproxy_conf
    echo "## Configuration for eth1 (Downstream Interface)" >> $igmpproxy_conf
    echo "##------------------------------------------------------" >> $igmpproxy_conf
    echo "phyint $downstream_br0 downstream  ratelimit 0  threshold 1" >> $igmpproxy_conf

    echo "##------------------------------------------------------" >> $igmpproxy_conf
    echo "## Configuration for eth2 (Disabled Interface)" >> $igmpproxy_conf
    echo "##------------------------------------------------------" >> $igmpproxy_conf
    echo "#phyint eth2 disabled" >> $igmpproxy_conf

    echo "##Extern by Triductor Technology, Inc." >> $igmpproxy_conf

    local Version=`cfgcmd get ${igmpproxy_path}.LANVersion`
    echo "Version $Version" >> $igmpproxy_conf

    local QI=`cfgcmd get ${igmpproxy_path}.QI`
    echo "QI $QI" >> $igmpproxy_conf

    local QRI=`cfgcmd get ${igmpproxy_path}.QRI`
    echo "QRI $QRI" >> $igmpproxy_conf

    local LMQI=`cfgcmd get ${igmpproxy_path}.LMQI`
    echo "LMQI $LMQI" >> $igmpproxy_conf

    local ROBUST=`cfgcmd get ${igmpproxy_path}.ROBUST`
    echo "ROBUST $ROBUST" >> $igmpproxy_conf
}

#Create igmpproxy config file
gen_proxy_conf()
{
    local wan_path=`cfgcmd get ${igmpproxy_path}.WANPathName`
    if [ -z "$wan_path" ]; then
        echo "No wan connection interface is choice"
        return
    fi

    local v4_wan_is_up=`check_ipv4_wan_is_up_by_path $wan_path`
    if [ $v4_wan_is_up -eq 0 ]; then
        echo "Wan connection interface is not up yet."
        return
    fi

    local wan_folder=`gen_wanconn_folder $wan_path`
    local wan_ifname=`get_wanconn_ifname $wan_folder`
    local wan_v4_ip=`ifconfig $wan_ifname | grep 'inet addr' | awk '{print $2}' | cut -d: -f 2`
    if [ -z "$wan_v4_ip" ]; then
        echo "Wan connection interface is not get IP address yet."
        return
    fi

    local dot_mask=`ifconfig $wan_ifname | grep 'Mask' | cut -d: -f 4`
    local wan_ipmask=`mask2suffix $dot_mask`
    make_config $wan_ifname $wan_v4_ip $wan_ipmask

	# set igmp version for WAN side.
	local wan_igmpVer=`cfgcmd get ${igmpproxy_path}.WANVersion`
	if [ "$wan_igmpVer" == "2" ]; then
		echo 2 > /proc/sys/net/ipv4/conf/$wan_ifname/force_igmp_version
	else
		echo 0 > /proc/sys/net/ipv4/conf/$wan_ifname/force_igmp_version
	fi
}

InetBrWANMCFilterStop()
{
    ebtables -F ${BR_MC_IGMP_FILTER}
    if [ -e "/tmp/.br_mc_igmp_filter.sh" ]; then
        sh /tmp/.br_mc_igmp_filter.sh
    fi
}

kill_proxy()
{
    local process=$1

    local ret=`check_process_exist $process`
    if [ $ret -eq 1 ]; then
        echo "Disable $process!"
        killall -TERM $process

        InetBrWANMCFilterStop
    fi
}

mld_proxy_init()
{
    local mldproxy_enable=`cfgcmd get ${mldproxy_path}.Enable`

    kill_proxy ecmh

    if [ ${mldproxy_enable} -eq 0 ]; then
        return
    fi

    local wan_path=`cfgcmd get ${mldproxy_path}.WANPathName`
    local v6_wan_up=`check_ipv6_wan_is_up_by_path $wan_path`
    if [ $v6_wan_up -eq 1 ];then
        local wan_folder=`gen_wanconn_folder $wan_path`
        local wan_ifname=`get_wanconn_ifname $wan_folder`
       # ecmh -i ${wan_ifname} -2 -p
		local version=`cfgcmd get ${mldproxy_path}.Version`
		local qi=`cfgcmd get ${mldproxy_path}.QI`
		local qri=`cfgcmd get ${mldproxy_path}.QRI`
		local lmqi=`cfgcmd get ${mldproxy_path}.LMQI`
		local robust=`cfgcmd get ${mldproxy_path}.ROBUST`
		local mmds=`cfgcmd get ${mldproxy_path}.MMDS`
		local fl=`cfgcmd get ${mldproxy_path}.FLEnable`
        
		if [ $fl -eq 0 ]; then
		   ecmh -i ${wan_ifname} -$version -p -Q $qi -R $qri -L $lmqi -r $robust -M $mmds  
	   else
           ecmh -i ${wan_ifname} -$version -p -Q $qi -R $qri -L $lmqi -r $robust -M $mmds -F
	   fi
   
   else
        echo "IPV6 wan connection interface is not up yet."
    fi
}

InetBrWANMCFilter()
{
    local wanDevs=""
    local wanConnDevs=""
    local wanIPs=""
    local wan_path=""

    InetBrWANMCFilterStop

    echo "#!/bin/sh" > /tmp/.br_mc_igmp_filter.sh
    #wanDevs 循环
    wanDevs=`cfgcmd get_idxes InternetGatewayDevice.WANDevice.`
    for i in ${wanDevs} ; do
        wanConnDevs=`cfgcmd get_idxes InternetGatewayDevice.WANDevice."$i".WANConnectionDevice`
        if [ "${wanConnDevs}" != "0" ]; then
            for s in $wanConnDevs ; do
                wanIPs=`cfgcmd get_idxes InternetGatewayDevice.WANDevice."$i".WANConnectionDevice."$s".WANIPConnection`
                if [ "${wanIPs}" != "0" ]; then
                    for x in $wanIPs ; do
                        wan_path="InternetGatewayDevice.WANDevice.$i.WANConnectionDevice.$s.WANIPConnection.$x"
                        local wan_is_bridged=`is_Bridged_Conn $wan_path.`
                        if [ $wan_is_bridged -eq 1 ];then
                            # 目前只有INTERNET和other两种桥，INTERNET桥， 才添加规则
                            local is_inet_br=`cfgcmd get ${wan_path}.X_CT-COM_ServiceList`
                            if [ "$is_inet_br" != "INTERNET" ]; then
                                continue
                            fi
                            local isMcFilterSet=`cfgcmd get ${wan_path}.X_TRI-InetBrMCRuleFlag`
                            if [ "$isMcFilterSet" == "0" ]; then
                                cfgcmd sset ${wan_path}.X_TRI-InetBrMCRuleFlag 1
                                echo "cfgcmd sset ${wan_path}.X_TRI-InetBrMCRuleFlag 0" >> /tmp/.br_mc_igmp_filter.sh
                                local ifname=`echo "${wan_path}" | /usr/bin/awk -F "." '{print "ip_"$3"_"$5"_"$7}'`
                                ebtables -A ${BR_MC_IGMP_FILTER} -d Multicast -o ${ifname} -j DROP
                            fi
                        fi
                    done
                fi
            done
        fi
    done
}

igmp_proxy_init()
{
    local igmpproxy_enable=`cfgcmd get ${igmpproxy_path}.Enable`

    kill_proxy igmpproxy

    if [ -e $igmpproxy_conf ]; then
        rm -rf $igmpproxy_conf
    fi

    if [ $igmpproxy_enable -eq 0 ]; then
        return
    fi

    gen_proxy_conf

    if [ -e $igmpproxy_conf ]; then
       ##Must be sleep one second,to wait igmpproxy process exit
       sleep 1
       echo "Enable igmp proxy"
       igmpproxy $igmpproxy_conf &

       ## check if igmpproxy is running , set rules to limit inet bridge wan multicast
       sleep 2
       if [ "`pidof igmpproxy`" != "" ]; then
           InetBrWANMCFilter
       fi
    fi
}

if_up()
{
    local up_wan_path=$1
    local igmpproxy_wan_path=`cfgcmd get ${igmpproxy_path}.WANPathName`
    local mldproxy_wan_path=`cfgcmd get ${mldproxy_path}.WANPathName`

    if [ "$up_wan_path" = "$igmpproxy_wan_path" ]; then
       igmp_proxy_init 
    fi

    if [ "$up_wan_path" = "$mldproxy_wan_path" ]; then
        mld_proxy_init
    fi
}

if_down()
{
    local wan_path=$1

    local obj_exist=`cfgcmd check_obj ${wan_path}`
    local igmpproxy_wan_path=`cfgcmd get ${igmpproxy_path}.WANPathName`
    local mldproxy_wan_path=`cfgcmd get ${mldproxy_path}.WANPathName`

    if [ "$wan_path" = "${igmpproxy_wan_path}" ]; then
        if [ "${obj_exist}" != "0" ]; then
            #the object has been deleted, so we should delete this object from *WANPathName
            cfgcmd set ${igmpproxy_path}.WANPathName ""
        else
            #the WAN connect just down,kill the proxy
            kill_proxy igmpproxy
        fi
    fi

    if [ "$wan_path" = "${mldproxy_wan_path}" ]; then
        if [ "${obj_exist}" != "0" ]; then
            #the object has been deleted, so we should delete this object from *WANPathName
            cfgcmd set ${mldproxy_path}.WANPathName ""
        else
            #the WAN connect just down,kill the proxy
            kill_proxy ecmh
        fi
    fi
}

case $action in
    "set")
        case $type in
        "ipv4")
            igmp_proxy_init
        ;;
        "ipv6")
            mld_proxy_init
        ;;
        *)
            echo "This command must specfic type option."
            echo "Like this: `basename $0` action=set type=ipv4"
        ;;
        esac
    ;;
    "if_up")
        if_up $path
    ;;
    "if_down")
        if_down $path
    ;;
    *)
        help
    ;;
esac

