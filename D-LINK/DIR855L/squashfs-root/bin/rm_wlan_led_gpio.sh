#!/bin/sh

rmmod wlan_led_gpio

echo "18" > /sys/class/gpio/export

echo "1" > /sys/class/gpio/gpio18/value
