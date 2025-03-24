#!/bin/sh
# 
# callback funcs for ip6tables rules:
# just execute ip6tables rules, and no
# iptables rules
# 
# $1: rule file name
#

MATCH_PATTEN="iptables"
FW_RULE_COMMON_CB="/usr/syscfg/rule/cb/fw.common.sh"

arg_script=$1

if [ -z "${wan_code}" ]; then
	exit
fi

tmp_script="/tmp/.`basename ${arg_script}`"
while [ -f ${tmp_script} ]
do
	sleep 1
done

cp ${arg_script} ${tmp_script}
sed -i "/${MATCH_PATTEN}/d" ${tmp_script}

${FW_RULE_COMMON_CB} ${tmp_script}

rm ${tmp_script}

