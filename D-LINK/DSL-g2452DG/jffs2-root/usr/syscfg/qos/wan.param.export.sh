#!/bin/sh
# 

. /usr/syscfg/dsl.utils.sh
. /usr/syscfg/wan.utils.sh

S_DIR="/tmp/.qos"

#1:DSL onLine, 2:Eth onLine, 3:Both onLine
wan_status=$(get_uplink_line_state)

# wan type:
#  - atm: 0
#  - ptm: 1
wan_type_code=1
wan_type=$(get_layer2_mode)
if [ ${wan_type} == "ATM" ]; then
	wan_type_code=0
elif [ ${wan_type} == "PTM" ]; then
	wan_type_code=1
fi

# calculate wan band
PARAM_FILE="${S_DIR}/param.wan_band_ceil"
wan_band_ceil=0
if [ "${wan_status}" == "2" ];then
	wan_band_kb=1000000
	gewan_band_kb=1000000
else
	wan_band_kb=$(get_uplink_us)
	gewan_band_kb=1000000
fi

if [ -f ${PARAM_FILE} ]; then
	source ${PARAM_FILE}
fi

if [ ${wan_band_ceil} != 0 ]; then
	if [ ${wan_band_ceil} -lt ${wan_band_kb} ]; then
		wan_band_kb=${wan_band_ceil}
		gewan_band_kb=${wan_band_ceil}
	fi
fi

if [ ${wan_band_ceil} -ne ${wan_band_kb} ]; then
	wan_band_16kb=`expr ${wan_band_kb} \* 80 / 100`
fi

wan_band_16kb=`expr ${wan_band_kb} / 16`
gewan_band_16kb=`expr ${gewan_band_kb} / 16`

export wan_status wan_type_code wan_band_kb wan_band_16kb gewan_band_16kb

