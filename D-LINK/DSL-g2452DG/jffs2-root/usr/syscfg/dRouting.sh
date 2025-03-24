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

gAction=$1 #可能是init/set/del/ifup/ifdown
gPath=$2 #可能是InternetGatewayDevice.X_TRI_DynamicRoute.1./InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.
gNeedStartRipd=0
gNeedStartOspfd=0
gNeedStartBgpd=0
PAHT_ARRAY_DYNAMICROUTE="InternetGatewayDevice.X_TRI_DynamicRoute."


#名称：SetRipdConfig
#描述：生成ripd的配置文件,配置文件的格式好像必须是这样的
#输入：$1 - 动态路由path, 比如InternetGatewayDevice.X_TRI_DynamicRoute.1.
#      $2 - 协议类型, RIPv1/RIPv2
#返回：无
SetRipdConfig()
{
    local path=$1
    local Protocol=$2
    local wan_folder=""
    local ifname=""
    local RipPassive=`cfgcmd get ${path}RipPassive`
    local Interface=`cfgcmd get ${path}Interface`

    #接口配置
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


    echo "!start $path" >> $ripd_conf_file #保存path,方便修改或者删除动态路由时,将相应的配置删除
    echo "router rip" >> $ripd_conf_file
    echo "redistribute kernel" >> $ripd_conf_file
    echo "redistribute static" >> $ripd_conf_file
    echo "redistribute connected" >> $ripd_conf_file #重发布直连路由,否则某些pc机无法抓到Response,我也不知道为什么...
    echo "network ${ifname}" >> $ripd_conf_file

    if [ $RipPassive -eq 1 ]; then
        echo "passive-interface $ifname" >> $ripd_conf_file
    else
        echo "interface $ifname" >> $ripd_conf_file #没有任何意义,只是为了与passive模式时行数相同
    fi

    echo "interface $ifname" >> $ripd_conf_file

    # V1/V2配置
    if [ "${Protocol}" == "RIPv1" ]; then
        echo "ip rip send version 1" >> $ripd_conf_file
        echo "ip rip receive version 1" >> $ripd_conf_file
    else
        echo "ip rip send version 2" >> $ripd_conf_file
        echo "ip rip receive version 2" >> $ripd_conf_file
    fi
     echo "!end $path" >> $ripd_conf_file #保存path,方便修改或者删除动态路由时,将相应的配置删除
}


#名称：SetOspfdConfig
#描述：生成ospfd的配置文件
#输入：$1 - 动态路由path, 比如InternetGatewayDevice.X_TRI_DynamicRoute.1.
#返回：无
SetOspfdConfig()
{
    local path=$1
    local wan_folder=""
    local ipaddr=""
    local Interface=`cfgcmd get ${path}Interface`
    local tmpfile="${dync_routing_dir}/tmp_droute_file"
    local tmp=""
    local areaID="" # area的ID, 用网络号标识, 实际跟网络号没有关系, 比如192.168.1.0

    #获取到br0或者wan的地址
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

    #根据ip地址找到对应的route条目, 比如192.168.1.0/24 dev br0  proto kernel  scope link  src 192.168.1.1 
    ip route |grep $ipaddr > $tmpfile
    tmp=`cat $tmpfile`
    if [ -z "$tmp" ]; then
        TGP_Log ${TGP_LOG_ERROR} "get ip failed. path=$path, Interface=$Interface"
        return
    fi

    #取出网络段,比如192.168.1.0/24
    tmp=`echo ${tmp%% *}`
    areaID=`echo ${tmp%/*}`

    echo "!start $path" >> $ospfd_conf_file #保存path,方便修改或者删除动态路由时,将相应的配置删除
    echo "router ospf" >> $ospfd_conf_file
    echo "redistribute kernel" >> $ospfd_conf_file
    echo "redistribute static" >> $ospfd_conf_file
    echo "redistribute connected" >> $ospfd_conf_file #重发布直连路由
    echo "network ${tmp} area $areaID" >> $ospfd_conf_file
    echo "!end $path" >> $ospfd_conf_file #保存path,方便修改或者删除动态路由时,将相应的配置删除
}



#名称：SetBgpdConfig
#描述：生成bgpd的配置文件
#输入：$1 - 动态路由path, 比如InternetGatewayDevice.X_TRI_DynamicRoute.1.
#返回：无
SetBgpdConfig()
{
    local path=$1
    local wan_folder=""
    local ipaddr=""
    local objectValue=`cfgcmd get ${path}` #获取一次,将结果保存下来
    local Interface=`GetLeafValueFromObject "$objectValue" "Interface"`
    local BgpLocalAS=`GetLeafValueFromObject "$objectValue" "BgpLocalAS"`
    local BgpRemoteAS=`GetLeafValueFromObject "$objectValue" "BgpRemoteAS"`
    local BgpNeighborIP=`GetLeafValueFromObject "$objectValue" "BgpNeighborIP"`
    local tmp=""


    #获取到br0或者wan的地址
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
    # 格式如下:其中router-id表示希望在哪个接口的ip上发布路由信息,比如br0的ip; network表示希望发布哪些路由信息,比如192.168.1.0/24,这里除了br1的都发布
    # router bgp 7675
    # bgp router-id 192.168.1.1 
    # neighbor 192.168.1.100 remote-as 7676
    # network 192.168.1.0/24  
    # network 20.20.20.0/24
    ####################################
    echo "!start $path" >> $bgpd_conf_file #保存path,方便修改或者删除动态路由时,将相应的配置删除
    echo "router bgp ${BgpLocalAS}" >> $bgpd_conf_file
    echo "bgp router-id ${ipaddr}" >> $bgpd_conf_file
    echo "neighbor ${BgpNeighborIP} remote-as ${BgpRemoteAS}" >> $bgpd_conf_file
    ip route |grep /|grep -v br1 | while read line #过滤出192.168.1.0/24 dev br0  proto kernel  scope link  src 192.168.1.1等条目
    do
        tmp=`echo ${line%% *}`
        echo "network $tmp" >> $bgpd_conf_file
    done
    echo "redistribute connected" >> $bgpd_conf_file #重发布直连路由
    echo "!end $path" >> $bgpd_conf_file #保存path,方便修改或者删除动态路由时,将相应的配置删除
}



#名称：SetDynamicRouteConfig
#描述：动态路由解析和处理
#输入：$1 - 动态路由path，比如InternetGatewayDevice.X_TRI_DynamicRoute.1.
#返回：无
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



#名称：DeleteDynamicRouteConfig
#描述：动态路由解析和处理
#输入：$1 - 动态路由path，比如InternetGatewayDevice.X_TRI_DynamicRoute.1.
#返回：无
DeleteDynamicRouteConfig()
{
    local path=$1

    # 这里不需要判断当前是什么协议,直接删除,因为如果是修改的话, 当前的协议类型跟之前的可能不同
    sed -i '/!start '$path'/,/!end '$path'/d' ${ripd_conf_file}  #删除旧配置
    sed -i '/!start '$path'/,/!end '$path'/d' ${ospfd_conf_file}  #删除旧配置
    sed -i '/!start '$path'/,/!end '$path'/d' ${bgpd_conf_file}  #删除旧配置
}


#名称：GetDynamicRoutePathByWanPath
#描述：根据wan的path获取动态路由的object path
#输入：$1 - wan path，比如InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.
#返回：成功 - 动态路由path, 失败 - 空
GetDynamicRoutePathByWanPath()
{
    local path=$1
    local pathDynamicRoute=""
    local tmp=""
    local tmpfile="${dync_routing_dir}/tmp_droute_file"

    # 在所有的动态路由配置中找wan的path
    cfgcmd get ${PAHT_ARRAY_DYNAMICROUTE} |grep $path > $tmpfile
    tmp=`cat $tmpfile`
    if [ -z "$tmp" ]; then
        echo -n ""
        return
    fi

    # 截取InternetGatewayDevice.X_TRI_DynamicRoute.1.Interface=InternetGatewayDevice.WANDevice.2.WANConnectionDevice.1.WANIPConnection.1.左边部分
    tmp=`echo "${tmp%=*}"`

    pathDynamicRoute=`GetParentPath $tmp`
    echo -n $pathDynamicRoute
}



#名称：HandleWanUp
#描述：wan上线处理
#输入：$1 - wan path，比如InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.
#返回：无
HandleWanUp()
{
    local path=$1
    local pathDynamicRoute=`GetDynamicRoutePathByWanPath $path`

    if [ -n "$pathDynamicRoute" ]; then
        SetDynamicRouteConfig $pathDynamicRoute
    fi
}


#名称：HandleWanDown
#描述：wan下线处理
#输入：$1 - wan path，比如InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection.{i}.
#返回：无
HandleWanDown()
{
    local path=$1
    local pathDynamicRoute=`GetDynamicRoutePathByWanPath $path`

    if [ -n "$pathDynamicRoute" ]; then
        DeleteDynamicRouteConfig $pathDynamicRoute
    fi
}


#名称：NeedStart
#描述：根据配置文件判断是否需要启动
#输入：$1 - 配置文件的路径
#返回：需要启动 - 1, 不需要启动 - 0
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


# 加锁,因为C和脚本都会调用此脚本                                                                                                                                     
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


# 先kill所有进程
killall -q ripd
killall -q ospfd
killall -q bgpd

# 判断是否需要启动
gNeedStartRipd=`NeedStart $ripd_conf_file`
gNeedStartOspfd=`NeedStart $ospfd_conf_file`
gNeedStartBgpd=`NeedStart $bgpd_conf_file`


# 只有当动态路由使能之后才运行zebra, 否则2601端口会被扫描到, 不安全
if [ $gNeedStartRipd -eq 1 -o $gNeedStartOspfd -eq 1 -o $gNeedStartBgpd -eq 1 ]; then
    zebra -d -f $zebra_conf_file
fi

# 根据需要启动进程
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