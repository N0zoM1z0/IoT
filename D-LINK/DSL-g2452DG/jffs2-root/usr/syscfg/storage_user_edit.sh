#!/bin/sh
USERLISTFD=/tmp/.storageusr.list
FILE_Group="/etc/group"
FILE_Passwd="/etc/passwd"
user=$2
passwd=$3

gen_user_ID()
{
    local userID=501
    while [ "$userID" -le "520" ]
    do
        local exist=`grep -c "$userID" $FILE_Passwd`
        if [ "$exist" == "0" ]; then
            break
        fi
        userID=`expr $userID + 1`
    done
    echo -n $userID
}

add_storage_user()
{
	local uid=`gen_user_ID`
	if [ -n "$user" ]; then
	    if [ "$user" != "admin" ];then
		    echo "$user::$uid:$uid:$user:/mnt:/bin/sh" >> $FILE_Passwd
		    echo "$user:x:$uid:$user" >> $FILE_Group
		    echo "$user:$uid" >> $USERLISTFD
	    fi
	    chpasswd.sh "$user" "$passwd"
	fi
}

del_storage_user()
{
        if [ $user != admin ];then
	    local username=`sed -n /^${user}:/p $USERLISTFD | awk -F : '{print $1}'`
	    sed -i /^${username}/d $USERLISTFD
	    deluser ${user}
	fi
}

case "$1" in
	"add")
	       del_storage_user
		add_storage_user
		;;
	*)
	       echo "add user error!"
		;;
esac
