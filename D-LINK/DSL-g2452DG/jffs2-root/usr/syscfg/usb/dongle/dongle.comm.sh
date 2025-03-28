
local Prepare_Direct="/var/peers"
local PPP_Config=${Prepare_Direct}"/air"
local PPP_DEF_ROUTE=${Prepare_Direct}"/ppp_default_route.sh"
local PPP_RESOLV=${Prepare_Direct}"/resolv.conf"
local BASE_URL="InternetGatewayDevice.WANDevice.3"
local X_BASE_URL=${BASE_URL}".WANConnectionDevice.1.WANPPPConnection.1"
local X_TRI_USER=${X_BASE_URL}".Username"
local X_TRI_PASSWD=${X_BASE_URL}".Password"
local X_TRI_APN=${X_BASE_URL}".X_TRI_APN"
local X_TRI_PIN=${X_BASE_URL}".X_TRI_PIN"
local X_TRI_DialNumber=${X_BASE_URL}".X_TRI_DialNumber"
local X_TRI_DialDelay=${X_BASE_URL}".X_TRI_DialDelay"
local CanBeDial=${X_BASE_URL}".Enable"

local APN=""
local DialNumber=""
local DialDelay=""
local USER=""
local PASSWD=""

local ECHO="/bin/echo"
local SLEEP="/bin/sleep"
local KILL="/bin/kill"
local PPPD="/usr/sbin/pppd file"
local PS="/bin/ps"
local CUT="/usr/bin/cut"
local GREP="/bin/grep"
local MKDIR="/bin/mkdir -p"
local RM="/bin/rm -rf"
local BASENAME="/usr/bin/basename"
local IP="/usr/sbin/ip"
local CHMOD="/bin/chmod"

local GET_NODE="/usr/sbin/cfgcmd get"
local Dongle_Clear="/usr/syscfg/usb/dongle/dongle.sh stop"
