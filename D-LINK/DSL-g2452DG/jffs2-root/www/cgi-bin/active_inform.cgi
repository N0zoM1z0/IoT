#!/bin/sh

local action=`echo ${QUERY_STRING} | cut -d = -f 3 | cut -d ? -f 1`

case "$action" in
	"informState")
	local informState=`cfgcmd get InternetGatewayDevice.ManagementServer.X_CT-COM_ManualInformState`
	echo "Pragma: no-cache\n"
	echo "Cache-control: no-cache\n"
	echo "Content-type: text/html"
	echo ""
	echo "$informState"
	;;

	"maintain")
	local maintain=`cfgcmd get InternetGatewayDevice.ManagementServer.X_CT-COM_MaintenanceInformState`
	echo "Pragma: no-cache\n"
	echo "Cache-control: no-cache\n"
	echo "Content-type: text/html"
	echo ""
	echo "$maintain"
	;;
esac
