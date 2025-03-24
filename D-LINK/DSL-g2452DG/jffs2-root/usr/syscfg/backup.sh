#!/bin/sh
. /usr/syscfg/api_log.sh

SUCCESS="success"
ERR_FILE_EXIST="err_file_exist"
ERR_FILE_NONE="err_file_none"
ERR_FILE_FORMAT="err_file_format"
ERR_SPACE_USEDUP="err_space_usedup"
ERR_PARTITION_NONE="err_partition_none"



action=$1
backup_config_path=$2


if [ -z "$backup_config_path" ]; then
	TGP_Log ${TGP_LOG_ERROR} "backup_config_path is empty!"
	exit 1
fi


ret=$SUCCESS

backup_judge()
{
	if [ -f "$backup_config_path" ]; then
		ret=$ERR_FILE_EXIST
	fi
}

restore_judge()
{
	if [ ! -f "$backup_config_path" ]; then
		ret=$ERR_FILE_NONE
	fi
}

backup()
{
	local config_tmpcfg="/tmp/.backup.cfg.tmp"
	local config_tmpmd5="/tmp/.backup.cfg.md5"
	local config_tmpall="/tmp/.backup.cfg.all"
	local config_tmpenc="/tmp/.backup.cfg.enc"

	dd if=/dev/mtd2 of=$config_tmpcfg
	md5sum $config_tmpcfg | cut -d ' ' -f 1 > $config_tmpmd5
	cat $config_tmpmd5 $config_tmpcfg > $config_tmpall
	base64 $config_tmpall > $config_tmpenc

	cp $config_tmpenc $backup_config_path
	if [ $? -ne 0 ]; then
		ret=$ERR_SPACE_USEDUP
		rm -f $backup_config_path
	fi

	rm -f $config_tmpcfg
	rm -f $config_tmpmd5
	rm -f $config_tmpall
	rm -f $config_tmpenc
}

restore()
{
	local config_tmpall="/tmp/.backup.cfg.all"

	base64 -d $backup_config_path > $config_tmpall

	md5_old=`sed -n '1p' $config_tmpall`
	sed -i '1d' $config_tmpall
	md5_new=`md5sum $config_tmpall | cut -d ' ' -f 1`

	if [ "$md5_old" != "$md5_new" ]; then
		ret=$ERR_FILE_FORMAT
		return
	fi

	dd if=$config_tmpall of=/dev/mtdblock2

	rm -f $config_tmpall
}


case "$action" in
	"backup_judge")
		backup_judge
		echo -n $ret
		;;
	"restore_judge")
		restore_judge
		echo -n $ret
		;;
	"backup")
		backup_judge
		if [ "${ret:0:3}" != "err" ]; then
			backup
		fi
		echo -n $ret
		;;
	"restore")
		restore_judge
		if [ "${ret:0:3}" != "err" ]; then
			restore
		fi
		echo -n $ret
		;;

	"clean")
		rm -f $backup_config_path
		exit 0
		;;

	"dump")
		restore_judge
		if [ "${ret:0:3}" != "err" ]; then
			cat $backup_config_path
			exit 0
		fi
		;;
esac

