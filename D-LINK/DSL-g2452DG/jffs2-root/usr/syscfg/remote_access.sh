#!/bin/sh

. /usr/syscfg/firewall.param.sh

for para in $*
do
	export $para
done

##################################################################

PATH_Rmnt="InternetGatewayDevice.X_TRI_RemoteAccess"
PATH_ServiceCtl="InternetGatewayDevice.Services.ServiceAccessControl"

servicectl_add_rule()
{
	local ServiceName=$1
	local Enable=$2
	local AccessDirection=$3
	local SrcIpRange=$4
	local Action=$5
	
	local newIdx=`cfgcmd add_obj ${PATH_ServiceCtl}.ServiceCtrlList` 
	cfgcmd set ${PATH_ServiceCtl}.ServiceCtrlList.${newIdx}.ServiceName "${ServiceName}"
	cfgcmd set ${PATH_ServiceCtl}.ServiceCtrlList.${newIdx}.Enable "${Enable}"
	cfgcmd set ${PATH_ServiceCtl}.ServiceCtrlList.${newIdx}.AccessDirection "${AccessDirection}"
	cfgcmd set ${PATH_ServiceCtl}.ServiceCtrlList.${newIdx}.Action "${Action}"	
	cfgcmd set ${PATH_ServiceCtl}.ServiceCtrlList.${newIdx}.SrcIpRange "${SrcIpRange}"
}
servicectl_enable_lan()
{
	#delete all of lan rules
	ipidx=`cfgcmd get_idxes ${PATH_ServiceCtl}.ServiceCtrlList`
	if [ "$ipidx" != "0" ]; then
		for idx in $ipidx ; do
			local AccessDirection=`cfgcmd get ${PATH_ServiceCtl}.ServiceCtrlList.${idx}.AccessDirection`
			if [ "$AccessDirection" == "LAN" ]; then
						cfgcmd del_obj ${PATH_ServiceCtl}.ServiceCtrlList.${idx}
			fi
		done
	fi
	servicectl_add_rule "HTTP" "1" "LAN" "" "ACCEPT"
	servicectl_add_rule "SNMP" "1" "LAN" "" "ACCEPT"
	servicectl_add_rule "TELNET" "1" "LAN" "" "ACCEPT"
	servicectl_add_rule "FTP" "1" "LAN" "" "ACCEPT"
	servicectl_add_rule "TFTP" "1" "LAN" "" "ACCEPT"
	servicectl_add_rule "SAMBA" "1" "LAN" "" "ACCEPT"
	servicectl_add_rule "ICMP" "1" "LAN" "" "ACCEPT"
	servicectl_add_rule "SSH" "1" "LAN" "" "ACCEPT"
}
remote_access_enable()
{
	servicectl_add_rule "ICMP" "1" "WAN" "" "ACCEPT"
	
	servicectl_add_rule "HTTP" "1" "WAN" "" "ACCEPT"
	servicectl_add_rule "SNMP" "1" "WAN" "" "ACCEPT"
	servicectl_add_rule "TELNET" "1" "WAN" "" "ACCEPT"		
}


remote_access_disable()
{
	#enable wan icmp
	servicectl_add_rule "ICMP" "1" "WAN" "" "ACCEPT"

	## allow wan ip range(port 80) as following: 
	ipidx=`cfgcmd get_idxes ${PATH_Rmnt}.RemoteIPList`
	if [ "$ipidx" != "0" ]; then
		for idx in $ipidx ; do
			local rmntip=`cfgcmd get ${PATH_Rmnt}.RemoteIPList.${idx}.RemoteIPAddress`
			servicectl_add_rule "HTTP" "1" "WAN" "${rmntip}" "ACCEPT"
		done
	fi
	servicectl_enable_lan
}
#rmnt enable: enable HTTP,SNMP,TELNET
#rmnt disable:enable ICMP,enable 7547 for tr069,enable HTTP for some ip,such as 110.164.252.0/24
remote_access()
{
	#delete all of wan telnet,http,icmp,snmp rules
	ipidx=`cfgcmd get_idxes ${PATH_ServiceCtl}.ServiceCtrlList`
	if [ "$ipidx" != "0" ]; then
		for idx in $ipidx ; do
			local ServiceName=`cfgcmd get ${PATH_ServiceCtl}.ServiceCtrlList.${idx}.ServiceName`
			local AccessDirection=`cfgcmd get ${PATH_ServiceCtl}.ServiceCtrlList.${idx}.AccessDirection`
			if [ "$AccessDirection" == "WAN" ]; then
					if [ "$ServiceName" == "HTTP" -o "$ServiceName" == "ICMP" -o "$ServiceName" == "TELNET" -o "$ServiceName" == "SNMP" ]; then
						cfgcmd del_obj ${PATH_ServiceCtl}.ServiceCtrlList.${idx}
					fi
			fi
		done
	fi
	
	rmntenable=`cfgcmd get ${PATH_Rmnt}.Enable`
	if [ "${rmntenable}" == "1" ]; then
		remote_access_enable
	else
		remote_access_disable
	fi
  cfgcmd oset ${PATH_ServiceCtl}.Enable "1"
}

remote_access
