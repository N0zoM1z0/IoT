#!/bin/sh

FW_FILE="/tmp/firmware.img"  
CHECKSUM="/tmp/MD5"
BHWVER="/tmp/BHWVER"

rm /tmp/verify_OK -rf

[ -e $FW_FILE ] || {
  echo 'firmware file not exist.'
  exit 1
}

FILE_SIZE=`wc -c $FW_FILE | awk '{ print $1 }'`
MD5_OFFSET=`expr $FILE_SIZE - 64`
VER_OFFSET=`expr $FILE_SIZE - 32` 

dd if=$FW_FILE of=$CHECKSUM skip=$MD5_OFFSET count=32 bs=1
dd if=$FW_FILE of=$BHWVER skip=$VER_OFFSET count=32 bs=1
dd if=/dev/zero of=$FW_FILE bs=1 count=0 seek=$MD5_OFFSET conv=sync

# verify md5.
cal_md5=`md5sum $FW_FILE | awk '{printf $1}'`
echo -e "$cal_md5\c"  > /tmp/cal_md5

cmp $CHECKSUM  /tmp/cal_md5
if [ "$?" = "0" ] 
then
  echo 'md5 is correct.' > /dev/console  
else
  echo 'md5 is not correct.' > /dev/console
  rm $FW_FILE -rf
  exit 1    
fi

# verify Blink hwver.
nvr_Bhwver=`nvram get blink Bhwver | awk '{printf $1}'`
if [ ! $nvr_Bhwver ]
then
  echo 'nvr_Bhwver is nil.' > /dev/console  
else
  echo -e "$nvr_Bhwver\c" > /tmp/nvr_Bhwver
  nvr_Bhwver_len=`wc -c /tmp/nvr_Bhwver | awk '{ print $1 }'`
  dd if=/tmp/BHWVER of=/tmp/BHWVER_t count=1 bs=$nvr_Bhwver_len
     
  cmp /tmp/BHWVER_t  /tmp/nvr_Bhwver
  if [ "$?" = "0" ] 
  then
    echo 'Bhwver is same.'  > /dev/console
  else
    echo 'Bhwver is not same.'  > /dev/console                        
    rm $FW_FILE -rf
    exit 1 
  fi
fi 

rm $CHECKSUM  $BHWVER  /tmp/cal_md5  /tmp/nvr_Bhwver  /tmp/BHWVER_t  -rf
touch /tmp/verify_OK

exit 0