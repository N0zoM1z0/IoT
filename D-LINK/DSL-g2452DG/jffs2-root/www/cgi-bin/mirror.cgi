#!/bin/sh
type=`echo ${QUERY_STRING} | cut -d = -f 3 | cut -d ? -f 1`
case "$type" in
"1") #get Enable
	ingressEnable=`cs_cli /home/cli/debug/sdk/sd56xx/level_0/port/get_mrr_attr -v dir 0 | grep mrr_en | awk '{print $4}'`

	egressEnable=`cs_cli /home/cli/debug/sdk/sd56xx/level_0/port/get_mrr_attr -v dir 1 | grep mrr_en | awk '{print $4}'`

	if [ "${ingressEnable}" == "00000000" ]; then
		inEnable=0
	else
		inEnable=1
	fi

	if [ "${egressEnable}" == "00000000" ]; then
		eEnable=0
	else
		eEnable=1
	fi

	ingressDport_hex=`cs_cli /home/cli/debug/sdk/sd56xx/level_0/port/get_mrr_attr -v dir 0 | grep dport | awk '{print $4}'`	
	ingressDport=`printf "%d" 0x${ingressDport_hex}`

	egressDport_hex=`cs_cli /home/cli/debug/sdk/sd56xx/level_0/port/get_mrr_attr -v dir 1 | grep dport | awk '{print $4}'`			
	egressDport=`printf "%d" 0x${egressDport_hex}`
	echo "Pragma: no-cache\n"
	echo "Cache-control: no-cache\n"
	echo "Content-type: text/html"
	echo ""
	echo "${inEnable}[-]${eEnable}[-]${ingressDport}[-]${egressDport}[-]"
	;;
"2") #close
	cs_cli /home/cli/debug/sdk/sd56xx/level_0/port/set_mrr_attr -v dir 0 mrr_en 0 	
	cs_cli /home/cli/debug/sdk/sd56xx/level_0/port/set_mrr_attr -v dir 1 mrr_en 0 	
	mirror=`lsmod | grep 'nic_mirror'`
	if [ -n "$mirror" ];then
		rmmod nic_mirror.ko
	fi
	;;
"3") #open
	mode=`echo ${QUERY_STRING} | cut -d = -f 4 | cut -d ? -f 1`
	sPort=`echo ${QUERY_STRING} | cut -d = -f 5 | cut -d ? -f 1`
	dPort=`echo ${QUERY_STRING} | cut -d = -f 6 | cut -d ? -f 1`
	
	if [ "${mode}" == "1" ]; then
		cs_cli /home/cli/debug/sdk/sd56xx/level_0/port/set_mrr_attr -v dir 0 mrr_en 1 sport $sPort dport $dPort 
		modeName='rx'
	elif [ "${mode}" == "2" ]; then
		cs_cli /home/cli/debug/sdk/sd56xx/level_0/port/set_mrr_attr -v dir 1 mrr_en 1 sport $sPort dport $dPort 
		modeName='tx'
	elif [ "${mode}" == "0" ]; then
		cs_cli /home/cli/debug/sdk/sd56xx/level_0/port/set_mrr_attr -v dir 0 mrr_en 1 sport $sPort dport $dPort 
		cs_cli /home/cli/debug/sdk/sd56xx/level_0/port/set_mrr_attr -v dir 1 mrr_en 1 sport $sPort dport $dPort 
		modeName='both'
	fi

	mirror=`lsmod | grep 'nic_mirror'`
	if [ -z "$mirror" ];then
		ipInterface=`ifconfig | grep 'ip_3' | awk '{print $1}'`
		pppInterface=`ifconfig | grep 'ppp' | awk '{print $1}'`
		let "dPort-=6"
		dst=`ifconfig | grep eth0.$dPort | awk '{print $1}'`
		if [ -n "$ipInterface" -a -n "$dst" ];then
			insmod /lib/modules/3.14.18/nic_mirror.ko mode=$modeName src=$ipInterface dst=$dst debug=1
		elif [ -n "$pppInterface" -a -n "$dst" ];then
			insmod /lib/modules/3.14.18/nic_mirror.ko mode=$modeName src=$pppInterface dst=$dst debug=1
		fi
	fi
	;;
esac
