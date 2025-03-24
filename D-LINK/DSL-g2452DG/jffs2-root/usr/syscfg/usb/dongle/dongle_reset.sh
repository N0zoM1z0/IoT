#!/bin/sh

reset()
{
    cam=$(lsusb | awk "/$1/{print $6}")
    if [ ! -z "$cam" -a "$cam" != " " ]; then
        for X in /sys/bus/usb/devices/*
        do
            a=$(cat "$X/idVendor" 2>/dev/null)
            b=$(cat "$X/idProduct" 2>/dev/null)
            c="$a:$b"
            if [ ! -z "$c" -a "$c" != " " ] && [ "$c" == "$1" ]; then
                d=$(echo $X | sed "s/\/sys\/bus\/usb\/devices\///g")
                echo "[FOUND] $d"
                echo 0 > /sys/bus/usb/devices/$d/authorized
                sleep 2
                echo 1 > /sys/bus/usb/devices/$d/authorized
                break
            fi
        done
    fi    
}

devices=`lsusb | awk {'print $6'}`
for devicesItem in ${devices}
do
    usb_switch_id=$(echo $devicesItem | sed "s/:/_/g")
    if [ -f "/etc/usb_modeswitch/$usb_switch_id" ]; then
        reset $devicesItem
    fi
done