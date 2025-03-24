#!/bin/sh

. /lib/functions.sh
config_load misc

# power on all lan port
sw_start_lan() {
	config_get power_reg sw_reg sw_power
	config_get up_val sw_reg sw_power_up
	config_get lan_ports sw_reg sw_lan_ports
	for p in $lan_ports
	do
		mii_mgr -s -p $p -r $power_reg -v $up_val >/dev/null
	done
}

# power off all lan port
sw_stop_lan() {
	config_get power_reg sw_reg sw_power
	config_get down_val sw_reg sw_power_down
	config_get lan_ports sw_reg sw_lan_ports
	for p in $lan_ports
	do
		mii_mgr -s -p $p -r $power_reg -v $down_val >/dev/null
	done
}

# restart all LAN ports
sw_restart_lan() {
	config_get reg_config sw_reg sw_phy_config
	config_get lan_ports sw_reg sw_lan_ports
	for p in $lan_ports
	do
		switch phy cl22 w $p $reg_config 0x1240
	done
}

# detect link on wan port
sw_wan_link_detect() {
	config_get wan_port sw_reg sw_wan_port
	/sbin/ethstatus 2>&1 | grep -e"^port $wan_port" | grep -q "up"
}

# count link on all lan port
sw_lan_count() {
	config_get lan_ports sw_reg sw_lan_ports
	/sbin/ethstatus 2>&1 | grep -e"^port [$lan_ports]" | grep "up" | wc -l
}

# is wan port enable gigabytes?
sw_is_wan_giga() {
	config_get wan_port sw_reg sw_wan_port
	mii_mgr -g -p $wan_port -r 9 |grep -q -i 0600
}

# set gigabyte on/off for wan
# sw_set_wan_giga on
# sw_set_wan_giga off
sw_set_wan_giga() {
	config_get wan_port sw_reg sw_wan_port
	if [ "$1" = 'on' ]; then
		switch phy cl22 w $wan_port 9 0x600
	else
		switch phy cl22 w $wan_port 9 0
	fi
}

# wan port 100M or 10M?
sw_is_wan_100m() {
	config_get wan_port sw_reg sw_wan_port
	config_get neg_val sw_reg sw_neg_100
	mii_mgr -g -p $wan_port -r 4 |grep -q -i $neg_val
}
sw_is_wan_10m(){
	config_get wan_port sw_reg sw_wan_port
	config_get neg_val sw_reg sw_neg_10
	mii_mgr -g -p $wan_port -r 4 |grep -q -i $neg_val
}

# set wan port to 100M or 10M
# sw_set_wan_100m 100
# sw_set_wan_100m 10
sw_set_wan_100m() {
	config_get wan_port sw_reg sw_wan_port

	if [ "$1" = '100' ]; then
	config_get neg_val sw_reg sw_neg_100
	else
	config_get neg_val sw_reg sw_neg_10
	fi

	switch phy cl22 w $wan_port 4 0x$neg_val
}

sw_set_wan_auto(){
	config_get wan_port sw_reg sw_wan_port
	switch phy cl22 w $wan_port 0 0x5e1
}

# issue re-negation on wan
sw_reneg_wan() {
	config_get wan_port sw_reg sw_wan_port
	config_get reg_config sw_reg sw_phy_config
	switch phy cl22 w $wan_port $reg_config 0x1240 >/dev/null
}

sw_set_wan_neg_speed(){
	local wan_port=$(uci get misc.sw_reg.sw_wan_port)
	local reg=0x23f

	case "$1" in
	0)
		sw_set_wan_auto
		sw_set_wan_giga on
		;;
	10)
		sw_set_wan_100m 10
		sw_set_wan_giga off
		;;
	100)
		sw_set_wan_100m 100
		sw_set_wan_giga off
		;;
	1000)
		sw_set_wan_giga on
		;;
	*)
		echo "unsupport speed!"
		return 1
		;;
	esac

	# issue re-negotiat
	if sw_reneg_wan; then
		# let phy do re-neg
		[ -z "$1" ] && sleep 2
		echo "set WAN speed to ${speed}Mb"
	return 0
	else
		ehco 'renegotiation fail!'
		return 1
	fi
}
