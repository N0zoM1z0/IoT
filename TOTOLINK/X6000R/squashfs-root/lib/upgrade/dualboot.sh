#
# Copyright (C) 2021 lintel<lintel.huang@gmail.com>
#

dualboot_switch_boot_ubi() {
	cur_boot_sys=$(/usr/sbin/fw_printenv -n dual_boot_sys)

	[ -z "$cur_boot_sys" ] && cur_boot_sys=0

	#获取当前的系统分区，更新另外的系统分区.
	if [ "$cur_boot_sys" = "0" ]
	then
		#假设现在是系统0，升级系统1,下次启动系统1
		echo "Dualboot: Switch to OS1..."
		fw_setenv dual_boot_sys 1
	elif [ "$cur_boot_sys" = "1" ]
	then
		echo "Dualboot: Switch to OS0..."
		#假设现在是系统1，升级系统0,下次启动系统0
		fw_setenv dual_boot_sys 0
	fi

	#告诉Bootloader,进行了系统升级
	fw_setenv dual_boot_sysupgrade 1
	
}

dualboot_get_target_ubi_dev() {
	cur_boot_sys=$(/usr/sbin/fw_printenv -n dual_boot_sys)

	target_ubi_dev=""
	#获取当前的系统分区，更新另外的系统分区.
	if [ "$cur_boot_sys" = "0" ]
	then
		#假设现在是系统0，升级系统1
		target_ubi_dev="UBI_DEV_1"
	elif [ "$cur_boot_sys" = "1" ]
	then
		#假设现在是系统1，升级系统0
		target_ubi_dev="UBI_DEV_0"
	fi

	echo "$target_ubi_dev"
}

dual_boot_nand_upgrade_tar() {
	local tar_file="$1"
	local kernel_mtd="$(find_mtd_index $CI_KERNPART)"

	local board_dir=$(tar tf $tar_file | grep -m 1 '^sysupgrade-.*/$')
	board_dir=${board_dir%/}

	local kernel_length=`(tar xf $tar_file ${board_dir}/kernel -O | wc -c) 2> /dev/null`
	local rootfs_length=`(tar xf $tar_file ${board_dir}/root -O | wc -c) 2> /dev/null`

	local rootfs_type="$(identify_tar "$tar_file" ${board_dir}/root)"

	local has_kernel=1
	local has_env=0

	[ "$kernel_length" != 0 -a -n "$kernel_mtd" ] && {
		tar xf $tar_file ${board_dir}/kernel -O | mtd write - $CI_KERNPART
	}
	[ "$kernel_length" = 0 -o ! -z "$kernel_mtd" ] && has_kernel=0

	nand_upgrade_prepare_ubi "$rootfs_length" "$rootfs_type" "$has_kernel" "$has_env"

	local ubidev="$( nand_find_ubi "$CI_UBIPART" )"
	[ "$has_kernel" = "1" ] && {
		local kern_ubivol="$(nand_find_volume $ubidev $CI_KERNPART)"
		tar xf $tar_file ${board_dir}/kernel -O | \
			ubiupdatevol /dev/$kern_ubivol -s $kernel_length -
	}

	local root_ubivol="$(nand_find_volume $ubidev $CI_ROOTPART)"
	tar xf $tar_file ${board_dir}/root -O | \
		ubiupdatevol /dev/$root_ubivol -s $rootfs_length -

	[ $? -ne 0 ] && echo "Dualboot: TAR sysupgrade fail!" || {
		echo "Dualboot: TAR sysupgrade done."
		#切换启动系统
		dualboot_switch_boot_ubi
	}

	#结束升级,重启系统
	nand_do_upgrade_success
}

platform_do_upgrade_dualboot() {
	local magic_long="$(get_magic_long "$1")"

	mkdir -p /var/lock
	local part_label="$(dualboot_get_target_ubi_dev)"
	touch /var/lock/fw_printenv.lock

	if [ ! -n "$part_label" ]
	then
		echo "cannot find target partition"
		exit 1
	fi

	#获取要升级的目标系统
	local target_mtd=$(find_mtd_part $part_label)

	echo "Dualboot: Start sysupgrade..."

	[ "$magic_long" = "73797375" ] && {
		CI_UBIPART="$part_label"

		echo "Dualboot: magic check passed..."

		local mtdnum="$( find_mtd_index "$CI_UBIPART" )"
		if [ ! "$mtdnum" ]; then
			echo "cannot find ubi mtd partition $CI_UBIPART"
			return 1
		fi

		local ubidev="$( nand_find_ubi "$CI_UBIPART" )"
		if [ ! "$ubidev" ]; then
			ubiattach -m "$mtdnum"
			sync
			ubidev="$( nand_find_ubi "$CI_UBIPART" )"
		fi

		echo "Dualboot: Starting $CI_UBIPART TAR sysupgrade..."

		#进行TAR升级
		dual_boot_nand_upgrade_tar "$1"

	}
}
