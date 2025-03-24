#!/bin/sh
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/wan.comm.param.sh

local Dev=$1
local Path=$2

Already=`ifconfig tun0 2>/dev/null | grep "Link encap" | wc -l`
if [ $Already == "1" ];then
	ip addr del 192.0.0.2 peer 192.0.0.1 dev tun0
	ip link set tun0 down
	ip -6 tunnel del tun0
	cfgcmd sset "$Path"X_TRI_Dslite_Status down
	if [ $3 == "0" ];then
		exit
	fi
fi

#local DevName=`cfgcmd get "$Path"Name`
local DevName=`gen_wanconn_folder $Path`
local DsLite=`cfgcmd get "$Path"X_CT-COM_Dslite_Enable`

if [ $DsLite != "1" ];then
	exit
fi

if [ ! -n $DevName ];then
	exit
fi

if [ ! -f /tmp/$DevName/$IP6_ADDR ];then
	exit
fi

local ips=`cat /tmp/$DevName/$IP6_ADDR`

if [ ! -n "$ips" ];then
	exit
fi

local Local=`echo $ips | cut -d " " -f 1`
AfMode=`cfgcmd get "$Path"X_CT-COM_AftrMode`

if [ ! -n $AfMode ];then
	exit
fi

local RemoteDomain=""

if [ $AfMode == "1" ];then
	RemoteDomain=`cfgcmd get "$Path"X_CT-COM_Aftr`
elif [ $AfMode == "0" ];then
	if [ ! -e "/tmp/$DevName/aftr" ];then
	  cfgcmd sset "$Path"X_TRI_Dslite_Status down 
	  exit
	fi
	local str=`cat /tmp/$DevName/aftr`
	if [ ! -n "$str" ];then
	 cfgcmd sset "$Path"X_TRI_Dslite_Status down 
	 exit
	fi
	local len=`expr length $str`
	local lastdot=`echo $str | cut -c $len`
	if [ ${lastdot} == "." ];then
		local new_len=$(($len - 1))
		RemoteDomain=`echo $str | cut -c 1-$new_len`
	else
		RemoteDomain=$str
	fi
	cfgcmd sset "$Path"X_CT-COM_Aftr $RemoteDomain
else
	exit
fi

if [ ! -n "$RemoteDomain" ];then
	exit
fi
if [ "$RemoteDomain" == "" ];then
	exit
fi



#workaround for dhcp6c,because it will run script firstly,and then add global address to interface.
local ip6_only=` echo "$ips" | cut -d '/' -f 1 `
local has_ip6=`ifconfig $Dev | grep $ip6_only`
if [ ! -n "$has_ip6" ]; then
  ip -6 addr add ${ips} dev $Dev
fi

Remote=`ping6 resolv_only $RemoteDomain 2>/dev/null`

if [ -n "$Remote" ];then
#echo "ip -6 tunnel add tun0 mode ipip6 remote $Remote local $Local dev $Dev encaplimit none"
ip -6 tunnel add tun0 mode ipip6 remote $Remote local $Local dev $Dev encaplimit none
#echo "ip link set tun0 up"
ip link set tun0 up
#echo "ip addr add 192.0.0.2 peer 192.0.0.1 dev $Dev"
ip addr add 192.0.0.2 peer 192.0.0.1 dev tun0
#echo "ip route add default via 192.0.0.1"
#ip route add default via 192.0.0.1
ip route add default dev tun0
#support dslite hardware accelerate
fi
tunnel_state=`ifconfig tun0 2>/dev/null | wc -l`
if [ "$tunnel_state" == "0" ];then
	cfgcmd sset "$Path"X_TRI_Dslite_Status down 
else
	cfgcmd sset "$Path"X_TRI_Dslite_Status up
fi
	
wan_ifname=`cat /tmp/$DevName/${IFNAME_FILE}`
if [ -n "${phy_ifname}" ]; then
	cs_cli /home/cli/api/intf/settnl -v ifname ${phy_ifname} type 1
	cs_cli /home/cli/api/intf/setipv6 -v ifname ${phy_ifname} ip $Local
	cs_cli /home/cli/api/intf/setfwd -v ifname ${phy_ifname} fwd 3
fi
