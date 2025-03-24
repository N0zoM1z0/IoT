#!/bin/sh

index=`uci show samba|grep "/tmp"|cut -d '[' -f2|cut -d ']' -f1`
uci delete samba.@sambashare[$index]
