#!/bin/sh

path=""

for para in $*
do
        export $para
done

if [ -z $path ]; then
	echo  "[$0] parameter cannot be empty!"
	exit 1
fi

local total=`free | grep Mem | awk '{print $2}'`
local free=`free | grep Mem | awk '{print $4}'`

cfgcmd sset $path.MemTotalFree $free
cfgcmd sset $path.MemTotal $total
