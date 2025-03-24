#!/bin/sh

cpu_idle=`top -n 1 | grep ^CPU | awk '{print $8}'`
cpu=`expr 100 - ${cpu_idle//%/}`
cpu="${cpu}%"

mem_tmp=`free | grep ^Mem:`
mem_total=`echo $mem_tmp | awk '{print $2}'`
mem_used=`echo $mem_tmp | awk '{print $3}'`
mem_utilize=`awk 'BEGIN {printf "%0.2f%%",100 * '${mem_used}'/'${mem_total}'}'`

echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: text/html"
echo ""
echo "cpu=\"${cpu}\";mem=\"${mem_utilize}\";"
