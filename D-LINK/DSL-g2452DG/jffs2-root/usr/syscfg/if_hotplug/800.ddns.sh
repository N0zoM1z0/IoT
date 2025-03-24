#!/bin/sh
. /usr/syscfg/getifname.sh
. /usr/syscfg/api_dns.sh
. /usr/syscfg/api_log.sh
####################################################
for para in $*
do
	export $para
done
####################################################
#action = ifup,ifdown
#path = WAN.DDNSCONFIG.n.

TGP_Log ${TGP_LOG_WARNING} "action=${action}path=${path}"
/usr/syscfg/ddns_setting.sh ${action} ${path}

