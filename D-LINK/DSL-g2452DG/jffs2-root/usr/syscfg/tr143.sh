#!/bin/sh
. /usr/syscfg/wan.utils.sh

PerformanceDiagPATH="InternetGatewayDevice.Capabilities.PerformanceDiagnostic."
DownDiagPATH="InternetGatewayDevice.DownloadDiagnostics."
UpDiagPATH="InternetGatewayDevice.UploadDiagnostics."

stdfile="/tmp/tr143.log"


UploadDiagnostics()
{
	local utype=`cfgcmd get ${PerformanceDiagPATH}UploadTransports`

	local state=`cfgcmd get ${UpDiagPATH}DiagnosticsState`
	local ifname_path=`cfgcmd get ${UpDiagPATH}Interface`
	CONN_WAN_FOLDER=`gen_wanconn_folder ${ifname_path}`
	ifname=`get_wanconn_ifname ${CONN_WAN_FOLDER}`

	local url=`cfgcmd get ${UpDiagPATH}UploadURL`
	local dscp=`cfgcmd get ${UpDiagPATH}DSCP`
	local priority=`cfgcmd get ${UpDiagPATH}EthernetPriority`
	local length=`cfgcmd get ${UpDiagPATH}TestFileLength`
	
	killall tr143

	if [ "$state" == "Requested" -a -n ${url} ]; then
		cfgcmd set ${DownDiagPATH}DiagnosticsState None
		if [ -z ${ifname} ]; then
			tr143 -T $url -l $length -F $stdfile &
		else
			tr143 -T $url -l $length -I $ifname -F $stdfile &
		fi
	fi
}

DownloadDiagnostics()
{
	local dtype=`cfgcmd get ${PerformanceDiagPATH}DownloadTransports`
	
	local state=`cfgcmd get ${DownDiagPATH}DiagnosticsState`
	local ifname_path=`cfgcmd get ${DownDiagPATH}Interface`
	CONN_WAN_FOLDER=`gen_wanconn_folder ${ifname_path}`
	ifname=`get_wanconn_ifname ${CONN_WAN_FOLDER}`

	local url=`cfgcmd get ${DownDiagPATH}DownloadURL`
	local dscp=`cfgcmd get ${DownDiagPATH}DSCP`
	local priority=`cfgcmd get ${DownDiagPATH}EthernetPriority`

	killall tr143

	if [ "$state" == "Requested" -a -n ${url} ]; then
		cfgcmd set ${DownDiagPATH}DiagnosticsState None
		if [ -z ${ifname} ]; then
			tr143 -D $url -F $stdfile &
		else
			tr143 -D $url -I $ifname -F $stdfile &
		fi
	fi
}


case $1 in
	"up")
		UploadDiagnostics
		;;
	"down")
		DownloadDiagnostics
		;;
	*)
		;;
esac
