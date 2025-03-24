#!/bin/sh

. /usr/syscfg/firewall.param.sh

DMP_PORTAL="InternetGatewayDevice.DeviceInfo.X_CT-COM_PortalManagement"
DMP_URL_FILTER="InternetGatewayDevice.X_CT-COM_UrlFilter"

PORT_HTTP=80

portal_enable=`cfgcmd get "${DMP_PORTAL}.Enable"`
url_filter_enable=`cfgcmd get "${DMP_URL_FILTER}.Enable"`


url_accel=`flowaccel show | grep "0x50000000/0xf0000000" | wc -l`

if [ "${portal_enable}" == "1" -o "${url_filter_enable}" == "1" ]; then
	if [ "${url_accel}" == "0" ]; then
		iptables -A ${FLOW_ACCEL_CHAIN} -p tcp --dport ${PORT_HTTP} -j MARK --set-mark 0x50000000/0xf0000000
		iptables -A ${FLOW_ACCEL_CHAIN} -p tcp --sport ${PORT_HTTP} -j MARK --set-mark 0x50000000/0xf0000000
		flowaccel add 0x50000000/0xf0000000 no
	fi
else
	iptables -D ${FLOW_ACCEL_CHAIN} -p tcp --dport ${PORT_HTTP} -j MARK --set-mark 0x50000000/0xf0000000
	iptables -D ${FLOW_ACCEL_CHAIN} -p tcp --sport ${PORT_HTTP} -j MARK --set-mark 0x50000000/0xf0000000
	flowaccel del 0x50000000/0xf0000000 no
fi

