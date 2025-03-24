#!/bin/sh
# 2018 Hua Shao <hua.shao@mediatek.com>


profile_backup() {
	echo "profile_backup"
}


profile_diff() {
	echo "profile_diff"
}


mi_wifi_iface_up() {
	[ "$1" == "" ] && return
	local wifi_iface=$1
	local devname=$2
	local ifname
	local network
	local device
	local disabled

	if [ "$1" == "apcli0" ]; then
		ifname="apcli0"
		network="lan"
		device="MT7915D_1_1"
	elif [ "$1" == "apclix0" ]; then
		ifname="apclix0"
		network="lan"
		device="MT7915D_1_2"
	else
		ifname=`uci -q get wireless.${wifi_iface}.ifname`
		network=`uci -q get wireless.${wifi_iface}.network`
		device=`uci -q get wireless.${wifi_iface}.device`
		disabled=`uci -q get wireless.${wifi_iface}.disabled`
	fi


	[ "$ifname" == "" ] && return;
	[ -n "$devname" ] && [ "$device" != "$devname" ] && return;
	[ -e /sys/class/net/$ifname ] || return;

	if [ "${disabled}" == "1" ]; then
		echo " @@@ down ${ifname} net(${network})"
		ifconfig ${ifname} down;

		if [ -L "/sys/devices/virtual/net/$ifname/master" ]; then
			network=`ls /sys/devices/virtual/net/$ifname/master -l | awk '{print $11}' | sed 's/..\/br-//g'`
			if [ -n ${network} ]; then
				brctl delif br-${network} ${ifname} 2>/dev/null || true;
				ubus call network.interface.${network} remove_device "{\"name\":\"${ifname}\"}" 2>/dev/null || true;
			fi
		fi
	else
		echo " @@@ up ${ifname} net(${network})"
		ifconfig ${ifname} up;

		if [ -n ${network} ]; then
			brctl addif br-${network} ${ifname} 2>/dev/null || true;
			ubus call network.interface.${network} add_device "{\"name\":\"${ifname}\"}" 2>/dev/null || true;
		fi

		if [ "${ifname}" == "apcli0" -o "${ifname}" == "apclix0" ]; then
			echo "@@@ ${ifname} dev,so  ApCliAutoConnect"
			iwpriv ${ifname} set ApCliAutoConnect=3
		fi

		if [ -n ${network} ]; then
			mi_wifi_ctl devcheck ${ifname} br-${network} 3 &
		else
			mi_wifi_ctl devcheck ${ifname} NULL 3 &
		fi
	fi
}

mi_wifi_iface_down() {
	[ "$1" == "" ] && return
	local wifi_iface=$1
	local devname=$2
	local ifname
	local network
	local device

	if [ "$1" == "apcli0" ]; then
		ifname="apcli0"
		device="MT7915D_1_1"
	elif [ "$1" == "apclix0" ]; then
		ifname="apclix0"
		device="MT7915D_1_2"
	else
		ifname=`uci -q get wireless.${wifi_iface}.ifname`
		device=`uci -q get wireless.${wifi_iface}.device`
	fi

	[ "$ifname" == "" ] && return;
	[ -n "$devname" ] && ["$device" != "$devname" ] && return;
	[ -e /sys/class/net/$ifname ] || return;

	echo " @@@ down ${ifname} net(${network})"
	ifconfig ${ifname} down;

	if [ -L "/sys/devices/virtual/net/$ifname/master" ]; then
		network=`ls /sys/devices/virtual/net/$ifname/master -l | awk '{print $11}' | sed 's/..\/br-//g'`
		if [ -n ${network} ]; then
			brctl delif br-${network} ${ifname} 2>/dev/null || true;
			ubus call network.interface.${network} remove_device "{\"name\":\"${ifname}\"}" 2>/dev/null || true;
		fi
	fi
}

miot_iface_up() {
	local bindstatus
	local userswitch
	
	bindstatus=`uci -q get wireless.miot_2G.bindstatus`
	userswitch=`uci -q get wireless.miot_2G.userswitch`
	
	if [ -z $bindstatus ];then
		bindstatus=0
	fi
	
	if [ -z $userswitch ];then
		userswitch=1
	fi
	
	#echo "bind=$bindstatus" "switch=$userswitch"

	if [ $bindstatus == 0 -o $userswitch == 0 ];then
		ifconfig wl13 down;
	else
		ifconfig wl13 up;
	fi
}

# vifs_up and vifs_down accept ifname patterns, for example:
#
#	 vifs_up ra0			 -- ra0
#	 vifs_up rai0			-- rai0
#	 vifs_up ra?			 -- ra0, ra1, ..., ra9, raa, rab, ....
#	 vifs_up ra*			 -- ra0, rai0, ra1, rai1asdfasdfasdf, ....
#	 vifs_up ra[0-9]		 -- ra0, ra1, ..., ra9
#	 vifs_up ra1[1-3]		-- ra11, ra12, ra13
#	 vifs_up ra[0-9]*		-- ra0, ra1, ..., ra10, ra11, ....

vifs_up() {
	[ "$1" == "" ] && return
	local ifname=$1 # can be pattern
	local devname=$2
	local network

	cd /sys/class/net
	for vif in `set +f;ls -d *${ifname} 2>/dev/null;set -f`; do
		local device=`uci -q get wireless.${vif}.device`
		if [ "$device" != "$devname" ]; then 
			continue;
		fi

		disabled=`uci -q get wireless.${vif}.disabled`
		network=`uci -q get wireless.${vif}.network`

		if [ "${disabled}" == "1" ]; then
			if [ -n ${network} ]; then
			#brvifs=`uci get network.lan.ifname`
			#if echo ${brvifs} | grep -q ${vif}; then
			#	echo "will remove ${vif} from ${bridge}!" > /dev/null;
			#	brvifs=`uci get network.lan.ifname | sed "s/${vif}//g"`
			#	uci set network.lan.ifname="${brvifs}";
			#	uci commit;
			#fi
			brctl delif br-${network} ${vif} 2>/dev/null || true;
			ubus call network.interface.${network} remove_device "{\"name\":\"${vif}\"}" 2>/dev/null || true;
			fi
			echo " @@@ down ${vif} net(${network})"
			ifconfig ${vif} down;
			continue; 
		fi
		echo " @@@ up ${vif} net(${network})"
		ifconfig ${vif} up;

		if [ -n ${network} ]; then
			brctl addif br-${network} ${vif} 2>/dev/null || true;
			ubus call network.interface.${network} add_device "{\"name\":\"${vif}\"}" 2>/dev/null || true;
			mi_wifi_ctl devcheck ${vif} br-${network} 3 &
		else
			mi_wifi_ctl devcheck ${vif} NULL 3 &
		fi
	done
}

vifs_down() {
	[ "$1" == "" ] && return
	local ifname=$1 # can be pattern
	local devname=$2
	local network
	cd /sys/class/net
	for vif in `set +f;ls -d *${ifname} 2>/dev/null;set -f`; do
		local device=`uci -q get wireless.${vif}.device`

		if [ -n "$devname" -a "$device" != "$devname" ]; then 
			continue;
		fi

		echo " @@@ down ${vif} net(${network})"
		ifconfig $vif down;

		if [ -L "/sys/devices/virtual/net/$vif/master" ]; then
		network=`ls /sys/devices/virtual/net/$vif/master -l | awk '{print $11}' | sed 's/..\/br-//g'`
		if [ -n ${network} ]; then
			brctl delif br-${network} ${vif} 2>/dev/null || true;
			ubus call network.interface.${network} remove_device "{\"name\":\"${vif}\"}" 2>/dev/null || true;
		fi
		fi
	done
}

main_vif_check() {
	[ "$1" == "" ] && return
	local ifname=$1
	local network

	disabled=`uci -q get wireless.${ifname}.disabled`
	if [ "${disabled}" == "1" ]; then 
		echo "@@@ down main_vif(${ifname})"
	 	ifconfig $ifname down;
		if [ -L "/sys/devices/virtual/net/$ifname/master" ]; then
			network=`ls /sys/devices/virtual/net/$ifname/master -l | awk '{print $11}' | sed 's/..\/br-//g'`
			if [ -n ${network} ]; then
				brctl delif br-${network} ${ifname} 2>/dev/null || true;
				ubus call network.interface.${network} remove_device "{\"name\":\"${ifname}\"}" 2>/dev/null || true;
			fi
		fi
	else
		network=`uci -q get wireless.${ifname}.network`
		if [ -n ${network} ]; then
			brctl addif br-${network} ${ifname} 2>/dev/null || true;
			ubus call network.interface.${network} add_device "{\"name\":\"${ifname}\"}" 2>/dev/null || true;
			mi_wifi_ctl devcheck ${ifname} br-${network} 3 &
		else
			mi_wifi_ctl devcheck ${ifname} NULL 3 &
		fi
	fi
}

# common API for mt76xx drivers
# $1 = devname
# $2 = driver
mt76xx_up() {
	local devname=`echo $1 | sed 's/\./_/g'`
	local driver=$2
	local devs

	[ -f /lib/modules/`uname -r`/${driver}.ko ] && modprobe ${driver}.ko

	if [ "$devname" == "" ]; then
		for devname in $L1DEVNAMES; do
			eval init_compatible=\$${devname}_init_compatible
			if [ "${init_compatible}" == "${driver}" ]; then
				devs="$devname $devs"
			fi
		done
	else
		devs=$devname
	fi

	for devname in $devs; do
		# 1. call uci2dat to save uci changes into profile
		eval profile=\${${devname}_profile_path}
		eval main_ifname=\$${devname}_main_ifname
		eval ext_ifname=\$${devname}_ext_ifname
		echo "@@@mt76xx_up devname=${devname}"
		uci2dat -d ${devname} -f ${profile}

		disabled=`uci -q get wireless.${devname}.disabled`
		if [ "${disabled}" == "1" ]; then
			echo "@@@ ${devname} is disabled,so up down ${main_ifname}"
			ifconfig ${main_ifname} up;
			ifconfig ${main_ifname} down;
		else
			# 1. just up main_ifname
			echo "@@@ up main_ifname(${main_ifname})"
			ifconfig ${main_ifname} up;
			set -f
			# 2. up vifs wl2~wl7 
			vifs_up wl[2-7] ${devname}

			# 3. up bh , guest , apcli . by need 
			if [ "$devname" == "MT7915D_1_1" ]; then
				mi_wifi_iface_up "guest_2G" ${devname}
				miot_iface_up
			elif [ "$devname" == "MT7915D_1_2" ]; then
				mi_wifi_iface_up "guest_5G" ${devname}
			fi
			mi_wifi_iface_up "apcli" ${devname}

			# 4. recheck main_ifname, down or add bridge
			main_vif_check ${main_ifname}
			set +f
		fi
	done
	## Patch: Fix AMSDU RATE AUTORATE SETTING
	iwpriv wl1 mac 820f2018=1cc20080
}




# $1 = devname
# $2 = driver
mt76xx_down() {
	local devname=`echo $1 | sed 's/\./_/g'`
	local driver=$2
	local devs

	if [ "$devname" == "" ]; then
		for devname in $L1DEVNAMES; do
			eval init_compatible=\$${devname}_init_compatible
			if [ "${init_compatible}" == "${driver}" ]; then
				devs="$devs $devname"
			fi
		done
	else
		devs=$devname
	fi

	for devname in $devs; do
		# 1. call uci2dat to save uci changes into profile(DBDC Mode)
		eval profile=\${${devname}_profile_path}
		eval main_ifname=\$${devname}_main_ifname
		eval ext_ifname=\$${devname}_ext_ifname
		echo "@@@mt76xx_down devname=${devname}"
		uci2dat -d ${devname} -f ${profile}

		if [ "$1" == "MT7915D_1_1" ]; then
			mi_wifi_iface_down "apcli0"
			mi_wifi_iface_down "guest_2G"
			mi_wifi_iface_down "bh_2G_ap"
			ifconfig wl13 down
		elif [ "$1" == "MT7915D_1_2" ]; then
			mi_wifi_iface_down "apclix0"
			mi_wifi_iface_down "guest_5G"
			mi_wifi_iface_down "bh_5G_ap"
		fi

		vifs_down wl[2-7] ${devname}
		vifs_down ${main_ifname} ${devname}

	done
}


# $1 = devname
# $2 = driver
mt76xx_reload() {
	local devname=`echo $1 | sed 's/\./_/g'`
	local devnames=${devname}
	local driver=$2
	local need_restart=0
	local need_downup=0
	if [ "${devnames}" == "" ]; then
		if [ "${driver}" == "" ]; then
			echo "Invalid arguments! Both devname and driver are empty."
		fi
		for dev in ${L1DEVNAMES}; do
			eval compat=\${${dev}_init_compatible}
			if [ "${compat}" == "${driver}" ]; then
				devnames="${dev} ${devnames}"
			fi
		done
	fi

	for devname in ${devnames}; do
		eval profile=\${${devname}_profile_path}

		# 0. backup profiles first
		mkdir -p /tmp/mtk/wifi
		local profile_bak=`echo ${profile} | awk -F "/" '{print $(NF-0)}'`
		profile_bak=/tmp/mtk/wifi/${profile_bak}.bak
		cp ${profile} ${profile_bak} || true

		# 1. call uci2dat to save uci changes into profile
		uci2dat -d ${devname} -f ${profile}

		# 2. check if we can do quick reload, "uci changes wireless" is a possible alternative
		datdiff ${profile_bak} ${profile} > /tmp/mtk/wifi/datdiff-${devname}.tmp
		if cat /tmp/mtk/wifi/datdiff-${devname}.tmp | grep -q BssidNum=; then
			# need call mt76xx_restart
#			need_restart=1
#			mt76xx_restart "" "${driver}"
			need_downup=1
		fi

		if cat /tmp/mtk/wifi/datdiff-${devname}.tmp\
			| grep -Eq '(HT_LDPC|VHT_SGI|VHT_LDPC|E2pAccessMode|BandDisabled)='; then
			need_downup=1
		fi

		# 3. quick reload
		if [ "0" == "${need_downup}"  -a "0" == "${need_restart}" ]; then
			datdiff -x ${profile_bak} ${profile} > /tmp/mtk/wifi/datdiff-${devname}.sh
			# save the quick seting log, we assume it can hold up to 200 lines at most.
			if [ -s /tmp/mtk/wifi/datdiff-${devname}.sh ]; then
				[ -f "/tmp/mtk/wifi/iwpriv_cmds.log" ] && lines=`sed -n '$=' /tmp/mtk/wifi/iwpriv_cmds.log`
				[ $lines -gt 200 ] && mv -f "/tmp/mtk/wifi/iwpriv_cmds.log" "/tmp/mtk/wifi/iwpriv_cmds_bak.log"
				echo "------------------------------------------------------" >> /tmp/mtk/wifi/iwpriv_cmds.log
				cat /tmp/mtk/wifi/datdiff-${devname}.sh >> /tmp/mtk/wifi/iwpriv_cmds.log
			fi
			mt76xx_up "${devname}" "${driver}"
			sh /tmp/mtk/wifi/datdiff-${devname}.sh 2>/dev/null
		fi
	done

	#4 . normal reload (Both single band mode and DBDC mode)
	if [ "1" == "${need_downup}" -a "0" == "${need_restart}" ]; then
		# normal reload
		mt76xx_down "" "${driver}"
		mt76xx_up "" "${driver}"
	fi

	#5 . normal restart
#	if [ "1" == "${need_restart}" ]; then
#		# In order to display vifs in UI correctly
#		uci2dat
#		dat2uci
#		[ -f "/tmp/mtk/wifi/reboot_required" ] && /sbin/wifi down && reboot -f >/dev/null 2>&1
#	fi

	# remove tmp files
	# rm -f /tmp/mtk/wifi/*.dat.bak   || true
	# rm -f /tmp/mtk/wifi/*.sh  || true
	# rm -f /tmp/mtk/wifi/*.tmp || true
}




# $1 = devname
# $2 = driver
mt76xx_restart() {
	local devname=`echo $1 | sed 's/\./_/g'`
	local driver=$2

	[ -f /lib/modules/`uname -r`/${driver}.ko ] || echo "failed to detect ${driver}.ko"
	if [ -d /sys/module/${driver} ]; then
		mt76xx_down "${devname}" "${driver}"
		rmmod ${driver};
		modprobe ${driver}.ko;
		mt76xx_up "${devname}" "${driver}"
	else
		# if wifi driver is built-in, it's necessary action to reboot the device
		mkdir -p /tmp/mtk/wifi
		echo reboot_required > /tmp/mtk/wifi/reboot_required
	fi

}


# $1 = devname
# $2 = driver
mt76xx_detect() {
	dat2uci -l /etc/wireless/l1profile.dat -u /etc/config/wireless
}


# $1 = devname
# $2 = driver
mt76xx_status() {
	iwconfig
}

# $1 = devname
# $2 = driver
mt76xx_hello() {
	echo "mt76xx_hello($@)"
}

