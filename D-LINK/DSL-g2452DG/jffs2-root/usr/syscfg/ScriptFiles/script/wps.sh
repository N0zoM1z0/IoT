#!/bin/sh

index=$1

local path="InternetGatewayDevice.LANDevice.1.WLANConfiguration"

local WIFIEnable=`cfgcmd get ${path}.${index}.Enable`

local ifname=`cfgcmd get ${path}.${index}.Name`

if [ "$WIFIEnable" -ne "1" ]; then
	echo "WIFI off"
	exit
fi

local WPSEnable=`cfgcmd get ${path}.${index}.WPS.Enable`
if [ "$WPSEnable" -ne "1" ]; then
	iwpriv ${ifname} set WscConfMode=0
	iwpriv ${ifname} set WscConfStatus=1
	echo "WPS off"
	exit
fi

# set pin attack times to 10.
iwpriv ${ifname} set WscMaxPinAttack=10

local role=`cfgcmd get ${path}.${index}.WPS.X_CT-COM_Role`

if [ "${role}" == "Registrar" ]; then
	iwpriv ${ifname} set WscConfMode=0
	iwpriv ${ifname} set WscConfStatus=1
else
	local pin_number=`cfgcmd get ${path}.${index}.WPS.PeerPassword`

	iwpriv ${ifname} set WscConfMode=1
	iwpriv ${ifname} set WscConfStatus=2
	iwpriv ${ifname} set WscMode=1

	if [ ${#pin_number} -ne 8 ]; then
		flash get-pin $ifname > /dev/null 2>&1
		pin_number=`cat /var/RT2860AP/${ifname}_pin`
		cfgcmd set ${path}.${index}.WPS.PeerPassword ${pin_number} > /dev/null 2>&1
	else
		iwpriv ${ifname} set WscVendorPinCode=$pin_number
	fi

	iwpriv ${ifname} set WscGetConf=1
fi
