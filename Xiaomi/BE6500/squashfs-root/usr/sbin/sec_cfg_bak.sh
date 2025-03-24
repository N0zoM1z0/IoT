#!/bin/sh

readonly SEC_CFG_VOL_FILE="/data/sec_cfg/data.vol"
readonly SEC_CFG_VOL_BACK="/data/usr/sec_cfg/data.vol"
readonly SEC_CFG_MD5_BACK="/data/usr/sec_cfg/data.md5"

sec_cfg_md5_chk() {
	local _new_md5=

	_new_md5=$(uci show | md5sum | awk '{print $1}')

	grep -sqw "$_new_md5" "$SEC_CFG_MD5_BACK"
}

# Check whether the feature enabled
if uci -q get misc.features.sec_cfg_bak | grep -sqw 1; then
	# Do nothing if vol file not exist
	[ ! -f "$SEC_CFG_VOL_FILE" ] && exit 0

	if ! sec_cfg_md5_chk; then
		mkdir -p "${SEC_CFG_VOL_BACK%/*}"
		cp "$SEC_CFG_VOL_FILE" "$SEC_CFG_VOL_BACK"
		uci show | md5sum | awk '{print $1}' | tee "$SEC_CFG_MD5_BACK" >/dev/null
	fi
fi
