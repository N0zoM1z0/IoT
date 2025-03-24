#!/bin/sh

local time=`cfgcmd oget InternetGatewayDevice.Time.CurrentLocalTime`
local ntpstatuse=`cfgcmd get InternetGatewayDevice.Time.Status`
local LocalTimeZone=`cfgcmd get InternetGatewayDevice.Time.LocalTimeZone`
local ret=$time" GMT "$LocalTimeZone"?"$ntpstatuse

echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: text/html"
echo ""
echo -n $ret
