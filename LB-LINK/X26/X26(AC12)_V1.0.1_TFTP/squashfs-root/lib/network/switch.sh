#!bin/sh

link_down()
{
	# get original register value
	get_mii=`mii_mgr -g -p $1 -r 0`
	orig=`echo $get_mii | sed 's/^.....................//'`
	# stupid hex value calculation.
	pre=`echo $orig | sed 's/...$//'`
	post=`echo $orig | sed 's/^..//'` 
	num_hex=`echo $orig | sed 's/^.//' | sed 's/..$//'`
	case $num_hex in
		"0")	rep="8"	;;
		"1")	rep="9"	;;
		"2")	rep="a"	;;
		"3")	rep="b"	;;
		"4")	rep="c"	;;
		"5")	rep="d"	;;
		"6")	rep="e"	;;
		"7")	rep="f"	;;
		# The power is already down
		*)		echo "Port$1 is down. Skip.";return;;
	esac
	new=$pre$rep$post
	# power down
	mii_mgr -s -p $1 -r 0 -v $new
}

link_up()
{
	# get original register value
	get_mii=`mii_mgr -g -p $1 -r 0`
	orig=`echo $get_mii | sed 's/^.....................//'`
	# stupid hex value calculation.
	pre=`echo $orig | sed 's/...$//'`
	post=`echo $orig | sed 's/^..//'` 
	num_hex=`echo $orig | sed 's/^.//' | sed 's/..$//'`
	case $num_hex in
		"8")	rep="2"	;;
		"9")	rep="3"	;;
		"a")	rep="2"	;;
		"b")	rep="3"	;;
		"c")	rep="6"	;;
		"d")	rep="7"	;;
		"e")	rep="6"	;;
		"f")	rep="7"	;;
		*)		echo "Port$1 is up. Skip.";return;;
	esac
	new=$pre$rep$post
	# power up
	mii_mgr -s -p $1 -r 0 -v $new
}

reset_port()
{
	down_port
	sleep 1
	up_port
}


down_port()
{
	link_down 0
	link_down 1
	link_down 2
	link_down 3	
}


up_port()
{
	link_up 0
	link_up 1
	link_up 2
	link_up 3
}


restoreEsw()
{
	switch reg w 14 5555
	switch reg w 40 1001
	switch reg w 44 1001
	switch reg w 48 1001
	switch reg w 4c 1
	switch reg w 50 2001
	switch reg w 70 ffffffff
	switch reg w 74 ffffffff
	switch reg w 98 7f7f
	switch reg w e4 7f
	
	#clear mac table if vlan configuration changed
	switch clear
}


configEsw()
{
	switch reg w 14 405555
	switch reg w 50 2001
	switch reg w 98 7f3f
if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
	switch reg w e4 40043f
else
	switch reg w e4 3f
fi

	if [ "$1" = "LLLLW" ]; then
if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		switch reg w 40 7007
		switch reg w 44 7007
		switch reg w 48 7008
		switch reg w 70 48444241
		switch reg w 74 50ef6050
else
		switch reg w 40 1001
		switch reg w 44 1001
		switch reg w 48 1002
		switch reg w 70 ffff506f
		switch reg w 74 ffffffff
fi
	elif [ "$1" = "WLLLL" ]; then
if [ "$CONFIG_RAETH_SPECIAL_TAG" == "y" ]; then
		switch reg w 40 7008
		switch reg w 44 7007
		switch reg w 48 7007
		switch reg w 70 48444241
		switch reg w 74 41fe6050
else
		switch reg w 40 1002
		switch reg w 44 1001
		switch reg w 48 1001
		switch reg w 70 ffff417e
		switch reg w 74 ffffffff
fi
	elif [ "$1" = "W1234" ]; then
		switch reg w 40 1005
		switch reg w 44 3002
		switch reg w 48 1004
		switch reg w 70 50484442
		switch reg w 74 ffffff41
	elif [ "$1" = "12345" ]; then
		switch reg w 40 2001
		switch reg w 44 4003
		switch reg w 48 1005
		switch reg w 70 48444241
		switch reg w 74 ffffff50
	elif [ "$1" = "GW" ]; then
		switch reg w 40 1001
		switch reg w 44 1001
		switch reg w 48 2001
		switch reg w 70 ffff605f
	elif [ "$1" = "G01234" ]; then
		switch reg w 40 2001
		switch reg w 44 4003
		switch reg w 48 6005
		switch reg w 70 48444241
		switch reg w 74 ffff6050
	fi

	#clear mac table if vlan configuration changed
	switch clear
}

setup_switch()
{
	configEsw LLLLW
}

reset_switch()
{
	restoreEsw
}
