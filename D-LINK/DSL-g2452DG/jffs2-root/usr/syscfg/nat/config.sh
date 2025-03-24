#!/bin/sh

. /usr/syscfg/nat/param.sh
. /usr/syscfg/wan.utils.sh
. /usr/syscfg/firewall.param.sh

generate_rule()
{
	local inspath=$1

	if [ $# -lt 1 ]; then
		return
	fi

	local enable=`cfgcmd get $inspath.Enabled`
	if [ "$enable" != "1" ]; then
		return
	fi

	local type=`cfgcmd get $inspath.Type`
	local wcd_path=`cfgcmd get $inspath.WanConnection`
	local local_start_ip=`cfgcmd get $inspath.LocalStartIP`
	local local_end_ip=`cfgcmd get $inspath.LocalEndIP`
	local public_start_ip=`cfgcmd get $inspath.PublicStartIP`

	local match_o=""
	if [ ! -z "$wcd_path" ]; then
		local wcd_code=`gen_wanconn_folder $wcd_path`
		match_o="-o \${$wcd_code}"
	fi

	local match="-m iprange --src-range"
	local target="-j SNAT --to-source"

	if [ "$type" == $MULTINAT_TYPE_MANY_TO_ONE ]; then
		match="$match $local_start_ip-$local_end_ip"
		target="$target $public_start_ip"
	elif [ "$type" == $MULTINAT_TYPE_ONE_TO_ONE ]; then
		match="$match $local_start_ip"
		target="$target $public_start_ip"
	else
		echo "Unsupport MultiNAT Type=$type"
		exit 1
	fi

	echo "iptables -t nat -A $MULTINAT_INTERNET_CHAIN $match_o $match $target" >> $MULTINAT_CONFIG_RULES_PATH
	echo "ip addr add $public_start_ip/32 dev \${$wcd_code}" >> $MULTINAT_CONFIG_RULES_PATH

	echo "iptables -t nat -D $MULTINAT_INTERNET_CHAIN $match_o $match $target" >> $MULTINAT_RESET_RULES_PATH
	echo "ip addr del $public_start_ip/32 dev \${$wcd_code}" >> $MULTINAT_RESET_RULES_PATH

	#except rules
	echo "iptables -A ${FLOW_ACCEL_CHAIN} $match_o $match -j MARK --set-mark 0x70000000/0xf0000000" >> $MULTINAT_CONFIG_RULES_PATH
	echo "iptables -D ${FLOW_ACCEL_CHAIN} $match_o $match -j MARK --set-mark 0x70000000/0xf0000000" >> $MULTINAT_RESET_RULES_PATH
}

generate_rules()
{
	rm -f $MULTINAT_RULES_PATH/*

    local i=1
    local max=`cfgcmd get_max_obj "${DMP_MULTINAT}."`

    while [ $i -le $max ]
    do
        result=`cfgcmd check_obj "${DMP_MULTINAT}.${i}"`
        if [ "${result}" == "0" ]; then
			generate_rule "${DMP_MULTINAT}.${i}"
        fi
		let i++
    done
}

mkdir -p $MULTINAT_RULES_PATH

/usr/syscfg/rule/wan.rules.do.sh reset all $MULTINAT

/usr/syscfg/rule/wan.rules.clean.sh config $MULTINAT
/usr/syscfg/rule/wan.rules.clean.sh reset $MULTINAT

generate_rules

if [ -f $MULTINAT_CONFIG_RULES_PATH -a -f $MULTINAT_RESET_RULES_PATH ]; then
    /usr/syscfg/rule/wan.rules.parse.awk config $MULTINAT_CONFIG_RULES_PATH whole $MULTINAT
    /usr/syscfg/rule/wan.rules.parse.awk reset $MULTINAT_RESET_RULES_PATH whole $MULTINAT
    /usr/syscfg/rule/wan.rules.do.sh config all $MULTINAT
else
    echo "MultiNAT rule is empty!"
fi
flush_hs_conntrack_entries

