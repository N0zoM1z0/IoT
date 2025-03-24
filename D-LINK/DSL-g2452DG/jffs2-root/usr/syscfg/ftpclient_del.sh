#!/bin/sh

local path="${1:41}"
if [ -e "/tmp/${path}delSh" ]; then
    sh "/tmp/${path}delSh"
    rm -f "/tmp/${path}delSh"
fi
exit 0
