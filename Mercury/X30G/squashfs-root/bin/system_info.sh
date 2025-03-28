#!/bin/sh
#
# SYSTEM INFO
#
# $Copyright TP-LINK Corporation$
#

LOOP_TIME=120
NR_RUNS=0

# $2 Heading
# $3 cmd to execute
display_cmd_op(){
	cmd="$2"
	echo "---------------------------------"
	echo -e "$1"
	echo "---------------------------------"
	$cmd
}

if [ $# -ge 1 ] || [ $# -ge 2 ]; then
	NR_REPEATS=$1
else
	NR_REPEATS=0
fi

ifconfig_info () {
	display_cmd_op "IFCONFIG: ifconfig" "ifconfig"
}

lan_port_info () {
	display_cmd_op "LAN_PORT_INFO: lan --dump_port_info" "lan --dump_port_info"
	display_cmd_op "LAN PORT INFO: lan --dump_assoc_table" "$LANCMD --dump_assoc_table"
}

br_info () {
	display_cmd_op "BRCTL INFO: brctl show" "brctl show"
	display_cmd_op "BR-LAN DEV: brctl showmacs br-lan" "brctl showmacs br-lan"
	display_cmd_op "BR-WAN DEV: brctl showmacs br-wan" "brctl showmacs br-wan"
}

devinfo_info () {
	display_cmd_op "DEVINFO: devinfo" "devinfo"
}

mem_info () {
	echo "============================="
	echo "mem info"
	echo "============================="

	cat /proc/meminfo
}

loop_commands () {
	sleep $LOOP_TIME
	NR_RUNS=`expr $NR_RUNS + 1`
	echo "================================="
	echo "SYSTEM INFO ($NR_RUNS)"
	echo "================================="
	lan_port_info
	mem_info
	br_info

	REMAINED=$(($NR_RUNS%3))
	if [[ $REMAINED=0]]; then
		ifconfig_info
	fi
}

echo "================================="
echo "System info first run"
echo "================================="

devinfo_info
ifconfig_info
lan_port_info
mem_info
br_info

if [[ $NR_REPEATS -eq 0 ]]; then
	while true; do
		loop_commands
	done
else
while [[ $NR_REPEATS -gt $NR_RUNS ]]; do
	loop_commands
done
fi