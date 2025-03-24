###################################################################
# this script include ipv6 useful functions.
###################################################################

GenEui64()
{

	local prefixstr=$1
	local ifname=$2

	local prefix=`echo $prefixstr | awk -F '::/' '{ printf $1 }'`
	local prefixlen=`echo $prefixstr | awk -F '::/' '{ printf $2 }'`

	local mac=`ifconfig $ifname | grep HWaddr | awk '{ print $5 }'`
	
	local first0=`echo $mac | cut -d ':' -f 1`
	let first0=0x$first0
	let "first0=$first0^2"
	first0=`printf %x $first0`
	local first1=`echo $mac | cut -d ':' -f 2`
	local secd0=`echo $mac | cut -d ':' -f 3`
	local secd1="FF"
	local third0="FE"
	local third1=`echo $mac | cut -d ':' -f 4`
	local four0=`echo $mac | cut -d ':' -f 5`
	local four1=`echo $mac | cut -d ':' -f 6`

	local n=`echo $prefix | awk -F ':' '{ printf $4 }'`
	if [ -z $n ]; then
		echo -n "$prefix::$first0$first1:$secd0$secd1:$third0$third1:$four0$four1/$prefixlen"
	else
		echo -n "$prefix:$first0$first1:$secd0$secd1:$third0$third1:$four0$four1/$prefixlen"
	fi

}

PPP64()
{
	local prefixstr=$1
	local ifname=$2

	local prefix=`echo $prefixstr | awk -F '::/' '{ printf $1 }'`
	local prefixlen=`echo $prefixstr | awk -F '::/' '{ printf $2 }'`

	local var=`ifconfig $ifname | grep "Scope:Link" | awk -F '::' '{ printf $2 }'`
	local link=`echo $var | awk -F '/' '{ printf $1 }'`
	
	local n=`echo $prefix | awk -F ':' '{ printf $4 }'`
	local nl=`echo $link | awk -F ':' '{ printf $4 }'`

	if [ -z "$n" -o -z "$nl" ]; then
		echo -n "$prefix::$link/$prefixlen"
	else
		echo -n "$prefix:$link/$prefixlen"
	fi


	
}
