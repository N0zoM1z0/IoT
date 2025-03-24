#!/bin/sh

Root_Path="InternetGatewayDevice.LANDevice.1.WLANConfiguration"

# get value from dhcp result

ClearInst()
{
	local WLAN_Dev=$1
	local obj_count=0
	local index=1
	
	obj_count=`cfgcmd get_max_obj ${WLAN_Dev}.`

	while [ ${index} -le ${obj_count} ]
	do
		cfgcmd del_obj "${WLAN_Dev}.${index}"
		index=`expr $index + 1`
	done
}
ClearInsts()
{
	local obj_count=0
	local index=1
	
	obj_count=`cfgcmd get_max_obj ${Root_Path}.`

	while [ ${index} -le ${obj_count} ]
	do
		ClearInst ${Root_Path}.${index}.AssociatedDevice
		index=`expr $index + 1`
	done
}

AddInst()
{
	local ip=$1
	local mac=$2
	local WLAN_Dev_index=$3
	local index=0
	
	index=`cfgcmd add_obj "${Root_Path}.${WLAN_Dev_index}.AssociatedDevice."`
	
	if [ ${index} -gt 0 ]; then
		cfgcmd sset "${Root_Path}.${WLAN_Dev_index}.AssociatedDevice.${index}.AssociatedDeviceMACAddress" "${mac}"
		cfgcmd sset "${Root_Path}.${WLAN_Dev_index}.AssociatedDevice.${index}.AssociatedDeviceIPAddress" "${ip}"
	fi
}

AddConnectInsts()
{
    if [ -e "/usr/lib/mt7603e_ap.ko" ];then
    
		local devName_2g=`cfgcmd get ${Root_Path}.1.Name`

		local wlan_cliinfo="/tmp/wlan_cliinfo"
		local arp_info="/tmp/wlan_dev_arpinfo"

		cat /proc/net/arp | grep "br0" > $arp_info
		iwpriv ${devName_2g} show stamac >/dev/null 2>&1
	       cat /var/RT2860AP/Nstainfo > $wlan_cliinfo

		while read mac
		do
			local ip=`grep -i $mac $arp_info | awk '{print $1}'`
			if [ "$ip" != "" ]; then
				AddInst $ip $mac 1
			fi
		done < $wlan_cliinfo

		rm -f $wlan_cliinfo
		rm -f $arp_info
	fi

	if [ -e "/usr/lib/mt7662e_ap.ko" ];then
		local devName_5g=`cfgcmd get ${Root_Path}.5.Name`

		local wlan_cliinfo="/tmp/wlan_cliinfo"
		local arp_info="/tmp/wlan_dev_arpinfo"

		cat /proc/net/arp | grep "br0" > $arp_info
		iwpriv ${devName_5g} show stamac >/dev/null 2>&1
		cat /var/RT2860AP/ACstainfo > $wlan_cliinfo

		while read mac
		do
			local ip=`grep -i $mac $arp_info | awk '{print $1}'`
			if [ "$ip" != "" ]; then
				AddInst $ip $mac 5
			fi
		done < $wlan_cliinfo

		rm -f $wlan_cliinfo
		rm -f $arp_info
	fi

	if [ -e "/usr/lib/rtl8192cd.ko" ];then
        local wlan_dev="/tmp/eth_stat"
        local curr_conninfo="/tmp/ethnet_info"
        ip neigh > $curr_conninfo

        cat /proc/wlan0/sta_info | grep "hwaddr" > $wlan_dev
        cat /proc/wlan0-va0/sta_info | grep "hwaddr" >> $wlan_dev
        cat /proc/wlan0-va1/sta_info | grep "hwaddr" >> $wlan_dev
        cat /proc/wlan0-va2/sta_info | grep "hwaddr" >> $wlan_dev
        while read line
        do
            local dev=`echo $line | awk '{print $3}'`
            local mac=`echo $line | awk '{print $5}'`
            local macAddr=${mac//:/}
            isWlanDev=`grep -c "$macAddr" $wlan_dev`
            if [ "$isWlanDev" != "0" -a "$dev" == "br0" ]; then
                local ipAddr=`echo $line | awk '{print $1}'`
                local reply=`arping -w 1 -f -I br0 $ipAddr | grep :`
			    if [ -n "$reply" ]; then
                    AddInst $ipAddr $mac 1
                fi
            fi
        done < $curr_conninfo
        rm -f $wlan_dev
        rm -f $curr_conninfo
	fi

    # TR51XX
    if [ -e "/lib/ko/hmac.ko" ];then
        local wlan_intf="/tmp/wlan_intf"
        local wlan_sta="/tmp/wlan_sta"

        # 2.4G
        ifconfig | grep wlan0 | awk '{print $1}' > $wlan_intf
        ifconfig | grep wlan-va[1-3] | awk '{print $1}' >> $wlan_intf

        # 5G
        ifconfig | grep wlan1 | awk '{print $1}' >> $wlan_intf
        ifconfig | grep wlan-vai[1-3] | awk '{print $1}' >> $wlan_intf

        while read intf
        do
            # a valid VAP interface has one hostapd instance
            local pid=`ps | grep hostapd | grep $intf.conf`
            if [ "$pid" == "" ] ; then
                continue
            fi

            hostapd_cli -i $intf all_sta | grep : | grep -v = > $wlan_sta

            while read sta
            do
                local ipAddr=`cat /proc/net/arp | grep $sta | awk '{print $1}'`
                if [ -n "$ipAddr" ]; then
                    local index=1
                    if [ "$intf" == "wlan0" ] ;then
                        index=1
                    elif [ "$intf" == "wlan1" ] ;then
                        index=5
                    else
                        prefix=${intf:0:8}
                        if [ "$prefix" == "wlan-vai" ]; then
                            index=5
                        else
                            index=1
                        fi
                    fi
                    AddInst $ipAddr $sta $index
                fi
            done < $wlan_sta
        done < $wlan_intf

        rm -f $wlan_intf
        rm -f $wlan_sta
    fi



    if [ -e "/lib/modules/3.14.18/umac.ko" ];then
        local wlan_cliinfo="/tmp/wlan_cliinfo"
        local wlan_index=1
        local arp_info="/tmp/wlan_dev_arpinfo"

		cat /proc/net/arp | grep "br0" > $arp_info
        intf_VAP=`ifconfig | grep -c ath0`
        if [ "$intf_VAP" = "1" ];then
	        wlanconfig ath0 list sta | awk 'NR>1 {print}'| cut -f1 -d ' ' > $wlan_cliinfo
	        local devName=`cfgcmd get ${Root_Path}.1.Name`
            if [ "ath0" = "$devName" ];then
                wlan_index=1
            else
                wlan_index=5
            fi
            while read mac
		    do
			    local ip=`grep -i $mac $arp_info | awk '{print $1}'`
			    if [ "$ip" != "" ]; then
				    AddInst $ip $mac $wlan_index
			    fi
		    done < $wlan_cliinfo
	    fi
        intf_VAP=`ifconfig | grep -c ath1`
        if [ "$intf_VAP" = "1" ];then
	        wlanconfig ath1 list sta | awk 'NR>1 {print}'| cut -f1 -d ' ' > $wlan_cliinfo
	        
            while read mac
		    do
			    local ip=`grep -i $mac $arp_info | awk '{print $1}'`
			    if [ "$ip" != "" ]; then
				    AddInst $ip $mac 5
			    fi
		    done < $wlan_cliinfo
	    fi
	    rm -f $wlan_cliinfo
		rm -f $arp_info
	fi
}

ClearInsts
AddConnectInsts

