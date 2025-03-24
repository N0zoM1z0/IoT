#!/bin/sh

local pidVsftpd=`pidof vsftpd`
if [ "$pidVsftpd" != "" ]; then
	killall -q vsftpd
fi

local local_root=$1
local port_lists="$2"
if [ "$port_lists" == "" ]; then
	port_lists="21"
else
	port_lists=`echo $port_lists | tr "," " " `
fi
CFG_FILE="/tmp/vsftpd.conf"
SEC_CHROOT_DIR=/var/run/vsftpd
mkdir -p $SEC_CHROOT_DIR
chmod 555 $SEC_CHROOT_DIR

## not allow user "admin" accessed to ftpd.
# if no u-disc pluged,just enable admin to login
if [ "$local_root" == "/mnt" ]; then
	echo "admin" > /var/.vsftpd.users
	userlist_deny=NO
else
	echo "" > /var/.vsftpd.users
	userlist_deny=YES
fi

for ftp_port in $port_lists
do
	echo "
pasv_min_port=30000
pasv_max_port=30099
background=YES
listen=NO
listen_ipv6=YES
anonymous_enable=NO
local_enable=YES
local_root=$local_root
write_enable=YES
local_umask=022
check_shell=NO
listen_port=$ftp_port
#dirmessage_enable=YES
#ftpd_banner=Welcome to blah FTP service.
session_support=NO
#syslog_enable=YES
userlist_enable=YES
userlist_deny=$userlist_deny
userlist_file=/var/.vsftpd.users
#xferlog_enable=YES
#xferlog_file=/var/log/vsftpd.log
#xferlog_std_format=YES
secure_chroot_dir=$SEC_CHROOT_DIR
" > $CFG_FILE.$ftp_port

## enable vsftpd server
	vsftpd $CFG_FILE.$ftp_port
done
