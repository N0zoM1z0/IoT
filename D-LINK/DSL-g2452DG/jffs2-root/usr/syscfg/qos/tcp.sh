#!/bin/sh
# 
# configure tcp session number constraints
# 
#
. /usr/syscfg/firewall.param.sh

S_DIR="/tmp/.qos"
DMP_TCP="InternetGatewayDevice.X_CT-COM_UplinkQoS.TcpSessionRestrict"
RST_RULE=${S_DIR}/tcp.reset.sh

# 0/1
enable=`cfgcmd get ${DMP_TCP}.Enable`
# 1: percentage; 2: number;
mode=`cfgcmd get ${DMP_TCP}.LimitMode`
perc=`cfgcmd get ${DMP_TCP}.LimitPercentage`
num=`cfgcmd get ${DMP_TCP}.LimitNumber`

if [ -x ${RST_RULE} ]; then
	${RST_RULE}
	rm -f ${RST_RULE}
fi

if [ ${enable} == "0" ]; then
	exit 0;
fi

total=${num}
if [ ${mode} == "1" ]; then
	total=$((`cat /proc/sys/net/ipv4/tcp_max_syn_backlog`*${perc}/100))
fi

iptables -A ${QOS_LMT_TCP_CHAIN} -p tcp --syn -m connlimit --connlimit-above ${total} --connlimit-mask 0 -j REJECT

echo "iptables -D ${QOS_LMT_TCP_CHAIN} -p tcp --syn -m connlimit --connlimit-above ${total} --connlimit-mask 0 -j REJECT" > ${RST_RULE}
chmod a+x ${RST_RULE}


