#
# Copyright (C) 2011 OpenWrt.org
#

USE_REFRESH=1

. /lib/ipq806x.sh
. /lib/upgrade/common.sh

RAMFS_COPY_DATA=/lib/ipq806x.sh
RAMFS_COPY_BIN="/usr/bin/dumpimage /bin/mktemp /usr/sbin/mkfs.ubifs
	/usr/sbin/ubiattach /usr/sbin/ubidetach /usr/sbin/ubiformat /usr/sbin/ubimkvol
	/usr/sbin/ubiupdatevol /usr/bin/basename /bin/rm /usr/bin/find
	/usr/sbin/mkfs.ext4"

get_full_section_name() {
	local img=$1
	local sec=$2

	dumpimage -l ${img} | grep "^ Image.*(${sec})" | \
		sed 's,^ Image.*(\(.*\)),\1,'
}

image_contains() {
	local img=$1
	local sec=$2
	dumpimage -l ${img} | grep -q "^ Image.*(${sec}.*)" || return 1
}

print_sections() {
	local img=$1

	dumpimage -l ${img} | awk '/^ Image.*(.*)/ { print gensub(/Image .* \((.*)\)/,"\\1", $0) }'
}

image_has_mandatory_section() {
	local img=$1
	local mandatory_sections=$2

	for sec in ${mandatory_sections}; do
		image_contains $img ${sec} || {\
			return 1
		}
	done
}

image_demux() {
	local img=$1

	for sec in $(print_sections ${img}); do
		local fullname=$(get_full_section_name ${img} ${sec})

		local position=$(dumpimage -l ${img} | grep "(${fullname})" | awk '{print $2}')
		dumpimage -i ${img} -o /tmp/${fullname}.bin -T "flat_dt" -p "${position}" ${fullname} > /dev/null || { \
			echo "Error while extracting \"${sec}\" from ${img}"
			return 1
		}
	done
	return 0
}

image_is_FIT() {
	if ! dumpimage -l $1 > /dev/null 2>&1; then
		echo "$1 is not a valid FIT image"
		return 1
	fi
	return 0
}

switch_layout() {
	local layout=$1
	local boot_layout=`find / -name boot_layout`

	# Layout switching is only required as the  boot images (up to u-boot)
	# use 512 user data bytes per code word, whereas Linux uses 516 bytes.
	# It's only applicable for NAND flash. So let's return if we don't have
	# one.

	[ -n "$boot_layout" ] || return

	case "${layout}" in
		boot|1) echo 1 > $boot_layout;;
		linux|0) echo 0 > $boot_layout;;
		*) echo "Unknown layout \"${layout}\"";;
	esac
}

do_flash_mtd() {
	local bin=$1
	local mtdname=$2
	local append=""

	local mtdpart=$(grep "\"${mtdname}\"" /proc/mtd | awk -F: '{print $1}')
	local pgsz=$(cat /sys/class/mtd/${mtdpart}/writesize)
	[ -f "$CONF_TAR" -a "$SAVE_CONFIG" -eq 1 -a "$2" == "rootfs" ] && append="-j $CONF_TAR"

	dd if=/tmp/${bin}.bin bs=${pgsz} conv=sync | mtd $append -e "/dev/${mtdpart}" write - "/dev/${mtdpart}"
}

do_flash_emmc() {
	local bin=$1
	local emmcblock=$2

	dd if=/dev/zero of=${emmcblock}
	dd if=/tmp/${bin}.bin of=${emmcblock}
}

do_flash_partition() {
	local bin=$1
	local mtdname=$2
	local emmcblock="$(find_mmc_part "$mtdname")"

	if [ -e "$emmcblock" ]; then
		do_flash_emmc $bin $emmcblock
	else
		do_flash_mtd $bin $mtdname
	fi
}

do_flash_bootconfig() {
	local bin=$1
	local mtdname=$2

	# Fail safe upgrade
	if [ -f /proc/boot_info/getbinary_${bin} ]; then
		cat /proc/boot_info/getbinary_${bin} > /tmp/${bin}.bin
		do_flash_partition $bin $mtdname
	fi
}

do_flash_failsafe_partition() {
	local bin=$1
	local mtdname=$2
	local emmcblock
	local primaryboot

	# Fail safe upgrade
	[ -f /proc/boot_info/$mtdname/upgradepartition ] && {
		default_mtd=$mtdname
		mtdname=$(cat /proc/boot_info/$mtdname/upgradepartition)
		primaryboot=$(cat /proc/boot_info/$default_mtd/primaryboot)
		if [ $primaryboot -eq 0 ]; then
			echo 1 > /proc/boot_info/$default_mtd/primaryboot
		else
			echo 0 > /proc/boot_info/$default_mtd/primaryboot
		fi
	}

	emmcblock="$(find_mmc_part "$mtdname")"

	if [ -e "$emmcblock" ]; then
		do_flash_emmc $bin $emmcblock
	else
		do_flash_mtd $bin $mtdname
	fi

}

do_flash_ubi() {
	local bin=$1
	local mtdname=$2
	local mtdpart
	local primaryboot

	mtdpart=$(grep "\"${mtdname}\"" /proc/mtd | awk -F: '{print $1}')
	ubidetach -f -p /dev/${mtdpart}

	# Fail safe upgrade
	[ -f /proc/boot_info/$mtdname/upgradepartition ] && {
		primaryboot=$(cat /proc/boot_info/$mtdname/primaryboot)
		if [ $primaryboot -eq 0 ]; then
			echo 1 > /proc/boot_info/$mtdname/primaryboot
		else
			echo 0 > /proc/boot_info/$mtdname/primaryboot
		fi

		mtdname=$(cat /proc/boot_info/$mtdname/upgradepartition)
	}

	mtdpart=$(grep "\"${mtdname}\"" /proc/mtd | awk -F: '{print $1}')

	ubiformat /dev/${mtdpart} -y -f /tmp/${bin}.bin
}

do_flash_tz() {
	local sec=$1
	local mtdpart=$(grep "\"0:QSEE\"" /proc/mtd | awk -F: '{print $1}')
	local emmcblock="$(find_mmc_part "0:QSEE")"

	if [ -n "$mtdpart" -o -e "$emmcblock" ]; then
		do_flash_failsafe_partition ${sec} "0:QSEE"
	else
		do_flash_failsafe_partition ${sec} "0:TZ"
	fi
}

do_flash_ddr() {
	local sec=$1
	local mtdpart=$(grep "\"0:CDT\"" /proc/mtd | awk -F: '{print $1}')
	local emmcblock="$(find_mmc_part "0:CDT")"

	if [ -n "$mtdpart" -o -e "$emmcblock" ]; then
		do_flash_failsafe_partition ${sec} "0:CDT"
	else
		do_flash_failsafe_partition ${sec} "0:DDRPARAMS"
	fi
}

to_upper ()
{
	echo $1 | awk '{print toupper($0)}'
}
image_is_nand()
{
	local nand_part="$(find_mtd_part "ubi_rootfs")"
	[ -e "$nand_part" ] || return 1

}
flash_section() {
	local sec=$1
	local board=$(ipq806x_board_name)
	local version=$(hexdump -n 1 -e '"%1d"' /sys/firmware/devicetree/base/soc_version_major)

	if [ $version == "" ]; then
		version=1
	fi

	# Look for pci mhi devices
	for device in $(cat /sys/bus/pci/devices/*/device 2> /dev/null)
	do
		[ "${device}" = "0x1104" ] && qcn9000="true"
	done

	case "${sec}" in
		hlos*) switch_layout linux; image_is_nand && return || do_flash_failsafe_partition ${sec} "0:HLOS";;
		rootfs*) switch_layout linux; image_is_nand && return || do_flash_failsafe_partition ${sec} "rootfs";;
		wififw-*) switch_layout linux; do_flash_failsafe_partition ${sec} "0:WIFIFW";;
		wififw_ubi-*) switch_layout linux; do_flash_ubi ${sec} "0:WIFIFW";;
		wififw_v${version}-*) switch_layout linux; do_flash_failsafe_partition ${sec} "0:WIFIFW";;
		wififw_ubi_v${version}-*)
			if ! [ "${qcn9000}" = "true" ]; then
				switch_layout linux; do_flash_ubi ${sec} "0:WIFIFW";
			else
				echo "Section ${sec} ignored"; return 1;
			fi
			;;
		wififw_ubi_*_v${version}-*)
			if [ "${qcn9000}" = "true" ]; then
				switch_layout linux; do_flash_ubi ${sec} "0:WIFIFW";
			else
				echo "Section ${sec} ignored"; return 1;
			fi
			;;
		fs*) switch_layout linux; do_flash_failsafe_partition ${sec} "rootfs";;
		ubi*) switch_layout linux; image_is_nand || return && do_flash_ubi ${sec} "rootfs";;
		sbl1*) switch_layout boot; do_flash_partition ${sec} "0:SBL1";;
		sbl2*) switch_layout boot; do_flash_failsafe_partition ${sec} "0:SBL2";;
		sbl3*) switch_layout boot; do_flash_failsafe_partition ${sec} "0:SBL3";;
		dtb-$(to_upper $board)*) switch_layout boot; do_flash_partition ${sec} "0:DTB";;
		u-boot*) switch_layout boot; do_flash_failsafe_partition ${sec} "0:APPSBL";;
		lkboot*) switch_layout boot; do_flash_failsafe_partition ${sec} "0:APPSBL";;
		ddr-$(to_upper $board)*) switch_layout boot; do_flash_ddr ${sec};;
		ddr-${board}-*) switch_layout boot; do_flash_failsafe_partition ${sec} "0:DDRCONFIG";;
		ssd*) switch_layout boot; do_flash_partition ${sec} "0:SSD";;
		tz*) switch_layout boot; do_flash_tz ${sec};;
		apdp*) switch_layout boot; do_flash_failsafe_partition ${sec} "0:APDP";;
		devcfg*) switch_layout boot; do_flash_failsafe_partition ${sec} "0:DEVCFG";;
		rpm*) switch_layout boot; do_flash_failsafe_partition ${sec} "0:RPM";;
		*) echo "Section ${sec} ignored"; return 1;;
	esac

	echo "Flashed ${sec}"
}

erase_emmc_config() {
	local mtdpart=$(cat /proc/mtd | grep rootfs)
	local emmcblock="$(find_mmc_part "rootfs_data")"
	if [ -z "$mtdpart" -a -e "$emmcblock" ]; then
		yes | mkfs.ext4 "$emmcblock"
	fi
}

platform_pre_upgrade() {
	cp /sbin/upgraded /tmp
	ubus call system nandupgrade "{\"path\": \"$1\" }"
}

platform_check_image() {
	local board=$(ipq806x_board_name)

	local mandatory_nand="ubi"
	local mandatory_nor_emmc="hlos fs"
	local mandatory_nor="hlos"
	local mandatory_section_found=0
	local ddr_section="ddr"
	local optional="sb11 sbl2 u-boot lkboot ddr-${board} ssd tz rpm"
	local ignored="mibib bootconfig"

	image_is_FIT $1 || return 1

	image_has_mandatory_section $1 ${mandatory_nand} && {\
		mandatory_section_found=1
	}

	image_has_mandatory_section $1 ${mandatory_nor_emmc} && {\
		mandatory_section_found=1
	}

	image_has_mandatory_section $1 ${mandatory_nor} && {\
		mandatory_section_found=1
	}

	if [ $mandatory_section_found -eq 0 ]; then
		echo "Error: mandatory section(s) missing from \"$1\". Abort..."
		return 1
	fi

	image_has_mandatory_section $1 $ddr_section && {\
		image_contains $1 ddr-$board || {\
			image_contains $1 ddr-$(to_upper $board) || {\
			return 1
			}
		}
	}
	for sec in ${optional}; do
		image_contains $1 ${sec} || {\
			echo "Warning: optional section \"${sec}\" missing from \"$1\". Continue..."
		}
	done

	for sec in ${ignored}; do
		image_contains $1 ${sec} && {\
			echo "Warning: section \"${sec}\" will be ignored from \"$1\". Continue..."
		}
	done

	image_demux $1 || {\
		echo "Error: \"$1\" couldn't be extracted. Abort..."
		return 1
	}

	[ -f /tmp/hlos_version ] && rm -f /tmp/*_version
	dumpimage -c $1
	if [[ "$?" == 0 ]];then
		return $?
	else
		echo "Rebooting the system"
		reboot
		return 1
	fi
}

platform_version_upgrade() {
	local version_files="appsbl_version sbl_version tz_version hlos_version rpm_version"
	local sys="/sys/devices/system/qfprom/qfprom0/"
	local tmp="/tmp/"

	for file in $version_files; do
		[ -f "${tmp}${file}" ] && {
			echo "Updating "${sys}${file}" with `cat "${tmp}${file}"`"
			echo `cat "${tmp}${file}"` > "${sys}${file}"
			rm -f "${tmp}${file}"
		}
	done
}

platform_do_upgrade() {
	local board=$(ipq806x_board_name)

	# verify some things exist before erasing
	if [ ! -e $1 ]; then
		echo "Error: Can't find $1 after switching to ramfs, aborting upgrade!"
		reboot
	fi

	for sec in $(print_sections $1); do
		if [ ! -e /tmp/${sec}.bin ]; then
			echo "Error: Cant' find ${sec} after switching to ramfs, aborting upgrade!"
			reboot
		fi
	done

	case "$board" in
	db149 | ap148 | ap145 | ap148_1xx | db149_1xx | db149_2xx | ap145_1xx | ap160 | ap160_2xx | ap161 | ak01_1xx | ap-dk01.1-c1 | ap-dk01.1-c2 | ap-dk04.1-c1 | ap-dk04.1-c2 | ap-dk04.1-c3 | ap-dk04.1-c4 | ap-dk04.1-c5 | ap-dk04.1-c6 | ap-dk05.1-c1 |  ap-dk06.1-c1 | ap-dk07.1-c1 | ap-dk07.1-c2 | ap-dk07.1-c3 | ap-dk07.1-c4 | ap-hk01-c1 | ap-hk01-c2 | ap-hk01-c3 | ap-hk01-c4 | ap-hk01-c5 | ap-hk02 | ap-hk07 | ap-hk08 | ap-hk09 | ap-hk10-c1 | ap-hk10-c2 | ap-hk11-c1 | ap-hk14 | ap-ac01 | ap-ac02 | ap-ac03 | ap-ac04 | ap-oak02 | ap-oak03 | db-hk01 | db-hk02 | ap-cp01-c1 | ap-cp01-c2 | ap-cp01-c3 | ap-cp01-c4 | ap-cp02-c1 | ap-cp03-c1 | db-cp01 | db-cp02 | mp-emu | ap-mp02.1 | ap-mp03.1 | ap-mp03.1-c2 | ap-mp03.3 | ap-mp03.3-c2 | db-mp02.1 | db-mp03.1 | db-mp03.1-c2 | db-mp03.3 | db-mp03.3-c2)
		for sec in $(print_sections $1); do
			flash_section ${sec}
		done

		switch_layout linux
		# update bootconfig to register that fw upgrade has been done
		do_flash_bootconfig bootconfig "0:BOOTCONFIG"
		do_flash_bootconfig bootconfig1 "0:BOOTCONFIG1"
		platform_version_upgrade

		erase_emmc_config
		return 0;
		;;
	esac

	echo "Upgrade failed!"
	return 1;
}

platform_copy_config() {
	local nand_part="$(find_mtd_part "ubi_rootfs")"
	local emmcblock="$(find_mmc_part "rootfs_data")"
	mkdir -p /tmp/overlay

	if [ -e "$nand_part" ]; then
		local mtdname=rootfs
		local mtdpart

		[ -f /proc/boot_info/$mtdname/upgradepartition ] && {
			mtdname=$(cat /proc/boot_info/$mtdname/upgradepartition)
		}

		mtdpart=$(grep "\"${mtdname}\"" /proc/mtd | awk -F: '{print $1}')
		ubiattach -p /dev/${mtdpart}
		mount -t ubifs ubi0:rootfs_data /tmp/overlay
		cp /tmp/sysupgrade.tgz /tmp/overlay/
		sync
		umount /tmp/overlay
	elif [ -e "$emmcblock" ]; then
		mount -t ext4 "$emmcblock" /tmp/overlay
		cp /tmp/sysupgrade.tgz /tmp/overlay/
		sync
		umount /tmp/overlay
	fi
}

