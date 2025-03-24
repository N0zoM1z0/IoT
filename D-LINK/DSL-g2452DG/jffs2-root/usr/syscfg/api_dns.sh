#!/bin/sh
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/api_route.sh

#名称： dns_query_4
#描述：查询域名对应的v4的ip
#输入：$1 - 需要查询的域名
#      $2 - 指向dns请求发出的wan path，比如InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.
#返回：url对应的ip，如果查询失败返回空
dns_query_4()
{
	local cmd=""
	local wan_folder=""
	local wan_ifname=""
	local wan_ip=""
	local dns_servers=""
	local domain_ip=""

	if [ "$1" == "" -o "$2" == "" ]; then
		echo -n ""
		return
	fi
	echo domain=$1 > /tmp/api_dns

	#获取wan目录
	wan_folder=`gen_wanconn_folder $2`
	if [ "$wan_folder" == "" ]; then
		echo -n ""
		return
	fi
	echo wan_folder=$wan_folder >> /tmp/api_dns

	#wan是否up
	if [ `is_wan_up $wan_folder` == 0 ]; then
		echo -n ""
		return
	fi
	echo "wan is up" >> /tmp/api_dns

	#获取wan接口的名称
	wan_ifname=`get_wanconn_ifname $wan_folder`
	if [ "$wan_ifname" == "" ]; then
		echo -n ""
		return
	fi
	echo wan_ifname=$wan_ifname >> /tmp/api_dns

	#获取wan接口的ip
	IPC_ConnectionType=`cfgcmd get ${2}ConnectionType`
	if [ "$IPC_ConnectionType" == "Con_Bridged" ]; then
		wan_ip=`cat /tmp/${wan_folder}/ip_address`
	else
		wan_ip=`ifconfig $wan_ifname | grep "inet addr" | awk '{print $2}' | cut -d : -f 2`
	fi
	if [ "$wan_ip" == "" ]; then
		echo -n ""
		return
	fi
	echo wan_ip=$wan_ip >> /tmp/api_dns

	#获取dns列表
	dns_servers=`get_wan_dns $wan_folder`	
	if [ "$dns_servers" == "" ]; then
		echo -n ""
		return
	fi
	dns_servers=`echo $dns_servers |tr "," " "`
	echo dns_servers=$dns_servers >> /tmp/api_dns

	#生成命令		
 	for i in ${dns_servers}
 	do
 		add_static_route $i $2
 		cmd="dig $1 -4 -b $wan_ip @$i"
 		echo $cmd +noall +answer  +tries=2 +time=3 >> /tmp/api_dns
		domain_ip=`$cmd +noall +answer +tries=2 +time=3 | grep -m 2 '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'|awk '{print $5}'|sed -n "2p"`
		del_static_route $i $2
		if [ "$domain_ip" != "" ]; then
			echo domain_ip=$domain_ip >> /tmp/api_dns
			break
		fi
	done

	echo -n $domain_ip
}


#名称： dns_query_6
#描述：查询域名对应的v6的ip
#输入：$1 - 需要查询的域名
#      $2 - 指向dns请求发出的wan path，比如InternetGatewayDevice.WANDevice.1.WANConnectionDevice.1.WANIPConnection.1.
#返回：url对应的ip，如果查询失败返回空
dns_query_6()
{
	local cmd=""

	if [ $1 == "" ]; then
		echo -n ""
	fi

	cmd="dig $1 -6"

	if [ $2 != "" ]; then
		cmd="$cmd -b $2"
	fi

	if [ $3 != "" ]; then
		cmd="$cmd @$3"
	fi

	dns_ip=`$cmd +noall +answer | grep -m 2 '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'|awk '{print $5}'|sed -n "2p"`
	echo -n $dns_ip
}
