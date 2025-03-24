#!/bin/sh
<? /* vi: set sw=4 ts=4: */
include "/htdocs/phplib/xnode.php";
include "/htdocs/phplib/phyinf.php";
include "/htdocs/webinc/config.php";
include "/htdocs/phplib/trace.php";
function add_each($list, $path, $node)
{
	$i = 0;
	$cnt = scut_count($list, "");
	while ($i < $cnt)
	{
		$val = scut($list, $i, "");
		if ($val!="") add($path."/".$node, $val);
		$i++;
	}
	return $cnt;
}

/*sam_pan add*/
function netbios_handler($SCOPE, $WINSTYPE,$WINS)
{							
	foreach("/dhcps4/entry")
	{
		$active       = query("netbios/active");
		$learnfromwan = query("netbios/learnfromwan");
		$old_scpoe    = query("netbios/scope");		
		$old_winstype = query("netbios/ntype");
		$old_win1     = query("wins/entry:1");
		$old_win2     = query("wins/entry:2");								
		$SCOPE        = strip($SCOPE);
		$WINSTYPE     = strip($WINSTYPE);
		$WINS         = strip($WINS);
								
		if($active == "1" && $learnfromwan == "1") 
		{																																												
			$winlist = $old_win1;
			if($old_win2!="")
			{
				$winlist= $winlist." ".$old_win2;			
			}
			
			//echo '\necho scope='.$SCOPE.' winstype='.$WINSTYPE.' winlist = '.$winlist.' wins ='.$WINS.'\n';
			if($old_scpoe == $SCOPE && $old_winstype == $WINSTYPE && $winlist == $WINS)
			{				
				return 0;	
			}	
			//echo '\necho netbios changed\n';
						
			set("netbios/scope", $SCOPE);
			set("netbios/ntype", $WINSTYPE);															 			
			del("wins/entry:1");	
			del("wins/entry:2");
			
			if($WINS == "") 
			{
				set("wins/count", 0);				
			}
			else
			{	
				$total_len = strlen($WINS);
				$sub_len = strstr($WINS, " ");			
				
				echo 'echo sublen'.$sub_len.'\n';					
				if($sub_len != "")
				{				
					$win1 = substr($WINS, 0, $sub_len);														
					$win2 = substr($WINS, $sub_len+1, $total_len - $sub_len-1); 														
					
					set("wins/count", 2);
					set("wins/entry:1", $win1);								
					set("wins/entry:2", $win2);				
					
				}
				else
				{			
					set("wins/count", 1);		
					set("wins/entry:1", $WINS);								
				}
			}				
			return 1;													 				
		}						
	}
	return 0;					
}

//jef add + for IP Collision check 
function ip_conflict_check($wan_ip, $wan_mask)
{
	include "/htdocs/phplib/phyinf.php";
	include "/htdocs/phplib/xnode.php";
	include "/htdocs/webinc/config.php";
	
	//TRACE_debug("ip_conflict_check wan_ip=".$wan_ip." mask=".$wan_mask);	
	//+++ Jerry Kao, added for DLNA test (must force the router into bridge mode).
	$layout = query("/device/layout");
	if ($layout == "bridge")
		return 0;

	$laninf = XNODE_getpathbytarget("", "inf", "uid", $LAN1, 0);
	$uid = query($laninf."/inet");
	
	foreach ("/inet/entry")
	{
		if (query("uid") == $uid)
		{
			$lan_ip = query("ipv4/ipaddr");
			$lan_mask = query("ipv4/mask");
		}
	}
	//TRACE_debug("ip_conflict_check lan_ip=".$lan_ip." mask=".$lan_mask);	
	$mask=$lan_mask;
	if($mask > $wan_mask) { $mask = $wan_mask; }
	
	$lan_network_addr = ipv4networkid($lan_ip, $mask);
	$wan_network_addr = ipv4networkid($wan_ip, $mask);
	//TRACE_debug("ip_conflict_check lan_network_addr=".$lan_network_addr." wan_network_addr=".$wan_network_addr);
	if($wan_network_addr == $lan_network_addr) 
	{ 
	    if(strstr($lan_network_addr,"172.16") != "")
		{return 4;}
	    else if($wan_mask < $lan_mask)
	        {return 3;}
	    else
	        {return 1;}
	}
	else
	{//check guest zone
			$guest_inf = XNODE_getpathbytarget("", "inf", "uid", $LAN2, 0);  //LAN2 is guest zone
			$uid = query($guest_inf."/inet");
			
			foreach ("/inet/entry")
			{
				if (query("uid") == $uid)
				{
					$guest_ip = query("ipv4/ipaddr");
					$guest_mask = query("ipv4/mask");
				}
			}
			//TRACE_debug("ip_conflict_check gzone_ip=".$guest_ip." mask=".$guest_mask);
			$guest_network_addr = ipv4networkid($guest_ip, $guest_mask);
			//TRACE_debug("ip_conflict_check guest_network_addr=".$guest_network_addr." wan_network_addr=".$wan_network_addr);
		if($wan_network_addr == $guest_network_addr) { return 2; }
	}
	return 0;
}

if ($ACTION=="bound")
{	
	$wan_mask = ipv4mask2int($SUBNET);
	
	$conflict = ip_conflict_check($IP, $wan_mask);
	
	//check whether syslog addr need change while lan ip be changed with ip cpnflict.
	$change_syslog = 0;
	if($conflict != "0" && $conflict != "2")
	{
		$syslog_ip = query("/device/log/remote/ipv4/ipaddr");
		TRACE_debug("syslog_ip=".$syslog_ip);

		if($syslog_ip != "")
		{
			$laninf = XNODE_getpathbytarget("", "inf", "uid", $LAN1, 0);
			$uid = query($laninf."/inet");
			
			foreach ("/inet/entry")
			{
				if (query("uid") == $uid)
				{
					$lan_ip = query("ipv4/ipaddr");
					$lan_mask = query("ipv4/mask");
				}
			}

			$lan_network_addr = ipv4networkid($lan_ip, $lan_mask);
			$syslog_network_addr = ipv4networkid($syslog_ip,  $lan_mask);
			TRACE_debug("lan_network_addr=".$lan_network_addr.",  syslog_network_addr=".$syslog_network_addr);
			
			//if subnet of syslog ip is same as lan
			//syslog ip need be changed to the new subnet while lan ip change with ip conflict.
			if($syslog_network_addr == $lan_network_addr)
			{
				$change_syslog = 1;
				$syslog_hostid = ipv4hostid($syslog_ip, $lan_mask);
			}			
		}
	}
	TRACE_debug("ip_conflict_check = ".$conflict.", change_syslog=".$change_syslog);
	
	// ther handle functions as below should be integrated. but spec. is still modifying. sigh...
	// ref: D-Link Router Auto Nat Handleing for Collision LAN Specification.pdf
	if($conflict == 1)
	{
		$ACTION="other";
        $laninf = XNODE_getpathbytarget("", "inf", "uid", $LAN1, 0);
        $uid = query($laninf."/inet");
        foreach("/inet/entry")
        {
            if (query("uid") == $uid)
            {
                $t_ip=query("ipv4/ipaddr");
                if(strstr($t_ip, "192.168.0")!="")
                    {$lan_ip="192.168.100.1";}
                else
                    {$lan_ip="192.168.0.1";}
                set("ipv4/ipaddr", $lan_ip);
                set("ipv4/mask", "24");
		if($change_syslog == "1")
		{
			$syslog_ip = ipv4ip($lan_ip, "24", $syslog_hostid);
			set("/device/log/remote/ipv4/ipaddr", $syslog_ip);
			TRACE_debug("change syslog ip to ".$syslog_ip);
		}
                event("DBSAVE");
                event("REBOOT");
            }
        }
	}
	else if ($conflict == 2)
	{
        $ACTION="other";
        $laninf = XNODE_getpathbytarget("", "inf", "uid", $LAN2, 0);
        $uid = query($laninf."/inet");
        $lan1inf = XNODE_getpathbytarget("", "inf", "uid", $LAN1, 0);
        $uid1 = query($lan1inf."/inet");
	foreach("/inet/entry") { if (query("uid") == $uid1)    {$lan_ip=query("ipv4/ipaddr");  }}
	TRACE_debug("lan ip = ".$lan_ip);

        foreach("/inet/entry")
        {
            if (query("uid") == $uid)
            {
                $t_ip=query("ipv4/ipaddr");
                if(strstr($t_ip, "192.168.7")!="")
                {
			if(strstr($lan_ip, "192.168.107")!="")
			    	{$gzone_ip="192.168.108.1";}
			    else
			   	{$gzone_ip="192.168.107.1";}
		}
                else if(strstr($t_ip, "192.168.107")!="")
                {
			if(strstr($lan_ip, "192.168.7")!="")
			    	{$gzone_ip="192.168.108.1";}
			    else
			   	{$gzone_ip="192.168.7.1";}
		}
		else if(strstr($t_ip, "192.168.108")!="")
                {
			if(strstr($lan_ip, "192.168.7")!="")
			    	{$gzone_ip="192.168.107.1";}
			    else
			   	{$gzone_ip="192.168.7.1";}
		}
                set("ipv4/ipaddr", $gzone_ip);
                set("ipv4/mask", "24");
                event("DBSAVE");
                event("REBOOT");
            }
        }
	}
	else if ($conflict == 3)
	{
        $ACTION="other";
        $laninf = XNODE_getpathbytarget("", "inf", "uid", $LAN1, 0);
        $uid = query($laninf."/inet");
        $lan_ip="172.16.0.1";
        $laninf_2 = XNODE_getpathbytarget("", "inf", "uid", $LAN2, 0);
        $uid_2 = query($laninf_2."/inet");
        $gzone_ip="172.16.7.1";
        foreach("/inet/entry")
        {
            if (query("uid") == $uid)
            {
                set("ipv4/ipaddr", $lan_ip);
                set("ipv4/mask", "24");
            }
	    else if (query("uid") == $uid_2)
            {
                set("ipv4/ipaddr", $gzone_ip);
                set("ipv4/mask", "24");
            }
        }
	if($change_syslog == "1")
	{
		$syslog_ip=ipv4ip($lan_ip, "24", $syslog_hostid);
		set("/device/log/remote/ipv4/ipaddr", $syslog_ip);
		TRACE_debug("change syslog ip to ".$syslog_ip);
	}
	event("DBSAVE");
        event("REBOOT");
	}
	else if ($conflict == 4)
	{
		$ACTION="other";
		$laninf = XNODE_getpathbytarget("", "inf", "uid", $LAN1, 0);
		$uid = query($laninf."/inet");
		$laninf2 = XNODE_getpathbytarget("", "inf", "uid", $LAN2, 0);
		$uid2 = query($laninf2."/inet");
		foreach("/inet/entry")
		{
			if (query("uid") == $uid)
			{
				set("ipv4/ipaddr", "192.168.0.1");
				set("ipv4/mask", "24");
			}
			if (query("uid") == $uid2)
			{
				set("ipv4/ipaddr", "192.168.7.1");
				set("ipv4/mask", "24");
			}
		}
		if($change_syslog == "1")
		{
			$syslog_ip=ipv4ip($lan_ip, "24", $syslog_hostid);
			set("/device/log/remote/ipv4/ipaddr", $syslog_ip);
			TRACE_debug("change syslog ip to ".$syslog_ip);
		}
		event("DBSAVE");
		event("REBOOT");
	}
}
//jef add -
if ($ACTION=="bound")
{
	/* Actuall, we don't need to set the 'udhcpc' nodes under /runtime/inf.
	 * Those were temporary nodes of the old implementation. (That's why I did not put into the documentation.)
	 * But there are still some modules referencing these nodes, so I keep these code for compatible reason.
	 *			David Hsieh <david_hsieh@alphanetworks.com> */

	/* Anchor to the target interface's runtime status path.  */
	$sts = XNODE_getpathbytarget("/runtime",  "inf", "uid", $INF, 1);

	/* Check if there are existing setting ? */
	if (query($sts."/udhcpc/inet")==$INET)
	{
		anchor($sts."/udhcpc");
		if (query("interface")==$INTERFACE &&
			query("ip")==$IP &&
			query("subnet")==$SUBNET &&
			query("broadcast")==$BROADCAST &&
			query("lease")==$LEASE &&
			query("domain")==$DOMAIN &&
			query("raw_router")==$ROUTER &&
			query("raw_dns")==$DNS &&
			query("raw_clsstrout")==$CLSSTROUT &&
			query("raw_sstrout")==$SSTROUT &&
			query("sixrd_pfx")==$SIXRDPFX &&
			query("sixrd_pfxlen")==$SIXRDPFXLEN &&
			query("sixrd_msklen")==$SIXRDMSKLEN &&
			query("sixrd_bripaddr")==$SIXRDBRIP)
		{
			$nochange = 1;			
		}
		else
		{
			$nochange = 0;			
		}								
	}
	
	$netbios_changed = netbios_handler($SCOPE, $WINSTYPE, $WINS);
	if($netbios_changed == 1)
	{ 			
		$nochange = 0;						
	}
	
	
	if($nochange ==1)
	{
		echo 'echo "[$0]: no changed in '.$INF.' ..." > /dev/console';			
	}	
	else
	{			
		echo "phpsh /etc/scripts/IPV4.INET.php ACTION=DETACH INF=".$INF."\n";
	}	
		
	if ($nochange!=1)
	{
		del($sts."/udhcpc");
		set($sts."/udhcpc/inet",$INET);
		anchor($sts."/udhcpc");

		/* Record the arguments */
		set("interface",$INTERFACE);
		set("ip",		$IP);
		set("subnet",	$SUBNET);
		set("broadcast",$BROADCAST);
		set("lease",	$LEASE);
		set("domain",	$DOMAIN);
		set("raw_router",	$ROUTER);
		set("raw_dns",		$DNS);
		set("raw_clsstrout",$CLSSTROUT);
		set("raw_sstrout",	$SSTROUT);		

		/* 6rd info */
		set("sixrd_pfx",	$SIXRDPFX);		
		set("sixrd_pfxlen",	$SIXRDPLEN);		
		set("sixrd_msklen",	$SIXRDMSKLEN);		
		set("sixrd_brip",	$SIXRDBRIP);		

		add_each($ROUTER,	$statusp."/udhcpc", "router");
		add_each($DNS,		$statusp."/udhcpc", "dns");
		add_each($CLSSTROUT,$statusp."/udhcpc", "cltrout");
		add_each($SSTROUT,	$statusp."/udhcpc", "sstrout");

		echo "phpsh /etc/scripts/IPV4.INET.php ACTION=ATTACH".
				" STATIC=0".
				" INF=".$INF.
				" DEVNAM=".$INTERFACE.
				" MTU=".$MTU.
				" IPADDR=".$IP.
				" SUBNET=".$SUBNET.
				" BROADCAST=".$BROADCAST.
				" GATEWAY=".$ROUTER.
				' "DOMAIN='.$DOMAIN.'"'.
				' "DNS='.$DNS.'"'.
				' "CLSSTROUT='.$CLSSTROUT.'"'.
				' "SSTROUT='.$SSTROUT.'"'.
				'\n';
		$restartdhcpswer = 0;
		if ($DOMAIN != query("/runtime/device/domain"))
		{
			echo "xmldbc -s /runtime/device/domain \"".$DOMAIN."\"\n";
			$restartdhcpswer = 1;
		}
		/*Check LAN DHCP setting. We will resatrt DHCP server if the DNS relay is disabled*/
		foreach ("/inf")
		{
		    $disable= query("disable");
		    $active = query("active");
		    $dhcps4 = query("dhcps4");
		    $dns4 = query("dns4");
		    if ($disable != "1" && $active=="1" && $dhcps4!="")
		    {
	            if ($dns4 =="")
	            {
	                $restartdhcpswer = 1;
	            }
		    }
		}
				
		if ($restartdhcpswer == 1 || $netbios_changed ==1)
		{
		    echo "event DHCPS4.RESTART\n";
		}	
	}

	/*Any DNS request should return router LAN IP address to access wizard page if these condition are satisfied.
	1. Factory Default.
	2. Wizard for factory default is supported.
	3. Country code is RU.
	4. If Country code is not RU. WAN does not get the DHCP IP address.*/
	if(get("", "/runtime/device/devconfsize")=="0" && get("", "/device/fresetwizard")!="0" && get("", "/runtime/devdata/countrycode")!="RU")
	{
		echo "phpsh /etc/scripts/factorydefault.php ACTION=break";//Don't return router LAN IP address if the target of DNS query is not the router.
	}
}
else if ($ACTION=="classlessstaticroute")
{
	$netid	= ipv4networkid($SDEST, $SSUBNET);
	$cfg = XNODE_getpathbytarget("", "inf", "uid", $INF, 0);
	if ($cfg=="") return $_GLOBALS["INF"]."does not exist!";
	$sts = XNODE_getpathbytarget("/runtime", "inf", "uid", $INF, 1);

	echo "result=`xmldbc -w /runtime/inf:4/inet/ipv4/ipaddr`\n";
	echo 'while [ "$result" == "" ]; do sleep 2; result=`xmldbc -w '.$sts.'/inet/ipv4/ipaddr`; done\n';
	echo "ip route add ".$netid."/".$SSUBNET." via ".$SROUTER." table CLSSTATICROUTE\n";
}
else if ($ACTION=="staticroute")
{
	$netid	= ipv4networkid($SDEST, $SSUBNET);
	$cfg = XNODE_getpathbytarget("", "inf", "uid", $INF, 0);
	if ($cfg=="") return $_GLOBALS["INF"]."does not exist!";
	$sts = XNODE_getpathbytarget("/runtime", "inf", "uid", $INF, 1);

	echo "result=`xmldbc -w /runtime/inf:4/inet/ipv4/ipaddr`\n";
	echo 'while [ "$result" == "" ]; do sleep 2; result=`xmldbc -w '.$sts.'/inet/ipv4/ipaddr`; done\n';
	echo "ip route add ".$SDEST." via ".$SROUTER." table CLSSTATICROUTE\n";
}
else if ($ACTION=="deconfig")
{
	$sts = XNODE_getpathbytarget("/runtime",  "inf", "uid", $INF, 0);
	if ($sts=="") echo 'echo "[$0]: no interface '.$INF.' ..." > /dev/console';
	else
	{
		del($sts."/udhcpc");
		echo "ip route flush table CLSSTATICROUTE\n";
		echo "phpsh /etc/scripts/IPV4.INET.php ACTION=DETACH INF=".$INF;
	}
}
else if ($ACTION=="renew")
{
	echo 'echo "[$0]: got renew for '.$INF.' ..." > /dev/console';
}
else if ($ACTION=="dhcpplus")
{
	echo 'echo "[DHCP+]: config '.$INTERFACE.' '.$IP.'/'.$SUBNET.' default gw '.$ROUTER.'" > /dev/console\n';
	/* Get the netmask */
	if ($SUBNET!="") $mask = ipv4mask2int($SUBNET);
	/* Get the broadcast address */
	if ($BROADCAST!="") $brd = $BROADCAST;
	else
	{
		$max = ipv4maxhost($mask);
		$brd = ipv4ip($IP, $mask, $max);
	}
//marco
	echo "echo 0 > /proc/sys/net/ipv4/ip_forward\n";	
	echo "ip addr add ".$IP."/".$mask." broadcast ".$brd." dev ".$INTERFACE."\n";
	
	/* gateway */
	$cfg = XNODE_getpathbytarget("", "inf", "uid", $INF, 0);

	/* Get the defaultroute metric from config. */
	$defrt = query($cfg."/defaultroute");
	if ($ROUTER!="")
	{
		$netid = ipv4networkid($IP, $mask);
		if ($defrt!="" && $defrt>0)
		{	
			echo "ip route add default via ".$ROUTER." metric ".$defrt." table default\n";
		}
		else
		{	
			echo "ip route add ".$netid."/".$mask." dev ".$INTERFACE." src ".$IP." table ".$INF."\n";
		}
	}
}
else
{
	echo '# unknown action - ['.$ACTION.']';
}
?>
exit 0
