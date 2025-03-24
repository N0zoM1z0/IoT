#!/bin/sh

. /usr/syscfg/usb/dongle/dongle.comm.sh
gen_ppp_config()
{
	${ECHO} "debug
nodetach
logfd 1
/dev/ttyUSB0
9600
user ${APN}@mycdma.cn
password vnet.mobi
crtscts
show-password
usepeerdns
noauth
noipdefault
novj
novjccomp
noccp
defaultroute
nolock
mru 1444
persist
ipcp-accept-local
ipcp-accept-remote" > ${PPP_Config}
	${ECHO} "connect \"/usr/sbin/chat '' \rATZ OK-AT-OK ATD${DialNumber} CONNECT \d\c"\" >> ${PPP_Config}
	${ECHO} "ip-up-script /etc/ppp/dongle-up" >> ${PPP_Config}
}

Stop_Air_ppp()
{
	pid=`${PS} | ${GREP} "${PPPD} ${PPP_Config}" | ${GREP} -v grep | ${CUT} -d " " -f 1`
	
	if [ "${pid}" != "" ]; then
		${KILL} $pid
		${SLEEP} 5
	fi
}

Launch_Air_ppp()
{
	Stop_Air_ppp

	gen_ppp_config

	if [ "$DialDelay" != "0" ];then
		${SLEEP} $DialDelay
	fi
	${PPPD} ${PPP_Config} &
}

Launch_Air()
{
	APN=`${GET_NODE} ${X_TRI_APN}`
	DialNumber=`${GET_NODE} ${X_TRI_DialNumber}`
	DialDelay=`${GET_NODE} ${X_TRI_DialDelay}`
	Enable=`${GET_NODE} ${CanBeDial}`
	
	if [ "${Enable}" == "1" ] && [ "${APN}" != "" ] && [ "${DialNumber}" != "" ];then
		${MKDIR} ${Prepare_Direct}
		Launch_Air_ppp
	fi
}

Stop_Air()
{
	Stop_Air_ppp
	${RM} ${Prepare_Direct}
	pidf="/tmp/PPP_3_1_1/pid_ppd"
	if [ -f ${pidf} ];then
		pid=`cat ${pidf}`
		kill ${pid}
	fi
}

Help_Air()
{
	${ECHO} "--------------------------------------------"
	${ECHO} "Usage: `${BASENAME} $0` <start|stop|restart>"
	${ECHO} "--------------------------------------------"
}

case "$1" in
	"start")
		Launch_Air
		;;
	"stop")
		Stop_Air
		;;
	"restart")
		Stop_Air
		Launch_Air
		;;
	*)
		Help_Air
		;;
esac
