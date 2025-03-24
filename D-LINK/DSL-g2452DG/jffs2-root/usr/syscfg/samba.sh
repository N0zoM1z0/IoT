#!/bin/sh

SAMBA_FILE=/var/smb.conf

if [ ! -n "$2" ]; then
	echo "insufficient arguments!"
	echo "Usage: $0 <netbios_name> <workgroup>"
	echo "Example: $0 	VSPM310 Triductor"
	exit 0
fi

NETBIOS_NAME="$1"
WORKGROUP="$2"
LOGPATH="$3"

echo "$LOGPATH"

echo "[global]
	netbios name = $NETBIOS_NAME
	display charset = UTF8
	interfaces = br0
	server string = Samba Server
	unix charset = UTF8
	dos charset = CP936
	workgroup = $WORKGROUP
	browseable = yes
	deadtime = 30
	domain master = yes
	enable core files = no
	guest account = nobody
	guest ok = yes
	invalid users = root
	local master = yes
	load printers = no
	map to guest = Bad User
	max protocol = SMB2
	min receivefile size = 16384
	null passwords = yes
	obey pam restrictions = yes
	os level = 20
	passdb backend = smbpasswd
	preferred master = yes
	printable = no
	security = user
	smb encrypt = disabled
	smb passwd file = /var/smbpasswd
	socket options = TCP_NODELAY IPTOS_LOWDELAY
	syslog = 2
	use sendfile = yes
	writeable = yes
" > $SAMBA_FILE

iptables -t raw -D PREROUTING -p tcp --dport 445  -j NOTRACK
iptables -t raw -A PREROUTING -p tcp --dport 445  -j NOTRACK
iptables -t raw -D OUTPUT -p tcp --sport 445  -j NOTRACK
iptables -t raw -A OUTPUT -p tcp --sport 445  -j NOTRACK

