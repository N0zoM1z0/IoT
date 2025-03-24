###################################################################
# this script include some useful functions.
# those functions will be used by wan related script.
###################################################################

. /usr/syscfg/wan.utils.sh


#名称： add_static_route
#描述：增加一条静态路由
#输入：$1 - 目的ip
#      $2 - 静态路由对应的wan obj path，比如InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.
#返回：成功: 0, 失败: -1 
add_static_route()
{
	local wan_folder=""
	local wan_ifname=""
	local gw_ip=""

	if [ "$1" == "" -o "$2" == "" ]; then
		echo -n ""
		return
	fi

	#获取wan目录
	wan_folder=`gen_wanconn_folder $2`
	if [ "$wan_folder" == "" ]; then
		echo -n ""
		return
	fi
	echo wan_folder=$wan_folder > /tmp/api_route

	#wan是否up
	if [ `is_wan_up $wan_folder` == 0 ]; then
		echo -n ""
		return
	fi
	echo "wan is up" >> /tmp/api_route

	#获取wan接口的名称
	wan_ifname=`get_wanconn_ifname $wan_folder`
	if [ "$wan_ifname" == "" ]; then
		echo -n ""
		return
	fi
	echo wan_ifname=$wan_ifname >> /tmp/api_route

	#获取wan接口的网关
	gw_ip=`get_wan_gw $wan_folder`
	if [ "$gw_ip" == "" ]; then
		echo -n ""
		return
	fi
	echo gw_ip=$gw_ip >> /tmp/api_route

	#生成命令
	IPC_ConnectionType=`cfgcmd get ${2}ConnectionType`
	if [ "$IPC_ConnectionType" == "Con_Bridged" ]; then
		wan_ifname="`cat /tmp/${wan_folder}/ConBrOutIf`"
	fi
	echo ip route add $1 via $gw_ip dev $wan_ifname metric 1 >> /tmp/api_route
	`ip route add $1 via $gw_ip dev $wan_ifname metric 1`
}


#名称： del_static_route
#描述：删除一条静态路由
#输入：$1 - 目的ip
#      $2 - 静态路由对应的wan obj path，比如InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.
#返回：成功: 0, 失败: -1 
del_static_route()
{
	local wan_folder=""
	local wan_ifname=""
	local gw_ip=""

	if [ "$1" == "" -o "$2" == "" ]; then
		echo -n ""
		return
	fi

	#获取wan目录
	wan_folder=`gen_wanconn_folder $2`
	if [ "$wan_folder" == "" ]; then
		echo -n ""
		return
	fi
	echo wan_folder=$wan_folder >> /tmp/api_route

	#wan是否up
	if [ `is_wan_up $wan_folder` == 0 ]; then
		echo -n ""
		return
	fi
	echo "wan is up" >> /tmp/api_route

	#获取wan接口的名称
	wan_ifname=`get_wanconn_ifname $wan_folder`
	if [ "$wan_ifname" == "" ]; then
		echo -n ""
		return
	fi
	echo wan_ifname=$wan_ifname >> /tmp/api_route

	#获取wan接口的网关
	gw_ip=`get_wan_gw $wan_folder`
	if [ "$gw_ip" == "" ]; then
		echo -n ""
		return
	fi
	echo gw_ip=$gw_ip >> /tmp/api_route

	#生成命令
	IPC_ConnectionType=`cfgcmd get ${2}ConnectionType`
	if [ "$IPC_ConnectionType" == "Con_Bridged" ]; then
		wan_ifname="`cat /tmp/${wan_folder}/ConBrOutIf`"
	fi
	echo ip route del $1 via $gw_ip dev $wan_ifname metric 1 >> /tmp/api_route
	`ip route del $1 via $gw_ip dev $wan_ifname metric 1`
}
