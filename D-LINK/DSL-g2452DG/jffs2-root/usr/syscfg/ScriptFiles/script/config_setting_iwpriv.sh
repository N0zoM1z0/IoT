#!/bin/sh

CFGCMD=/usr/sbin/cfgcmd
IFCONFIG=ifconfig
IWPRIV=iwpriv

## error code
ERROR_SUC=0
ERROR_INVALID_PARA=1

if [ $# -lt 2 ]; then echo "Usage: $0 iface path"; exit 1; fi

intf=$1
path=$2

change_ascii_to_str()
{
	parse_value="$1"
	var=0
	while [ $var -lt ${#parse_value} ];do
		tmp=`echo ${parse_value:${var}:2}`
		let hex=0x$tmp
		num=`echo $hex | awk '{printf("%c", $1)}'`
		KEY_VALUE=$KEY_VALUE$num
		var=`expr $var + 2`
	done
}


local isenable=0
isenable=`$CFGCMD get ${path}.Enable`
if [ "${isenable}" == "0" ]; then
	$IFCONFIG ${intf} down
	exit $ERROR_SUC
else
	$IFCONFIG ${intf} up
fi

# SSID config will let above config workon
local ssid=""
ssid=`$CFGCMD get ${path}.SSID`


local channel=0
local isauto=0
isauto=`$CFGCMD get ${path}.AutoChannelEnable`
if [ "${isauto}" == "1" ]; then
	$IWPRIV ${intf} set AutoChannelSel=2
else
	channel=`$CFGCMD get ${path}.Channel`
	$IWPRIV ${intf} set AutoChannelSel=0
	$IWPRIV ${intf} set Channel=${channel}
fi


local standard=
local bandwith=

local opmode=
local txmode=
local wifimode=
local mcs=
local rate=
local bw=
standard=`$CFGCMD get ${path}.Standard`
bandwith=`$CFGCMD get ${path}.X_CT-COM_ChannelWidth`
case "${standard}" in
	"a")
		opmode=0
		txmode=0
		wifimode=2
		mcs=33
		rate=15
		bw=0
		;;
	"b")
		opmode=1
		txmode=1
		wifimode=1
		mcs=33
		rate=15
		bw=0
		;;
	"g")
		opmode=0
		txmode=2
		wifimode=4
		mcs=33
		rate=15
		bw=0
		;;
	"n")
		opmode=1
		txmode=0
		wifimode=6
		mcs=33
		rate=15
		bw=${bandwith}	
		;;
	"b,g")
		opmode=0
		txmode=0
		wifimode=0
		mcs=33
		rate=15
		bw=0	
		;;
	"n,g")
		opmode=0
		txmode=0
		wifimode=7
		mcs=33
		rate=15
		bw=${bandwith}	
		;;
	"b,g,n")
		opmode=0
		txmode=0
		wifimode=9
		mcs=33
		rate=15
		bw=${bandwith}	
		;;
	"a,n,ac")
		opmode=0
		txmode=0
		wifimode=14
		mcs=33
		rate=15
		bw=${bandwith}
		;;
esac

$IWPRIV ${intf} set HtOpMode=${opmode}
$IWPRIV ${intf} set FixedTxMode=${txmode} 
$IWPRIV ${intf} set WirelessMode=${wifimode}
#Fixed me Max Rate Should config Mcs and Rate(11bg), Default use Auto
$IWPRIV ${intf} set HtMcs=${mcs}
$IWPRIV ${intf} set BasicRate=${rate}

#0: 20, 1:40, 2:20/40, 3:80
case "${bw}" in
	"0")
		$IWPRIV ${intf} set HtBw=0
		$IWPRIV ${intf} set VhtBw=0
		$IWPRIV ${intf} set AP2040Rescan=0
		;;
	"1")
		$IWPRIV ${intf} set HtBw=1
		$IWPRIV ${intf} set VhtBw=0
		$IWPRIV ${intf} set AP2040Rescan=0
		;;
	"2")
		$IWPRIV ${intf} set HtBw=1
		$IWPRIV ${intf} set VhtBw=0
		$IWPRIV ${intf} set AP2040Rescan=1
		;;
	"3")
		$IWPRIV ${intf} set HtBw=1
		$IWPRIV ${intf} set VhtBw=1
		$IWPRIV ${intf} set AP2040Rescan=0
		;;
esac

local shortgi=`$CFGCMD get ${2}.X_CT-COM_GuardInterval`
$IWPRIV ${intf} set HtGi=${shortgi}


local rts=`$CFGCMD get ${path}.RTS_Threshold`
if [ "${rts}" == "" ]; then
		rts=2347
fi
$IWPRIV ${intf} set RTSThreshold=${rts}


local fragment=`$CFGCMD get ${path}.Fragment_Threshold`
if [ "${fragment}" == "" ]; then
		fragment=2346
fi
$IWPRIV ${intf} set FragThreshold=${fragment}

local Interval=`$CFGCMD get ${path}.BeaconInterval`
if [ "${Interval}" == "" ]; then
		Interval=100
fi
$IWPRIV ${intf} set BeaconPeriod=${Interval}


local dtim=`$CFGCMD get ${path}.DTIM`
if [ "${dtim}" == "" ]; then
	dtim=1
fi
$IWPRIV ${intf} set DtimPeriod=${dtim}


local hide=`$CFGCMD get ${path}.X_CT-COM_SSIDHide`
$IWPRIV ${intf} set HideSSID=${hide}

local maxclient=`$CFGCMD get ${path}.Maximum_Clients`
if [ "${maxclient}" == "" ]; then
		maxclient=0
fi
$IWPRIV ${intf} set MaxStaNum=${maxclient}

#############Isolation################
local isolation=`$CFGCMD get ${path}.Isolation`
#############End Isolation################

local wmm=`$CFGCMD get ${path}.WMMEnable`
if [ "${wmm}" == "0" ]; then
	${IWPRIV} ${intf} set WmmCapable=0
	${IWPRIV} ${intf} set TxBurst=1
else
	${IWPRIV} ${intf} set WmmCapable=1
	${IWPRIV} ${intf} set TxBurst=0
fi


local code=`$CFGCMD get ${2}.RegulatoryDomain`
if [ "${code}" == "" ]; then
	code="CN"
fi
${IWPRIV} ${intf} set CountryCode=${code}



###################EncryptionModes###################
local authmode=
local encrytype=
local ieee8021x=0
local key=
local keyid=
local wpapsk=

local encrypt_value=`$CFGCMD get ${path}.BeaconType`
if [ "Basic" = ${encrypt_value} ]; then
	basicencrypt=`$CFGCMD get ${path}.BasicEncryptionModes`
	if [ "None" = ${basicencrypt} ]; then
		encrypt_value="None"
	fi
fi

case "$encrypt_value" in
	"None")
		authmode="OPEN"
		encrytype="NONE"
		$IWPRIV ${intf} set AuthMode=${authmode}
		$IWPRIV ${intf} set EncrypType=${encrytype}
		$IWPRIV ${intf} set IEEE8021X=0
		;;
	"Basic")
		auth_type_value=`$CFGCMD get ${path}.BasicAuthenticationMode`
		case "$auth_type_value" in
			"None")
				authmode="OPEN"
				;;
			"SharedAuthentication")
				authmode="SHARED"
				;;
		esac
		encrytype="WEP"
		wep_default_key_value=`$CFGCMD get ${path}.WEPKeyIndex`
		wep_key=`$CFGCMD get ${path}.WEPKey.${wep_default_key_value}.WEPKey`
		key_len=`echo ${#wep_key}`
		if [ $key_len -eq 5 -o $key_len -eq 10 ]; then
			##echo "40-bit"
			$CFGCMD set ${path}.WEPEncryptionLevel 40-bit
		elif [ $key_len -eq 13 -o $key_len -eq 26 ]; then
			##echo "104-bit"
			$CFGCMD set ${path}.WEPEncryptionLevel 104-bit
		else
			##echo "Invalid wep key length!!!"
			$CFGCMD oset ${path}.WEPKey.${wep_default_key_value}.WEPKey 0123456789
			exit 1
		fi
		key=${wepkey}
		keyid=${wep_default_key_value}
		$IWPRIV ${intf} set AuthMode=${authmode}
		$IWPRIV ${intf} set EncrypType=${encrytype}
		$IWPRIV ${intf} set IEEE8021X=0
		;;
	"WPA" | "11i" | "WPAand11i")
		case "$encrypt_value" in
			"WPA")
				authmode="WPAPSK"
				;;
			"11i")
				authmode="WPA2PSK"
				;;
			"WPAand11i")
				authmode="WPAPSKWPA2PSK"
				;;
		esac
		wpa_cipher_value=`$CFGCMD get ${path}.WPAEncryptionModes`
		case $wpa_cipher_value in
			"TKIPEncryption")
				encrytype="TKIP"
				;;
			"AESEncryption")
				encrytype="AES"
				;;
			"TKIPandAESEncryption")
				encrytype="TKIPAES"
				;;
		esac
		$IWPRIV ${intf} set AuthMode=${authmode}
		$IWPRIV ${intf} set EncrypType=${encrytype}
		$IWPRIV ${intf} set IEEE8021X=0
		#Must set ssid follow Programming Guide
		sleep 1
		$IWPRIV ${intf} set SSID=${ssid}
		wpa_key_value=`$CFGCMD get ${path}.PreSharedKey.1.KeyPassphrase`
		if [ "$wpa_key_value" == "undefined"  ]; then
			wpa_key_value=`$CFGCMD get ${path}.PreSharedKey.1.PreSharedKey`
			change_ascii_to_str $wpa_key_value
		else
			$CFGCMD set ${path}.PreSharedKey.1.PreSharedKey 3132333435363738
			wpa_key_value=`$CFGCMD get $path.PreSharedKey.1.PreSharedKey`
			change_ascii_to_str $wpa_key_value
		fi
		wpapsk="${KEY_VALUE}"
		keyid=2
		;;
esac


if [ ! -z "${key}" ]; then
	$IWPRIV ${intf} set Key1=${key}
	$IWPRIV ${intf} set DefaultKeyID=${keyid}
fi
if [ ! -z "${wpapsk}" ]; then
	$IWPRIV ${intf} set WPAPSK=${wpapsk}
	$IWPRIV ${intf} set DefaultKeyID=${keyid}
fi

sleep 1
$IWPRIV ${intf} set SSID=${ssid}


