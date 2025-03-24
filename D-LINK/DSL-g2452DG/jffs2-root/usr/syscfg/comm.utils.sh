#!/bin/sh

# This file contain the little func with common function will used by other
# script,so don't add not common func in this file.

# $1: ip addr;
# $2: ip addr range start;
# $3: ip addr range end;
ip_in_range()
{
	if [ $# -lt 3 ]; then
		echo -n 0
	fi

	local ip=$1
	local start=$2
	local end=$3

	i=1
	until [ $i -gt 4 ]; do
		
		local fip=`echo ${ip} | cut -d '.' -f ${i}`
		local fst=`echo ${start} | cut -d '.' -f ${i}`
		local fen=`echo ${end} | cut -d '.' -f ${i}`

		if [ `expr "${fip}" - "${fst}"` -lt 0 ]; then
			echo -n 0
			return
		fi
		
		if [ `expr "${fip}" - "${fen}"` -gt 0 ]; then
			echo -n 0
			return
		fi
		
		i=$(($i + 1))

	done; unset i

	echo -n 1
}

# Check para '$2' is substring of para '$1'.
# If true return 1,else return 0
strsearch()
{
    local ret=0
    local string=$1
    local substr=$2

    case $string in
        *$substr*)
        ret=1
        ;;
    esac

    echo -n $ret
}

# Check process which name is '$1' is exist or not.
# If exist return 1,else return 0
check_process_exist()
{
    local process=$1
    local ret=0

    local temp=`ps | grep $process | awk '{print \$4}'`
    temp=`echo $temp`   ##This make multi line to one line.
    local result=`echo $temp | grep $process`

    if [ "$temp" != "" -a "$temp" = "$result" ]; then
        ret=1
    fi

    echo -n $ret
}

#get the bridge mac address the paramter is the bridge name 'br0'/'br1'
get_bridge_mac()
{
    local bridge=$1

    local mac=`ifconfig $bridge | grep HWaddr | awk '{ print $5 }'`
    echo -n $mac
}



#名称： is_valid_ip
#描述：判断输入是否为合法的ip
#输入：$1 - 需要判断的ip
#返回：1 - 合法ip
#      0 - 非法ip
is_valid_ip()
{
	echo $1|grep "^[0-9]\{1,3\}\.\([0-9]\{1,3\}\.\)\{2\}[0-9]\{1,3\}$" > /dev/null;
	#IP地址必须为全数字
	if [ $? -ne 0 ]; then
		echo -n 0
		return
	fi
	ipaddr=$1
	a=`echo $ipaddr|awk -F . '{print $1}'` #以"."分隔，取出每个列的值
	b=`echo $ipaddr|awk -F . '{print $2}'`
	c=`echo $ipaddr|awk -F . '{print $3}'`
	d=`echo $ipaddr|awk -F . '{print $4}'`
	for num in $a $b $c $d
	do
		if [ $num -gt 255 ] || [ $num -lt 0 ]   #每个数值必须在0-255之间
		then
			echo -n 0
			return
		fi
	done

	echo -n 1
}
