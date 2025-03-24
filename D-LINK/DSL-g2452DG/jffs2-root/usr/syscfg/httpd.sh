#!/bin/sh
cmd=$1

ps_uhttpd="/tmp/.ps_httpd"
if [ "$cmd" == "restart" ];then
    ps | grep uhttpd | grep -v grep | awk '{for(i=4;i<=NF;i++)printf("%s ",$i);}' > $ps_uhttpd
    chk_cmd=`cat $ps_uhttpd`
	if [ -n "$chk_cmd" ];then
	    echo "&" >> $ps_uhttpd
	    sleep 4
	    cfgcmd sset InternetGatewayDevice.DeviceInfo.X_TRI-RestartWeb 0
	    killall -11 uhttpd
	    sh $ps_uhttpd
	else
		cfgcmd sset InternetGatewayDevice.DeviceInfo.X_TRI-RestartWeb 0
    fi
fi