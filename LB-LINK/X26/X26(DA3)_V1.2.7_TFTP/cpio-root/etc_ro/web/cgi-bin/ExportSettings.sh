#!/bin/sh


#output HTTP header
echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: application/octet-stream"
echo "Content-Transfer-Encoding: binary"			#  "\n" make Un*x happy
echo "Content-Disposition: attachment; filename=\"RT2880_Settings.dat\""
echo ""

echo "#The following line must not be removed."
echo "Default"
ralink_init show 2860 2>/dev/null
echo "#The following line must not be removed."
echo "["
echo "#The following line must not be removed."
echo "Default"
ralink_init show RTDEV 2>/dev/null
