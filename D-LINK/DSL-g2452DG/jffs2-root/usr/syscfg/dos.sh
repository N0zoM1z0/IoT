#!/bin/sh

LOCK="/tmp/.dos.lock"

if [ -f ${LOCK} ]; then
	exit
fi
touch ${LOCK}

# ANTI_ATTACK_TARGET
# ANTI_ATTACK_CHAIN
. firewall.param.sh

DMP_ROOT="InternetGatewayDevice.X_CT-COM_AntiAttack"
DMP_DOS="InternetGatewayDevice.X_CT-COM_AntiAttack.AntiDos"
DMP_SCAN="InternetGatewayDevice.X_CT-COM_AntiAttack.AntiScan"


reset_all()
{
	iptables -F ${ANTI_ATTACK_TARGET}
	iptables -F ${ANTI_ATTACK_CHAIN}
	
	killall klogd
	
	echo 1 > /proc/sys/net/ipv4/tcp_syncookies
	echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
	
	echo 0 > /proc/sys/net/ipv4/tcp_ack_unlisten
	echo 0 > /proc/sys/net/ipv4/udp_ack_unlisten
}

setup_target()
{
	local log_en=`cfgcmd get "${DMP_ROOT}.AntiLogEnable"`

	if [ ${log_en} == "1" ]; then
		iptables -A ${ANTI_ATTACK_TARGET} -j LOG --log-prefix "AntiAttack"
		klogd -c 8
	fi
	iptables -A ${ANTI_ATTACK_TARGET} -j DROP
}

setup_lan_bypass()
{
	iptables -I ${ANTI_ATTACK_CHAIN} -i br0 -j RETURN
}

setup_antidos()
{
    local syn_cookie_en=`cfgcmd get "${DMP_DOS}.SynCookieEnable"`
    local syn_max_conn=`cfgcmd get "${DMP_DOS}.SynMaxConnections"`
    local icmp_bcast=`cfgcmd get "${DMP_DOS}.IcmpEchoIgnrBcastEnable"`
    local fraggle=`cfgcmd get "${DMP_DOS}.AntiFraggleEnable"`
    local echo_chargen=`cfgcmd get "${DMP_DOS}.AntiEchoCargenEnable"`
    local ipland=`cfgcmd get "${DMP_DOS}.AntiIPLandEnable"`
    local portscan=`cfgcmd get "${DMP_DOS}.IgnrPortScanEnable"`

	if [ ${syn_cookie_en} == "1" ]; then
		echo 1 > /proc/sys/net/ipv4/tcp_syncookies
		iptables -A ${ANTI_ATTACK_CHAIN} -p tcp --tcp-flags SYN,ACK SYN -m hashlimit --hashlimit-name "syncookies" --hashlimit-above ${syn_max_conn}/second --hashlimit-burst ${syn_max_conn} -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${icmp_bcast} == "1" ]; then
		echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
	else
		echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
	fi

	if [ ${fraggle} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p udp --dport 7 -j ${ANTI_ATTACK_TARGET}
	fi
	
	if [ ${echo_chargen} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p udp --dport 19 -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${ipland} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -s 127.0.0.1 ! -i lo -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${portscan} == "1" ]; then
		echo 0 > /proc/sys/net/ipv4/tcp_ack_unlisten
		echo 0 > /proc/sys/net/ipv4/udp_ack_unlisten
	else
		echo 1 > /proc/sys/net/ipv4/tcp_ack_unlisten
		echo 1 > /proc/sys/net/ipv4/udp_ack_unlisten
	fi
}

setup_antiscan()
{
    local st_syn_fin=`cfgcmd get "${DMP_SCAN}.AntiScanSetSynFinEnable"`
    local st_syn_rst=`cfgcmd get "${DMP_SCAN}.AntiScanSetSynRstEnable"`
    local st_fin_rst=`cfgcmd get "${DMP_SCAN}.AntiScanSetFinRstEnable"`
    local us_ack_st_fin=`cfgcmd get "${DMP_SCAN}.AntiScanUnAckSetFinEnable"`
    local us_ack_st_psh=`cfgcmd get "${DMP_SCAN}.AntiScanUnAckSetPshEnable"`
    local us_ack_st_urg=`cfgcmd get "${DMP_SCAN}.AntiScanUnAckSetUrgEnable"`
    local us_all=`cfgcmd get "${DMP_SCAN}.AntiScanUnsetAllEnable"`
    local st_all=`cfgcmd get "${DMP_SCAN}.AntiScanSetAllEnable"`
    local us_psh_st_oth=`cfgcmd get "${DMP_SCAN}.AntiScanForAllSetSynRstAckFinUrgEnable"`
    local us_oth_st_fin=`cfgcmd get "${DMP_SCAN}.AntiScanForAllSetFinEnable"`
    local us_oth_st_fin_psh_urg=`cfgcmd get "${DMP_SCAN}.AntiScanForAllSetFinUrgPshEnable"`

	if [ ${st_syn_fin} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p tcp --tcp-flags SYN,FIN SYN,FIN -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${st_syn_rst} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p tcp --tcp-flags SYN,RST SYN,RST -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${st_fin_rst} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p tcp --tcp-flags FIN,RST FIN,RST -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${us_ack_st_fin} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p tcp --tcp-flags ACK,FIN FIN -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${us_ack_st_psh} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p tcp --tcp-flags ACK,PSH PSH -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${us_ack_st_urg} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p tcp --tcp-flags ACK,URG URG -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${us_all} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p tcp --tcp-flags ALL NONE -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${st_all} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p tcp --tcp-flags ALL ALL -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${us_psh_st_oth} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${us_oth_st_fin} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p tcp --tcp-flags ALL FIN -j ${ANTI_ATTACK_TARGET}
	fi

	if [ ${us_oth_st_fin_psh_urg} == "1" ]; then
		iptables -A ${ANTI_ATTACK_CHAIN} -p tcp --tcp-flags ALL FIN,URG,PSH -j ${ANTI_ATTACK_TARGET}
	fi
}

reset_all

local enable=`cfgcmd get "${DMP_ROOT}.AntiDosEnable"`
if [ ${enable} == "1" ]; then
	setup_target
	setup_lan_bypass
	setup_antidos
	setup_antiscan
fi

rm ${LOCK}

