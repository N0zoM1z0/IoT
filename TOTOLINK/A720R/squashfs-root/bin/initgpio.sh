#!/bin/sh
#
# script file to init gpio
#
# Usage: initgpio.sh
#

#C818SR
#echo "0x1e 0" > /proc/phyPower
echo "0x1e 1" > /proc/phyPower
# 初始化：导出对应GPIO,设置GPIO方向为输入，设置触发电平
echo 19 > /sys/class/gpio/export
echo in > /sys/class/gpio/gpio19/direction
echo 1 > /sys/class/gpio/gpio19/active_low

# 初始化1：导出对应GPIO,设置GPIO方向为输出
echo 15 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio15/direction

# 初始化2：设置触发电平
echo 1 > /sys/class/gpio/gpio15/active_low

# 初始化3：点亮所有灯位
echo 1 > /sys/class/gpio/gpio15/value

sleep 3

# 初始化3：关闭所有灯位
#echo 0 > /sys/class/gpio/gpio15/value
