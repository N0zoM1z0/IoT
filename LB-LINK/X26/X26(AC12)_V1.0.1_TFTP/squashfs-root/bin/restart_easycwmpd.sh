#!/bin/sh

sleep 3

killall easycwmpd

sleep 1

/usr/sbin/easycwmpd -f --boot &
