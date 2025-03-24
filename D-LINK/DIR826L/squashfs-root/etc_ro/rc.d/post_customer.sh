#!/bin/sh

echo "##################### Post customer settings #####################"

#echo -n 10240 > /proc/sys/vm/min_free_kbytes
#echo -n 500 > /proc/sys/vm/dirty_expire_centisecs
#echo -n 100 > /proc/sys/vm/dirty_writeback_centisecs

#sleep 5

echo "Initialize silex modules start"

#cp /etc/samba/smb-silex.conf /etc/config/smb.conf
cp /etc/samba/smb.conf /etc/config/smb.conf
#sleep 1

/etc/rc.d/rc.hotplug start
sleep 5

/etc/rc.d/rc.sxuptp start
/etc/rc.d/rc.storage start
