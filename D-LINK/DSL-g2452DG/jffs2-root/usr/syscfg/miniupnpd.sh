#!/bin/sh
. /usr/syscfg/wan.utils.sh
Usage()
{
	echo "Usage: $0 <command> <node>"
	echo "  <command>: "
	echo "		  upnp_server    - minupnpd server "
	echo "		  blacklist_init - miniupnpd blacklist init"
	echo "            blacklist_set  - miniupnpd blacklist set"
	echo "            blacklist_add  - miniupnpd blacklist add"
	echo "            blacklist_del  - miniupnpd blacklist del"
	echo "Example:"
	echo "	$0 upnp_server"
	echo "	$0 blacklist_init"
	echo "  $0 blacklist_add 1"
	echo "  $0 blacklist_set 1"
	echo "  $0 blacklist_del 1"
	exit 1
}

IPTABLES=/usr/sbin/iptables
UPNP_PATH=InternetGatewayDevice.DeviceInfo.X_CT-COM_UPNP
WAN_IF_PATH=`/usr/sbin/cfgcmd get ${UPNP_PATH}.WANPathName`
WAN_IF_FOLDER=`gen_wanconn_folder $WAN_IF_PATH`
WAN_IF=`get_wanconn_ifname ${WAN_IF_FOLDER}`
LAN_IF_PATH=`/usr/sbin/cfgcmd get ${UPNP_PATH}.LANPathName`
LAN_IPADDR="br0"
MINIUPNPD_FILE=/tmp/miniupnpd.conf
IGD=`/usr/sbin/cfgcmd get ${UPNP_PATH}.Enable`
PORT=0

SW_VER=`/usr/sbin/cfgcmd get InternetGatewayDevice.DeviceInfo.SoftwareVersion`
MANUFACTURER=`/usr/sbin/cfgcmd get InternetGatewayDevice.DeviceInfo.Manufacturer`
MODEL_NAME=`/usr/sbin/cfgcmd get InternetGatewayDevice.DeviceInfo.ModelName`
MODEL_DESC=`/usr/sbin/cfgcmd get InternetGatewayDevice.DeviceInfo.Description`
MODEL_URL=`/usr/sbin/cfgcmd get InternetGatewayDevice.DeviceInfo.ModelURL`
MODEL_NUM=`/usr/sbin/cfgcmd get InternetGatewayDevice.DeviceInfo.ModelNum`
SERIAL_NUMBER=`/usr/sbin/cfgcmd get InternetGatewayDevice.DeviceInfo.SerialNumber`

OS_NAME=`echo $MANUFACTURER | awk '{print $1}'`

upnp_remove()
{
	killall -q miniupnpd 1>/dev/null 2>&1
	rm /tmp/$MINIUPNPD_FILENAME 1>/dev/null 2>&1

	$IPTABLES -t nat -F MINIUPNPD 1>/dev/null 2>&1
#rmeoving the rule to MINIUPNPD
	$IPTABLES -t nat -D PREROUTING -i $WAN_IF -j MINIUPNPD 1>/dev/null 2>&1
	$IPTABLES -t nat -X MINIUPNPD 1>/dev/null 2>&1

#removing the MINIUPNPD chain for filter
	$IPTABLES -t filter -F MINIUPNPD 1>/dev/null 2>&1
#adding the rule to MINIUPNPD
	$IPTABLES -t filter -D FORWARD -i $WAN_IF ! -o $WAN_IF -j MINIUPNPD 1>/dev/null 2>&1
	$IPTABLES -t filter -X MINIUPNPD 1>/dev/null 2>&1
}

upnp_init()
{
	$IPTABLES -t nat -N MINIUPNPD
	$IPTABLES -t nat -A PREROUTING -i $WAN_IF -j MINIUPNPD
	$IPTABLES -t filter -N MINIUPNPD
	$IPTABLES -t filter -I FORWARD 9 -i $WAN_IF ! -o $WAN_IF -j MINIUPNPD

	echo "ext_ifname=$WAN_IF

listening_ip=$LAN_IPADDR

port=$PORT

bitrate_up=800000000
bitrate_down=100000000

secure_mode=no

system_uptime=yes

notify_interval=30

uuid=68555350-3352-3883-2883-335030522880

serial=$SERIAL_NUMBER

friendly_name=$MODEL_DESC
manufacturer_name=$MANUFACTURER
manufacturer_url=$MODEL_URL
model_name=$MODEL_NAME
model_description=$MODEL_DESC
model_number=$MODEL_NUM
model_url=$MODEL_URL

enable_upnp=yes

" > $MINIUPNPD_FILE

	/usr/sbin/miniupnpd -f $MINIUPNPD_FILE

}

BLACKLIST_PATH=${UPNP_PATH}.Blacklist
BlacklistEntries=${UPNP_PATH}.BlacklistNumberOfEntries
count=`/usr/sbin/cfgcmd get_max_obj $BLACKLIST_PATH`

blacklist_clear()
{

	if [ ${IGD} == 1 ]; then
		i=1
		while [ $i -le $count ]
		do
			blacklist_enable=`/usr/sbin/cfgcmd get ${BLACKLIST_PATH}.${i}.Enable`
			if [ ${blacklist_enable} == 1 ]; then
				
				/tmp/upnp_blacklist/${i}_del.sh
			fi
			i=`/usr/bin/expr $i + 1`
		done
	
	fi


}




blacklist_init()
{
	if [ ! -d "/tmp/upnp_blacklist" ]; then
	/bin/mkdir /tmp/upnp_blacklist
	fi
	i=1
	while [ $i -le $count ]
	do
		blacklist_enable=`/usr/sbin/cfgcmd get ${BLACKLIST_PATH}.${i}.Enable`
		blacklist_srcip=`/usr/sbin/cfgcmd get ${BLACKLIST_PATH}.${i}.SrcIP`
		if [ ! -f "/tmp/upnp_blacklist/${i}_add.sh" ]; then
			
			echo "/usr/sbin/iptables -I upnp_blacklist -s ${blacklist_srcip} -j DROP" > /tmp/upnp_blacklist/${i}_add.sh
			/bin/chmod 777 /tmp/upnp_blacklist/${i}_add.sh
			
			echo "/usr/sbin/iptables -D upnp_blacklist -s ${blacklist_srcip} -j DROP" > /tmp/upnp_blacklist/${i}_del.sh
			/bin/chmod 777 /tmp/upnp_blacklist/${i}_del.sh
		fi
		i=`/usr/bin/expr $i + 1`
	done
	if [ ${IGD} == 1 ]; then
		i=1
		while [ $i -le $count ]
		do
			blacklist_enable=`/usr/sbin/cfgcmd get ${BLACKLIST_PATH}.${i}.Enable`
			if [ ${blacklist_enable} == 1 ]; then
				
				/tmp/upnp_blacklist/${i}_add.sh
			fi
			i=`/usr/bin/expr $i + 1`
		done
	
	fi
}

blacklist_set()
{
	/tmp/upnp_blacklist/${1}_del.sh

	enable=`/usr/sbin/cfgcmd get ${BLACKLIST_PATH}.${1}.Enable`
	
	srcip=`/usr/sbin/cfgcmd get ${BLACKLIST_PATH}.${1}.SrcIP`
	
	echo "/usr/sbin/iptables -I upnp_blacklist -s ${srcip} -j DROP" > /tmp/upnp_blacklist/${1}_add.sh
	
	echo "/usr/sbin/iptables -D upnp_blacklist -s ${srcip} -j DROP" > /tmp/upnp_blacklist/${1}_del.sh

	if [ ${enable} == 1 ]; then
		
		/tmp/upnp_blacklist/${1}_add.sh

	fi
}

blacklist_add()
{
	touch /tmp/upnp_blacklist/${1}_add.sh
	/bin/chmod 777 /tmp/upnp_blacklist/${1}_add.sh

	touch /tmp/upnp_blacklist/${1}_del.sh
	/bin/chmod 777 /tmp/upnp_blacklist/${1}_del.sh
}

blacklist_del()
{
	/tmp/upnp_blacklist/${1}_del.sh
	rm -f /tmp/upnp_blacklist/${1}_del.sh
	rm -f /tmp/upnp_blacklist/${1}_add.sh
}
if [ "$1" == "upnp_server" ]; then
	if [ "$IGD" == "1" ]; then
		upnp_remove
		upnp_init	

	elif [ "$IGD" == "0" ]; then
		upnp_remove
	fi	
elif [ "$1" == "remove" ]; then
	upnp_remove
elif [ "$1" == "blacklist_init" ]; then
		blacklist_clear
		blacklist_init

elif [ "$1" == "blacklist_set" ]; then


	if [ "${IGD}" == "1" ]; then
		set_num=`echo "$2" | cut -d . -f 5`
		blacklist_set $set_num
	else 
		echo "upnp is disable, can't run blacklist."	
		exit 1
	fi	

elif [ "$1" == "blacklist_add" ]; then

	if [ "${IGD}" == "1" ]; then
		blacklist_add $2
	else 
		echo "upnp is disable, can't run blacklist."	
		exit 1
	fi	
elif [ "$1" == "blacklist_del" ]; then

	if [ "${IGD}" == "1" ]; then
		blacklist_del $2
	else 
		echo "upnp is disable, can't run blacklist."	
		exit 1
	fi	
elif [ "$1" == "blacklist_num" ]; then
	/usr/sbin/cfgcmd sset ${BlacklistEntries} ${count}
else
	echo "unknown comand"
	Usage
	exit 1
fi
