#!/bin/sh
#FileName: ftpset.sh
#Function: 浠巉tp鏈嶅姟鍣ㄤ笂涓嬭浇鏂囦欢鍒版湰鍦板鎴风
#Version: V0.1
#Author: 
#Date:

#DOWNLOAD_URL="URL"
#USERNAME="Username"
#PASSWORD="Password"
#PORT="Port"
#USBPARTITION="UsbPartion"
#SAVEPATH="SavePath"

valid_ip()
{
	echo $1|grep "^[0-9]\{1,3\}\.\([0-9]\{1,3\}\.\)\{2\}[0-9]\{1,3\}$" > /dev/null;
	#IP地址必须为全数字
	if [ $? -ne 0 ]
	then
	echo 1
	return
	fi
	ipaddr=$1
	a=`echo $ipaddr|awk -F . '{print $1}'` #以"."分隔，取出每个列的值
	b=`echo $ipaddr|awk -F . '{print $2}'`
	c=`echo $ipaddr|awk -F . '{print $3}'`
	d=`echo $ipaddr|awk -F . '{print $4}'`
	for num in $a $b $c $d
	do
	if [ $num -gt 255 ] || [ $num -lt 0 ]   #每个数值必须在0-255之间
	then
	echo 1
	return
	fi
	done
	echo 0
}

# ex: ftp=ftp://192.168.1.10/peizhi
local ftp_downurl=`cfgcmd get "$1URL"`
while test -z ${ftp_downurl}
do
	ftp_downurl=`cfgcmd get "$1URL"`
done

#ftp account, maybe "anonymous"
local ftp_username=`cfgcmd get "$1Username"`
while test -z ${ftp_username}
do
	ftp_username=`cfgcmd get "$1Username"`
done

#ftp password
local i=1
local ftp_password=`cfgcmd get "$1Password"`
while [ "$ftp_password" == "" -a "$i" -lt "3" ]
do 
	ftp_password=`cfgcmd get "$1Password"`
	i=`expr $i + 1`
done

#ftp port, default:21
local ftp_port=`cfgcmd get "$1Port"`
while test -z ${ftp_port}
do
	ftp_port=`cfgcmd get "$1Port"`
done

#External storage partition, ex: /mnt/usb1_1
local ftp_usbpartition=`cfgcmd get "$1UsbPartion"`
while test -z ${ftp_usbpartition}
do
	ftp_usbpartition=`cfgcmd get "$1UsbPartion"`
done	

#Document of the download file default: xdown
local ftp_savepath=`cfgcmd get "$1SavePath"`
while test -z ${ftp_savepath}
do
	ftp_savepath=`cfgcmd get "$1SavePath"`
done

#File name of download,ex: peizhi
LOCAL_FILE_NAME=`basename "${ftp_downurl}"`

# ex: FULL_NAME=ftp://192.168.1.10/peizhi 
FULL_NAME=${ftp_downurl}

# ex: SERVER_ADDR1=192.168.1.10/peizhi/
SERVER_ADDR1=${FULL_NAME#ftp*//}/

# ex: SERVER_ADDR=192.168.1.10
ftp_ipaddr=${SERVER_ADDR1%%/*/}

RET=`valid_ip $ftp_ipaddr`
if [ $RET -eq 0 ]; then 
    SERVER_ADDR=$ftp_ipaddr
else
    SERVER_ADDR=`ping resolv_only $ftp_ipaddr 2>/dev/null`
fi

RET=`valid_ip $SERVER_ADDR`
if [ $RET -ne 0 ]; then
    cfgcmd set $1DownloadState "10"
    return
fi

# ex: FILE_PATH=peizhi
FILE_PATH=${FULL_NAME#ftp://*/}

#DESTDIR鑾峰彇鏂囦欢瀛樺偍璺緞
#DESTDIR=${ftp_usbpartition}/${ftp_savepath}

#test -n ${ftp_usbpartition} -a -n ${ftp_savepath} && mkdir -p ${ftp_usbpartition}/${ftp_savepath} || echo "+++++++" >> /erro_info
# ex: mkdir -p /mnt/usb1_1/xdown
mkdir -p "${ftp_usbpartition}/${ftp_savepath}" || exit 1

# ex: ABC=192.168.1.10:21
ABC=${SERVER_ADDR}:${ftp_port}

# ex: XYZ=anonymous  or  XYZ=xxx:yyy
test ftp_username = "anonymous" && XYZ=${ftp_username} || XYZ=${ftp_username}:${ftp_password}

if [ -f "${ftp_usbpartition}/${ftp_savepath}/${LOCAL_FILE_NAME}.ftplog" ];then
   rm -rf ${ftp_usbpartition}/${ftp_savepath}/${LOCAL_FILE_NAME}.ftplog
fi

if [ -f "${ftp_usbpartition}/${ftp_savepath}/${LOCAL_FILE_NAME}" ];then
   mv -f "${ftp_usbpartition}/${ftp_savepath}/${LOCAL_FILE_NAME}" "${ftp_usbpartition}/${ftp_savepath}/${LOCAL_FILE_NAME}.old"
fi

# ex: wget -c ftp://xxx:yyy@192.168.1.10:21/peizhi -P /mnt/usb1_1/xdown -o /mnt/usb1_1/xdown/peizhi.outputmsg -b
# add -t (retry times) -T (timeout) params, limits the retry times and total time to 30s, avoid trying connecting, trying connecting, and trying connecting...no end.
wget -c -t 3 -T 10 "ftp://${XYZ}@${ABC}/${FILE_PATH}" -P "${ftp_usbpartition}/${ftp_savepath}" -o "${ftp_usbpartition}/${ftp_savepath}/${LOCAL_FILE_NAME}.ftplog" -b

#download started. now set DownloadState to 1
cfgcmd set $1DownloadState "1"

### create file for deleting task
local delSh="/tmp/${1:41}delSh"
echo "if [ \"${LOCAL_FILE_NAME}\" != \"\" ]; then" > $delSh
echo '	kill -SIGKILL $(ps | '"grep \"${ftp_usbpartition}/${ftp_savepath}/${LOCAL_FILE_NAME}\""" | grep -v \"gerp\" | awk '{print \$1}')" >> $delSh
echo "	rm -f \"${ftp_usbpartition}/${ftp_savepath}/${LOCAL_FILE_NAME}\"*" >> $delSh
echo "fi" >> $delSh
### end

exit 0
