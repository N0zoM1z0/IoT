
BASE_MAC="00:11:22:33:44:55"
get_base_mac()
{
	local mac=""
	mac="`nvram basic get MAC 2>/dev/null`"
	if [ -z "${mac}" ]; then
		mac=${BASE_MAC}
	fi
	echo ${mac}
}

mac_increase()
{
	local ins_num=$1
	local base_mac=$2
	local tmp_mac=""
	local ret_mac=""
	
	if [ -z "${base_mac}" ]; then
		base_mac=${BASE_MAC}
	fi

	#remove ':' in mac string
	tmp_mac="0x${base_mac//:}"
	let tmp_mac+=${ins_num}
	tmp_mac=`printf "%012lX" ${tmp_mac}`
	ret_mac="${tmp_mac:0:2}:${tmp_mac:2:2}:${tmp_mac:4:2}:${tmp_mac:6:2}:${tmp_mac:8:2}:${tmp_mac:10:2}"
	echo "$ret_mac"
}


IsMac()
{
    local tmp=$1
    local result=`echo "$tmp" | sed -n '/^[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]$/p'`

    if [ "${result}" = "$tmp" ]; then
        echo -n 1
    else
        echo -n 0
    fi
}
