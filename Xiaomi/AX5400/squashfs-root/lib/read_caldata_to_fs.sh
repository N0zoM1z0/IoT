#!/bin/sh
#
# Copyright (c) 2015 The Linux Foundation. All rights reserved.
# Copyright (C) 2011 OpenWrt.org

. /lib/ipq806x.sh

do_load_ipq4019_board_bin()
{
    local board=$(ipq806x_board_name)
    local mtdblock=$(find_mtd_part 0:ART)

    local apdk="/tmp"

    if [ -z "$mtdblock" ]; then
        # read from mmc
        mtdblock=$(find_mmc_part 0:ART)
    fi

    [ -n "$mtdblock" ] || return

    # load board.bin
    case "$board" in
            ap-dk0*)
                    mkdir -p ${apdk}
                    dd if=${mtdblock} of=${apdk}/wifi0.caldata bs=32 count=377 skip=128
                    dd if=${mtdblock} of=${apdk}/wifi1.caldata bs=32 count=377 skip=640
            ;;
            ap16* | ap148*)
                    mkdir -p ${apdk}
                    dd if=${mtdblock} of=${apdk}/wifi0.caldata bs=32 count=377 skip=128
                    dd if=${mtdblock} of=${apdk}/wifi1.caldata bs=32 count=377 skip=640
                    dd if=${mtdblock} of=${apdk}/wifi2.caldata bs=32 count=377 skip=1152
            ;;
            ap-hk14 | ap-hk01-c6)
                    FILESIZE=131072
                    mkdir -p ${apdk}/IPQ8074
                    dd if=${mtdblock} of=${apdk}/IPQ8074/caldata.bin bs=1 count=$FILESIZE skip=4096
                    ln -s ${apdk}/IPQ8074/caldata.bin /lib/firmware/IPQ8074/caldata.bin

                    mkdir -p ${apdk}/qcn9000
                    dd if=${mtdblock} of=${apdk}/qcn9000/caldata_1.bin bs=1 count=$FILESIZE skip=157696
                    ln -s ${apdk}/qcn9000/caldata_1.bin /lib/firmware/qcn9000/caldata_1.bin
            ;;
            ap-hk01-*)
                    HK_BD_FILENAME=/lib/firmware/IPQ8074/bdwlan.bin
                    mkdir -p ${apdk}/IPQ8074
                    if [ -f "$HK_BD_FILENAME" ]; then
                        FILESIZE=$(stat -Lc%s "$HK_BD_FILENAME")
                    else
                        FILESIZE=131072
                    fi
                    dd if=${mtdblock} of=${apdk}/IPQ8074/caldata.bin bs=1 count=$FILESIZE skip=4096
                    [ -L /lib/firmware/IPQ8074/caldata.bin ] || \
                    ln -s ${apdk}/IPQ8074/caldata.bin /lib/firmware/IPQ8074/caldata.bin
            ;;
            ap-hk10-*)
                    FILESIZE=131072
                    mkdir -p ${apdk}/IPQ8074
                    dd if=${mtdblock} of=${apdk}/IPQ8074/caldata.bin bs=1 count=$FILESIZE skip=4096
                    ln -s ${apdk}/IPQ8074/caldata.bin /lib/firmware/IPQ8074/caldata.bin

                    mkdir -p ${apdk}/qcn9000
                    dd if=${mtdblock} of=${apdk}/qcn9000/caldata_1.bin bs=1 count=$FILESIZE skip=157696
                    dd if=${mtdblock} of=${apdk}/qcn9000/caldata_2.bin bs=1 count=$FILESIZE skip=311296
                    ln -s ${apdk}/qcn9000/caldata_1.bin /lib/firmware/qcn9000/caldata_1.bin
                    ln -s ${apdk}/qcn9000/caldata_2.bin /lib/firmware/qcn9000/caldata_2.bin
	    ;;
            ap-hk* | ap-ac* | ap-oa*)
                    HK_BD_FILENAME=/lib/firmware/IPQ8074/bdwlan.bin
                    mkdir -p ${apdk}/IPQ8074
                    dd if=${mtdblock} of=${apdk}/wifi1.caldata bs=1 count=12064 skip=208896
                    if [ -f "$HK_BD_FILENAME" ]; then
                        FILESIZE=$(stat -Lc%s "$HK_BD_FILENAME")
                    else
                        FILESIZE=131072
                    fi
                    dd if=${mtdblock} of=${apdk}/IPQ8074/caldata.bin bs=1 count=$FILESIZE skip=4096
                    [ -L /lib/firmware/IPQ8074/caldata.bin ] || \
                    ln -s ${apdk}/IPQ8074/caldata.bin /lib/firmware/IPQ8074/caldata.bin
            ;;
            ap-cp01-c3*)
                    CP_BD_FILENAME=/lib/firmware/IPQ6018/bdwlan.bin
                    mkdir -p ${apdk}/IPQ6018
                    if [ -f "$CP_BD_FILENAME" ]; then
                        FILESIZE=$(stat -Lc%s "$CP_BD_FILENAME")
                    else
                        FILESIZE=65536
                    fi
                    dd if=${mtdblock} of=${apdk}/IPQ6018/caldata.bin bs=1 count=$FILESIZE skip=4096
                    [ -L /lib/firmware/IPQ6018/caldata.bin ] || \
                    ln -s ${apdk}/IPQ6018/caldata.bin /lib/firmware/IPQ6018/caldata.bin

                    mkdir -p ${apdk}/qcn9000
                    FILESIZE=131072
                    dd if=${mtdblock} of=${apdk}/qcn9000/caldata_1.bin bs=1 count=$FILESIZE skip=157696
                    ln -s ${apdk}/qcn9000/caldata_1.bin /lib/firmware/qcn9000/caldata_1.bin
            ;;
            ap-mp02.1* | db-mp02.1*)
                    mkdir -p ${apdk}/IPQ5018
                    FILESIZE=131072

                    dd if=${mtdblock} of=${apdk}/IPQ5018/caldata.bin bs=1 count=$FILESIZE skip=4096
                    ln -s ${apdk}/IPQ5018/caldata.bin /lib/firmware/IPQ5018/caldata.bin

                    mkdir -p ${apdk}/IPQ5018/qcn6122
                    # Read after 154KB
                    dd if=${mtdblock}  of=${apdk}/IPQ5018/qcn6122/caldata_1.bin bs=1 count=$FILESIZE skip=157696
                    ln -s ${apdk}/IPQ5018/qcn6122/caldata_1.bin /lib/firmware/qcn6122/caldata_1.bin
            ;;
            ap-mp03.1* | db-mp03.1*)
                    MP_BD_FILENAME=/lib/firmware/IPQ5018/bdwlan.bin
                    mkdir -p ${apdk}/IPQ5018
                    if [ -f "$MP_BD_FILENAME" ]; then
                        FILESIZE=$(stat -Lc%s "$MP_BD_FILENAME")
                    else
                        FILESIZE=131072
                    fi
                    dd if=${mtdblock} of=${apdk}/IPQ5018/caldata.bin bs=1 count=$FILESIZE skip=4096
                    ln -s ${apdk}/IPQ5018/caldata.bin /lib/firmware/IPQ5018/caldata.bin

                    mkdir -p ${apdk}/IPQ5018/qcn9000
                    dd if=${mtdblock} of=${apdk}/IPQ5018/qcn9000/caldata_1.bin bs=1 count=$FILESIZE skip=157696
                    ln -s ${apdk}/IPQ5018/qcn9000/caldata_1.bin /lib/firmware/qcn9000/caldata_1.bin

					#QCA9889 caldata, start from 0x4d000
                    dd if=${mtdblock} of=${apdk}/wifi2.caldata bs=1 count=2116 skip=$((0x4d000))
            ;;
            ap-mp03.3* | db-mp03.3*)
                    MP_BD_FILENAME=/lib/firmware/IPQ5018/bdwlan.bin
                    mkdir -p ${apdk}/IPQ5018
                    if [ -f "$MP_BD_FILENAME" ]; then
                        FILESIZE=$(stat -Lc%s "$MP_BD_FILENAME")
                    else
                        FILESIZE=131072
                    fi
                    dd if=${mtdblock} of=${apdk}/IPQ5018/caldata.bin bs=1 count=$FILESIZE skip=4096
                    ln -s ${apdk}/IPQ5018/caldata.bin /lib/firmware/IPQ5018/caldata.bin

                    mkdir -p ${apdk}/qcn9100
                    dd if=${mtdblock} of=${apdk}/qcn9100/caldata_1.bin bs=1 count=$FILESIZE skip=157696
                    ln -s ${apdk}/qcn9100/caldata_1.bin /lib/firmware/qcn9100/caldata_1.bin

                    mkdir -p ${apdk}/qcn9000
                    dd if=${mtdblock} of=${apdk}/qcn9000/caldata_1.bin bs=1 count=$FILESIZE skip=311296
                    ln -s ${apdk}/qcn9000/caldata_1.bin /lib/firmware/qcn9000/caldata_1.bin
            ;;
            ap-mp*)
                    MP_BD_FILENAME=/lib/firmware/IPQ5018/bdwlan.bin
                    mkdir -p ${apdk}/IPQ5018
                    if [ -f "$MP_BD_FILENAME" ]; then
                        FILESIZE=$(stat -Lc%s "$MP_BD_FILENAME")
                    else
                        FILESIZE=131072
                    fi
                    dd if=${mtdblock} of=${apdk}/IPQ5018/caldata.bin bs=1 count=$FILESIZE skip=4096
                    [ -L /lib/firmware/IPQ5018/caldata.bin ] || \
                    ln -s ${apdk}/IPQ5018/caldata.bin /lib/firmware/IPQ5018/caldata.bin
            ;;
            ap-cp*)
                    CP_BD_FILENAME=/lib/firmware/IPQ6018/bdwlan.bin
                    mkdir -p ${apdk}/IPQ6018
                    if [ -f "$CP_BD_FILENAME" ]; then
                        FILESIZE=$(stat -Lc%s "$CP_BD_FILENAME")
                    else
                        FILESIZE=65536
                    fi
                    dd if=${mtdblock} of=${apdk}/IPQ6018/caldata.bin bs=1 count=$FILESIZE skip=4096
                    [ -L /lib/firmware/IPQ6018/caldata.bin ] || \
                    ln -s ${apdk}/IPQ6018/caldata.bin /lib/firmware/IPQ6018/caldata.bin
            ;;
   esac
}

