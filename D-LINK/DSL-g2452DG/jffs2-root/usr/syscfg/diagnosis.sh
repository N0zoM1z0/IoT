#!/bin/sh
. /usr/syscfg/comm.utils.sh
. /usr/syscfg/api_dns.sh
. /usr/syscfg/getifname.sh
trace()
{
    DiagCon="/tmp/.tracertDiag"
    TRACE_PATH="InternetGatewayDevice.TraceRouteDiagnostics"
    TRACEROUTE_HOST=`cfgcmd get "${TRACE_PATH}.Host"`
    TRACEROUTE_MAXTTL=`cfgcmd get "${TRACE_PATH}.MaxHopCount"`
    TRACEROUTE_WaitTime=`cfgcmd get "${TRACE_PATH}.Timeout"`
    TRACEROUTE_DateSize=`cfgcmd get "${TRACE_PATH}.DataBlockSize"`
    TRACEROUTE_pkgperhops=`cfgcmd get "${TRACE_PATH}.NumberOfTries"`
    interface_path=`cfgcmd get "${TRACE_PATH}.Interface"`
    
    submit=`cfgcmd get ${TRACE_PATH}.websubmit`
    inform="1"
    if [ "${submit}" == "1" ]; then
        cfgcmd sset ${TRACE_PATH}.websubmit 0
        inform="0"
    fi

    ##delete last node value
    indexes=`cfgcmd get_idxes ${TRACE_PATH}.RouteHops`
    if [ "$indexes" != "0" ]; then
        for i in $indexes ; do
            cfgcmd del_obj "${TRACE_PATH}.RouteHops.$i."
        done
    fi

    ## "ms" to "s"
    TRACEROUTE_WaitTime=`expr $TRACEROUTE_WaitTime / 1000`  
    if [ "${TRACEROUTE_WaitTime}" == "0" ]; then
        TRACEROUTE_WaitTime="1"
    fi
    OPTION="-I -w ${TRACEROUTE_WaitTime} -m ${TRACEROUTE_MAXTTL} -q $TRACEROUTE_pkgperhops"

    #如果host为域名并且指定了interface,则先通过域名解析出ip再执行ping命令
    if [ "${interface_path}" != "" -a `is_valid_ip $TRACEROUTE_HOST` -eq 0 ]; then
        TRACEROUTE_HOST=`dns_query_4 $TRACEROUTE_HOST $interface_path`
    fi

    # 如果域名解析失败，则直接设置为Error_CannotResolveHostName返回
    if [ `is_valid_ip $TRACEROUTE_HOST` -eq 0 ]; then
        cfgcmd sset ${TRACE_PATH}.DiagnosticsState Error_CannotResolveHostName
    else
        `add_static_route $TRACEROUTE_HOST $interface_path`
        traceroute ${OPTION} ${TRACEROUTE_HOST} $TRACEROUTE_DateSize> $DiagCon # traceroute -I -w 5 -m 30 -q 3 8.8.8.8 38
        `del_static_route $TRACEROUTE_HOST $interface_path`
    
        ##TODO generate diag file to a valid format
        err_maxhops=0
        tracehops=`cat $DiagCon | wc -l`
        line=2
        while [ $line -le $tracehops ]
        do
            ## FMT: Time1,Time2,Time3 Host (HostIP) ErrNum ErrCode  e.g. "0.794,0.754,0.768 192.168.1.10 (192.168.1.10) 3 !H"
            local linetxt=`sed -n ${line}p $DiagCon | awk '{errnum=0; for (i=2;i<=NF;i++) {if ($i~/^\([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\)$/) {ip=$i; host=$(i-1);} if ($i=="ms") printf ",%d",$(i-1);if ($i=="*") printf ",*"; if ($i~/^!/) {errcode=$i;errnum++;}} printf " %s %s %d %s",host,ip,errnum,errcode}'`
            linetxt=${linetxt/,/} #去掉前面的逗号
    
            ## if number of '*' was equals to pkg number, this hop is timeout, not error, skip this hop
            local starnum=`echo $linetxt | grep -o '*' | wc -l`
            if [ "$starnum" == "$TRACEROUTE_pkgperhops" ]; then
                line=`expr $line + 1`
                if [ $line -gt $tracehops ]; then
                    err_maxhops=1
                    break
                fi
                continue
            fi
    
            local idx=`cfgcmd add_obj ${TRACE_PATH}.RouteHops`
    
            local hoprttime=`echo $linetxt | awk '{print $1}'`
            hoprttime=${hoprttime//'*,'/}
            hoprttime=${hoprttime//',*'/}
            local hophost=`echo $linetxt | awk '{print $2}'`
            local hophostaddr=`echo $linetxt | awk '{print $3}'`
            hophostaddr=${hophostaddr//(/}
            hophostaddr=${hophostaddr//)/}
            local errnum=`echo $linetxt | awk '{print $4}'`
            local hoperrid=0
            if [ "$errnum" == "$TRACEROUTE_pkgperhops" ]; then
                errcode=`echo $linetxt | awk '{print $5}'`
                ## set HopErrorCode
                case "$errcode" in
                    "!N") # ICMP_UNREACH_NET
                        hoperrid=0
                        ;;
                    "!H") # ICMP_UNREACH_HOST
                        hoperrid=1
                        ;;
                    "!P") # ICMP_UNREACH_PROTOCOL
                        hoperrid=2
                        ;;
                    "!") # ICMP_UNREACH_PORT
                        hoperrid=3
                        ;;
                esac
            fi
            cfgcmd sset ${TRACE_PATH}.RouteHops.$idx.HopHost "$hophost"
            cfgcmd sset ${TRACE_PATH}.RouteHops.$idx.HopHostAddress "$hophostaddr"
            cfgcmd sset ${TRACE_PATH}.RouteHops.$idx.HopErrorCode "$hoperrid"
            cfgcmd sset ${TRACE_PATH}.RouteHops.$idx.HopRTTimes "$hoprttime"
    
            line=`expr $line + 1`
        done
    
        if [ "$hoprttime" != "" -a "$hoperrid" == "0" ]; then
            responsetime=`echo $hoprttime | awk -F ',' '{printf "%d",$NF}'`
            cfgcmd sset ${TRACE_PATH}.ResponseTime $responsetime
        fi
    
        hopnum=`cfgcmd get ${TRACE_PATH}.RouteHopsNumberOfEntries`
        if [ "${hopnum}" == "0" ]; then
            cfgcmd sset ${TRACE_PATH}.DiagnosticsState None
        elif [ "$err_maxhops" == "1" ]; then
            cfgcmd sset ${TRACE_PATH}.DiagnosticsState Error_MaxHopCountExceeded
        else
            cfgcmd sset ${TRACE_PATH}.DiagnosticsState Complete
        fi
    fi #end of `is_valid_ip $TRACEROUTE_HOST`

    #如果是tr069的请求，需要上报
    if [ "${inform}" == "1" ]; then
        cfgcmd manully_inform EV DC
    fi
}

dia_ping()
{
	PING_PATH="InternetGatewayDevice.IPPingDiagnostics"	
	option="-q"
	PING_RESULT_FILEPATH="/tmp/ping_info"

	rm $PING_RESULT_FILEPATH -f

	submit=`cfgcmd get ${PING_PATH}.websubmit`
	inform="1"
	if [ "${submit}" == "1" ]; then
		cfgcmd sset ${PING_PATH}.websubmit 0 > /dev/null
		inform="0"
	fi

	############### 生成ping参数 ###############
	size=`cfgcmd get ${PING_PATH}.DataBlockSize`
	option="$option -s ${size}"

	NumberOfRepetitions=`cfgcmd get ${PING_PATH}.NumberOfRepetitions`
	option="$option -c ${NumberOfRepetitions}"
	
	timeout=`cfgcmd get ${PING_PATH}.Timeout`
	timeout=`expr $timeout / 1000`
	if [ "${timeout}" == "0" ]; then
		timeout="1"
	fi
	option="$option -W ${timeout}"

	protocol=`cfgcmd get ${PING_PATH}.Protocol`	
	if [ "${protocol}" == "IPv4" ]; then
		ip_ver="-4"
	elif [ "${protocol}" == "IPv6" ]; then
		ip_ver="-6"
	fi
	option="$option ${ip_ver}"

	interface_path=`cfgcmd get ${PING_PATH}.Interface`
	interface=`GetIfName "${interface_path}"`
	if [ -n "${interface}" ]; then
		option="$option -I ${interface}"
	fi
	echo option=$option

	############### 执行ping命令 ###############	
	host=`cfgcmd get ${PING_PATH}.Host`
	if [ "${protocol}" == "IPv6" ]; then
		ping ${option} ${host} > $PING_RESULT_FILEPATH
	else
		#如果host为域名并且指定了Interface,则先解析出ip，用于增加静态路由
		if [ `is_valid_ip $host` -eq 0 -a -n "$interface_path" ]; then
			host_ip=`dns_query_4 $host $interface_path`
			if [ `is_valid_ip $host_ip` -eq 1 ]; then
				`add_static_route $host_ip $interface_path`
				ping ${option} ${host_ip} > $PING_RESULT_FILEPATH
				`del_static_route $host_ip $interface_path`
			else
				echo query ip failed, host=$host, host_ip=$host_ip!
				cfgcmd sset ${PING_PATH}.DiagnosticsState Error_CannotResolveHostName > /dev/null
			fi
		else
			ping ${option} ${host} > $PING_RESULT_FILEPATH
		fi		
	fi


	############### 解析结果 ###############
	failurecount=$NumberOfRepetitions #这里必须赋值, 因为PING_RESULT_FILEPATH可能不存在
	if [ -f $PING_RESULT_FILEPATH ]; then
		# 只要结果存在, 就设置诊断状态为Complete
		cfgcmd sset ${PING_PATH}.DiagnosticsState Complete > /dev/null

		timeinfo=`cat $PING_RESULT_FILEPATH | sed -n '5p' | awk '{print $4}'`
		avgtime=`echo $timeinfo | cut -d / -f 2 | cut -d . -f 1`
		mintime=`echo $timeinfo | cut -d / -f 1 | cut -d . -f 1`
		maxtime=`echo $timeinfo | cut -d / -f 3 | cut -d . -f 1`
		if [ "$avgtime" == "" ]; then
		    avgtime=0
		else
		    avgtime=`expr $avgtime + 1`
		fi
		if [ "$mintime" == "" ]; then
		    mintime=0
		else
		    mintime=`expr $mintime + 1`
		fi
		if [ "$maxtime" == "" ]; then
		    maxtime=0
		else
		    maxtime=`expr $maxtime + 1`
		fi

		successcount=`cat $PING_RESULT_FILEPATH | sed -n '4p' | awk '{print $4}'`
		if [ -z "$successcount" ]; then
			successcount=0
		fi
		failurecount=`expr $NumberOfRepetitions - $successcount`
	fi	


	############### 将结果写入xml中 ###############	
	cfgcmd sset ${PING_PATH}.SuccessCount ${successcount} > /dev/null
	cfgcmd sset ${PING_PATH}.FailureCount ${failurecount} > /dev/null
	cfgcmd sset ${PING_PATH}.AverageResponseTime ${avgtime} > /dev/null
	cfgcmd sset ${PING_PATH}.MinimumResponseTime ${mintime} > /dev/null
	cfgcmd sset ${PING_PATH}.MaximumResponseTime ${maxtime}  > /dev/null
	if [ "${inform}" == "1" ]; then
		cfgcmd manully_inform EV DC > /dev/null
	fi
}


dns()
{
	DNS_PATH="InternetGatewayDevice.X_CT-COM_DnsQuery"
	interface_path=`cfgcmd get ${DNS_PATH}.Interface`

	if [ "${interface_path}" == "" ]; then
		cfgcmd sset ${DNS_PATH}.ResolveStates 0
		exit 1
	fi

	url=`cfgcmd get ${DNS_PATH}.URL`
	protocol=`cfgcmd get ${DNS_PATH}.Protocol`
	if [ "$protocol" == "IPv4" ]; then		
		dns_ip=`dns_query_4 $url ${interface_path}`
	elif [ "$protocol" == "IPv6" ]; then		
		dns_ip=`dns_query_6 $url ${interface_path}`
	fi

	if [ "${dns_ip}" == "" ]; then
		resolve=0
	else
		resolve=1
		cfgcmd sset ${DNS_PATH}.Ipaddress "${dns_ip}"
	fi
	cfgcmd sset ${DNS_PATH}.ResolveStates "${resolve}"
}


http()
{
	HTTP_PATH="InternetGatewayDevice.X_CT-COM_HttpRequest"
	interface_path=`cfgcmd get ${HTTP_PATH}.Interface`
	interface=`GetIfName "${interface_path}"`
	url=`cfgcmd get ${HTTP_PATH}.URL`
	protocol=`cfgcmd get ${HTTP_PATH}.Protocol`
	code_path="${HTTP_PATH}.StatusCode"
	sta_path="${HTTP_PATH}.DiagnosticsState"
	ipver=""
	if [ "$protocol" == "IPv4" ]; then
		ipver="-4"
	else
		ipver="-6"
	fi
	code=`/usr/bin/curl --interface "${interface}" -l -m 10 -o /dev/null -s ${ipver} -w %{http_code} ${url}`
	if [ "$code" -ge "200" -a "$code" -lt "309" ]; then
		cfgcmd sset $code_path $code
		cfgcmd sset $sta_path OK
	else
		cfgcmd sset $code_path $code
		cfgcmd sset $sta_path ERROR
	fi
}


case "$1" in
	"http")
		http
		;;
	"ping")
		dia_ping
		;;
	"dns")
		dns
		;;
	"route")
		trace
		;;
	*)
		;;
esac
