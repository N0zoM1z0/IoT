#!/bin/sh
#
# Copyright (c) 2020 Qualcomm Technologies, Inc.
#
# All Rights Reserved.
# Confidential and Proprietary - Qualcomm Technologies, Inc.
#
#

. /lib/ipq806x.sh
. /lib/functions.sh

low_mem_compress_art()
{
        local ART_PART=$(cat /proc/mtd | grep 0:ART)
        [ -n "$ART_PART" ] || return

        local mtd_dev=$(echo $ART_PART | awk '{print $1}' | sed 's/:$//')
        [ -n "$mtd_dev" ] || return

        local apmp="/tmp"

        lzma -zvfk ${apmp}/virtual_art.bin

        if [ $? -ne 0 ]
        then
                echo "Error Compressing Virtual ART" > /dev/console
                return
        fi

        mtd erase /dev/$mtd_dev
        mtd write ${apmp}/virtual_art.bin.lzma /dev/$mtd_dev
        echo "Success compressing Virtual ART" > /dev/console
        return
}

compress_caldata()
{
        local board=$(ipq806x_board_name)
        case "$board" in
                ap-mp02.1* | db-mp02.1*)
                        low_mem_compress_art
                ;;
                *)
                        echo "Compressing Virtual ART Not Supported on $board " > /dev/console
                ;;
        esac
}

if [ "$1" = "compress_caldata" ]
then
        compress_caldata
fi
