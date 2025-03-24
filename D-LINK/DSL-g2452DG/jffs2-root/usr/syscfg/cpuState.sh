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

local idle=`top -b -n 1 | grep idle | grep CPU | awk '{print $8}' | sed 's/%//g'`
local use=$((100-idle))

cfgcmd sset $path.CPULoad $use
