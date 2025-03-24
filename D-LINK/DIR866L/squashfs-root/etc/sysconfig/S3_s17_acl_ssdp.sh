#!/bin/sh
# echo "Let ethernet driver handle this !!!" 
exit 0 

echo "begin S3_s17_acl_ssdp.sh"

tohex(){
	case $1 in
		10)
		echo A
		;;
	11)
		echo B
		;;
	12)
		echo C
		;;
	13)
		echo D
		;;
	14)
		echo E
		;;
	15)
		echo F
		;;
	*)
		echo $1
		;;

	esac
}

func(){
	b=$(($1/16))
	c=$(($1%16))
	first=$(tohex $b)
	second=$(tohex $c)
	echo $first$second
}

iptohex(){
	lan_addr=`nvram get lan_ipaddr`
	count=1
	one=`echo $lan_addr | cut -d '.' -f 1`
	one=$(func $one)
	two=`echo $lan_addr | cut -d '.' -f 2`
	two=$(func $two)
	three=`echo $lan_addr | cut -d '.' -f 3`
	three=$(func $three)
	four=`echo $lan_addr | cut -d '.' -f 4`
	four=$(func $four)
	
	echo "$one$two$three$four"	
}

masktohex(){
	mask_addr=`nvram get lan_netmask`
	one=`echo $mask_addr | cut -d '.' -f 1`
	one=$(func $one)
	two=`echo $mask_addr | cut -d '.' -f 2`
	two=$(func $two)
	three=`echo $mask_addr | cut -d '.' -f 3`
	three=$(func $three)
	four=`echo $mask_addr | cut -d '.' -f 4`
	four=$(func $four)

	echo "$one$two$three$four"

}

fun_nvram_get(){
	if [ "$1" != "" ]; then
		ret=`nvram get $1`
	fi
	echo "$ret"
}

hnat_status(){
	ret=$(fun_nvram_get "hnat_enable")
	echo "$ret"
}

hnat_enable=$(hnat_status)

#echo "ACL # 15 - UPnP SSDP forwarding lan"
# forward SSDP 239.255.255.250 to all port 0~4
# IPv4 Pattern
ethreg 0x404=0x5e7ffffa
ethreg 0x408=0x00000100
ethreg 0x40c=0x00000000
ethreg 0x410=0x08000001
ethreg 0x414=0x0000001f
ethreg 0x400=0x8000000b
# Mask
ethreg 0x404=0xffffffff
ethreg 0x408=0x0000ffff
ethreg 0x40c=0x00000000
ethreg 0x410=0xffff0fff
ethreg 0x414=0x000000c9
ethreg 0x400=0x8000010b
# IPv4 Result
ethreg 0x404=0x00000000
ethreg 0x408=0xe0000000
ethreg 0x40c=0x00000013
ethreg 0x410=0x00000000
ethreg 0x414=0x00000000
ethreg 0x400=0x8000020b


if [ $hnat_enable = "0" ]; then
	exit;
fi
# Block packet src ip == 192.168.0.0/24 in lan , port 0~4 
# Rule

ethreg 0x404=0x0
ethreg 0x408=0x$(iptohex) # 192.168.0.0
ethreg 0x40c=0x0
ethreg 0x410=0x0
ethreg 0x414=0x0000009e # 00000000 10011110
			# bit 1 ~ 4, action port
			# bit 7, 1b1 : action on the rule NOT matched
#ethreg 0x400=0x8000000f # ACL index-15
ethreg 0x400=0x80000056 # ACL index-15(f) -->86(56)

# Mask

ethreg 0x404=0x0
ethreg 0x408=0x$(masktohex) # Mask 255.255.255.0 
ethreg 0x40c=0x0
ethreg 0x410=0x00030000 # 00000000 00000011 00000000 00000000
			# bit[0], TCP/UDP Destination mask, 1b'1, mask
			# bit[1], TCP/UDP Source mask, 1b'1, mask
ethreg 0x414=0x800000c2 # 10000000 00000000 00000000 11000010
			# bit[7:6], 2'b11, start and end
			# bit[2:0], 3'b010, IPv4 Type Rule
#ethreg 0x400=0x8000010f # ACL index - 15
ethreg 0x400=0x80000156 # ACL index - 15(f)->86(56)

# Action

ethreg 0x404=0x0
ethreg 0x408=0x00000000 # 00100000 00000000 00000000 00000000
			# bit[61], DES_PORT 0, 1b'1
ethreg 0x40c=0xd0       # 00000000 00000000 11010000
			# Bit[72:70], 3b'011, redirect
			# bit[68], Des_port_over_en, 1b'1
ethreg 0x410=0x0
ethreg 0x414=0x0
#ethreg 0x400=0x8000020f # ACL index - 15
ethreg 0x400=0x80000256 # ACL index - 15(f)->86(56)

echo "end S3_s17_acl_ssdp.sh"
