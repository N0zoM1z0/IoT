#!/bin/sh

PerformanceDiagPATH="InternetGatewayDevice.Capabilities.PerformanceDiagnostic."
DownDiagPATH="InternetGatewayDevice.DownloadDiagnostics."
UpDiagPATH="InternetGatewayDevice.UploadDiagnostics."

stdfile="/tmp/tr143.log"

find_test_result()
{	
	if [ "$1" == "upload" ]; then
		DPATH=$UpDiagPATH
	else
		DPATH=$DownDiagPATH
	fi

	if [ -e $stdfile ]; then
		err=`grep "DiagnosticsState" $stdfile | cut -d : -f 2 | awk '{print $1}'`
		if [ ! -z $err ]; then
			cfgcmd set ${DPATH}DiagnosticsState $err
		else
			tcpreq=`grep "TCPOpenRequestTime" $stdfile | cut -d = -f 2 | awk '{print $1}'`
			tcpack=`grep "TCPOpenResponseTime" $stdfile | cut -d = -f 2 | awk '{print $1}'`
			romtime=`grep "ROMTime" $stdfile | cut -d = -f 2 | awk '{print $1}'`
			bomtime=`grep "BOMTime" $stdfile | cut -d = -f 2 | awk '{print $1}'`
			eomtime=`grep "EOMTime" $stdfile | cut -d = -f 2 | awk '{print $1}'`
			testrecv=`grep "TestBytesReceived" $stdfile | cut -d = -f 2 | awk '{print $1}'`
			totalrecv=`grep "TotalBytesReceived" $stdfile | cut -d = -f 2 | awk '{print $1}'`
			totalsend=`grep "TotalBytesSent" $stdfile | cut -d = -f 2 | awk '{print $1}'`

			cfgcmd sset ${DPATH}ROMTime $romtime
			cfgcmd sset ${DPATH}BOMTime $bomtime
			cfgcmd sset ${DPATH}EOMTime $eomtime
			cfgcmd sset ${DPATH}TCPOpenRequestTime $tcpreq
			cfgcmd sset ${DPATH}TCPOpenResponseTime $tcpack
			if [ "$1" == "upload" ]; then
				cfgcmd sset ${DPATH}TotalBytesSent $totalsend
			else
				cfgcmd sset ${DPATH}TestBytesReceived $testrecv
				cfgcmd sset ${DPATH}TotalBytesReceived $totalrecv
			fi

			cfgcmd set ${DPATH}DiagnosticsState "Completed"
			echo "do cfgcmd manully_inform EV DC" > /tmp/tr143debug
			cfgcmd manully_inform EV DC
		fi
		mv $stdfile /tmp/tr143.log.1
#		rm -fr $stdfile
	fi
}

find_test_result $1


