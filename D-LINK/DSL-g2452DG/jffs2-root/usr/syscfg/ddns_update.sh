#!/bin/sh

. /usr/syscfg/api_log.sh

DDNS_username=$1
DDNS_password=$2 
DDNS_domainname=$3
DDNS_interface=$4
DDNS_PATH=$5
DDNS_ipaddr=$6
DDNS_provider=$7
statu=""
#dyndns传递下来的provider有可能是dyndns.com或者tzo，所以做如下处理
local Dyndns=`echo "$DDNS_provider" | grep -e "dyndns" -e "tzo"`


if [ "${DDNS_provider}" == "oray.com" ];then
    ddns_cmd="/usr/bin/curl --interface ${DDNS_interface} -u ${DDNS_username}:${DDNS_password} http://ddns.oray.com/ph/update?hostname=${DDNS_domainname}&myip=${DDNS_ipaddr}"
elif [ -n "${Dyndns}" ];then
    ddns_cmd="/usr/bin/curl --interface ${DDNS_interface} -u ${DDNS_username}:${DDNS_password} http://members.dyndns.org/nic/update?hostname=${DDNS_domainname}&myip=${DDNS_ipaddr}&wildcard=ON"
elif [ "${DDNS_provider}" == "noip" ];then
    ddns_cmd="/usr/bin/curl --interface ${DDNS_interface} -u ${DDNS_username}:${DDNS_password} http://dynupdate.no-ip.com/nic/update?hostname=${DDNS_domainname}&myip=${DDNS_ipaddr}"
fi

TGP_Log ${TGP_LOG_WARNING} "${ddns_cmd}"

while [ -z "$statu" ]
do
    statu=`${ddns_cmd}`
    sleep 10
done  


TGP_Log ${TGP_LOG_WARNING} "statu=${statu}"

temp=`echo "${statu}" | cut -d ' ' -f 1`

if [ "${temp}" = "Unconfigure" ];then
    cfgcmd sset ${DDNS_PATH}.DDNSState Unsynchronized
elif [ "${temp}" = "good" -o "${temp}" = "nochg" ]; then
    cfgcmd sset ${DDNS_PATH}.DDNSState Synchronized
elif [ "${temp}" = "badauth" ]; then
    cfgcmd sset ${DDNS_PATH}.DDNSState Badauthication
elif [ "${temp}" = "abuse" ]; then
    return
else
    cfgcmd sset ${DDNS_PATH}.DDNSState Unsynchronized
fi