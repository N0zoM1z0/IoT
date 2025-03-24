RAMFS_COPY_BIN='mkfs.f2fs blkid blockdev fw_printenv fw_setenv'
RAMFS_COPY_DATA="/etc/fw_env.config /var/lock/fw_printenv.lock"

platform_do_upgrade() {
	local board=$(board_name)
	IS_NAND_DUALBOOT=$(cat /proc/mtd |grep UBI_DEV_1)

	[ -z "$IS_NAND_DUALBOOT" ] &&  {
		IS_NAND_DUALBOOT=$(cat /proc/mtd |grep ubi_1)
	}
	
	case "$board" in
	*pgb-m8* |\
	*04509a-spim-nand*)
		platform_do_upgrade_dualboot "$1"
		;;
	*snand* |\
	*04498a* |\
	*04499a-spim-nand*)
		nand_do_upgrade "$1"
		;;
	*emmc*)
		mtk_mmc_do_upgrade "$1"
		;;
	*)
		[ -n "$IS_NAND_DUALBOOT" ] &&  { 
			platform_do_upgrade_dualboot "$1"
		}

		[ -z "$IS_NAND_DUALBOOT" ] &&  { 
			default_do_upgrade "$1"
		}
		;;
	esac
}

PART_NAME=firmware

platform_check_image() {
	local board=$(board_name)
	local magic="$(get_magic_long "$1")"

	[ "$#" -gt 1 ] && return 1

	case "$board" in
	*pgb-m8* |\
	*04499a-spim-nand* |\
	*04509a-spim-nand* |\
	*04498a* |\
	*snand* |\
	*emmc*)
		# tar magic `ustar`
		magic="$(dd if="$1" bs=1 skip=257 count=5 2>/dev/null)"

		[ "$magic" != "ustar" ] && {
			echo "Invalid image type."
			return 1
		}

		return 0
		;;
	*)
		[ "$magic" != "d00dfeed" ] && {
			echo "Invalid image type."
			return 1
		}
		return 0
		;;
	esac

	return 0
}

