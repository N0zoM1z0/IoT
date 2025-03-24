####################################################################
# this script was used to generate the real udhcpc.sh
# udhcpc.sh will be called by udhcpc when udhcpc release/renew/bound
####################################################################

. /usr/syscfg/wan.comm.param.sh
. /usr/syscfg/wan.utils.sh

####################################################################
[ -z "$1" ] && echo "Error: should be called from udhcpc" && exit 1
#RESOLV_CONF="/etc/resolv.conf"
[ -n "$broadcast" ] && BROADCAST="broadcast $broadcast"
if [ -n "$ConnType" ]; then
	[ -n "$subnet" ] && NETMASK="$subnet"
else
	[ -n "$subnet" ] && NETMASK="netmask $subnet"
fi

case "$1" in
deconfig)
	#non Con_Bridged Mode
	if [ -z "$ConnType" ]; then
		ifconfig $interface 0.0.0.0
	fi
	if [ -f ${uptime_file_path} ]; then
		${wan_servicelist_path} action=stop ipmode=ipv4 path=${path}
		rm -f ${uptime_file_path}
		#this means dhcp already up.
		rm -f ${gateway_file_path}
		rm -f ${server_assigned_dns_path}
		rm -f ${dhcp_leasetime_path}
		rm -f ${server_assigned_tftp_addr_path}
	fi
	#create release_done_flag file
	touch ${release_done_flag_path} 
	;;

renew|bound)
	if [ "$1" == "renew" ]; then
		return
	fi
	[ -z "$ConnType" ] && ifconfig $interface $ip $BROADCAST $NETMASK
	write_file "${ip_address_path}" "${ip}"
	[ -n "$ConnType" ] && write_file "${ip_mask_path}" "${NETMASK}"
	#delete release_done_flag file
	rm -f ${release_done_flag_path}
	#save current uptime to uptime_file_path
	gen_uptime_file ${uptime_file_path}
	#save dhcp lease time
	echo $lease > ${dhcp_leasetime_path}
	#save gateway
	if [ -n "$router" ]; then
		local gw=""
		#only use the first address in $router as gateway
		for i in $router ; do
			if [ "${gw}" == "" ]; then
				gw=$i
			fi
		done
		echo "[$0] write gateway $gw to ${gateway_file_path}"
		write_file ${gateway_file_path} ${gw}
	else
		echo "[$0] router is empty!"
	fi
	#if [ -n "$router" ] ; then
	#    echo "deleting routers"
	#    while route del default gw 0.0.0.0 dev $interface ; do
	#        :
	#    done
	#    metric=0
	#    for i in $router ; do
	#        metric=`expr $metric + 1`
	#        route add default gw $i dev $interface metric $metric
	#    done
	#fi
	#save server assigned dns
	if [ -n "$dns" ]; then
		gen_dns_file ${server_assigned_dns_path} "$dns"
	fi
	#save server assigned tftp addr
	if [ -n "$tftp" ]; then
		write_file ${server_assigned_tftp_addr_path} ${tftp}
	fi
	#save domain
	#$[ -n "$domain" ] && echo "search $domain" >>/tmp/domain

	## Con_Bridged Mode add wan if ip to brvlan*
	if [ -n "$ConnType" ]; then
		brIf=`cat ${conn_folder}/ConBrOutIf`
		ip addr add $ip/$NETMASK $BROADCAST dev "$brIf"
	else
		#support hardware accelerate
		cs_cli /home/cli/api/intf/setip -v ifname $interface ip $ip
	fi
	${wan_servicelist_path} action=start ipmode=ipv4 path=${path}
	${wan_status_update_path} path=${path}
        ;;
esac

exit 0

