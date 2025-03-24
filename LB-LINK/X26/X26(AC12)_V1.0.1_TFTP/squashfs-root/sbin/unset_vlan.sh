#!/bin/sh

brctl delif br-lan eth0.3
brctl delif br-lan eth0.4
brctl delif br-lan eth0.5

ifconfig eth0.3 down
ifconfig eth0.4 down
ifconfig eth0.5 down

vconfig rem eth0.3
vconfig rem eth0.4
vconfig rem eth0.5

switch reg w 14 405555
switch reg w 50 2001
switch reg w 98 7f3f
switch reg w e4 3f

switch reg w 40 1001
switch reg w 44 1001
switch reg w 48 1002
switch reg w 70 ffff506f
switch reg w 74 ffffffff

switch clear