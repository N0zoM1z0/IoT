#!/bin/sh
ack()
{
	local code=$1
	echo "Pragma: no-cache"
	echo "Cache-control: no-cache"
	echo "Content-type: text/html"
	echo ""
	echo -n $code
}

ret=`cat /tmp/upload.flag.cfg`
ack $ret
