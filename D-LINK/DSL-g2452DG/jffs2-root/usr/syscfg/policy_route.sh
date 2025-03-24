#!/bin/sh
. /usr/syscfg/wan.comm.param.sh
. /usr/syscfg/wan.utils.sh

setup_local_policy_route()
{
	myip=$1
	gw=$2
	myif=$3
	mask=$4
	table_id=$5
	lanmask=`ifconfig br0 | grep Mask | awk '{print $4}' | cut -d ":" -f 2`
	lanip=`ifconfig br0 | grep "inet addr" | awk '{print $2}' | cut -d : -f 2`
	lannet=$(get_net_from_ip $lanip $lanmask)
	
	#ip route del default via ${gw} dev $myif table ${table_id} > /dev/null 2>&1
	#ip rule del from ${myip}/32 table ${table_id} > /dev/null 2>&1
	s=`ip route list table ${table_id} | grep default | wc -l`

	
	if [ "$s" == "0" ];then	
		s=`ip route list table ${table_id} | grep default`
		ogw=`echo $s | cut -d " " -f 3`				
		omyif=`echo $s | cut -d " " -f 5`				
		if [ "$ogw" != "$gw" ]  || [ "$omyif" == "$myif" ];then
			net=$(get_net_from_ip $myip $mask)
			ip route add $net/$mask dev $myif table ${table_id}

			ip route add $lannet/$lanmask dev br0 table ${table_id}

			ip route add default via ${gw} dev $myif table ${table_id}
		fi
	fi
	s=`ip rule show | grep ${table_id} | grep ${myip} | wc -l`
	if [ "$s" == "0" ];then
		ip rule add from ${myip}/32 table ${table_id}
	fi
}

clear_local_policy_route()
{
	local myip=$1
	local script=$2
	local table_id=$3
	if [ ! -f ${script} ]; then
		echo "#!/bin/sh" > ${script}
		chmod +x ${script}
	fi
	echo "ip rule del from ${myip}/32 table ${table_id} > /dev/null 2>&1" >> ${script}
	echo "ip route flush table ${table_id} > /dev/null 2>&1" >> ${script}
}

setup_voip_route()
{
	setup_local_policy_route "$1" "$2" "$3" "$4" "${voip_table_id}"
}

setup_tr069_route()
{
	setup_local_policy_route "$1" "$2" "$3" "$4" "${tr069_table_id}"
}

clear_voip_route()
{
	clear_local_policy_route $1 $2 ${voip_table_id}
}

clear_tr069_route()
{
	clear_local_policy_route $1 $2 ${tr069_table_id}
}
