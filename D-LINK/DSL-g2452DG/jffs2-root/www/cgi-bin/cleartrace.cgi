#!/bin/sh
TRACE_PATH="InternetGatewayDevice.TraceRouteDiagnostics"
local indexes=`cfgcmd get_idxes ${TRACE_PATH}.RouteHops`
	if [ "$indexes" != "0" ]; then
		for i in $indexes ; do
			cfgcmd del_obj "${TRACE_PATH}.RouteHops.$i."
		done
	fi
	cfgcmd set ${TRACE_PATH}.DiagnosticsState None
echo  "Content-type: text/html"
echo  ""
echo  "OK"

	
