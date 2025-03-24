#!/bin/sh

#kasda KM121 module
echo "161c 9115" > /sys/bus/usb-serial/drivers/option1/new_id
echo "2001 7d0e" >> /sys/bus/usb-serial/drivers/option1/new_id
echo "2001 7e3d" >> /sys/bus/usb-serial/drivers/option1/new_id
echo "2001 7600" >> /sys/bus/usb-serial/drivers/option1/new_id

# DWM-222 its HW ver  A1      F/W  2.0.2EU
echo "2001 7e35" >> /sys/bus/usb-serial/drivers/option1/new_id
