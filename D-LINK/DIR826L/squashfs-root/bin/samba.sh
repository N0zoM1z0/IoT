#!/bin/sh

#opmode=`nvram_get 2860 OperationMode`
SAMBA_FILE=/etc/smb.conf

if [ ! -n "$2" ]; then
	echo "insufficient arguments!"
	echo "Usage: $0 <netbios_name> <workgroup>"
	echo "Example: $0 RT2880 Ralink"
	exit 0
fi

NETBIOS_NAME="$1"
WORKGROUP="$2"

echo "[global]
use sendfile = yes
netbios name = $NETBIOS_NAME
server string = Samba Server
workgroup = $WORKGROUP
security = SHARE
guest account = root
log file = /var/log.samba
socket options = TCP_NODELAY SO_KEEPALIVE SO_RCVBUF=48000 SO_SNDBUF=40000 IPTOS_LOWDELAY
encrypt passwords = yes
use spne go = no
client use spnego = no
disable spoolss = yes
smb passwd file = /etc/samba/smbpasswd
host msdfs = no
getwd cache = yes
strict allocate = No
os level = 20
log level = 0
max log size = 100
null passwords = yes
mangling method = hash
dos charset = CP950
unix charset = UTF8
display charset = UTF8
unix password sync = yes
case sensitive = no
bind interfaces only = yes" > $SAMBA_FILE

echo "interfaces = lo, br0" >> $SAMBA_FILE

#if [ "$opmode" = 0 ]; then
#	echo "interfaces = lo br0" >> $SAMBA_FILE
#elif [ "$opmode" = 1 ]; then
#	echo "interfaces = lo br0 eth2.2" >> $SAMBA_FILE
#elif [ "$opmode" = 2 ]; then
#	echo "interfaces = lo eth2 ra0" >> $SAMBA_FILE
#elif [ "$opmode" = 3 ]; then
#	echo "interfaces = lo br0 apcli0" >> $SAMBA_FILE
#else
#	echo "interfaces = lo" >> $SAMBA_FILE
#fi

echo "" >> $SAMBA_FILE

#echo "[mnt]
#   comment = USB Storage disk share
#   path = /var/tmp/usb/
#   browseable = yes
#   writable = yes
#   create mask = 0777
#   directory mask = 0777
#   guest ok = yes" >> $SAMBA_FILE

#iptables -t raw -D PREROUTING -p tcp --dport 445  -j NOTRACK
#iptables -t raw -A PREROUTING -p tcp --dport 445  -j NOTRACK
#iptables -t raw -D OUTPUT -p tcp --sport 445  -j NOTRACK
#iptables -t raw -A OUTPUT -p tcp --sport 445  -j NOTRACK

