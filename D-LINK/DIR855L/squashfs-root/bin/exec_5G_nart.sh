#!/bin/sh
cd /tmp;
chmod +x nart.out
mkdir nart5G
mv *.so nart5G
mv nart.out nart5G
export LD_LIBRARY_PATH=/tmp/nart5G:$LD_LIBRARY_PATH
insmod /lib/modules/art_ap.ko
sleep 1
cd;
/tmp/nart5G/nart.out -instance 1 -port 2391 &
echo "1" > /tmp/calibration_ready5G.txt
