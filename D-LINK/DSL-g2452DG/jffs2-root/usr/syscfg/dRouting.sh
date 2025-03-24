#!/bin/sh
#*****************************************************
#dRouting.sh
#
#Author:hongqing.xu
#****************************************************

. /usr/syscfg/api_log.sh
. /usr/syscfg/api_common.sh
. /usr/syscfg/wan.utils.sh


dync_routing_dir="/tmp/dync-routing"
zebra_conf_file="${dync_routing_dir}/zebra.conf"
ripd_conf_file="${dync_routing_dir}/ripd.conf"
ospfd_conf_file="${dync_routing_dir}/ospfd.conf"
bgpd_conf_file="${dync_routing_dir}/bgpd.conf"
gDynamicRouteLockPath='/var/tgp/lock/dynamic_route'

gAction=$1 #������init/set/del/ifup/ifdown
gPath=$2 #������InternetGatewayDevice.X_TRI_DynamicRoute.1./InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.
gNeedStartRipd=0
gNeedStartOspfd=0
gNeedStartBgpd=0
PAHT_ARRAY_DYNAMICROUTE="InternetGatewayDevice.X_TRI_DynamicRoute."


#���ƣ�SetRipdConfig
#����������ripd�������ļ�,�����ļ��ĸ�ʽ���������������
#���룺$1 - ��̬·��path, ����InternetGatewayDevice.X_TRI_DynamicRoute.1.
#      $2 - Э������, RIPv1/RIPv2
#���أ���
SetRipdConfig()
{
    local path=$1
    local Protocol=$2
    local wan_folder=""
    local ifname=""
    local RipPassive=`cfgcmd get ${path}RipPassive`
    local Interface=`cfgcmd get ${path}Interface`

    #�ӿ�����
    echo ${Interface} | grep LAN > /dev/null
    if [ $? -eq 1 ]; then
        wan_folder=`gen_wanconn_folder ${Interface}`
        ifname=`get_wanconn_ifname ${wan_folder}`
    else
        ifname="br0"
    fi

    if [ -z "$ifname" ]; then
        TGP_Log ${TGP_LOG_WARNING} "ifname is empty, path=$path"
        return;
    fi


    echo "!start $path" >> $ripd_conf_file #����path,�����޸Ļ���ɾ����̬·��ʱ,����Ӧ������ɾ��
    echo "router rip" >> $ripd_conf_file
    echo "redistribute kernel" >> $ripd_conf_file
    echo "redistribute static" >> $ripd_conf_file
    echo "redistribute connected" >> $ripd_conf_file #�ط���ֱ��·��,����ĳЩpc���޷�ץ��Response,��Ҳ��֪��Ϊʲô...
    echo "network ${ifname}" >> $ripd_conf_file

    if [ $RipPassive -eq 1 ]; then
        echo "passive-interface $ifname" >> $ripd_conf_file
    else
        echo "interface $ifname" >> $ripd_conf_file #û���κ�����,ֻ��Ϊ����passiveģʽʱ������ͬ
    fi

    echo "interface $ifname" >> $ripd_conf_file

    # V1/V2����
    if [ "${Protocol}" == "RIPv1" ]; then
        echo "ip rip send version 1" >> $ripd_conf_file
        echo "ip rip receive version 1" >> $ripd_conf_file
    else
        echo "ip rip send version 2" >> $ripd_conf_file
        echo "ip rip receive version 2" >> $ripd_conf_file
    fi
     echo "!end $path" >> $ripd_conf_file #����path,�����޸Ļ���ɾ����̬·��ʱ,����Ӧ������ɾ��
}


#���ƣ�SetOspfdConfig
#����������ospfd�������ļ�
#���룺$1 - ��̬·��path, ����InternetGatewayDevice.X_TRI_DynamicRoute.1.
#���أ���
SetOspfdConfig()
{
    local path=$1
    local wan_folder=""
    local ipaddr=""
    local Interface=`cfgcmd get ${path}Interface`
    local tmpfile="${dync_routing_dir}/tmp_droute_file"
    local tmp=""
    local areaID="" # area��ID, ������ű�ʶ, ʵ�ʸ������û�й�ϵ, ����192.168.1.0

    #��ȡ��br0����wan�ĵ�ַ
    echo ${Interface} | grep LAN > /dev/null
    if [ $? -eq 1 ]; then
        wan_folder=`gen_wanconn_folder ${Interface}`
        ipaddr=`get_wan_ip ${wan_folder}`
    else
        ipaddr=`cfgcmd get ${Interface}IPInterfaceIPAddress`
    fi

    if [ -z "$ipaddr" ]; then
        TGP_Log ${TGP_LOG_WARNING} "ipaddr is empty, path=$path"
        return;
    fi

    #����ip��ַ�ҵ���Ӧ��route��Ŀ, ����192.168.1.0/24 dev br0  proto kernel  scope link  src 192.168.1.1 
    ip route |grep $ipaddr > $tmpfile
    tmp=`cat $tmpfile`
    if [ -z "$tmp" ]; then
        TGP_Log ${TGP_LOG_ERROR} "get ip failed. path=$path, Interface=$Interface"
        return
    fi

    #ȡ�������,����192.168.1.0/24
    tmp=`echo ${tmp%% *}`
    areaID=`echo ${tmp%/*}`

    echo "!start $path" >> $ospfd_conf_file #����path,�����޸Ļ���ɾ����̬·��ʱ,����Ӧ������ɾ��
    echo "router ospf" >> $ospfd_conf_file
    echo "redistribute kernel" >> $ospfd_conf_file
    echo "redistribute static" >> $ospfd_conf_file
    echo "redistribute connected" >> $ospfd_conf_file #�ط���ֱ��·��
    echo "network ${tmp} area $areaID" >> $ospfd_conf_file
    echo "!end $path" >> $ospfd_conf_file #����path,�����޸Ļ���ɾ����̬·��ʱ,����Ӧ������ɾ��
}



#���ƣ�SetBgpdConfig
#����������bgpd�������ļ�
#���룺$1 - ��̬·��path, ����InternetGatewayDevice.X_TRI_DynamicRoute.1.
#���أ���
SetBgpdConfig()
{
    local path=$1
    local wan_folder=""
    local ipaddr=""
    local objectValue=`cfgcmd get ${path}` #��ȡһ��,�������������
    local Interface=`GetLeafValueFromObject "$objectValue" "Interface"`
    local BgpLocalAS=`GetLeafValueFromObject "$objectValue" "BgpLocalAS"`
    local BgpRemoteAS=`GetLeafValueFromObject "$objectValue" "BgpRemoteAS"`
    local BgpNeighborIP=`GetLeafValueFromObject "$objectValue" "BgpNeighborIP"`
    local tmp=""


    #��ȡ��br0����wan�ĵ�ַ
    echo ${Interface} | grep LAN > /dev/null
    if [ $? -eq 1 ]; then
        wan_folder=`gen_wanconn_folder ${Interface}`
        ipaddr=`get_wan_ip ${wan_folder}`
    else
        ipaddr=`cfgcmd get ${Interface}IPInterfaceIPAddress`
    fi

    if [ -z "$ipaddr" ]; then
        TGP_Log ${TGP_LOG_WARNING} "ipaddr is empty, path=$path"
        return;
    fi


    ####################################
    # ��ʽ����:����router-id��ʾϣ�����ĸ��ӿڵ�ip�Ϸ���·����Ϣ,����br0��ip; network��ʾϣ��������Щ·����Ϣ,����192.168.1.0/24,�������br1�Ķ�����
    # router bgp 7675
    # bgp router-id 192.168.1.1 
    # neighbor 192.168.1.100 remote-as 7676
    # network 192.168.1.0/24  
    # network 20.20.20.0/24
    ####################################
    echo "!start $path" >> $bgpd_conf_file #����path,�����޸Ļ���ɾ����̬·��ʱ,����Ӧ������ɾ��
    echo "router bgp ${BgpLocalAS}" >> $bgpd_conf_file
    echo "bgp router-id ${ipaddr}" >> $bgpd_conf_file
    echo "neighbor ${BgpNeighborIP} remote-as ${BgpRemoteAS}" >> $bgpd_conf_file
    ip route |grep /|grep -v br1 | while read line #���˳�192.168.1.0/24 dev br0  proto kernel  scope link  src 192.168.1.1����Ŀ
    do
        tmp=`echo ${line%% *}`
        echo "network $tmp" >> $bgpd_conf_file
    done
    echo "redistribute connected" >> $bgpd_conf_file #�ط���ֱ��·��
    echo "!end $path" >> $bgpd_conf_file #����path,�����޸Ļ���ɾ����̬·��ʱ,����Ӧ������ɾ��
}



#���ƣ�SetDynamicRouteConfig
#��������̬·�ɽ����ʹ���
#���룺$1 - ��̬·��path������InternetGatewayDevice.X_TRI_DynamicRoute.1.
#���أ���
SetDynamicRouteConfig()
{
    local path=$1
    local Protocol=`cfgcmd get ${path}Protocol`

    if [ "$Protocol" = "RIPv1" -o "$Protocol" = "RIPv2" ]; then
        SetRipdConfig $path $Protocol
    elif [ "$Protocol" = "OSPF" ]; then
        SetOspfdConfig $path
    else
        SetBgpdConfig $path
    fi
}



#���ƣ�DeleteDynamicRouteConfig
#��������̬·�ɽ����ʹ���
#���룺$1 - ��̬·��path������InternetGatewayDevice.X_TRI_DynamicRoute.1.
#���أ���
DeleteDynamicRouteConfig()
{
    local path=$1

    # ���ﲻ��Ҫ�жϵ�ǰ��ʲôЭ��,ֱ��ɾ��,��Ϊ������޸ĵĻ�, ��ǰ��Э�����͸�֮ǰ�Ŀ��ܲ�ͬ
    sed -i '/!start '$path'/,/!end '$path'/d' ${ripd_conf_file}  #ɾ��������
    sed -i '/!start '$path'/,/!end '$path'/d' ${ospfd_conf_file}  #ɾ��������
    sed -i '/!start '$path'/,/!end '$path'/d' ${bgpd_conf_file}  #ɾ��������
}


#���ƣ�GetDynamicRoutePathByWanPath
#����������wan��path��ȡ��̬·�ɵ�object path
#���룺$1 - wan path������InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.
#���أ��ɹ� - ��̬·��path, ʧ�� - ��
GetDynamicRoutePathByWanPath()
{
    local path=$1
    local pathDynamicRoute=""
    local tmp=""
    local tmpfile="${dync_routing_dir}/tmp_droute_file"

    # �����еĶ�̬·����������wan��path
    cfgcmd get ${PAHT_ARRAY_DYNAMICROUTE} |grep $path > $tmpfile
    tmp=`cat $tmpfile`
    if [ -z "$tmp" ]; then
        echo -n ""
        return
    fi

    # ��ȡInternetGatewayDevice.X_TRI_DynamicRoute.1.Interface=InternetGatewayDevice.WANDevice.2.WANConnectionDevice.1.WANIPConnection.1.��߲���
    tmp=`echo "${tmp%=*}"`

    pathDynamicRoute=`GetParentPath $tmp`
    echo -n $pathDynamicRoute
}



#���ƣ�HandleWanUp
#������wan���ߴ���
#���룺$1 - wan path������InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.
#���أ���
HandleWanUp()
{
    local path=$1
    local pathDynamicRoute=`GetDynamicRoutePathByWanPath $path`

    if [ -n "$pathDynamicRoute" ]; then
        SetDynamicRouteConfig $pathDynamicRoute
    fi
}


#���ƣ�HandleWanDown
#������wan���ߴ���
#���룺$1 - wan path������InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.
#���أ���
HandleWanDown()
{
    local path=$1
    local pathDynamicRoute=`GetDynamicRoutePathByWanPath $path`

    if [ -n "$pathDynamicRoute" ]; then
        DeleteDynamicRouteConfig $pathDynamicRoute
    fi
}


#���ƣ�NeedStart
#���������������ļ��ж��Ƿ���Ҫ����
#���룺$1 - �����ļ���·��
#���أ���Ҫ���� - 1, ����Ҫ���� - 0
NeedStart()
{
    local tmp=`cat $1|grep $PAHT_ARRAY_DYNAMICROUTE`

    if [ -z "$tmp" ];then
        echo -n 0
        return
    else
        echo -n 1
        return
    fi
}

########################################################### main ###############################################################


# ����,��ΪC�ͽű�������ô˽ű�                                                                                                                                     
while [ -f ${gDynamicRouteLockPath} ]; do                                         
    usleep 100                                                                         
done
touch ${gDynamicRouteLockPath}

TGP_Log ${TGP_LOG_WARNING} "gAction=$gAction, gPath=$gPath"



case "$gAction" in
    "set")
    DeleteDynamicRouteConfig $gPath
    SetDynamicRouteConfig $gPath
    ;;
    "del")
    DeleteDynamicRouteConfig $gPath
    ;;
    "ifup")
    HandleWanUp $gPath
    ;;
    "ifdown")
    HandleWanDown $gPath
    ;;
    *)
    ;;
esac


# ��kill���н���
killall -q ripd
killall -q ospfd
killall -q bgpd

# �ж��Ƿ���Ҫ����
gNeedStartRipd=`NeedStart $ripd_conf_file`
gNeedStartOspfd=`NeedStart $ospfd_conf_file`
gNeedStartBgpd=`NeedStart $bgpd_conf_file`


# ֻ�е���̬·��ʹ��֮�������zebra, ����2601�˿ڻᱻɨ�赽, ����ȫ
if [ $gNeedStartRipd -eq 1 -o $gNeedStartOspfd -eq 1 -o $gNeedStartBgpd -eq 1 ]; then
    zebra -d -f $zebra_conf_file
fi

# ������Ҫ��������
if [ $gNeedStartRipd -eq 1 ]; then
    ripd -f $ripd_conf_file -d
fi

if [ $gNeedStartOspfd -eq 1 ]; then
    ospfd -f $ospfd_conf_file -d
fi

if [ $gNeedStartBgpd -eq 1 ]; then
    bgpd -f $bgpd_conf_file -d
fi
rm ${gDynamicRouteLockPath}