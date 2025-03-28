#!/bin/sh

PPPOE_FILE=/etc/options.pppoe

if [ ! -n "$4" ]; then
  echo "insufficient arguments!"
  echo "Usage: $0 <user> <password> <eth_name> <opmode>"
  exit 0
fi

PPPOE_USER_NAME="$1"
PPPOE_PASSWORD="$2"
PPPOE_IF="$3"
PPPOE_OPMODE="$4"
PPPOE_IDLETIME="$5"

echo "noauth" > $PPPOE_FILE
echo "debug" >> $PPPOE_FILE
echo "user '$PPPOE_USER_NAME'" >> $PPPOE_FILE
echo "password '$PPPOE_PASSWORD'" >> $PPPOE_FILE
echo "hide-password" >> $PPPOE_FILE
echo "noipdefault" >> $PPPOE_FILE
echo "defaultroute" >> $PPPOE_FILE
echo "nodetach" >> $PPPOE_FILE
echo "usepeerdns" >> $PPPOE_FILE
if [ $PPPOE_OPMODE == "KeepAlive" ]; then
	echo "persist" >> $PPPOE_FILE
elif [ $PPPOE_OPMODE == "OnDemand" ]; then
	PPPOE_IDLETIME=`expr $PPPOE_IDLETIME \* 60`
	echo "demand" >> $PPPOE_FILE
	echo "idle $PPPOE_IDLETIME" >> $PPPOE_FILE
fi
mtuvalue=`nvram_get 2860 MTUpppoevalue`
echo "mtu $mtuvalue" >> $PPPOE_FILE
echo "mru $mtuvalue" >> $PPPOE_FILE
server_name=`nvram_get 2860 wan_pppoe_server`

echo "ipcp-accept-remote" >> $PPPOE_FILE 
echo "ipcp-accept-local" >> $PPPOE_FILE 
#echo "ipv6 ," >> $PPPOE_FILE
#echo "ipv6cp-accept-local" >> $PPPOE_FILE 
#echo "ipv6cp-use-persistent" >> $PPPOE_FILE 
echo "lcp-echo-failure 3" >> $PPPOE_FILE
echo "lcp-echo-interval 3" >> $PPPOE_FILE
echo "ktune" >> $PPPOE_FILE
echo "default-asyncmap nopcomp noaccomp" >> $PPPOE_FILE
echo "novj nobsdcomp nodeflate" >> $PPPOE_FILE
echo "plugin /etc_ro/ppp/plugins/rp-pppoe.so" >> $PPPOE_FILE
if [ "$server_name" != ""  ];then
    echo "rp_pppoe_service $server_name" >> $PPPOE_FILE
fi
echo "nic-$PPPOE_IF" >> $PPPOE_FILE
