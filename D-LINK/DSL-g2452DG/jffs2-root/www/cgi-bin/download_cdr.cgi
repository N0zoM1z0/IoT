#!/bin/sh
#log_filename="/tmp/voip/cdr.txt"

echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: application/octet-stream"
echo "Content-Transfer-Encoding: binary"
echo "Content-Disposition: attachment; filename=\"/tmp/test.db\""
echo ""

#cat ${log_filename}
voipcmd cdr qry
