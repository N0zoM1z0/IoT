#!/bin/sh

. /usr/syscfg/api_log.sh

CFGCMD=/usr/sbin/cfgcmd
IFCONFIG=ifconfig
IWPRIV=iwpriv
BRCTL=brctl
bridge=br0

## error code
ERROR_SUC=0
ERROR_INVALID_PARA=1

CONFIG_ROOT_DIR="/var/RT2860AP"

if [ $# -lt 1 ]; then echo "Usage: $0 module"; exit 1; fi

wlan_lock_flag=`expr /tmp/wlan_lock_flag`

while [ -f ${wlan_lock_flag} ]
do
	usleep 100
done

touch ${wlan_lock_flag}


MODULE=$1

if [ "$MODULE" == "mt7603e" ]; then
	local PATH1="InternetGatewayDevice.LANDevice.1.WLANConfiguration.1"
	local PATH2="InternetGatewayDevice.LANDevice.1.WLANConfiguration.2"
	local PATH3="InternetGatewayDevice.LANDevice.1.WLANConfiguration.3"
	local PATH4="InternetGatewayDevice.LANDevice.1.WLANConfiguration.4"
	local file=$CONFIG_ROOT_DIR/RT2860_11N_AP.dat
fi

if [ "$MODULE" == "mt7612e" ]; then
	local PATH1="InternetGatewayDevice.LANDevice.1.WLANConfiguration.5"
	local PATH2="InternetGatewayDevice.LANDevice.1.WLANConfiguration.6"
	local PATH3="InternetGatewayDevice.LANDevice.1.WLANConfiguration.7"
	local PATH4="InternetGatewayDevice.LANDevice.1.WLANConfiguration.8"
	local file=$CONFIG_ROOT_DIR/RT2860_11AC_AP.dat
fi

local pwl="$PATH1 $PATH2 $PATH3 $PATH4"

change_special_char()
{
	SPECIAL_VALUE=
	local parse_value="$1"
	local var=0
	while [ $var -lt ${#parse_value} ];do
		tmp=`echo "${parse_value:${var}:1}"`
		if [ "$tmp" == "&" ];then
		SPECIAL_VALUE="${SPECIAL_VALUE}\&"
		elif [ "$tmp" == "/" ];then
		SPECIAL_VALUE="${SPECIAL_VALUE}\/"
		elif [ "$tmp" == " " ];then
		SPECIAL_VALUE="${SPECIAL_VALUE} "
		else
		SPECIAL_VALUE="${SPECIAL_VALUE}${tmp}"
		fi
		var=`expr $var + 1`
	done
}

change_ascii_to_str()
{
	KEY_VALUE=
	local parse_value="$1"
	local var=0
	while [ $var -lt ${#parse_value} ];do
		tmp=`echo ${parse_value:${var}:2}`
		let hex=0x$tmp
		if [ "$hex" == "38" ];then
		num="\&"
		elif [ "$hex" == "92" ];then
		num="\\\\"
		elif [ "$hex" == "47" ];then
		num="\/"
		else
		num=`echo $hex | awk '{printf("%c", $1)}'`
		fi
		KEY_VALUE="$KEY_VALUE$num"
		var=`expr $var + 2`
	done
}

#Note: If you add the new parameter,
#	   Must make sure the parameter defined in default config file, or config will failed
change_value()
{
	local name="$1"
	local value="$2"

	local found=`sed -n "/\<"$name"=/p" $file | awk -F '=' '{print $1}'`
	if [ -z $found ]; then
		#echo $name=$value >> $file
		echo "new add ....."
	else
		sed -i "s/\(\<$name=\).*/\1$value/g" $file
	fi
}

wds_off()
{
    if [ "$MODULE" == "mt7603e" ]; then
		## Firstly Disable wds interfaces, and remove them from bridge
		local exist_wds0=`ifconfig | grep wds0 | cut -d " " -f 0`
		if [ "$exist_wds0" == "wds0" ];then
		    ${BRCTL} delif ${bridge} wds0
		    ${BRCTL} delif ${bridge} wds1
		    ${BRCTL} delif ${bridge} wds2
		    ${BRCTL} delif ${bridge} wds3
		    ${IFCONFIG} wds0 down
		    ${IFCONFIG} wds1 down
		    ${IFCONFIG} wds2 down
		    ${IFCONFIG} wds3 down
		fi
	fi
	
	if [ "$MODULE" == "mt7612e" ]; then
		## Firstly Disable wds interfaces, and remove them from bridge
		local exist_wds4=`ifconfig | grep wds4 | cut -d " " -f 0`
		if [ "$exist_wds4" == "wds4" ];then
		    ${BRCTL} delif ${bridge} wds4
		    ${BRCTL} delif ${bridge} wds5
		    ${BRCTL} delif ${bridge} wds6
		    ${BRCTL} delif ${bridge} wds7
		    ${IFCONFIG} wds4 down
		    ${IFCONFIG} wds5 down
		    ${IFCONFIG} wds6 down
		    ${IFCONFIG} wds7 down
		fi
	fi
}

intf_action()
{
	local isup=$1
	local isenable=0
	local Radio_Enable=`$CFGCMD get ${PATH1}.Enable`

	for p in $pwl 
	do
		local ifname=`$CFGCMD get $p.Name`
		if [ "${isup}" == 0 ]; then
		    local exist_wlan=`ifconfig | grep $ifname | cut -d " " -f 0`
		    if [ "$exist_wlan" == "$ifname" ];then
			    $IFCONFIG $ifname down
			fi
			wds_off
		else
			isenable=`$CFGCMD get $p.Enable`
			if [ "${isenable}" == "1" -a "${Radio_Enable}" == "1" ]; then
				$IFCONFIG $ifname up
				iwpriv ${ifname} set Debug=0
			fi
		fi
	done
}


change_mbssid()
{
	local ssid=
	local wmm=
	local hidessid=
	local isolation=
	local hasisolation=0
	local maxclient=
	local i=0
	for p in $pwl 
	do
		let i++
		local vssid=`$CFGCMD get ${p}.SSID`
		change_special_char "$vssid"
		vssid="${SPECIAL_VALUE}"
		ssid="${ssid}${vssid}"

		local vwmm=`$CFGCMD get ${p}.WMMEnable`
		if [ -z "${vwmm}" ]; then
			vwmm=0	
		fi
		wmm=${wmm}${vwmm}

		local vhidessid=`$CFGCMD get ${p}.X_CT-COM_SSIDHide`
		hidessid=${hidessid}${vhidessid}

		local visolation=`$CFGCMD get ${p}.Isolation`
		#if one VAP enable isolation, enable it between SSIDs.
		if [ "$visolation" == "1" ]; then
			hasisolation=1
		fi
		isolation=${isolation}${visolation}

		local vmaxclient=`$CFGCMD get ${p}.Maximum_Clients`
		if [ "${vmaxclient}" == "" ]; then
			vmaxclient=0
		fi
		maxclient=${maxclient}${vmaxclient}

		if [ $i -lt 4 ];then
			ssid=${ssid}\;
			wmm=${wmm}\;
			hidessid=${hidessid}\;
			isolation=${isolation}\;
			maxclient=${maxclient}\;
		fi
	done

	change_value SSID "${ssid}"
	change_value WmmCapable ${wmm}
	change_value HideSSID ${hidessid}
	change_value NoForwarding ${isolation}
	change_value NoForwardingBTNBSSID ${hasisolation}
	change_value MaxStaNum ${maxclient}
}

change_bssid()
{
    for p in $pwl 
    do
        local intf=`/usr/sbin/cfgcmd get ${p}".Name"`
        local if_mac=`iwconfig ${intf} | grep "Access Point:" | awk '{print $NF}'`
        $CFGCMD sset ${p}".BSSID" ${if_mac}
    done
}

set_wps_status()
{
	local index=$1
    wps_enable=`$CFGCMD get InternetGatewayDevice.LANDevice.1.WLANConfiguration.$1.WPS.Enable`
    wlan_enable=`$CFGCMD get InternetGatewayDevice.LANDevice.1.WLANConfiguration.$1.Enable`
    if [ "$wps_enable" == "1" -a "${wlan_enable}" == "1" ]; then   
	   $CFGCMD sset InternetGatewayDevice.LANDevice.1.WLANConfiguration.$1.WPS.ConfigurationState "Configured"   
    else
	   $CFGCMD sset InternetGatewayDevice.LANDevice.1.WLANConfiguration.$1.WPS.ConfigurationState "Not configured"
	fi
}

local radius_flag=0
change_msecurity()
{
	local authmode=
	local encrytype=
	local ieee8021x=
	local type1=
	local type2=
	local type3=
	local type4=
	local key1=
	local key2=
	local key3=
	local key4=
	local keyid=
	local wpapsk=
	local i=0
	local radius_server=
	local radius_port=
	local radius_key=
	for p in $pwl
	do
		vauthmode=
		vencrytype=
		vieee8021x=0
		vtype1=0
		vtype2=0
		vtype3=0
		vtype4=0
		vkey1=0
		vkey2=0
		vkey3=0
		vkey4=0
		vkeyid=
		vwpapsk=0
		vradius_server=
		vradius_port=
		vradius_key=
		let i++
		local encrypt_value=`$CFGCMD get ${p}.BeaconType`
		if [ "Basic" = ${encrypt_value} ]; then
			basicencrypt=`$CFGCMD get ${p}.BasicEncryptionModes`
			if [ "None" = ${basicencrypt} ]; then
				encrypt_value="None"
			fi
		fi

		case "$encrypt_value" in
			"None")
				vauthmode="OPEN"
				vencrytype="NONE"
				;;
			"Basic" | "8021X")
			
				case "$encrypt_value" in
					"8021X")
					vieee8021x=1
					local enable=`$CFGCMD get ${p}.Enable`
					
					if [ "1" == "${enable}" ];then
						vradius_server=`$CFGCMD get ${p}.X_CT-COM_RadiusServer.1.X_CT-COM_IPAddress`
						vradius_port=`$CFGCMD get ${p}.X_CT-COM_RadiusServer.1.X_CT-COM_Port`
						vradius_key=`$CFGCMD get ${p}.X_CT-COM_RadiusServer.1.X_CT-COM_ShareKey`
											
					fi
					;;
				esac
				
				auth_type_value=`$CFGCMD get ${p}.BasicAuthenticationMode`
				case "$auth_type_value" in
					"None" | "OpenSystem")
						vauthmode="OPEN"
						;;
					"SharedAuthentication" | "SharedKey")
						vauthmode="SHARED"
						;;
					"Both")
						vauthmode="WEPAUTO"
						;;
				esac
				vencrytype="WEP"
				wep_default_key_value=`$CFGCMD get ${p}.WEPKeyIndex`
				max_key_value=`$CFGCMD get_max_obj ${p}.WEPKey`
				local key_index=1
				while [ $key_index -le $max_key_value ];do
					wep_key=`$CFGCMD get ${p}.WEPKey.${key_index}.WEPKey`
					if [ "$key_index" == "$wep_default_key_value" ]; then
						key_len=`echo ${#wep_key}`

						if [ $key_len -eq 5 -o $key_len -eq 10 ]; then
							##echo "40-bit"
							$CFGCMD set ${p}.WEPEncryptionLevel 40-bit
						elif [ $key_len -eq 13 -o $key_len -eq 26 ]; then
							##echo "104-bit"
							$CFGCMD set ${p}.WEPEncryptionLevel 104-bit
						else
							echo "Error: Invalid wep key length!!! !!!"
							$CFGCMD oset ${p}.WEPKey.${key_index}.WEPKey 0123456789
							$CFGCMD set ${p}.WEPEncryptionLevel 40-bit
						fi
					fi
					change_special_char "${wep_key}"
					wep_key="${SPECIAL_VALUE}"
					local key_name="vkey"$key_index
					local type_name="vtype"$key_index
					if [ ! -z ${wep_key} ]; then
						eval $key_name=${wep_key}
						key_len=`echo ${#wep_key}`
						if [ $key_len -eq 5 -o $key_len -eq 13 ]; then
							key_type=1
						else
							key_type=0	
						fi
						eval $type_name=${key_type}
					fi
					key_index=`expr $key_index + 1`
				done
				vkeyid=${wep_default_key_value}
				;;
			"WPA" | "11i" | "WPAand11i")
				case "$encrypt_value" in
					"WPA")
						wpa_cipher_value=`$CFGCMD get ${p}.WPAEncryptionModes`
						vauthmode="WPAPSK"
						;;
					"11i")
						wpa_cipher_value=`$CFGCMD get ${p}.IEEE11iEncryptionModes`
						vauthmode="WPA2PSK"
						;;
					"WPAand11i")
						wpa_cipher_value=`$CFGCMD get ${p}.IEEE11iEncryptionModes`
						vauthmode="WPAPSKWPA2PSK"
						;;
				esac
				case $wpa_cipher_value in
					"TKIPEncryption")
						vencrytype="TKIP"
						;;
					"AESEncryption")
						vencrytype="AES"
						;;
					"TKIPandAESEncryption")
						vencrytype="TKIPAES"
						;;
				esac
				wpa_key_value=`$CFGCMD get ${p}.PreSharedKey.1.KeyPassphrase`
				if [ "$wpa_key_value" == "undefined"  ]; then
					wpa_key_value=`$CFGCMD get ${p}.PreSharedKey.1.PreSharedKey`
					change_ascii_to_str $wpa_key_value
				else
					$CFGCMD sset ${p}.PreSharedKey.1.PreSharedKey 3132333435363738
					wpa_key_value=`$CFGCMD get ${p}.PreSharedKey.1.PreSharedKey`
					change_ascii_to_str $wpa_key_value
				fi
				vwpapsk="${KEY_VALUE}"
				vkeyid=2
		esac

		authmode=${authmode}${vauthmode}
		encrytype=${encrytype}${vencrytype}
		wpapsk="${wpapsk}${vwpapsk}"
		keyid=${keyid}${vkeyid}
		ieee8021x=${ieee8021x}${vieee8021x}
		radius_server=${radius_server}${vradius_server}
		radius_port=${radius_port}${vradius_port}
		radius_key=${radius_key}${vradius_key}
		type1=${type1}${vtype1}
		type2=${type2}${vtype2}
		type3=${type3}${vtype3}
		type4=${type4}${vtype4}
		change_special_char "${vkey1}"
		vkey1="${SPECIAL_VALUE}"
		key1=${key1}${vkey1}
		change_special_char "${vkey2}"
		vkey2="${SPECIAL_VALUE}"
		key2=${key2}${vkey2}
		change_special_char "${vkey3}"
		vkey3="${SPECIAL_VALUE}"
		key3=${key3}${vkey3}
		change_special_char "${vkey4}"
		vkey4="${SPECIAL_VALUE}"
		key4=${key4}${vkey4}
		if [ $i -lt 4 ];then
			authmode=${authmode}\;
			encrytype=${encrytype}\;
			wpapsk="${wpapsk}\;"
			ieee8021x=${ieee8021x}\;
			radius_server=${radius_server}\;
			radius_port=${radius_port}\;
			radius_key=${radius_key}\;
			keyid=${keyid}\;
			type1=${type1}\;
			type2=${type2}\;
			type3=${type3}\;
			type4=${type4}\;
			key1="${key1}\;"
			key2="${key2}\;"
			key3="${key3}\;"
			key4="${key4}\;"
		fi
	done

	change_value AuthMode ${authmode}
	change_value EncrypType ${encrytype}
	change_value WPAPSK	"${wpapsk}"
	change_value DefaultKeyID ${keyid}
	change_value IEEE8021X ${ieee8021x}
	change_value RADIUS_Server ${radius_server}
	change_value RADIUS_Port ${radius_port}
	change_value RADIUS_Key ${radius_key}
	change_value Key1Type ${type1}
	change_value Key2Type ${type2}
	change_value Key3Type ${type3}
	change_value Key4Type ${type4}
	change_value Key1Str "${key1}"
	change_value Key2Str "${key2}"
	change_value Key3Str "${key3}"
	change_value Key4Str "${key4}"
}

## WDS Setup
set_wds()
{
	## WDS Setup
	wdsencryp=`$CFGCMD get ${PATH1}.WDS.WdsEncrypType`
	wdskey=`$CFGCMD get ${PATH1}.WDS.WdsKey`

	change_value WdsEncrypType "$wdsencryp"
	change_value WdsKey "$wdskey"

	wdsmode=`$CFGCMD get ${PATH1}.WDS.WdsMode`
	wdslist=`$CFGCMD get ${PATH1}.WDS.WdsList`
	## by default, set WdsEnable to disable.
	wdsenable=0
	if [ "$wdsmode" == "disabled" ]; then
		wdsenable=0
		wdslist=""
	elif [ "$wdsmode" == "repeater" ]; then
		## repeater mode, WdsEnable is 1 or 3.
		wdsenable=1
	elif [ "$wdsmode" == "bridge" ]; then
		wdsenable=2
	elif [ "$wdsmode" == "lazy" ]; then
		wdsenable=4
		wdslist=""
		if [ "$MODULE" == "mt7603e" ]; then
			${BRCTL} addif ${bridge} wds0
			${BRCTL} addif ${bridge} wds1
			${BRCTL} addif ${bridge} wds2
			${BRCTL} addif ${bridge} wds3
			${IFCONFIG} wds0 up
			${IFCONFIG} wds1 up
			${IFCONFIG} wds2 up
			${IFCONFIG} wds3 up
		elif [ "$MODULE" == "mt7612e" ]; then
			${BRCTL} addif ${bridge} wds4
			${BRCTL} addif ${bridge} wds5
			${BRCTL} addif ${bridge} wds6
			${BRCTL} addif ${bridge} wds7
			${IFCONFIG} wds4 up
			${IFCONFIG} wds5 up
			${IFCONFIG} wds6 up 
			${IFCONFIG} wds7 up
		fi
	fi
	change_value WdsEnable "$wdsenable"
	change_value WdsList "$wdslist"

	if [ "$wdslist" != "" ]; then
		## get the AP MAC numbers
		macs=`echo "$wdslist" | awk -F ';' '{print NF-1}'`
		i=0
		while [ $i -lt $macs ]
		do
			if [ "$MODULE" == "mt7603e" ]; then
				inf="wds"${i}
			else
				inf="wds"$((i+4))
			fi
			${BRCTL} addif ${bridge} ${inf}
			${IFCONFIG} ${inf} up
			i=`expr $i + 1`
		done
	fi
}

mac_filter()
{
    i=0
    for p in $pwl
    do
        local ifname=`$CFGCMD get $p.Name`
        local flag=`$CFGCMD get $p.X_TRI-ACL.Status`
        if [ "${flag}" == "0" ]; then
            #action as disable
            change_value AccessPolicy${i} 0
            return
        elif [ "${flag}" == "1" ]; then
            #action as white maclist
            change_value AccessPolicy${i} 1
        elif [ "${flag}" == "2" ]; then
            #action as black maclist
            change_value AccessPolicy${i} 2
        fi

        local maclist=""
        local maclistpath="$p.X_TRI-ACL.Mac_List"
        local aclnum=`$CFGCMD get $p.X_TRI-ACL.Mac_ListNumberOfEntries`
        local maxobj=`$CFGCMD get_max_obj ${maclistpath}.`

        local I=1
        local inst=1
        while [ $inst -le $maxobj -a $I -le $aclnum ]
        do
            isexist=`${CFGCMD} check_obj ${maclistpath}.${inst}`
            if [ "$isexist" == "0" ]; then
                mac_addr=`${CFGCMD} get ${maclistpath}.${inst}.MacAddr`
                maclist=${maclist}"${mac_addr};"
                I=$((I + 1))
            fi
            inst=$((inst + 1))
        done

        maclist=${maclist%;}
        ## clear the ACL List before setting to profile.
        iwpriv $ifname set ACLClearAll=1
        change_value AccessControlList${i} "$maclist"
        i=`expr $i + 1`
    done
}



# GenerateCountryRegion_2G
# 描述：根据2.4G的PossibleChannels生成驱动识别的CountryRegion
#       根据“MTK_Wi-Fi_SoftAP_Software_Programming_Guide_v4.2.pdf”实现
# $1 - 2.4G的channel列表
# 返回：无
GenerateCountryRegion_2G()
{
    local PossibleChannels_2G=$1

    case "${PossibleChannels_2G}" in
        "1-11")
            change_value CountryRegion 0
            ;;
        "1-13")
            change_value CountryRegion 1
            ;;
        "10-11")
            change_value CountryRegion 2
            ;;
        "10-13")    
            change_value CountryRegion 3
            ;;
        "14")
            change_value CountryRegion 4
            ;;
        "1-14")
            change_value CountryRegion 5
            ;;
        "3-9")
            change_value CountryRegion 6
            ;;
        "5-13")
            change_value CountryRegion 7
            ;;
        *)
            TGP_Log $TGP_LOG_ERROR "PossibleChannels_2G=$PossibleChannels_2G"
            ;;
    esac
}


# GenerateCountryRegion_5G
# 描述：根据5G的PossibleChannels生成驱动识别的CountryRegion
#       根据“MTK_Wi-Fi_SoftAP_Software_Programming_Guide_v4.2.pdf”实现
# 输入：$1 - 5G的channel列表
# 返回：无
GenerateCountryRegion_5G()
{
    local PossibleChannels_5G=$1

    case "${PossibleChannels_5G}" in
        "36,40,44,48,52,56,60,64,149,153,157,161,165")
            change_value CountryRegionABand 0
            ;;
        "36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128,132,136,140")
            change_value CountryRegionABand 1
            ;;
        "36,40,44,48,52,56,60,64")
            change_value CountryRegionABand 2
            ;;
        "52,56,60,64,149,153,157,161,165") #此选项比文档中多了165,用于适配新驱动的MY
            change_value CountryRegionABand 3
            ;;
        "149,153,157,161,165")
            change_value CountryRegionABand 4
            ;;
        "149,153,157,161")
            change_value CountryRegionABand 5
            ;;
        "36,40,44,48")
            change_value CountryRegionABand 6
            ;;
        "36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128,132,136,140,149,153,157,161,165")
            change_value CountryRegionABand 7
            ;;
        "52,56,60,64")
            change_value CountryRegionABand 8
            ;;
        "36,40,44,48,52,56,60,64,100,104,108,112,116,132,136,140,149,153,157,161,165")
            change_value CountryRegionABand 9
            ;;
        "36,40,44,48,149,153,157,161,165")
            change_value CountryRegionABand 10
            ;;
        "36,40,44,48,52,56,60,64,100,104,108,112,116,120,149,153,157,161")
            change_value CountryRegionABand 11
            ;;
        *)
            TGP_Log $TGP_LOG_ERROR "PossibleChannels_5G=$PossibleChannels_5G"
            ;;
    esac
}

#Multiple BSSID Setup
intf_action 0
change_mbssid
change_msecurity

mac_filter

#AutoChannelSelect=0
#0: disable
#1: Old Channel Selection Algorithm
#2: New Channel Selection Algorithm
local isauto=`$CFGCMD get ${PATH1}.AutoChannelEnable`
if [ "${isauto}" == "1" ]; then
	change_value AutoChannelSelect 2
else
	channel=`$CFGCMD get ${PATH1}.Channel`
	change_value AutoChannelSelect 0
	change_value Channel ${channel}
fi


#Mode and bandwith
local standard=
local bandwith=

local opmode=
local txmode=
local wifimode=
local mcs=
local rate=
local bw=
standard=`$CFGCMD get ${PATH1}.Standard`
bandwith=`$CFGCMD get ${PATH1}.X_CT-COM_ChannelWidth`
maxbitrate=`$CFGCMD get ${PATH1}.MaxBitRate`
#Rate define: idx:maxbitrate:txmode
txrate_a="0:6:2 1:9:2 2:12:2 3:18:2 4:24:2 5:36:2 6:48:2 7:54:2"
txrate_b="0:1:1 1:2:1 2:5.5:1 3:11:1"
txrate_g="0:6:2 1:9:2 2:12:2 3:18:2 4:24:2 5:36:2 6:48:2 7:54:2"
txrate_n="0:MCS0:0 1:MCS1:0 2:MCS2:0 3:MCS3:0 4:MCS4:0 5:MCS5:0 6:MCS6:0 7:MCS7:0 8:MCS8:0 9:MCS9:0 10:MCS10:0 11:MCS11:0 12:MCS12:0 13:MCS13:0 14:MCS14:0 15MCS15:0"
txrate_bg="0:1:1 1:2:1 2:5.5:1 3:11:1 0:6:2 1:9:2 2:12:2 3:18:2 4:24:2 5:36:2 6:48:2 7:54:2"
txrate_gn="0:6:2 1:9:2 2:12:2 3:18:2 4:24:2 5:36:2 6:48:2 7:54:2 0:MCS0:0 1:MCS1:0 2:MCS2:0 3:MCS3:0 4:MCS4:0 5:MCS5:0 6:MCS6:0 7:MCS7:0 8:MCS8:0 9:MCS9:0 10:MCS10:0 11:MCS11:0 12:MCS12:0 13:MCS13:0 14:MCS14:0 15MCS15:0"
txrate_bgn="0:1:1 1:2:1 2:5.5:1 3:11:1 0:6:2 1:9:2 2:12:2 3:18:2 4:24:2 5:36:2 6:48:2 7:54:2 0:6:2 1:9:2 2:12:2 3:18:2 4:24:2 5:36:2 6:48:2 7:54:2 0:MCS0:0 1:MCS1:0 2:MCS2:0 3:MCS3:0 4:MCS4:0 5:MCS5:0 6:MCS6:0 7:MCS7:0 8:MCS8:0 9:MCS9:0 10:MCS10:0 11:MCS11:0 12:MCS12:0 13:MCS13:0 14:MCS14:0 15MCS15:0"

settx_rate()
{
	local maxrate=$1
	local rate_t="$2"
	
	#default is Auto
	mcs=33
	for p in $rate_t
	do
		rate=`echo $p | cut -d : -f 2`
		if [ "${rate}" == "${maxrate}" ];then
			mcs=`echo $p | cut -d : -f 1`
			txmode=`echo $p | cut -d : -f 3`
		fi
	done
}

case "${standard}" in
	"a")
		opmode=0
		txmode=2
		wifimode=2
		settx_rate $maxbitrate "$txrate_a"
		rate=336
		bw=0
		;;
	"b")
		opmode=1
		# 0: HT, 1: CCK, 2:OFDM
		txmode=1
		wifimode=1
		settx_rate $maxbitrate "$txrate_b"
		rate=3
		bw=0
		;;
	"g")
		opmode=0
		txmode=2
		wifimode=4	
		settx_rate $maxbitrate "$txrate_g"
		rate=351
		bw=0
		;;
	"n")
		opmode=1
		txmode=0
		wifimode=6
		if [ "$MODULE" == "mt7612e" ]; then
			#11N only in 5G band only
			wifimode=11
		fi
		settx_rate $maxbitrate "$txrate_n"
		rate=15
		bw=${bandwith}
		;;
	"b,g")
		opmode=0
		txmode=0
		wifimode=0
		settx_rate $maxbitrate "$txrate_bg"
		rate=15
		bw=0	
		;;
	"n,g")
		opmode=0
		txmode=0
		wifimode=7
		settx_rate $maxbitrate "$txrate_gn"
		rate=351
		bw=${bandwith}	
		;;
	"b,g,n")
		opmode=0
		txmode=0
		wifimode=9
		settx_rate $maxbitrate "$txrate_bgn"
		rate=15
		bw=${bandwith}	
		;;
	"ac")
		opmode=0
		txmode=0
		wifimode=14
		settx_rate $maxbitrate "$txrate_n"
		rate=336
		bw=${bandwith}	
		;;
	"a,n,ac")
		opmode=0
		txmode=0
		wifimode=14
		settx_rate $maxbitrate "$txrate_n"
		rate=336
		bw=${bandwith}	
		;;
esac

#HT_OpMode=0
#0: HT mixed mode
#1: HT Greenfield mode
change_value HT_OpMode ${opmode}
change_value FixedTxMode ${txmode}
change_value WirelessMode ${wifimode}
change_value HT_MCS ${mcs}
change_value BasicRate ${rate}

#0: 20, 1:40, 2:20/40, 3:80
case "${bw}" in
	"0")
		change_value HT_BW 0
		change_value VHT_BW 0
		change_value HT_BSSCoexistence 0
		change_value HT_EXTCHA 0
		;;
	"1")
		change_value HT_BW 1
		change_value VHT_BW 0
		change_value HT_BSSCoexistence 0
		change_value HT_EXTCHA 0
		;;
	"2")
		change_value HT_BW 1
		change_value VHT_BW 0
		change_value HT_BSSCoexistence 1
		change_value HT_EXTCHA 0
		;;
	"3")
		change_value HT_BW 1
		change_value VHT_BW 1
		change_value HT_BSSCoexistence 0
		change_value HT_EXTCHA 1
		;;
esac

local shortgi=`$CFGCMD get ${PATH1}.X_CT-COM_GuardInterval`
change_value HT_GI ${shortgi}
change_value VHT_SGI ${shortgi}

local rts=`$CFGCMD get ${PATH1}.RTS_Threshold`
if [ "${rts}" == "" ]; then
	rts=2347
fi
change_value RTSThreshold ${rts} 

local fragment=`$CFGCMD get ${PATH1}.Fragment_Threshold`
if [ "${fragment}" == "" ]; then
	fragment=2346
fi
change_value FragThreshold ${fragment}

local Interval=`$CFGCMD get ${PATH1}.BeaconInterval`
if [ "${Interval}" == "" ]; then
	Interval=100
fi
change_value BeaconPeriod ${Interval}

local dtim=`$CFGCMD get ${PATH1}.DTIM`
if [ "${dtim}" == "" ]; then
	dtim=1
fi
change_value DtimPeriod ${dtim}


#Tx Power
#91 ~ 100% & AUTO, treat as 100% in terms of mW
#61 ~ 90%, treat as 75% in terms of mW -1dBm
#31 ~ 60%, treat as 50% in terms of mW -3dBm
#16 ~ 30%, treat as 25% in terms of mW -6dBm
#10 ~ 15%, treat as 12.5% in terms of mW -9dBm
#0 ~ 9 %, treat as MIN(~3%) in terms of mW -12dBm

local power_level_value=`$CFGCMD get ${PATH1}.TransmitPower`
change_value TxPower ${power_level_value}

#############countrycode##############
countrycode_value=`$CFGCMD get ${PATH1}.RegulatoryDomain`
change_value CountryCode ${countrycode_value}

PossibleChannels=`$CFGCMD get ${PATH1}.PossibleChannels`
if [ "$MODULE" == "mt7603e" ]; then
    GenerateCountryRegion_2G "$PossibleChannels"
else
    GenerateCountryRegion_5G "$PossibleChannels"
fi


set_wds
intf_action 1

change_bssid

if [ "$MODULE" == "mt7603e" ]; then
    set_wps_status 1
	/usr/syscfg/ScriptFiles/script/wps.sh 1
fi
if [ "$MODULE" == "mt7612e" ]; then
    set_wps_status 5
	/usr/syscfg/ScriptFiles/script/wps.sh 5
fi

rm -f ${wlan_lock_flag}


local rtdot1xd_pid=0
local rtdot1xd_pid_file
local flag

for p in $pwl 
do
	local enable=`$CFGCMD get $p.Enable`
	local type=`$CFGCMD get $p.BeaconType`
	
	if [ "${enable}" == "1" ]; then
	    if [ "${type}" == "8021X" ]; then
		radius_flag=1
	    fi
	fi
done


if [ "$MODULE" == "mt7603e" ]; then
	flag=$(ps | grep rtdot1xd | grep 11n | wc -l)
	if [ "${flag}" == "1" ]; then
	    rtdot1xd_pid_file="/tmp/wl80211n_pid"
	    rtdot1xd_pid=`cat ${rtdot1xd_pid_file}`
	fi
else
	flag=$(ps | grep rtdot1xd | grep 11ac | wc -l)
	if [ "${flag}" == "1" ]; then
	    rtdot1xd_pid_file="/tmp/wl80211ac_pid"
	    rtdot1xd_pid=`cat ${rtdot1xd_pid_file}`
	fi
fi


if  [ "${flag}" == "1" ]; then
    if [ "${rtdot1xd_pid}" != "0" ]; then
        kill ${rtdot1xd_pid} -9
        sleep 1
    fi
fi
    
if [ "${radius_flag}" == "1" ]; then
    if [ "$MODULE" == "mt7603e" ]; then
	/usr/sbin/rtdot1xd -i 11n &
    else
	/usr/sbin/rtdot1xd -i 11ac &
    fi
fi

