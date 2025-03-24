#!/bin/sh

. /usr/syscfg/ebtables.param.sh
. /usr/syscfg/wan.utils.sh

vlantagging_help()
{
	echo "-------------------------------------------------------"
	echo "Usage: `basename $0` wan_path=<string> down_dir=<string>"
	echo "-------------------------------------------------------"
}

wan_path=""
down_dir=""

for para in $*
do
	export $para
done

if [ -z ${wan_path} ]; then
	vlantagging_help
	exit 0
fi

vlan_ifname=""
wan_ifname=""
tblIDbase=`echo "${wan_path}" | awk -F "." '{print $3$5$7}'`
mark=""
fwmark=""
table_id=
wan_folder="$(gen_wanconn_folder ${wan_path})"

vlantagging_stop_script="${down_dir}/002_vlan_tagging_del.sh"
echo "#!/bin/sh" > ${vlantagging_stop_script}

update_vlanbind_wan_interface()
{
	local vlanID=$1

	mark=`printf "0x%x" "$((0x${tblIDbase}<<4|0x${vlanID}))"`
	fwmark="${mark}/0xf000"
	table_id=`expr 3 + $tblIDbase`
}

vlantagging_create_intf()
{
	#local mac="$(nvram basic get MAC)"
	local father_ifname=$1
	local vlanID=$2
	vlan_ifname="${father_ifname}"".${vlanID}"
	cs_cli /home/cli/api/intf/add -v fatherifname ${father_ifname} ifname ${vlan_ifname} mapmode 4 vid ${vlanID} allocwanid 0
	#ifconfig ${vlan_ifname} hw ether ${mac}
	ifconfig ${vlan_ifname} up
}

vlantagging_setmark()
{
	ebtables -t broute -N ${VLAN_SETMARK_CHAIN}_${vlan_ifname}
	ebtables -t broute -P ${VLAN_SETMARK_CHAIN}_${vlan_ifname} RETURN
	ebtables -t broute -A ${VLAN_SETMARK_CHAIN}_${vlan_ifname} --in-if ${vlan_ifname} -j mark --mark-or ${mark} --mark-target CONTINUE
	ebtables -t broute -A ${VLAN_SETMARK_CHAIN} -j ${VLAN_SETMARK_CHAIN}_${vlan_ifname}

	echo "ebtables -t broute -D ${VLAN_SETMARK_CHAIN} -j ${VLAN_SETMARK_CHAIN}_${vlan_ifname}" >> ${vlantagging_stop_script}
	echo "ebtables -t broute -F ${VLAN_SETMARK_CHAIN}_${vlan_ifname}" >> ${vlantagging_stop_script}
	echo "ebtables -t broute -X ${VLAN_SETMARK_CHAIN}_${vlan_ifname}" >> ${vlantagging_stop_script}
}

vlantagging_policy_ip4_routing()
{
	## ipv4

	local wan_ifname=`get_wanconn_ifname $wan_folder`
	local gateway=`get_wan_gw $wan_folder`

	ip route flush table ${table_id}
	ip route add default via ${gateway} dev ${wan_ifname} table ${table_id}
	ip rule add fwmark ${fwmark} table ${table_id}
	echo "ip rule del fwmark ${fwmark} table ${table_id}" >> ${vlantagging_stop_script}
	echo "ip route flush table ${table_id}" >> ${vlantagging_stop_script}
	echo "ip route add table ${table_id} unreachable default" >> ${vlantagging_stop_script}
}
vlantagging_policy_ip6_routing()
{
	## ipv6
	local wan_ifname=`get_wanconn_ifname $wan_folder`
	local gateway6=`get_ip6_wan_gw $wan_folder`

	ip -6 route flush table ${table_id}
	ip -6 route add default via ${gateway6} dev ${wan_ifname} table ${table_id}
	ip -6 rule add fwmark ${fwmark} table ${table_id}
	echo "ip -6 rule del fwmark ${fwmark} table ${table_id}" >> ${vlantagging_stop_script}
	echo "ip -6 route flush table ${table_id}" >> ${vlantagging_stop_script}
	echo "ip -6 route add table ${table_id} unreachable default" >> ${vlantagging_stop_script}
}
vlantagging_policy_routing()
{
	local ipmode="$(cfgcmd get ${wan_path}X_CT-COM_IPMode)"

	if [ "${ipmode}" == "1" ]; then
		vlantagging_policy_ip4_routing
	elif [ "${ipmode}" == "2" ]; then
		vlantagging_policy_ip6_routing
	elif [ "${ipmode}" == "3" ]; then
		vlantagging_policy_ip4_routing
		vlantagging_policy_ip6_routing
	fi
}

vlantagging_policy_bridge()
{
	ebtables -t filter -I ${BIND_POLICY_CHAIN}_IN_${wan_ifname} --out-if ${vlan_ifname} -j ACCEPT
	ebtables -t filter -I ${BIND_POLICY_CHAIN}_OUT_${wan_ifname} --in-if ${vlan_ifname} -j ACCEPT
	ebtables -t filter -A EBTABLES_BIND_POLICY_DEFAULT --in-if ${vlan_ifname} -j DROP
	ebtables -t filter -A EBTABLES_BIND_POLICY_DEFAULT --out-if ${vlan_ifname} -j DROP
	#ebtables -t filter -I FORWARD -i ${vlan_ifname} -o eth0.+ -j DROP
	ebtables -A INPUT -i ${vlan_ifname} -p IPv4 --ip-proto 17 --ip-dport 67 -j DROP
	ebtables -I FORWARD -i ${vlan_ifname} -o ${wan_ifname} -p IPv4 --ip-proto 17 --ip-dport 67 -j ACCEPT
	#iptables -t filter -I IP_BIND_POLICY_DEFAULT -m physdev --physdev-in ${vlan_ifname} -j DROP
	#ip6tables -t filter -I IP6_BIND_POLICY_DEFAULT -m physdev --physdev-in ${vlan_ifname} -j DROP
	echo "ebtables -t filter -D ${BIND_POLICY_CHAIN}_IN_${wan_ifname} --out-if ${vlan_ifname} -j ACCEPT" >> ${vlantagging_stop_script}
	echo "ebtables -t filter -D ${BIND_POLICY_CHAIN}_OUT_${wan_ifname} --in-if ${vlan_ifname} -j ACCEPT" >> ${vlantagging_stop_script}
	echo "ebtables -t filter -D EBTABLES_BIND_POLICY_DEFAULT --in-if ${vlan_ifname} -j DROP" >> ${vlantagging_stop_script}
	echo "ebtables -t filter -D EBTABLES_BIND_POLICY_DEFAULT --out-if ${vlan_ifname} -j DROP" >> ${vlantagging_stop_script}
	echo "ebtables -D INPUT -i ${vlan_ifname} -p IPv4 --ip-proto 17 --ip-dport 67 -j DROP" >> ${vlantagging_stop_script}
	echo "ebtables -D FORWARD -i ${vlan_ifname} -o ${wan_ifname} -p IPv4 --ip-proto 17 --ip-dport 67 -j ACCEPT" >> ${vlantagging_stop_script}
	#echo "iptables -t filter -D IP_BIND_POLICY_DEFAULT -m physdev --physdev-in ${vlan_ifname} -j DROP" >> ${vlantagging_stop_script}
	#echo "ip6tables -t filter -D IP6_BIND_POLICY_DEFAULT -m physdev --physdev-in ${vlan_ifname} -j DROP" >> ${vlantagging_stop_script}

	local C_ServiceList="$(cfgcmd get ${wan_path}X_CT-COM_ServiceList)"
	if [ "${C_ServiceList}" == "OTHER" ]; then
		brctl delif br0 ${vlan_ifname}
		brctl addif br1 ${vlan_ifname}
		echo "brctl delif br1 ${vlan_ifname}" >>${vlantagging_stop_script}

		cs_cli /home/cli/api/mc/del_member -v grpid 0 ifname ${vlan_ifname} upflag 0
		cs_cli /home/cli/api/mc/add_member -v grpid 1 ifname ${vlan_ifname} upflag 0
		echo "cs_cli /home/cli/api/mc/del_member -v grpid 1 ifname ${vlan_ifname} upflag 0" >>${vlantagging_stop_script}
		echo "cs_cli /home/cli/api/mc/add_member -v grpid 0 ifname ${vlan_ifname} upflag 0" >>${vlantagging_stop_script}
	elif [ "${C_ServiceList}" == "VOIP" -o "${C_ServiceList}" == "TR069" ]; then
		local conn_folder=`gen_wanconn_folder $wan_path`
		local brIf="`cat /tmp/${conn_folder}/ConBrOutIf`"
		brctl delif br0 ${vlan_ifname}
		brctl addif $brIf ${vlan_ifname}
		echo "brctl delif $brIf ${vlan_ifname}" >>${vlantagging_stop_script}
	fi
}

vlantagging_policy()
{
	local wan_up="0"
	local ip6_wan_up="0"
	
	if [ -n "${wan_folder}" ]; then
	    local wan_is_bridged=`is_Bridged_Conn "${wan_path}"`
	    if [ $wan_is_bridged -eq 1 ]; then
	        vlantagging_policy_bridge
	    else
	    	vlantagging_policy_routing
	    fi
	fi
	
}
vlantagging_start()
{
	local vlanID="$(cfgcmd get ${wan_path}X_TRI_VlanID)"
	local vlanIF_all="$(cfgcmd get ${wan_path}X_TRI_VlanTaggingIf)"
	local vlanName_all=""

	## if wan vlan is not set, exit
	if [ "${vlanID}" == "-1" ]; then
		exit 0;
	fi

	## get wan_ifname
	wan_ifname=`get_wan_l2_ifname_by_path ${wan_path}`

	#vlan binding
	if [ -n "${vlanIF_all}" ]; then
		vlanIF_all=`echo $vlanIF_all | tr "," " "`
		for lanIfPth in $vlanIF_all
		do
			local lanName="$(cfgcmd get ${lanIfPth}Name)"
			vlan_ifname="${lanName}"".${vlanID}"
			vlanName_all="${vlanName_all}${vlan_ifname},"

			update_vlanbind_wan_interface "${vlanID}"
		
			#create vlan interface
			vlantagging_create_intf "${lanName}" "${vlanID}"

			#mark the packets which received from this vlan interface
			vlantagging_setmark

			#defaultly add vlan interface to br0
			brctl addif br0 ${vlan_ifname}

			#add policy routing, ipv4 and ipv6
			vlantagging_policy

			echo "ifconfig ${vlan_ifname} down" >> ${vlantagging_stop_script}
			echo "cs_cli /home/cli/api/intf/delete -v ifname ${vlan_ifname}" >> ${vlantagging_stop_script}
		done

		## 添加规则不让报文在br0里所有非同vlan端口forward
		#删除vlanName_all最后一个字符， 即逗号
		vlanName_all="${vlanName_all%?}"
		vlanName_all=`echo $vlanName_all | tr "," " "`
		for vlanIf in $vlanName_all
		do
			#允许相同vlan内通信
			for vlanIf2 in $vlanName_all
			do
				if [ "$vlanIf" != "$vlanIf2" ]; then
					ebtables -A ${VLAN_BIND_CHIAN} -i ${vlanIf} -o ${vlanIf2} -j ACCEPT
					echo "ebtables -D ${VLAN_BIND_CHIAN} -i ${vlanIf} -o ${vlanIf2} -j ACCEPT" >> ${vlantagging_stop_script}
				fi
			done
			#不同vlan内不允许通信
			ebtables -A ${VLAN_BIND_CHIAN} -i ${vlanIf} -o eth0.+ -j DROP
			ebtables -A ${VLAN_BIND_CHIAN} -i ${vlanIf} -o wlan+ -j DROP
			echo "ebtables -D ${VLAN_BIND_CHIAN} -i ${vlanIf} -o eth0.+ -j DROP" >> ${vlantagging_stop_script}
			echo "ebtables -D ${VLAN_BIND_CHIAN} -i ${vlanIf} -o wlan+ -j DROP" >> ${vlantagging_stop_script}
		done
		## End

		# add exec right
		chmod +x ${vlantagging_stop_script}
	fi
}

###################################################################
# initial
vlantagging_start
