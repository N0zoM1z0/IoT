#!/bin/sh
# 
# callback funcs for iptables rules:
# just execute iptables rules, and no
# ip6tables rules
# 
# $1: rule file name
#

. /usr/syscfg/wan.utils.sh
arg_script=$1

if [ -z "${wan_code}" ]; then
	exit
fi

# do script
${arg_script}

#flash hardware and software conntrack entries
flush_hs_conntrack_entries

