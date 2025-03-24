#!/bin/sh 


for para in $*
do
	export $para
done

# OMG! cs_cli doesn't support redirect, when called by script. 
RELEASE_VER=0
DEBUG_OPT=""
if [ $RELEASE_VER -eq 1 ];then
	DEBUG_OPT=" >/dev/null"
fi

PORT_FLOW_BASE_IDX=16
PORT_CAR_BASE_IDX=16
IP_FLOW_BASE_IDX=32
IP_CAR_BASE_IDX=32 

# entry to control SSID DS
PROC_IFQOS="/proc/ifqos"

PORT_BW_LIMIT_BASIC_PATH="InternetGatewayDevice.Services.X_TRI_RateLimit.PerPort"
IP_BW_LIMIT_BASIC_PATH="InternetGatewayDevice.Services.X_TRI_RateLimit.PerIP"

local bw_limit_dir="/var/.bw_limit"
local bw_limit_lock_flag="${bw_limit_dir}/bw_limit_lock_flag"
while [ -f ${bw_limit_lock_flag} ]
do
	usleep 10000
done
touch ${bw_limit_lock_flag}

bw_limit_get_wan_port_mask()
{
	local wan_mask=0
	local chip_id=`cat /proc/chip_id`
	if [ "${chip_id}" == "T" ]; then 
		wan_mask=0x0101
	else
		wan_mask=0x1001
	fi

	echo -n $wan_mask
}

bw_limit_wait_intf_up()
{
	local ifname=$1
	local ret=`ifconfig ${ifname} 2>/dev/null`
	local max=180
	local i=0

	while [ "${ret}" == "" -a $i -lt $max ]
	do
		sleep 1	
		ret=`ifconfig ${ifname} 2>/dev/null`
		i=`expr $i + 1`
	done
			
	if [ $i -eq $max ];then
		echo " ################ Bandwidth limit: wait ${ifname} up timeout.####################"
		echo -n "-1"
	else	
		echo -n "0"
	fi
}

bw_limit_init_wifi_phyport()
{
	dmesg  -c > /dev/null
	cs_cli /home/cli/debug/app/res/dump_intf  wl0_ext ${DEBUG_OPT}

	local phyport=`dmesg | head -n 20 | grep "phyport" |  awk -F " " '{print $2}'`
	local wifi_port_cfg="${bw_limit_dir}/wifi_phyport"
	# band0: SSID1~4, band1: SSID5~8
	if [ "${phyport}" == "5" ];then
		echo "band0=0x20" > ${wifi_port_cfg}
		echo "band1=0x10" >> ${wifi_port_cfg}
	else
		echo "band0=0x10" > ${wifi_port_cfg}
		echo "band1=0x20" >> ${wifi_port_cfg}
	fi
}

bw_limit_init()
{
	# init public rule

	# 1. SSID UP
	# no need to set defaul flow again, use the ones in rcS

	# 2. SSID DS
	insmod /lib/modules/3.14.18/ifqos.ko

	# 3. IP DS, need to wait br0 up
	local wait=$(bw_limit_wait_intf_up br0)
	if [ "${wait}" == "-1" ];then
		return
	fi
	tc qdisc del dev br0 root ${DEBUG_OPT}
	tc qdisc add dev br0 root handle 1: htb default 2

	# 4. init IP private rule
	local PerIPIdxes=`cfgcmd get_idxes "${IP_BW_LIMIT_BASIC_PATH}"`
	if [ "${PerIPIdxes}" != "0" ];then
		for idx in $PerIPIdxes
		do
			local path="${IP_BW_LIMIT_BASIC_PATH}.${idx}"
			local en=`cfgcmd get "${path}.Enable"`	
			# do nothing for a disable IP rule
			if [ "${en}" == "1" ]; then
				bw_limit_enable_rule $path "PerIP" 
			fi
		done
	fi

	# 5. init WIFI PHY port setting
	local wait=$(bw_limit_wait_intf_up wl0_ext)
	if [ "${wait}" == "-1" ];then
		return
	fi
	bw_limit_init_wifi_phyport 

	# 6. init PORT private rule
	local PerPortIdxes=`cfgcmd get_idxes "${PORT_BW_LIMIT_BASIC_PATH}"`
	for idx in $PerPortIdxes
	do
		local path="${PORT_BW_LIMIT_BASIC_PATH}.${idx}"
		local en=`cfgcmd get "${path}.Enable"`
		if [ "${en}" == "0" ]; then
			# rule disabled
			continue
		fi

		if [ $idx -gt 4 ]; then
			local lanpath=`cfgcmd get "${path}.LanPort"`	
			local ifname=`cfgcmd get "${lanpath}Name"`
			wait=$(bw_limit_wait_intf_up ${ifname})
			if [ "${wait}" == "-1" ];then
				continue	
			fi
		fi
		bw_limit_enable_rule $path "PerPort"
	done
}



# To be simple, one car is bound to one flow, for one rule
bw_limit_get_flow_idx()
{
	local type=$1
	local rule_idx=$2
	local flow_idx=0
	local tmp=0

	if [ "${type}" == "PerPort" ];then
		if [ ${rule_idx} -le 4 ];then # flow_idx: UP, flow_idx:DS
			let tmp=$rule_idx-1
			let tmp=$tmp*2
			let flow_idx=$PORT_FLOW_BASE_IDX+$tmp
		else # SSID UP
			let flow_idx=$PORT_FLOW_BASE_IDX+8+$rule_idx-5
		fi
	else # IP UP
		let flow_idx=$IP_FLOW_BASE_IDX+$rule_idx-1	
	fi

	echo -n $flow_idx
}

bw_limit_get_car_idx()
{
	local type=$1
	local rule_idx=$2
	local car_idx=0
	local tmp=0

	if [ "${type}" == "PerPort" ];then
		if [ ${rule_idx} -le 4 ];then
			let tmp=$rule_idx-1
			let tmp=$tmp*2
			let car_idx=$PORT_CAR_BASE_IDX+$tmp
		else
			let car_idx=$PORT_CAR_BASE_IDX+8+$rule_idx-5
		fi
	else
		let car_idx=$IP_CAR_BASE_IDX+$rule_idx-1	
	fi

	echo -n $car_idx
}

bw_limit_get_ip_lan()
{
	local ip=$1
	local str1=`echo "${ip}" | awk -F '.' '{print $1}'`
	local str2=`echo "${ip}" | awk -F '.' '{print $2}'`
	local str3=`echo "${ip}" | awk -F '.' '{print $3}'`

	echo -n ${str1}.${str2}.${str3}.
}

bw_limit_disable_rule()
{
	local path=$1
	local type=$2
	local idx=`echo $path | awk -F '.' '{print $5}'`
	local igr_rate=0
	local egr_rate=0
	local flow_id=$(bw_limit_get_flow_idx ${type} ${idx})
	local car_id=$(bw_limit_get_car_idx ${type} ${idx})

	if [ "${type}" == "PerPort" ];then
		igr_rate=`cfgcmd get "${path}.Igr"`
		egr_rate=`cfgcmd get "${path}.Egr"`
		let igr_rate=$igr_rate*1000
		let egr_rate=$egr_rate*1000

		local lanpath=`cfgcmd get "${path}.LanPort"`	
		# Lan Port disable
		if [ ${idx} -le 4 ];then 
			# delete UP flow and car
			if [ "${igr_rate}" != "0" ];then
				cs_cli /home/cli/api/qos/del_flow -v index ${flow_id} ${DEBUG_OPT}
				cs_cli /home/cli/api/qos/del_car -v index ${car_id} ${DEBUG_OPT}
			fi

			# delete DS flow and car
			if [ "${egr_rate}" != "0" ];then
				let ds_flow_id=$flow_id+1	
				let ds_car_id=$car_id+1
				cs_cli /home/cli/api/qos/del_flow -v index ${ds_flow_id} ${DEBUG_OPT}
				cs_cli /home/cli/api/qos/del_car -v index ${ds_car_id} ${DEBUG_OPT}
			fi
		# SSID Port disable
		else 
			# delete UP flow and car
			if [ "${igr_rate}" != "0" ];then
				cs_cli /home/cli/api/qos/del_flow -v index ${flow_id} ${DEBUG_OPT}
				cs_cli /home/cli/api/qos/del_car -v index ${car_id} ${DEBUG_OPT}
			fi
					
			# delete DS flow and car
			if [ "${egr_rate}" != "0" ];then
				local ifname=`cfgcmd get "${lanpath}Name"`
				echo -n "del ${ifname}" > ${PROC_IFQOS}
				tc qdisc del dev ${ifname} root > /dev/null
			fi
		fi
	# IP rule disable
	else
		# if not ip dsdata file found, the rule isn't enabled.
		local ipdsfile=${bw_limit_dir}/${idx}.ipdsdata
		if [ ! -f ${ipdsfile} ];then
			return
		fi

		local lanstr=`cat ${ipdsfile} | grep "lanstr" | awk -F '=' '{print $2}'`
		local startip=`cat ${ipdsfile} | grep "startip" | awk -F '=' '{print $2}'`
		local endip=`cat ${ipdsfile} | grep "endip" | awk -F '=' '{print $2}'`
		local egrr=`cat ${ipdsfile} | grep "egr_rate" | awk -F '=' '{print $2}'`
		local igrr=`cat ${ipdsfile} | grep "igr_rate" | awk -F '=' '{print $2}'`
		rm -f ${ipdsfile}

		# delete UP flow and car
		if [ "${igrr}" != "0" ];then
			cs_cli /home/cli/api/qos/del_flow -v index ${flow_id}  ${DEBUG_OPT}
			cs_cli /home/cli/api/qos/del_car -v index ${car_id} ${DEBUG_OPT}
		fi

		if [ "${egrr}" == "0" ];then
			return
		fi

		# delete cfg for each IP, for IP range rule 
		let igr_rate=$igrr/1000
		let egr_rate=$egrr/1000
		while [ ${startip} -le ${endip} ]
		do
			tc qdisc delete dev br0 parent 1:2${startip} handle 2${startip}: sfq perturb 10
			tc filter delete dev br0 parent 1: protocol ip pref ${startip} u32
			tc class delete dev br0 parent 1:1 classid 1:2${startip} htb rate ${egr_rate}kbit ceil ${egr_rate}kbit prio 2 
			iptables -D flow_accel -o br0 --dst ${lanstr}${startip} -j MARK --set-mark 0x70000000/0xf0000000

			startip=`expr ${startip} + 1` 	
		done
	fi
}


bw_limit_enable_rule()
{
	local path=$1
	local type=$2
	local idx=`echo $path | awk -F '.' '{print $5}'`
	local igrr=`cfgcmd get "${path}.Igr"`
	local egrr=`cfgcmd get "${path}.Egr"`
	let igr_rate=$igrr*1000
	let egr_rate=$egrr*1000

	local flow_id=$(bw_limit_get_flow_idx ${type} ${idx})
	local car_id=$(bw_limit_get_car_idx ${type} ${idx})

	# TODO : caculate the best pbs, burst
	# when test with mobile phone, the result is always OK, using pbs 0x8000, 
	# but for some PC(wire, or wireless), using pbs 0x8000 will lead to low rate, 
	# they need a higher pbs than 0x8000.

	local wan_mask=$(bw_limit_get_wan_port_mask)

	if [ "${type}" == "PerPort" ];then
		local lanpath=`cfgcmd get "${path}.LanPort"`	
		# Lan Port enable 
		if [ ${idx} -le 4 ];then 
			local phyport=`cfgcmd get "${lanpath}X_TRI_PhyPort"`
			local igr_port_mask=`echo $phyport | awk '{print lshift(1,$phyport)}'`

			# add UP flow and car
			if [ "${igr_rate}" != "0" ]; then
				cs_cli /home/cli/api/qos/add_car -v index ${car_id} cir ${igr_rate} cbs 0x8000 pir ${igr_rate} pbs 0x8000 pps_en 0 ${DEBUG_OPT}
				cs_cli /home/cli/api/qos/add_flow -v index ${flow_id} valid 1 match_pri 1 car_id ${car_id} igr ${igr_port_mask} egr ${wan_mask} dport_min 0x0 dport_max 0xffff mask 0x04001D00 ${DEBUG_OPT}

			fi

			if [ "${egr_rate}" != "0" ]; then
				let ds_flow_id=$flow_id+1	
				let ds_car_id=$car_id+1
				let egr_port_mask=$igr_port_mask

				cs_cli /home/cli/api/qos/add_car -v index ${ds_car_id} cir ${egr_rate} cbs 0x8000 pir ${egr_rate} pbs 0x8000 pps_en 0 ${DEBUG_OPT}
				cs_cli /home/cli/api/qos/add_flow -v index ${ds_flow_id} valid 1 match_pri 1 car_id ${ds_car_id} egr ${egr_port_mask} igr ${wan_mask} dport_min 0x0 dport_max 0xffff mask 0x04001D00 ${DEBUG_OPT}
			fi

		# SSID Port enable 
		else 
			# add UP flow and car
			if [ "${igr_rate}" != "0" ]; then
				local wifi_port=0
				local svid=1

				local wifi_port_cfg="${bw_limit_dir}/wifi_phyport"
				if [ ! -f ${wifi_port_cfg} ] ;then
					echo "############# WIFI port cfg is lost !#############"
					return
				fi

				# band0: SSID1~4, band1: SSID5~8
				if [ ${idx} -le 8 ];then 
					wifi_port=`cat ${wifi_port_cfg} | grep "band0" | awk -F '=' '{print $2}'`
					svid=`expr $idx - 4`
				else
					wifi_port=`cat ${wifi_port_cfg} | grep "band1" | awk -F '=' '{print $2}'`
					svid=`expr $idx - 8`
				fi
				cs_cli /home/cli/api/qos/add_car -v index ${car_id} cir ${igr_rate} cbs 0x8000 pir ${igr_rate} pbs 0x8000 pps_en 0 ${DEBUG_OPT}
				cs_cli /home/cli/api/qos/add_flow -v index ${flow_id} valid 1 match_pri 1 car_id ${car_id} dport_min 0x0 dport_max 0xffff igr ${wifi_port} svid ${svid} egr ${wan_mask}  loop_pri 7  mask 0x0C041D00 ${DEBUG_OPT}
			fi
					
			# add DS flow and car
			if [ "${egr_rate}" != "0" ]; then
				local ifname=`cfgcmd get "${lanpath}Name"`
				let igr_rate=$igr_rate/1000
				let egr_rate=$egr_rate/1000

				echo -n "add ${ifname}" > ${PROC_IFQOS}
				tc qdisc del dev ${ifname} root > /dev/null
				tc qdisc add dev ${ifname} root handle 1: htb default 2
				tc class add dev ${ifname} parent 1:1 classid 1:2 htb rate ${egr_rate}kbit ceil ${egr_rate}kbit prio 2 
			fi
		fi
	# IP rule enable 
	else
		local IPmin=`cfgcmd get "${path}.Min"`
		local IPmax=`cfgcmd get "${path}.Max"`
		local startip=`echo "${IPmin}" | awk -F '.' '{print $4}'`
		local lanstr=$(bw_limit_get_ip_lan ${IPmin})
		local endip=0
		local step=0
		if [ "${IPmax}" == "" ]; then
			endip=$startip
			step=0
		else
			# GUI makes sure min and max are in the same mask 
			endip=`echo "${IPmax}" | awk -F '.' '{print $4}'`
			step=`expr ${endip} - ${startip}`
		fi

		# prepare for IP rule delete script
		echo "startip=${startip}" > ${bw_limit_dir}/${idx}.ipdsdata
		echo "endip=${endip}" >> ${bw_limit_dir}/${idx}.ipdsdata
		echo "lanstr=${lanstr}" >> ${bw_limit_dir}/${idx}.ipdsdata
		echo "egr_rate=${egr_rate}" >> ${bw_limit_dir}/${idx}.ipdsdata
		echo "igr_rate=${igr_rate}" >> ${bw_limit_dir}/${idx}.ipdsdata
		
		# add UP flow and car
		if [ "${igr_rate}" != "0" ]; then
			cs_cli /home/cli/api/qos/add_car -v index ${car_id} cir ${igr_rate} cbs 0x8000 pir ${igr_rate} pbs 0x8000 pps_en 0 ${DEBUG_OPT}
			cs_cli /home/cli/api/qos/add_flow -v index ${flow_id} valid 1 match_pri 1 car_id ${car_id} sip ${IPmin} sip_step ${step} dport_min 0x0 dport_max 0xffff mask 0x04000501 ${DEBUG_OPT}
		fi

		# add DS flow and car
		if [ "${egr_rate}" != "0" ]; then
			let igr_rate=$igr_rate/1000
			let egr_rate=$egr_rate/1000
			# add cfg for each IP, for IP range rule 
			while [ ${startip} -le ${endip} ]
			do
				iptables -A flow_accel -o br0 --dst ${lanstr}${startip} -j MARK --set-mark 0x70000000/0xf0000000
				tc class add dev br0 parent 1:1 classid 1:2${startip} htb rate ${egr_rate}kbit ceil ${egr_rate}kbit prio 2 
				tc qdisc add dev br0 parent 1:2${startip} handle 2${startip}: sfq perturb 10
				tc filter add dev br0 protocol ip prio ${startip} parent 1:0 u32 match ip dst ${lanstr}${startip} flowid 1:2${startip}

				startip=`expr ${startip} + 1` 	
			done
		fi
	fi
}

bw_limit_set_port_rule()
{
	local path=$rulelist
	local type=`echo $path | awk -F '.' '{print $4}'`
	if [ "${type}" != "PerPort" ]; then
		echo "Wrong rule type ${type}"
		return
	fi

	local en=`cfgcmd get "${path}.Enable"`	
	if [ "${en}" == "0" ]; then
		bw_limit_disable_rule $path	$type
	else
		bw_limit_enable_rule $path $type	
	fi
}

bw_limit_add_ip_rule()
{
	local path=$rulelist
	local type=`echo $path | awk -F '.' '{print $4}'`
	if [ "${type}" != "PerIP" ]; then
		echo "Wrong rule type ${type}"
		return
	fi

	local en=`cfgcmd get "${path}.Enable"`	
	# do nothing for a disable IP rule
	if [ "${en}" == "1" ]; then
		bw_limit_enable_rule $path $type	
	fi
}

bw_limit_del_ip_rule()
{
	local path=$rulelist
	local type=`echo $path | awk -F '.' '{print $4}'`
	if [ "${type}" != "PerIP" ]; then
		echo "Wrong rule type ${type}"
		return
	fi

	bw_limit_disable_rule $path	$type
}

case "${action}" in
	"add")
	# only PerIP will add rule
		bw_limit_add_ip_rule
		;;
	"del")
	# only PerIP will del rule
		bw_limit_del_ip_rule
		;;
	"set")
	# only PerPort will set rule
		bw_limit_set_port_rule
		;;
	"init")
	# init rules when system startup
		bw_limit_init
		;;
	*)
		;;
esac

rm -f ${bw_limit_lock_flag}

