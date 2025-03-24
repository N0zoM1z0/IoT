#!/bin/sh
TRACE_PATH="InternetGatewayDevice.IPPingDiagnostics"
	cfgcmd set ${TRACE_PATH}.DiagnosticsState None
echo  "Content-type: text/html"
echo  ""
echo  "OK"

	
