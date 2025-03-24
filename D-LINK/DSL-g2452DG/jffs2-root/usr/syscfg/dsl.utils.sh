#!/bin/sh
# 
# utility functions
#

# params:
# 1: option name;
# 2: option value;
#
get_option()
{
	if [ -z "$2" ]; then
		return;
	else
		echo -n "$1 $2"
	fi
}

is_dev_ready()
{
	local dev_ready=`xdsl_cli sys --alive | cut -d ':' -f 1`
	if [ "${dev_ready}" != "Yes" ]; then
		echo -n 0;
	else
		echo -n 1;
	fi
}

#when dsl up, it's state will change to "ShowTime"
is_showtime()
{
	local dsl_state=`xdsl_cli info --status | grep "^State:" | awk  '{print $2}'`
	if [ "${dsl_state}" != "Showtime" ]; then
		echo -n 0;
	else
		echo -n 1;
	fi
}

get_layer2_mode()
{
	local l2md=`xdsl_cli get --layer2-mode | cut -d "_" -f 4`
	echo ${l2md}
}

get_linktype()
{
	local linktype=$1
	local type_str="eoa"
	case "$linktype" in
	"EoA")
		type_str="eoa"
		;;
	"IPoA")
		type_str="ipoa"
		;;
	"PPPoA")
		type_str="poa"
		;;
	esac
	echo ${type_str}
}

get_encapsulation()
{
	local encap=$1
	local encap_str="llc"
	case "$encap" in
	"LLC")
		encap_str="llc"
		;;
	"VCMUX")
		encap_str="vc"
		;;
	esac
	echo ${encap_str}
}

get_atmqos()
{
	local qostype=$1
	local mbs=$2
	local scr=$3
	local mcr=$4
	local pcr=$5
	local atmqos_str=""
	case "$qostype" in
	"UBR")
		atmqos_str="qos ubr"
		;;
	"CBR")
		atmqos_str="qos cbr"
		;;
	"VBR-nrt")
		atmqos_str="qos nrt-vbr"
		;;
	"VBR-rt")
		atmqos_str="qos rt-vbr"
		;;
	"UBR+")
		atmqos_str="qos ubr-pcr"
		;;
	*)
		atmqos_str="qos disable"
		;;
	esac
	if [ -n "${mbs}" ]; then
		atmqos_str="${atmqos_str} mbs ${mbs}"
	fi
	if [ -n "${scr}" ]; then
		atmqos_str="${atmqos_str} scr ${scr}"
	fi
	if [ -n "${mcr}" ]; then
		atmqos_str="${atmqos_str} mcr ${mcr}"
	fi
	if [ -n "${pcr}" ]; then
		atmqos_str="${atmqos_str} pcr ${pcr}"
	fi
	echo ${atmqos_str}
}

get_uplink_us()
{
	local us=$(xdsl_cli info --status | grep "Upstream current rate:" | cut -f 3)
	if [ -z "${us}" ]; then
		echo -n 0
	fi
	echo -n ${us}
}

gen_profile()
{
	local AllowedProfiles=$1
	local profile=""
	local p8a_enable="0"
	local p8b_enable="0"
	local p8c_enable="0"
	local p8d_enable="0"
	local p12a_enable="0"
	local p12b_enable="0"
	local p17a_enable="0"
	local p30a_enable="0"

	AllowedProfiles="$(echo ${AllowedProfiles} | tr "," " ")"
	for i in ${AllowedProfiles}
        do
		if [ "${i}" == "8a" ]; then
			p8a_enable="1"
		elif [ "${i}" == "8b" ]; then
			p8b_enable="1"
		elif [ "${i}" == "8c" ]; then
			p8c_enable="1"
		elif [ "${i}" == "8d" ]; then
			p8d_enable="1"
		elif [ "${i}" == "12a" ]; then
			p12a_enable="1"
		elif [ "${i}" == "12b" ]; then
			p12b_enable="1"
		elif [ "${i}" == "17a" ]; then
			p17a_enable="1"
		elif [ "${i}" == "30a" ]; then
			p30a_enable="1"
		fi

        done

	if [ "${p8a_enable}" == "1" ]; then
		profile="${profile} 8a"
	fi
	if [ "${p8b_enable}" == "1" ]; then
		profile="${profile} 8b"
	fi
	if [ "${p8c_enable}" == "1" ]; then
		profile="${profile} 8c"
	fi
	if [ "${p8d_enable}" == "1" ]; then
		profile="${profile} 8d"
	fi
	if [ "${p12a_enable}" == "1" ]; then
		profile="${profile} 12a"
	fi
	if [ "${p12b_enable}" == "1" ]; then
		profile="${profile} 12b"
	fi
	if [ "${p17a_enable}" == "1" ]; then
		profile="${profile} 17a"
	fi
	if [ "${p30a_enable}" == "1" ]; then
		profile="${profile} 30a"
	fi
        echo "${profile}"
}

gen_standards()
{
	local line_enca=$1
	local standards=""
	local g1="0"
	local t1="0"
	local g21a="0"
	local g21b="0"
	local g23a="0"
	local g23b="0"
	local g23j="0"
	local g23l1="0"
	local g23l2="0"
	local g23m="0"
	local g25a="0"
	local g25b="0"
	local g25j="0"
	local g25m="0"
	local g32a="0"
	local g32b="0"
	local g32c="0"

	line_enca="$(echo ${line_enca} | tr "," " ")"
	for i in ${line_enca}
        do
		if [ "${i}" == "G.992.2" ]; then
			g1="1"
		elif [ "${i}" == "T1.413" ]; then
			t1="1"
		elif [ "${i}" == "G.992.1_Annex_A" ]; then
			g21a="1"
		elif [ "${i}" == "G.992.1_Annex_B" ]; then
			g21b="1"
		elif [ "${i}" == "G.992.3_Annex_A" ]; then
			g23a="1"
		elif [ "${i}" == "G.992.3_Annex_B" ]; then
			g23b="1"
		elif [ "${i}" == "G.992.3_Annex_J" ]; then
			g23j="1"
		elif [ "${i}" == "G.992.3_Annex_L" ]; then
			g23l1="1"
			g23l2="1"
		elif [ "${i}" == "G.992.3_Annex_L1" ]; then
			g23l1="1"
		elif [ "${i}" == "G.992.3_Annex_L2" ]; then
			g23l2="1"
		elif [ "${i}" == "G.992.3_Annex_M" ]; then
			g23m="1"
		elif [ "${i}" == "G.992.5_Annex_A" ]; then
			g25a="1"
		elif [ "${i}" == "G.992.5_Annex_B" ]; then
			g25b="1"
		elif [ "${i}" == "G.992.5_Annex_J" ]; then
			g25j="1"
		elif [ "${i}" == "G.992.5_Annex_M" ]; then
			g25m="1"
		elif [ "${i}" == "G.993.2" ]; then
			g32a="1"
			g32b="1"
			g32c="1"
		elif [ "${i}" == "G.993.2_Annex_A" ]; then
			g32a="1"
		elif [ "${i}" == "G.993.2_Annex_B" ]; then
			g32b="1"
		elif [ "${i}" == "G.993.2_Annex_C" ]; then
			g32c="1"
		fi
        done

	if [ "${g1}" == "1" ]; then
		standards="${standards} G.992.2"
	fi
	if [ "${t1}" == "1" ]; then
		standards="${standards} T1.413"
	fi
	if [ "${g21a}" == "1" ]; then
		standards="${standards} G.992.1_Annex_A"
	fi
	if [ "${g21b}" == "1" ]; then
		standards="${standards} G.992.1_Annex_B"
	fi
	if [ "${g23a}" == "1" ]; then
		standards="${standards} G.992.3_Annex_A"
	fi
	if [ "${g23b}" == "1" ]; then
		standards="${standards} G.992.3_Annex_B"
	fi
	if [ "${g23j}" == "1" ]; then
		standards="${standards} G.992.3_Annex_J"
	fi
	if [ "${g23l1}" == "1" ]; then
		standards="${standards} G.992.3_Annex_L1"
	fi
	if [ "${g23l2}" == "1" ]; then
		standards="${standards} G.992.3_Annex_L2"
	fi
	if [ "${g23m}" == "1" ]; then
		standards="${standards} G.992.3_Annex_M"
	fi
	if [ "${g25a}" == "1" ]; then
		standards="${standards} G.992.5_Annex_A"
	fi
	if [ "${g25b}" == "1" ]; then
		standards="${standards} G.992.5_Annex_B"
	fi
	if [ "${g25j}" == "1" ]; then
		standards="${standards} G.992.5_Annex_J"
	fi
	if [ "${g25m}" == "1" ]; then
		standards="${standards} G.992.5_Annex_M"
	fi
	if [ "${g32a}" == "1" ]; then
		standards="${standards} G.993.2_Annex_A"
	fi
	if [ "${g32b}" == "1" ]; then
		standards="${standards} G.993.2_Annex_B"
	fi
	if [ "${g32c}" == "1" ]; then
		standards="${standards} G.993.2_Annex_C"
	fi
        echo "${standards}"
}

