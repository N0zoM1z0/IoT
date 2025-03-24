#!/bin/sh

switch reg w 14 405555
switch reg w 50 2001
switch reg w 98 7f3f
switch reg w e4 3f
switch reg w 40 2001
switch reg w 44 4003
switch reg w 48 1005
switch reg w 70 48444241
switch reg w 74 ffffff50

switch clear

vconfig add eth0 3
vconfig add eth0 4
vconfig add eth0 5

ifconfig eth0.3 up
ifconfig eth0.4 up
ifconfig eth0.5 up

brctl addif br-lan eth0.3
brctl addif br-lan eth0.4
brctl addif br-lan eth0.5

