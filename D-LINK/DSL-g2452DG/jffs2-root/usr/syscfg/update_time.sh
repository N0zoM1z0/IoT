#!/bin/sh
#
# usage: update_time

. /usr/syscfg/comm.utils.sh
. /usr/syscfg/api_dns.sh

TIME_PATH="InternetGatewayDevice.Time"
cfgcmd=/usr/sbin/cfgcmd
ip=/usr/sbin/ip

status_path="${TIME_PATH}.Status"
ENABLE=`${cfgcmd} get ${TIME_PATH}.Enable`

if [ "${ENABLE}" == "0" ]; then
	echo "NTP is disable"
	${cfgcmd} sset ${status_path} Disable
	exit 1
fi



interval=`${cfgcmd} get ${TIME_PATH}.X_CT-COM_NTPInterval`
reinterval=`${cfgcmd} get ${TIME_PATH}.X_CT-COM_RetryInterval`
# when one server do not response try next time, 's'
tryNextServerTime=5

server1=`${cfgcmd} get ${TIME_PATH}.NTPServer1`
server2=`${cfgcmd} get ${TIME_PATH}.NTPServer2`
server3=`${cfgcmd} get ${TIME_PATH}.NTPServer3`
server4=`${cfgcmd} get ${TIME_PATH}.NTPServer4`
server5=`${cfgcmd} get ${TIME_PATH}.NTPServer5`

SERVERS="$server1 $server2 $server3 $server4 $server5"

currenttime=`${cfgcmd} get ${TIME_PATH}.CurrentLocalTime`
timezone=`${cfgcmd} get ${TIME_PATH}.LocalTimeZone`
timezonename=`${cfgcmd} get ${TIME_PATH}.LocalTimeZoneName`
ST_enable=`${cfgcmd} get ${TIME_PATH}.DaylightSavingsUsed`
ST_start=`${cfgcmd} get ${TIME_PATH}.DaylightSavingsStart`
ST_end=`${cfgcmd} get ${TIME_PATH}.DaylightSavingsEnd`
ServerType=`${cfgcmd} get ${TIME_PATH}.X_CT-COM_NTPServerType`

set_date()
{
	y=`/bin/date +%Y`
	m=`/bin/date +%m`
	d=`/bin/date +%d`
	h=`/bin/date +%H`
	M=`/bin/date +%M`
	r1=`expr $y\%4`
	r2=`expr $y\%100`
	r3=`expr $y\%400`
	case $m in
	01|03|05|07|08|10|12)day=31;;
	04|06|09|11)day=30;;
	esac
	if [ $m -eq 02 ]; then
		if [ ${r1} -eq 0 -a ${r2} -ne 0 -o ${r3} -eq 0 ];then
			day=29
		else
			day=28
		fi
	fi
	d_change_sta=0
	m_change_sta=0
	h=`expr $h + 1`
	if [ $h == "24" ]; then
		$h="00";
		$d=`expr $d + 1`
		d_change_sta=1
	fi
	
	case $day in
	28)
		if [ $d -gt "28" ]; then
			d=1
			m=`expr $m + 1`
			m_change_sta=1
		fi
		;;
	29)
		if [ $d -gt "29" ]; then
			d=1
			m=`expr $m + 1`
			m_change_sta=1
		fi
		;;
	30)
		
		if [ $d -gt "30" ]; then
			d=1
			m=`expr $m + 1`
			m_change_sta=1
		fi
		;;
	31)
	
		if [ $d -gt "31" ]; then
			d=1
			m=`expr $m + 1`
			m_change_sta=1
		fi
		;;
	esac
	if [ $m -gt "12" ];then
		m=1
		y=`expr $y + 1`
	fi
	if [ $d -lt 10 -a ${d_change_sta} == 1 ];then
		d="0${d}"
	fi
	if [ $m -lt 10 -a ${m_change_sta} == 1 ];then
		m="0${m}"
	fi
	if [ $h -lt 10 ];then
		h="0${h}"
	fi
	date -s "${y}${m}${d}${h}${M}"
}

#=========zone set start==========
option=`echo ${timezone} | cut -b 1`
if [ "${option}" == "-" ]; then
	zonename=GMT+
elif [ "${option}" == "+" ]; then
	zonename=GMT-
fi
option_flag=`echo ${timezone} | cut -b 2`
if [ "${option_flag}" == "0"  ]; then
	option=`echo ${timezone} |cut -d : -f 1 | cut -d 0 -f 2`
else
	option=`echo ${timezone} |cut -d : -f 1 | cut -d ${option} -f 2`
fi
zonename="${zonename}${option}"
if [ "${timezone}" == "+00:00" ]; then
	zonename="GMT-0"
fi

/bin/cp /usr/share/zoneinfo/${zonename} /tmp/localtime
#if [ "${timezone}" == "+08:00" ]; then
#	/bin/cp /usr/share/zoneinfo/Asia/Shanghai /tmp/localtime
#fi

## set kernel timezone
date -k /tmp/localtime
#=========zone set end==========

#=========ifname select start========
if [ "${ServerType}" == "0" ]; then
	ServerTypeStrLoc="INTERNET"
elif [ "${ServerType}" == "1" ]; then
	ServerTypeStrLoc="VOIP"
elif [ "${ServerType}" == "2" ]; then
	ServerTypeStrLoc="TR069"
elif [ "${ServerType}" == "3" ]; then
	ServerTypeStrLoc="OTHER"
fi

while :
do
    wanPath="" #每次循环都要初始化为空

    #wanDevs 循环
    wanDevs=`${cfgcmd} get_idxes InternetGatewayDevice.WANDevice.`
    for i in ${wanDevs} ; do
    	wanConnDevs=`${cfgcmd} get_idxes InternetGatewayDevice.WANDevice."$i".WANConnectionDevice`
    	if [ "${wanConnDevs}" != "0" ]; then
    		for s in $wanConnDevs ; do
    			wanPPPs=`${cfgcmd} get_idxes InternetGatewayDevice.WANDevice."$i".WANConnectionDevice."$s".WANPPPConnection`
    			if [ "${wanPPPs}" != "0" ]; then
    				for x in $wanPPPs ; do
    					ServerTypeStr=`${cfgcmd} get InternetGatewayDevice.WANDevice."$i".WANConnectionDevice."$s".WANPPPConnection."$x".X_CT-COM_ServiceList`
    					echo "$ServerTypeStr" |grep -q "$ServerTypeStrLoc"
    					if [ $? -eq 0 ]; then 
    						#bridge是在PPP的WANC下实现，所以需要判断是否是BRIDGE,如果是则继续找。另外route模式 没有ip都不进行。
    						if [ -e "/tmp/PPP_${i}_${s}_${x}/ip_address" ]; then
    							wanPath="InternetGatewayDevice.WANDevice.${i}.WANConnectionDevice.${s}.WANPPPConnection.${x}"
    							break;
    						fi
    					fi
    				done
    			fi
    
    			wanIPs=`${cfgcmd} get_idxes InternetGatewayDevice.WANDevice."$i".WANConnectionDevice."$s".WANIPConnection`
    			if [ "${wanIPs}" != "0" ]; then
    				for y in $wanIPs ; do
    					ServerTypeStr=`${cfgcmd} get InternetGatewayDevice.WANDevice."$i".WANConnectionDevice."$s".WANIPConnection."$y".X_CT-COM_ServiceList`
    					echo "$ServerTypeStr" |grep -q "$ServerTypeStrLoc"
    					if [ $? -eq 0 ]; then 
    						#bridge是在IP的WANC下实现，所以需要判断是否是BRIDGE,如果是则继续找。另外route模式 没有ip都不进行。
    						if [ -e "/tmp/IP_${i}_${s}_${y}/ip_address" ]; then
    							wanPath="InternetGatewayDevice.WANDevice.${i}.WANConnectionDevice.${s}.WANIPConnection.${y}"
    							break;
    						fi
    					fi
    				done
    			fi
    	
    			if [ "${wanPath}" != "" ]; then
    				break
    			fi
    		done
    		if [ "${wanPath}" != "" ]; then
    			break
    		fi
    	fi
    done
    #=========ifname select end==========

	if [ "${wanPath}" != "" ]; then
		syn_sta=0 # 需要先初始化,否则server为空时, 同步状态不正常
		for k in $SERVERS ; do
			${cfgcmd} sset ${status_path} Synchronizing > /dev/null

			#判断server如果是 域名，则进行域名解析
			if [ `is_valid_ip $k` -eq 1 ]; then
				ipaddr=$k
			else
				ipaddr=`dns_query_4 ${k} ${wanPath}`
			fi
			if [ `is_valid_ip $ipaddr` -eq 0 ]; then
				continue
			fi

			# 添加静态路由
			add_static_route $ipaddr $wanPath

			#运行ntpclient
			wanc_dir=`gen_wanconn_folder $wanPath`
			ifname=`get_wanconn_ifname $wanc_dir`
			ntp_info=`ntpclient -s -t -i "$tryNextServerTime" -h "$ipaddr" -e "$ifname"`

			#删除静态路由
			del_static_route $ipaddr $wanPath

			#根据ntp的结果判断是否需要继续同步
			if [ "${ntp_info}" == "" ]; then
				syn_sta=0
				continue
			else
				${cfgcmd} sset ${status_path} Synchronized > /dev/null
				syn_sta=1
				break
			fi
		done
		if [ "${syn_sta}" == "0" ]; then
			${cfgcmd} sset ${status_path} Error_FailedToSynchronize > /dev/null
			sleep $reinterval		
			continue
		fi

		if [ "${ST_enable}" == "1" ]; then
			now_date=`date +%Y%m%d%H%M`
			start_date=`echo ${ST_start} | cut -d \- -f 1`
			tmp=`echo ${ST_start} | cut -d \- -f 2`
			start_date="${start_date}${tmp}"
			tmp=`echo ${ST_start} | cut -d \- -f 3 | cut -d T -f 1`
			start_date="${start_date}${tmp}"
			tmp=`echo ${ST_start} | cut -d \- -f 3 | cut -d T -f 2 | cut -d : -f 1`
			start_date="${start_date}${tmp}"			
			tmp=`echo ${ST_start} | cut -d \- -f 3 | cut -d T -f 2 | cut -d : -f 2`
			start_date="${start_date}${tmp}"

			end_date=`echo ${ST_end} | cut -d \- -f 1`
			tmp=`echo ${ST_end} | cut -d \- -f 2`
			end_date="${end_date}${tmp}"
			tmp=`echo ${ST_end} | cut -d \- -f 3 | cut -d T -f 1`
			end_date="${end_date}${tmp}"
			tmp=`echo ${ST_end} | cut -d \- -f 3 | cut -d T -f 2 | cut -d : -f 1`
			end_date="${end_date}${tmp}"
			tmp=`echo ${ST_end} | cut -d \- -f 3 | cut -d T -f 2 | cut -d : -f 2`
			end_date="${end_date}${tmp}"
			if [ ${now_date} -ge ${start_date} -a ${now_date} -le ${end_date} ]; then
				set_date
			fi
		fi
		sleep $interval 
		
	else
		#echo "sntpclient: make sure you have the ${ServerTypeStrLoc} wan connection, and the wanConn is up."
		${cfgcmd} sset ${status_path} Error_FailedToSynchronize > /dev/null
		sleep $reinterval	
	fi
done

