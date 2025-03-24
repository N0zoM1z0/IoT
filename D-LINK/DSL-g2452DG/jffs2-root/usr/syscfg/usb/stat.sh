#!/bin/sh

local dev=`cfgcmd get ${1}SDName`
local tmp_dev="/^\/dev\/${dev}/"

local used_kb=""
local used_percent=""
 
used_kb=`df -k | awk ''${tmp_dev}'{print $3}'`
cfgcmd sset "${1}UsedKB" ${used_kb}          
 
used_percent=`df -h | awk ''${tmp_dev}'{print $5}' | cut -d '%' -f 1`
cfgcmd sset "${1}UsedPercent" ${used_percent}
