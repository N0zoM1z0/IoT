#!/bin/sh
#log_filename="/tmp/voip/cdr_newest.txt"

echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: text/html"
echo ""
#if [ "${log_filename}" == "" ]; then
#	exit 1
#fi

#cat ${log_filename}
voipcmd cdr qry 0
