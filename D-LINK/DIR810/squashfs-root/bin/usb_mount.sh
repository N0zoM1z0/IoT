#!/bin/sh

echo "****** insmod usb-sorage module ******"
# fix issue of DUT can't mount automatically when booting
# because the original code will be too late to mount
usbmount2 &
sleep 1
insmod /lib/modules/$(uname -r)/kernel/drivers/usb/storage/usb-storage.ko
echo "****** insmod usb-sorage module finish ******"

#original code
#usbmount2 &
#sleep 1
echo /usr/hotplug > /proc/sys/kernel/hotplug 
