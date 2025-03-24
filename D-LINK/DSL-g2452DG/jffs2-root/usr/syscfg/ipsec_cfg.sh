#!/bin/sh 

. /usr/syscfg/firewall.param.sh
. /usr/syscfg/wan.utils.sh

local IPSecRunDir="/var/ipsec/"
local IPSEC_DBG="${IPSecRunDir}Dbg/base"
local Path=$2

local ipsec_lock_flag="${IPSecRunDir}.ipsec_lock_flag"
while [ -f ${ipsec_lock_flag} ]
do
	usleep 100
done
#create ipsec_lock_flag
touch ${ipsec_lock_flag}

ipsec_get_mask_bits_cnt()
{                                                                                                                               
    local total=$1
    local i=7
    local cnt=0
    local val=0
        
    while [ $total -gt 0 -a $i -ge 0 ]
    do
        val=`echo $i | awk '{print lshift(1,$i)}'`
        i=`expr $i - 1`
        cnt=`expr $cnt + 1`
        total=`expr $total - $val`  
    done

    echo $cnt
}

ipsec_get_prefix_by_mask()
{
    local mask=$1
    local part1=`echo $mask | awk -F '.' '{print $1}'`    
    local part2=`echo $mask | awk -F '.' '{print $2}'`    
    local part3=`echo $mask | awk -F '.' '{print $3}'`    
    local part4=`echo $mask | awk -F '.' '{print $4}'`    

    local sum=0
    local val=0
    val=`ipsec_get_mask_bits_cnt $part1`
    sum=`expr $sum + $val`

    val=`ipsec_get_mask_bits_cnt $part2`
    sum=`expr $sum + $val`

    val=`ipsec_get_mask_bits_cnt $part3`
    sum=`expr $sum + $val`

    val=`ipsec_get_mask_bits_cnt $part4`
    sum=`expr $sum + $val`
    
    echo "$sum"
}
               

ipsec_cfg_sh_gen()
{
	local IPSecInstPath=$1
	local IPSecInstNum=`echo ${IPSecInstPath} | awk -F . '{print $5}'`
	local IPSecInstDir="${IPSecRunDir}ipsec${IPSecInstNum}/"
	local IPSECDBG="${IPSecRunDir}Dbg/ipsec${IPSecInstNum}"
	local STARTSH="${IPSecInstDir}start.sh"
	local STOPSH="${IPSecInstDir}stop.sh"
	local IPSECPSK="${IPSecInstDir}psk.txt"
	local IPSECPATHCERT="${IPSecInstDir}cert"
	local IPSECRACOON="${IPSecInstDir}racoon.conf"
	local IPSECSETKEYCFG="${IPSecInstDir}setkey.conf"
	echo "## DBG ipsec_cfg_sh_gen ==========##" >> $IPSECDBG
	local IPSecInstContent="`cfgcmd get ${IPSecInstPath}.`"
	local TunnelName=`echo "${IPSecInstContent}" | grep ".TunnelName=" | awk -F = '{print $2}'`
	local TunnelMode=`echo "${IPSecInstContent}" | grep ".TunnelMode=" | awk -F = '{print $2}'`
	local WanConnection=`echo "${IPSecInstContent}" | grep ".WanConnection=" | awk -F = '{print $2}'`
	local WanIP=`echo "${IPSecInstContent}" | grep ".WanIP=" | awk -F = '{print $2}'`
	local RemoteGatewayAddress=`echo "${IPSecInstContent}" | grep ".RemoteGatewayAddress=" | awk -F = '{print $2}'`
	local LocalMode=`echo "${IPSecInstContent}" | grep ".LocalMode=" | awk -F = '{print $2}'`
	local LocalIP=`echo "${IPSecInstContent}" | grep ".LocalIP=" | awk -F = '{print $2}'`	
	local LocalMask=`echo "${IPSecInstContent}" | grep ".LocalMask=" | awk -F = '{print $2}'	`
	local RemoteMode=`echo "${IPSecInstContent}" | grep ".RemoteMode=" | awk -F = '{print $2}'`
	local RemoteIP=`echo "${IPSecInstContent}" | grep ".RemoteIP=" | awk -F = '{print $2}'`
	local RemoteMask=`echo "${IPSecInstContent}" | grep ".RemoteMask=" | awk -F = '{print $2}'`
	local KeyMode=`echo "${IPSecInstContent}" | grep ".KeyMode=" | awk -F = '{print $2}'`
	local AuthenticationMode=`echo "${IPSecInstContent}" | grep ".AuthenticationMode=" | awk -F = '{print $2}'`
	local PreSharedKey=`echo "${IPSecInstContent}" | grep ".PreSharedKey=" | awk -F = '{print $2}'`
	local Certificates=`echo "${IPSecInstContent}" | grep ".Certificates=" | awk -F = '{print $2}'`
	local PerfectForwardSecrecy=`echo "${IPSecInstContent}" | grep ".PerfectForwardSecrecy=" | awk -F = '{print $2}'`
	local ConnectionMode=`echo "${IPSecInstContent}" | grep ".ConnectionMode=" | awk -F = '{print $2}'`
	local Phase1EncryptionAlgorithm=`echo "${IPSecInstContent}" | grep ".Phase1EncryptionAlgorithm=" | awk -F = '{print $2}'`
	local Phase1IntegrityAlgorithm=`echo "${IPSecInstContent}" | grep ".Phase1IntegrityAlgorithm=" | awk -F = '{print $2}'`
	local Phase1DiffieHellmanGroup=`echo "${IPSecInstContent}" | grep ".Phase1DiffieHellmanGroup=" | awk -F = '{print $2}'`
	local Phase1KeyLifeTime=`echo "${IPSecInstContent}" | grep ".Phase1KeyLifeTime=" | awk -F = '{print $2}'`
	local Phase2EncryptionAlgorithm=`echo "${IPSecInstContent}" | grep ".Phase2EncryptionAlgorithm=" | awk -F = '{print $2}'`
	local Phase2IntegrityAlgorithm=`echo "${IPSecInstContent}" | grep ".Phase2IntegrityAlgorithm=" | awk -F = '{print $2}'`
	local Phase2DiffieHellmanGroup=`echo "${IPSecInstContent}" | grep ".Phase2DiffieHellmanGroup=" | awk -F = '{print $2}'`
	local Phase2KeyLifeTime=`echo "${IPSecInstContent}" | grep ".Phase2KeyLifeTime=" | awk -F = '{print $2}'`
	local ManualEncryptionAlgorithm=`echo "${IPSecInstContent}" | grep ".ManualEncryptionAlgorithm=" | awk -F = '{print $2}'`
	local ManualEncryptionKey=`echo "${IPSecInstContent}" | grep ".ManualEncryptionKey=" | awk -F = '{print $2}'`
	local ManualAuthenticationAlgorithm=`echo "${IPSecInstContent}" | grep ".ManualAuthenticationAlgorithm=" | awk -F = '{print $2}'`
	local ManualAuthenticationKey=`echo "${IPSecInstContent}" | grep ".ManualAuthenticationKey=" | awk -F = '{print $2}'`
	local ManualSPI=`echo "${IPSecInstContent}" | grep ".ManualSPI=" | awk -F = '{print $2}'`
	local LocalNet=""
	local RemoteNet=""
	local LocalNetPrefix=""
	local RemoteNetPrefix=""
	
	echo "mkdir -p ${IPSecInstDir}" >> $IPSECDBG
	mkdir -p ${IPSecInstDir}

	IPSEC_WAN_CODE=`gen_wanconn_folder ${WanConnection}`
	echo "IPSEC_WAN_CODE=$IPSEC_WAN_CODE" >> $IPSECDBG

	if [ "${LocalMode}" == "0" ]; then
		LocalNet=`get_net_from_ip $LocalIP $LocalMask`
		LocalNetPrefix=`ipsec_get_prefix_by_mask $LocalMask`
		LocalIP="$LocalNet/$LocalNetPrefix"		
	else
		LocalIP="$LocalIP/32"
	fi

	if [ "${RemoteMode}" == "0" ]; then
		RemoteNet=`get_net_from_ip $RemoteIP $RemoteMask`
		RemoteNetPrefix=`ipsec_get_prefix_by_mask $RemoteMask`
		RemoteIP="$RemoteNet/$RemoteNetPrefix"
	else
		RemoteIP="$RemoteIP/32"
	fi

	if [ -f ${STOPSH} ]; then
		echo "${STOPSH}" >> $IPSECDBG
		${STOPSH}
	fi

	#ip route add $RemoteIP via ${IPSEC_WAN_CODE}
	echo "ip route add $RemoteIP via ${IPSEC_WAN_CODE}" > ${STARTSH}

	#ip route del $RemoteIP via ${IPSEC_WAN_CODE}
	echo "ip route del $RemoteIP via ${IPSEC_WAN_CODE}" > ${STOPSH}

	if [ "${TunnelMode}" == "ESP" ]; then
		tunnel_mode="esp"
	else
		tunnel_mode="ah"
	fi

	#SPD Configuration
	echo "spdadd $RemoteIP[any] $LocalIP[any] any" > $IPSECSETKEYCFG
	echo "    -P in ipsec ${tunnel_mode}/tunnel/$RemoteGatewayAddress-$IPSEC_WAN_CODE/require;" >> $IPSECSETKEYCFG
	echo "spdadd $LocalIP[any] $RemoteIP[any] any" >> $IPSECSETKEYCFG
	echo "    -P out ipsec ${tunnel_mode}/tunnel/$IPSEC_WAN_CODE-$RemoteGatewayAddress/require;" >> $IPSECSETKEYCFG

	if [ "${KeyMode}" == "Manual" ]; then

		if [ "${ManualEncryptionAlgorithm}" == "DES" ]; then
			EncryptionAlgorithm="des-cbc"
		fi
		if [ "${ManualEncryptionAlgorithm}" == "3DES" ]; then
			EncryptionAlgorithm="3des-cbc"
		fi
		if [ "${ManualEncryptionAlgorithm}" == "AES(aes-cbc)" ]; then
			EncryptionAlgorithm="aes-cbc"
		fi

		if [ "${ManualAuthenticationAlgorithm}" == "MD5" ]; then
			AuthenticationAlgorithm="md5"
		fi
		if [ "${ManualAuthenticationAlgorithm}" == "SHA1" ]; then
			AuthenticationAlgorithm="sha1"
		fi

		echo "add $RemoteGatewayAddress $IPSEC_WAN_CODE ${tunnel_mode} ${ManualSPI} -m tunnel" >> $IPSECSETKEYCFG
		echo "    -E ${EncryptionAlgorithm} \"${ManualEncryptionKey}\" -A hmac-${AuthenticationAlgorithm} \"${ManualAuthenticationKey}\";" >> $IPSECSETKEYCFG
		echo "add $IPSEC_WAN_CODE $RemoteGatewayAddress ${tunnel_mode} ${ManualSPI} -m tunnel" >> $IPSECSETKEYCFG
		echo "    -E ${EncryptionAlgorithm} \"${ManualEncryptionKey}\" -A hmac-${AuthenticationAlgorithm} \"${ManualAuthenticationKey}\";" >> $IPSECSETKEYCFG

	else
		if [ "${KeyMode}" != "Auto" ]; then
			return

		fi

		#CERT dir deal
		mkdir -p ${IPSECPATHCERT}

		# psk.txt
		# 192.168.100.xxx 0x123456
		echo "${RemoteGatewayAddress} ${PreSharedKey}" > $IPSECPSK

		# racoon.conf
		echo "remote ${RemoteGatewayAddress} {" > $IPSECRACOON

		if [ "${ConnectionMode}" == "Main" ]; then
			exc_mode="main"
		else
			exc_mode="aggressive"
		fi

		if [ "${Phase1DiffieHellmanGroup}" == "768bit" ]; then
			Phase1DiffieHellmanGroup="1"
		fi
		if [ "${Phase1DiffieHellmanGroup}" == "1024bit" ]; then
			Phase1DiffieHellmanGroup="2"
		fi
		if [ "${Phase1DiffieHellmanGroup}" == "1536bit" ]; then
			Phase1DiffieHellmanGroup="5"
		fi
		if [ "${Phase1DiffieHellmanGroup}" == "2048bit" ]; then
			Phase1DiffieHellmanGroup="14"
		fi

		if [ "${Phase2DiffieHellmanGroup}" == "768bit" ]; then
			Phase2DiffieHellmanGroup="1"
		fi
		if [ "${Phase2DiffieHellmanGroup}" == "1024bit" ]; then
			Phase2DiffieHellmanGroup="2"
		fi
		if [ "${Phase2DiffieHellmanGroup}" == "1536bit" ]; then
			Phase2DiffieHellmanGroup="5"
		fi
		if [ "${Phase2DiffieHellmanGroup}" == "2048bit" ]; then
			Phase2DiffieHellmanGroup="14"
		fi

		#echo "    exchange_mode main, aggressive, base;" >> $IPSECRACOON
		echo "    exchange_mode ${exc_mode};" >> $IPSECRACOON
		echo "    proposal_check obey;" >> $IPSECRACOON
		echo "    rekey on;" >> $IPSECRACOON
		echo "    nat_traversal on;" >> $IPSECRACOON
		echo "    dpd_delay 10;" >> $IPSECRACOON
		echo "    proposal {" >> $IPSECRACOON

		if [ "${Phase1EncryptionAlgorithm}" == "DES" ]; then
			Phase1EncryptionAlgorithm="des"
		fi
		if [ "${Phase1EncryptionAlgorithm}" == "3DES" ]; then
			Phase1EncryptionAlgorithm="3des"
		fi
		if [ "${Phase1EncryptionAlgorithm}" == "AES" ]; then
			Phase1EncryptionAlgorithm="aes"
		fi
		echo "        encryption_algorithm ${Phase1EncryptionAlgorithm};" >> $IPSECRACOON

		if [ "${Phase1IntegrityAlgorithm}" == "MD5" ]; then
			Phase1IntegrityAlgorithm="md5"
		fi
		if [ "${Phase1IntegrityAlgorithm}" == "SHA1" ]; then
			Phase1IntegrityAlgorithm="sha1"
		fi
		echo "        hash_algorithm ${Phase1IntegrityAlgorithm};" >> $IPSECRACOON
		echo "        authentication_method pre_shared_key;" >> $IPSECRACOON
		echo "        dh_group ${Phase1DiffieHellmanGroup};" >> $IPSECRACOON
		echo "        lifetime time ${Phase1KeyLifeTime} sec;" >> $IPSECRACOON
		echo "    }" >> $IPSECRACOON
		echo "}" >> $IPSECRACOON

		echo "sainfo address $LocalIP any address $RemoteIP any {" >> $IPSECRACOON

		if [ "${Phase2EncryptionAlgorithm}" == "DES" ]; then
			Phase2EncryptionAlgorithm="des"
		fi
		if [ "${Phase2EncryptionAlgorithm}" == "3DES" ]; then
			Phase2EncryptionAlgorithm="3des"
		fi
		if [ "${Phase2EncryptionAlgorithm}" == "AES" ]; then
			Phase2EncryptionAlgorithm="aes"
		fi
		echo "    encryption_algorithm ${Phase2EncryptionAlgorithm};" >> $IPSECRACOON

		if [ "${Phase2IntegrityAlgorithm}" == "MD5" ]; then
			Phase2IntegrityAlgorithm="hmac_md5"
		fi
		if [ "${Phase2IntegrityAlgorithm}" == "SHA1" ]; then
			Phase2IntegrityAlgorithm="hmac_sha1"
		fi
		echo "    authentication_algorithm ${Phase2IntegrityAlgorithm};" >> $IPSECRACOON
		echo "    compression_algorithm deflate;" >> $IPSECRACOON
		if [ "${PerfectForwardSecrecy}" == "Enable" ]; then
			#echo "    pfs_group modp768;" >> $IPSECRACOON
			echo "    pfs_group 1;" >> $IPSECRACOON
		fi
		#echo "    dh_group ${Phase2DiffieHellmanGroup};" >> $IPSECRACOON
		echo "    lifetime time ${Phase2KeyLifeTime} sec;" >> $IPSECRACOON
		echo "}" >> $IPSECRACOON
	fi

	#iptables -A ${IPSEC_VPN} -p ah -s ${RemoteGatewayAddress} -d $IPSEC_WAN_CODE -j ACCEPT
	#iptables -A ${IPSEC_VPN} -p esp -s ${RemoteGatewayAddress} -d $IPSEC_WAN_CODE -j ACCEPT
	if [ "${TunnelMode}" == "ESP" ]; then
		echo "iptables -A ${IPSEC_VPN} -p esp -s ${RemoteGatewayAddress} -d $IPSEC_WAN_CODE -j ACCEPT" >> ${STARTSH}
		echo "iptables -D ${IPSEC_VPN} -p esp -s ${RemoteGatewayAddress} -d $IPSEC_WAN_CODE -j ACCEPT" >> ${STOPSH}
	else
		echo "iptables -A ${IPSEC_VPN} -p ah -s ${RemoteGatewayAddress} -d $IPSEC_WAN_CODE -j ACCEPT" >> ${STARTSH}
		echo "iptables -D ${IPSEC_VPN} -p ah -s ${RemoteGatewayAddress} -d $IPSEC_WAN_CODE -j ACCEPT" >> ${STOPSH}
	fi
	
	echo "iptables -A ${IPSEC_VPN} -p udp -m udp --sport 500 --dport  500 -s ${RemoteGatewayAddress} -d $IPSEC_WAN_CODE -j ACCEPT" >> ${STARTSH}
	echo "iptables -D ${IPSEC_VPN} -p udp -m udp --sport 500 --dport  500 -s ${RemoteGatewayAddress} -d $IPSEC_WAN_CODE -j ACCEPT" >> ${STOPSH}

	#iptables -A ${FWD_IPSEC_VPN} -s ${RemoteIP} -d ${LocalIP} -m policy --mode tunnel --dir in --tunnel-src ${RemoteGatewayAddress} --tunnel-dst $IPSEC_WAN_CODE -j ACCEPT
	echo "iptables -A ${FWD_IPSEC_VPN} -s ${RemoteIP} -d ${LocalIP} -m policy --mode tunnel --dir in --tunnel-src ${RemoteGatewayAddress} --tunnel-dst $IPSEC_WAN_CODE -j ACCEPT" >> ${STARTSH}
	echo "iptables -D ${FWD_IPSEC_VPN} -s ${RemoteIP} -d ${LocalIP} -m policy --mode tunnel --dir in --tunnel-src ${RemoteGatewayAddress} --tunnel-dst $IPSEC_WAN_CODE -j ACCEPT" >> ${STOPSH}

	#conntrack -F
	echo "conntrack -F" >> ${STARTSH}

	#iptables -t nat -A ${IPSEC_VPN} -s ${LocalIP} -d ${RemoteIP} -j ACCEPT
	echo "iptables -t nat -A ${IPSEC_VPN} -s ${LocalIP} -d ${RemoteIP} -j ACCEPT" >> ${STARTSH}
	echo "iptables -t nat -D ${IPSEC_VPN} -s ${LocalIP} -d ${RemoteIP} -j ACCEPT" >> ${STOPSH}

	chmod +x ${STARTSH}
	chmod +x ${STOPSH}
}

ipsec_cfg_sh_gen_all()
{
	local IPSEC_BASIC_PATH="InternetGatewayDevice.Services.X_TRI_IPSec"

	cfgcmd get ${IPSEC_BASIC_PATH}. | grep ".TunnelName=" | (while read line ;
	do
		local IPSecINSTPath=`echo "${line}" | awk -F . '{print $1"."$2"."$3"."$4"."$5}'` ;
		echo "ipsec_cfg_sh_gen_all : IPSecINSTPath=${IPSecINSTPath}" >> $IPSEC_DBG ;
		ipsec_cfg_sh_gen ${IPSecINSTPath} ;
	done )
}

ipsec_cfg_run()
{
	local IPSEC_BASIC_PATH="InternetGatewayDevice.Services.X_TRI_IPSec"
	local IPSEC_PSK=${IPSecRunDir}psk.txt
	local IPSEC_PATHCERT=${IPSecRunDir}cert
	local IPSEC_RACOON=${IPSecRunDir}racoon.conf
	local IPSEC_SETKEYCFG=${IPSecRunDir}setkey.conf

	if [ -f ${IPSEC_PSK} ]; then
		rm -f ${IPSEC_PSK}
	fi

	local RACOON_INFO=`ps | grep racoon | grep -v grep`
	if [ "${RACOON_INFO}" != "" ]; then
		killall -9 racoon
		sleep 1
	fi

	echo "flush; spdflush;" > ${IPSEC_SETKEYCFG}
	echo "path pre_shared_key \"${IPSEC_PSK}\";" > ${IPSEC_RACOON}
	echo "path certificate \"${IPSEC_PATHCERT}\";" >> ${IPSEC_RACOON}

	local HardWare_Setup_File="/tmp/.ipsec_cfg_run.HardWare_Setup"
	echo "0" > ${HardWare_Setup_File}

	cfgcmd get ${IPSEC_BASIC_PATH}. | grep ".WanConnection=" | (while read line ;
	do
		local WanConnection=`echo "${line}" | grep ".WanConnection=" | awk -F = '{print $2}'`
		echo "ipsec_cfg_run : WanConnection=${WanConnection}" >> $IPSEC_DBG
		IPSEC_WAN_CODE=`gen_wanconn_folder ${WanConnection}`
		echo "ipsec_cfg_run : IPSEC_WAN_CODE=${IPSEC_WAN_CODE}" >> $IPSEC_DBG
		wan_up=`is_wan_up ${IPSEC_WAN_CODE}`
		echo "ipsec_cfg_run : wan_up=${wan_up}" >> $IPSEC_DBG
		if [ "${wan_up}" == "0" ]; then
			continue
		fi
		wan_ip=`get_wan_ip ${IPSEC_WAN_CODE}`
		echo "ipsec_cfg_run : wan_ip=${wan_ip}" >> $IPSEC_DBG
		if [ -z "${wan_ip}" ]; then
			continue
		fi
		echo "1" > ${HardWare_Setup_File}

		local IPSecInstNum=`echo ${line} | awk -F . '{print $5}'`
		local IPSecInstDir="${IPSecRunDir}ipsec${IPSecInstNum}/"
		local IPSECPSK="${IPSecInstDir}psk.txt"
		local IPSECPATHCERT="${IPSecInstDir}cert"
		local IPSECRACOON="${IPSecInstDir}racoon.conf"
		local IPSECSETKEYCFG="${IPSecInstDir}setkey.conf"

		sed -i "s/${IPSEC_WAN_CODE}/${wan_ip}/g" ${IPSECSETKEYCFG}

		if [ -f ${IPSECPSK} ]; then
			cat ${IPSECPSK} >> ${IPSEC_PSK}
		fi
		if [ -f ${IPSECRACOON} ]; then
			cat ${IPSECRACOON} >> ${IPSEC_RACOON}
		fi
		if [ -f ${IPSECSETKEYCFG} ]; then
			cat ${IPSECSETKEYCFG} >> ${IPSEC_SETKEYCFG}
		fi
	done )

	local HardWare_Setup=`cat ${HardWare_Setup_File}`
	rm -f ${HardWare_Setup_File}

	echo "ipsec_cfg_run : HardWare_Setup=${HardWare_Setup}" >> $IPSEC_DBG
	if [ "${HardWare_Setup}" != "0" ]; then
		echo 2 > /proc/irq/121/smp_affinity
	else
		echo 1 > /proc/irq/121/smp_affinity
		if [ -f ${IPSEC_PSK} ]; then
			rm -f ${IPSEC_PSK}
		fi
		if [ -f ${IPSEC_RACOON} ]; then
			rm -f ${IPSEC_RACOON}
		fi
		if [ -f ${IPSEC_SETKEYCFG} ]; then
			rm -f ${IPSEC_SETKEYCFG}
		fi
	fi

	if [ -f ${IPSEC_SETKEYCFG} ]; then
		echo "setkey -f ${IPSEC_SETKEYCFG}" >> $IPSEC_DBG
		setkey -f ${IPSEC_SETKEYCFG}
	fi

	if [ -f ${IPSEC_PSK} -a -f ${IPSEC_RACOON} ]; then
		chmod 600 ${IPSEC_PSK}
		echo "racoon -f ${IPSEC_RACOON} &" >> $IPSEC_DBG
		racoon -f ${IPSEC_RACOON} &
	fi
}

ipsec_sh_run()
{
	local IPSecInstPath=$1
	local IPSecInstRunType=$2
	local IPSecInstNum=`echo ${IPSecInstPath} | awk -F . '{print $5}'`
	local IPSecInstDir="${IPSecRunDir}ipsec${IPSecInstNum}/"
	local IPSECDBG="${IPSecRunDir}Dbg/ipsec${IPSecInstNum}"

	local WanConnection=`cfgcmd get ${IPSecInstPath}.WanConnection`
	echo "ipsec_sh_run : WanConnection=${WanConnection}" >> $IPSECDBG
	IPSEC_WAN_CODE=`gen_wanconn_folder ${WanConnection}`
	echo "ipsec_sh_run : IPSEC_WAN_CODE=${IPSEC_WAN_CODE}" >> $IPSECDBG
	wan_up=`is_wan_up ${IPSEC_WAN_CODE}`
	echo "ipsec_sh_run : wan_up=${wan_up}" >> $IPSECDBG
	wan_ip=`get_wan_ip ${IPSEC_WAN_CODE}`
	echo "ipsec_sh_run : wan_ip=${wan_ip}" >> $IPSECDBG

	local STOPSH="${IPSecInstDir}stop.sh"
	local STARTSH="${IPSecInstDir}start.sh"

	if [ "${IPSecInstRunType}" == "stop" ]; then
		echo "run stop : ${STOPSH}" >> $IPSECDBG
		${STOPSH}
	fi
	if [ "${IPSecInstRunType}" == "start" ]; then
		if [ "${wan_up}" == "0" -o -z "${wan_ip}" ]; then
			echo "ipsec_sh_run : error wan no ip" >> $IPSECDBG

			return
		fi
		sed -i "s/${IPSEC_WAN_CODE}/${wan_ip}/g" ${STARTSH}
		sed -i "s/${IPSEC_WAN_CODE}/${wan_ip}/g" ${STOPSH}
		echo "run start : ${STARTSH}" >> $IPSECDBG
		${STARTSH}
	fi
	if [ "${IPSecInstRunType}" == "auto" ]; then
		if [ "${wan_up}" == "0" -o -z "${wan_ip}" ]; then
			echo "run auto : ${STOPSH}" >> $IPSECDBG
			${STOPSH}
		else
			sed -i "s/${IPSEC_WAN_CODE}/${wan_ip}/g" ${STARTSH}
			sed -i "s/${IPSEC_WAN_CODE}/${wan_ip}/g" ${STOPSH}
			echo "run auto : ${STARTSH}" >> $IPSECDBG
			${STARTSH}
		fi
	fi
}

ipsec_clear_dbg()
{
	rm -f ${IPSecRunDir}Dbg/*
}

ipsec_sh_run_all()
{
	local IPSecInstRunType=$1
	local IPSEC_BASIC_PATH="InternetGatewayDevice.Services.X_TRI_IPSec"

	cfgcmd get ${IPSEC_BASIC_PATH}. | grep ".TunnelName=" | (while read line ;
	do
		local IPSecINSTPath=`echo "${line}" | awk -F . '{print $1"."$2"."$3"."$4"."$5}'` ;
		echo "ipsec_sh_run_all : IPSecINSTPath=${IPSecINSTPath}" >> $IPSEC_DBG ;
		ipsec_sh_run ${IPSecINSTPath} ${IPSecInstRunType} ;
	done )
}

ipsec_cfg_set()
{
	ipsec_cfg_sh_gen ${Path}

	ipsec_sh_run ${Path} "start"
	ipsec_cfg_run
}

ipsec_cfg_del()
{
	ipsec_sh_run ${Path} "stop"
	ipsec_cfg_run

	local IPSecInstNum=`echo ${Path} | awk -F . '{print $5}'`
	local IPSecInstDir="${IPSecRunDir}ipsec${IPSecInstNum}/"
	rm -rf ${IPSecInstDir}
}

case "$1" in
	"init")
		echo "init .." >> $IPSEC_DBG
		ipsec_cfg_sh_gen_all
		;;
	"set")
		echo "set ..." >> $IPSEC_DBG
		ipsec_cfg_set
		;;
	"add")
		echo "add ..." >> $IPSEC_DBG
		ipsec_cfg_set
		;;
	"del")
		echo "del ..." >> $IPSEC_DBG
		ipsec_cfg_del
		;;
	"ifup")
		ipsec_clear_dbg
		echo "ifup .." >> $IPSEC_DBG
		sleep 2
		ipsec_sh_run_all "start"
		ipsec_cfg_run
		;;
	"ifdown")
		echo "ifdn .." >> $IPSEC_DBG
		sleep 2
		ipsec_sh_run_all "stop"
		ipsec_cfg_run
		;;
	*)
		;;
esac
rm -f ${ipsec_lock_flag}
