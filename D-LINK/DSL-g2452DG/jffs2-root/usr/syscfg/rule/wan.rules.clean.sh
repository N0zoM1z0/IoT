#!/bin/sh
# 
# cleanup wan related rules out of date
# 
# $1: config | reset | all
# $2: dir | script
#
# NOTE:
#  script $2 can be a path/to/script to clean a single rule
#

usage()
{
        echo "------------------------------------------------------"
        echo "Usage: $0 <config|reset|all> <dir|script>"
        echo "------------------------------------------------------"
}

if [ $# -lt 2 ]; then
	usage
	exit
fi

op=$1
target=$2

root_dir="/tmp/.wan_rules"

# exec a script or all scripts recursively in a dir
# $1: a script file, or a scripts dir
clean_exec()
{
	if [ $# -lt 1 ]; then
		return;
	fi
	this=$1
	
	if [ -e ${this} ]; then
		rm -rf ${this}
	fi
}

clean_target()
{
	if [ $# -lt 1 ]; then
		return
	fi
	local dir=$1

	clean_exec "${dir}/${target}"
}

do_clean()
{
	if [ $# -lt 1 ]; then
		return
	fi
	local _op=$1

	if [ ${_op} == 'all' ]; then
		do_clean reset
		do_clean config
	else
		for w in `ls ${root_dir}`; do
			dir="${root_dir}/${w}/${_op}"
			clean_target ${dir}
		done; unset w
	fi
}


###################################### main ######################################
if [ ! -d ${root_dir} ]; then
	echo "[$0] ${root_dir} is empty, op=$1, target=$2"
	exit 0
fi

case "${op}" in
	"reset")
		do_clean ${op}
		;;
	"config")
		do_clean ${op}
		;;
	"all")
		do_clean ${op}
		;;
	*)
		exit
		;;
esac

