#!/bin/sh

ACTION=$1
CHECK_BAND=$2
ENABLE_PING=$3

echo ENABLE_PING = $ENABLE_PING

BANDS=
WLAN_INFO_PIDS=
PIDAPS=
PIDSYSTEM=
PIDMGT=
# PIDSWITCH=
PIDTOPOLOGY=
PIDWANPORTDETECT=
PIDBHOPT=
PIDBCMRUNNER=
PIDPINGMONITOR=

# 判断机型是qca方案还是bcm方案
if [ $(ifconfig | grep "^ath" | wc -l) -gt 0 ]; then
	PRODUCT=qca
else
	PRODUCT=bcm
fi
echo PRODUCT = $PRODUCT

# 判断是三频机型还是双频机型
if [ $PRODUCT == qca ]; then
	BANDNUM=$(ifconfig | grep "^wifi" | wc -l)
elif [ $PRODUCT == bcm ]; then
	BANDNUM=$(ifconfig | grep "^wl.[^.]" | wc -l)
fi
echo BANDNUM = $BANDNUM

if [ -f "/lib/libasan.so.2" ]; then
	export LD_PRELOAD="/lib/libasan.so.2"
fi

if [ -f "/lib/libubsan.so.0" ]; then
	export LD_PRELOAD="/lib/libubsan.so.0"
fi

run(){
	aps_info.sh &
	sleep 6s
	system_info.sh &
	sleep 6s
	mgt_sta_info.sh &
	sleep 6s
	topology_info.sh &
	sleep 6s
	wan_port_detect_info.sh &
	sleep 6s
	bh_optimize_info.sh &
	sleep 6s

	if [[ $PRODUCT == "bcm" ]]; then
		for BAND in $BANDS
		do
			/bin/brcm/wlan_info.sh ${BAND} dhd &
			sleep 6s
		done
		# /bin/brcm/switch_info.sh &
		# sleep 6s
		/bin/brcm/runner_info.sh &
	elif [[ $PRODUCT == "qca" ]]; then
		for BAND in $BANDS
		do
			/bin/qca/wlan_info.sh ${BAND} &
			sleep 6s
		done
		/bin/qca/switch_info.sh &
		sleep 6s
		/bin/qca/nss_info.sh &
		sleep 6s
	fi

	if [[ $ENABLE_PING == "--ping" ]]; then
		ping_monitor.sh &
	fi

	# 开启DHCPS debug
	log_conf --set_mask dhcps
	log_conf --set_level all
}

end(){
	for PID in $WLAN_INFO_PIDS;
	do
		kill -9 ${PID}
	done
	kill -9 ${PIDAPS}
	kill -9 ${PIDSYSTEM}
	kill -9 ${PIDMGT}
	kill -9 ${PIDTOPOLOGY}
	kill -9 ${PIDWANPORTDETECT}
	kill -9 ${PIDBHOPT}
	kill -9 ${PIDPINGMONITOR}
	if [[ $PRODUCT == "bcm" ]]; then
		kill -9 ${PIDBCMRUNNER}
		# kill -9 ${PIDBCMSWITCH}
	elif [[ $PRODUCT == "qca" ]]; then
		kill -9 ${PIDQCASWITCH}
		kill -9 ${PIDQCANSS}
	fi
	# 关闭DHCPS debug
	log_conf --set_mask dhcps --opt clear
	log_conf --set_level info
}

show_help () {
	echo "!!!!SYNTAX ERROR!!!!"
	echo "Syntax for dualband product: $0 <start|stop> <2G|5G|ALL> <--ping>"
	echo "Syntax for tripleband product: $0 <start|stop> <2G|5G1|5G4|ALL> <--ping>"
	exit
}

# Help option
if [ $# -eq 0 ] || [[ $# -eq 1 ]]; then
	show_help
	exit 0
fi

if [[ $PRODUCT == "bcm" ]]; then
	# PIDBCMSWITCH=$(ps | grep switch_info | awk '{print $1}')
	PIDBCMRUNNER=$(ps | grep runner_info | awk '{print $1}')
	if [ $BANDNUM -eq 2 ]; then
		if [[ $CHECK_BAND == "ALL" ]]; then
			BANDS="wl0 wl1"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | awk '{print $1}')
		elif [[ $CHECK_BAND == "2G" ]]; then
			BANDS="wl0"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | grep $BANDS | awk '{print $1}')
		elif [[ $CHECK_BAND == "5G" ]]; then
			BANDS="wl1"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | grep $BANDS | awk '{print $1}')
		else
			show_help
			exit 0
		fi
	elif [ $BANDNUM -eq 3 ]; then
		if [[ $CHECK_BAND == "ALL" ]]; then
			BANDS="wl0 wl1 wl2"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | awk '{print $1}')
		elif [[ $CHECK_BAND == "2G" ]]; then
			BANDS="wl0"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | grep $BANDS | awk '{print $1}')
		elif [[ $CHECK_BAND == "5G1" ]]; then
			BANDS="wl1"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | grep $BANDS | awk '{print $1}')
		elif [[ $CHECK_BAND == "5G4" ]]; then
			BANDS="wl2"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | grep $BANDS | awk '{print $1}')
		else
			show_help
			exit 0
		fi
	fi
elif [[ $PRODUCT == "qca" ]]; then
	PIDQCANSS=$(ps | grep nss_info | awk '{print $1}')
	PIDQCASWITCH=$(ps | grep switch_info | awk '{print $1}')
	if [ $BANDNUM -eq 2 ]; then
		if [[ $CHECK_BAND == "ALL" ]]; then
			BANDS="wifi0 wifi1"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | awk '{print $1}')
		elif [[ $CHECK_BAND == "2G" ]]; then
			BANDS="wifi0"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | grep $BANDS | awk '{print $1}')
		elif [[ $CHECK_BAND == "5G" ]]; then
			BANDS="wifi1"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | grep $BANDS | awk '{print $1}')
		else
			show_help
			exit 0
		fi
	elif [ $BANDNUM -eq 3 ]; then
		if [[ $CHECK_BAND == "ALL" ]]; then
			BANDS="wifi0 wifi1 wifi2"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | awk '{print $1}')
		elif [[ $CHECK_BAND == "2G" ]]; then
			BANDS="wifi0"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | grep $BANDS | awk '{print $1}')
		elif [[ $CHECK_BAND == "5G1" ]]; then
			BANDS="wifi1"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | grep $BANDS | awk '{print $1}')
		elif [[ $CHECK_BAND == "5G4" ]]; then
			BANDS="wifi2"
			WLAN_INFO_PIDS=$(ps | grep wlan_info | grep $BANDS | awk '{print $1}')
		else
			show_help
			exit 0
		fi
	fi
fi

PIDAPS=$(ps | grep aps_info | awk '{print $1}')
PIDSYSTEM=$(ps | grep system_info | awk '{print $1}')
PIDMGT=$(ps | grep mgt_sta_info | awk '{print $1}')
PIDTOPOLOGY=$(ps | grep topology_info | awk '{print $1}')
# ps指令输出的进程长度有限，只能显示到{wan_port_detect} /bin/sh ./wan_port_detect_i，
# 因此这里仅利用“wan_port_detect_”进行过滤
PIDWANPORTDETECT=$(ps | grep wan_port_detect_ | awk '{print $1}')
PIDBHOPT=$(ps | grep bh_optimize_info | awk '{print $1}')
PIDPINGMONITOR=$(ps | grep ping_monitor | awk '{print $1}')

if [[ $ACTION == "start" ]]; then
	run
fi

if [[ $ACTION == "stop" ]]; then
	end
fi
