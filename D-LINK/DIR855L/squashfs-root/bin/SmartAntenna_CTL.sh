#!/bin/sh

# Only for 24G to unlock 24G antenna GPIO
exp_gpio()
{
        echo $1 > /sys/class/gpio/export
        echo "out" > /sys/class/gpio/gpio$1/direction
}

# Only for 2G
exp_2g_mm()
{
	mm 0xb8116cc0 0x633c8177
	mm 0xb804006c 0x00000082
	mm 0xb8040000 0x312310
}

# Only for 5G
exp_5g_mm()
{
	mm 0xb0004050 0x3f008000  # Change GPIO from IN to OUT
	mm 0xb0004070 0x0 #OUT-MUX => 0 (must if want to control antenna)
}


if [ "$2" != "MM" ]; then 

	if [ "$1" = "2V" ]; then
		iwpriv wifi0 setSmartAntenna 0
		iwpriv wifi0 setSmartAntenna 1 
		iwpriv wifi0 default_ant 0
		iwpriv wifi0 current_ant 0
		echo "2.4G Smart Antenna Type = V1, V2, V3" > /tmp/SA_24G.txt
		exit
	fi

	if [ "$1" = "2H" ]; then
		iwpriv wifi0 setSmartAntenna 0
		iwpriv wifi0 setSmartAntenna 1 
		iwpriv wifi0 default_ant 7
		iwpriv wifi0 current_ant 7	
		echo "2.4G Smart Antenna Type = H1, H2, H3" > /tmp/SA_24G.txt
		exit
	fi

	if [ "$1" = "5V" ]; then
		iwpriv wifi1 setSmartAntenna 0
		iwpriv wifi1 setSmartAntenna 1
		iwpriv wifi1 default_ant 0
		iwpriv wifi1 current_ant 0
		echo "5G Smart Antenna Type = V1, V2, V3" > /tmp/SA_5G.txt
		exit
	fi

	if [ "$1" = "5H" ]; then
		iwpriv wifi1 setSmartAntenna 0
		iwpriv wifi1 setSmartAntenna 1
		iwpriv wifi1 default_ant 7
		iwpriv wifi1 current_ant 7
		echo "5G Smart Antenna Type = H1, H2, H3" > /tmp/SA_5G.txt
		exit
	fi

else

# V express vertical, H express Horizontal

	if [ "$1" = "2V" ]; then
		exp_gpio 1
		exp_gpio 2
		exp_gpio 3
		exp_2g_mm
		mm 0xb8040008 0x00000020
		echo "2.4G Smart Antenna Type = V1, V2, V3" > /tmp/SA_24G.txt
		exit
	fi

	if [ "$1" = "2H" ]; then
		exp_gpio 1
		exp_gpio 2
		exp_gpio 3
		exp_2g_mm
		mm 0xb8040008 0x0000002e
		echo "2.4G Smart Antenna Type = H1, H2, H3" > /tmp/SA_24G.txt
		exit
	fi

	if [ "$1" = "5V" ]; then
		exp_5g_mm
		mm 0xb0004048 0x00000080
		echo "5G Smart Antenna Type = V1, V2, V3" > /tmp/SA_5G.txt
		exit
	fi

	if [ "$1" = "5H" ]; then
		exp_5g_mm
		mm 0xb0004048 0x00007080
		echo "5G Smart Antenna Type = H1, H2, H3" > /tmp/SA_5G.txt
		exit
	fi

fi

if [ "$1" = "en" ]; then
	iwpriv wifi1 set SmartAntenna 3
	echo "Using Default Smart Antenna with 2.4G" > /tmp/SA_24G.txt
	iwpriv wifi1 set SmartAntenna 3
	echo "Using Default Smart Antenna with 5G" > /tmp/SA_5G.txt
	exit
fi
