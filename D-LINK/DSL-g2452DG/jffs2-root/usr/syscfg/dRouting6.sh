#!/bin/sh
. /usr/syscfg/wan.utils.sh
dync_routing_dir="/tmp/dync-routing"
zebra_conf_file="${dync_routing_dir}/zebra.conf"
conf6="/var/ripngd.conf"

g_conn_event=$1
g_conn_path=$2
g_conn_folder=`gen_wanconn_folder ${g_conn_path}`

GetWanStatus()
{
	local wan_folder=$1
	local wan_up=`is_ip6_wan_up ${wan_folder}`
	
	if [ "${wan_up}" == "0" ]; then
		echo -n 0
		return
	fi

	if [ "${g_conn_event}" == "ifdown" -a "${g_conn_folder}" == "${wan_folder}" ]; then
		echo -n 0
		return
	fi
	
	echo -n 1
}

create_droute6_conf()
{
        local tmpf="/tmp/tmp_droute6_file"
        local line=1
        local ret=0

        cfgcmd get InternetGatewayDevice.WANDevice.1.WANConnectionDevice. | grep "RIPngEnabled=1" | cut -d "." -f 1-7 > $tmpf
        cfgcmd get InternetGatewayDevice.WANDevice.2.WANConnectionDevice. | grep "RIPngEnabled=1" | cut -d "." -f 1-7 >> $tmpf        
        max_line=`cat $tmpf  | wc -l`

        rm -f $conf6
        while [ ${line} -le ${max_line} ]
        do
            local if_path=`cat $tmpf | sed -n $line"p"`
        	local if_ipmode=`cfgcmd get ${if_path}.IPMode`
			
			if [ "${if_ipmode}" == "${WP_IPMODE_IPV4}" ]; then
				index=`expr $index + 1`
				continue
			fi

			local wan_folder=`gen_wanconn_folder ${if_path}`
			local wan_up=`GetWanStatus ${wan_folder}`
			local wan_ifname=`get_wanconn_ifname ${wan_folder}`

			if [ "${wan_up}" == "0" ]; then
				line=`expr $line + 1`
				continue
			fi

			ret=1
			echo "interface ${wan_ifname}" >> $conf6
			echo "router ripng" >> $conf6
			echo "redistribute kernel" >> $conf6
			echo "redistribute connected" >> $conf6
			echo "redistribute static" >> $conf6
			echo "network $wan_ifname" >> $conf6
			echo >> $conf6

			line=`expr ${line} + 1`
        done
        rm -f $tmpf

        return $ret
}

ZebraRestart()
{
    killall -q zebra

    if [ ! -d ${dync_routing_dir} ]; then
        mkdir -p ${dync_routing_dir}
    fi
	if [ ! -f ${zebra_conf_file} ]; then
		echo "hostname zebra" > $zebra_conf_file
		echo "password zebra" >> $zebra_conf_file
		echo "enable password zebra" >> $zebra_conf_file
		echo "log file ${dync_routing_dir}/zebra.log" >> $zebra_conf_file
	fi													   
	zebra -d -f $zebra_conf_file
}

RipngdRestart()
{
	killall -q ripngd

	create_droute6_conf
	if [ $? != "1" ]; then
		return
	fi
	ripngd -f $conf6 -d

}
                                                                                  
ZebraRestart
RipngdRestart
