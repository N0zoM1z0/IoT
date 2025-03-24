#!/bin/sh

egr=""
dlen=""
num=""
pvc=""
chid=""

for para in $*
do
	export $para
done

useage()
{
	echo "./usr/syscfg/specialsend.sh egr=12 dlen=1500 num=10"
	echo "egr 0:dsl 8:eth0.2 9:eth0.3 10:eth0.4 11:eth0.5 12:nas1"
	echo "dlen: 64-1500"
	echo "num: 0:all along send ; 1-0xffff: send pkt numbers"
}

do_action()
{
	if [ -z "$egr" -o -z "$dlen" -o -z "${num}" ]; then
		useage
		return;
	fi

	let "a=1<<$egr"

	out=`printf %x $a`

	if [ "${num}" -eq "0" ]; then
		while [ 1 ]
		do
			cs_cli /home/cli/debug/test/eth/specialsend -v egr 0x${out} data_len $dlen
		done
	else
		cs_cli /home/cli/debug/test/eth/specialsend -v egr 0x${out} data_len $dlen num $num
	fi
}

do_action
