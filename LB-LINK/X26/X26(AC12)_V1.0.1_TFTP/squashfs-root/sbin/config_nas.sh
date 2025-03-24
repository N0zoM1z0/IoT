#!/bin/sh

sleep 5

/etc/init.d/vsftpd stop
/etc/init.d/samba stop

count=1
found=0
get_user=""
get_passwd=""
get_share_dir=""
del_samba_config=0
uci_config_section=""

file_list=`ls /mnt/`

for nas_dir in $file_list
do
	get_user=""
	get_passwd=""
	get_share_dir=""
	
	if [ -f /mnt/$nas_dir/.ftp_user_pass ];then
		while read line
		do
			if [ $count -eq 1 ];then	
				get_user="$line"
			fi

			if [ $count -eq 2 ];then
				get_passwd="$line"
			fi
			
			let count++

			if [ $count -gt 2 ];then
				break
			fi
		done < /mnt/$nas_dir/.ftp_user_pass		
	fi

	if [ -f /mnt/$nas_dir/.ftp_share_dir ];then
		while read line
		do
			get_share_dir="$line"		
			break
		done < /mnt/$nas_dir/.ftp_share_dir	
	fi	
	
	if [ -n "$get_user" -a -n "$get_passwd" -a "$get_share_dir" ];then
		echo "$get_user" > /etc/vsftpd/vsftpd.users
		userdel $get_user 2>/dev/null
		useradd -d $get_share_dir -s /bin/false $get_user
		echo "$get_user:$get_passwd" | chpasswd
		touch /etc/vsftpd/chroot_list
		
		ftp_enable=`uci get system.route.vsftpd`
		
		if [ "$ftp_enable" == "1" ];then
			/etc/init.d/vsftpd start
		fi
		break
	fi
done

count=1

for nas_dir in $file_list
do
	get_user=""
	get_passwd=""
	get_share_dir=""
	
	if [ -f /mnt/$nas_dir/.samba_user_pass ];then
		while read line
		do
			if [ $count -eq 1 ];then	
				get_user="$line"
			fi

			if [ $count -eq 2 ];then
				get_passwd="$line"
			fi
			
			let count++

			if [ $count -gt 2 ];then
				break
			fi
		done < /mnt/$nas_dir/.samba_user_pass		
	fi
	
	if [ -n "$get_user" -a -n "$get_passwd" ];then
		while read line
		do
			exist_name=`echo "$line" | awk -F ':' '{print $1}'`
			if [ "$get_user" == "$exist_name" ];then
				found=1
				break
			fi
		done < /etc/passwd
		
		if [ $found -eq 0 ];then
			useradd -s /bin/false $get_user
		fi
	fi

	if [ -f /mnt/$nas_dir/.samba_share_dir ];then		
		while read line
		do
			if [ $del_samba_config -eq 0 ];then
				del_samba_config=1
				for k in $( seq 1 8 )
				do
					uci delete samba.@sambashare[0] 2>/dev/null
				done
				uci commit samba
			fi
			
			uci_config_section=`uci add samba sambashare`
			
			uci set samba.$uci_config_section.name=`basename $line`
			uci set samba.$uci_config_section.path=$line
			uci set samba.$uci_config_section.users=$get_user
			uci set samba.$uci_config_section.read_only='no'
			uci set samba.$uci_config_section.guest_ok='no'
			uci set samba.$uci_config_section.create_mask='0777'
			uci set samba.$uci_config_section.dir_mask='0777'
			uci commit samba
		done < /mnt/$nas_dir/.samba_share_dir	
	fi	
	
	if [ -n "$get_user" -a -n "$get_passwd" -a  $del_samba_config -eq 1 ];then
		samba_enable=`uci get system.route.samba`
		if [ "$samba_enable" == "0" ];then
			uci set system.route.samba=1
			uci commit system
			/etc/init.d/samba start
			
			smbpasswd -x $get_user 2>/dev/null
			(echo $get_passwd;echo $get_passwd) | smbpasswd -a -s $get_user
			
			uci set system.route.samba=0
			uci commit system
			/etc/init.d/samba stop
		else
			/etc/init.d/samba start
			smbpasswd -x $get_user 2>/dev/null
			(echo $get_passwd;echo $get_passwd) | smbpasswd -a -s $get_user
		fi
		
		break
	fi
done




