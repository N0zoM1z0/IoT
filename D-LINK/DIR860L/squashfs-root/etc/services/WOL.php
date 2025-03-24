<?
/* VSVR & PFWD are depends on LAN services.
 * Be sure to start LAN services first. */

$ME="virtualserver";

include "/htdocs/phplib/trace.php";
include "/htdocs/phplib/inf.php";
include "/htdocs/phplib/phyinf.php";
include "/etc/services/IPTABLES/iptlib.php";


fwrite("w",$START, "#!/bin/sh\n");
fwrite("w",$STOP,  "#!/bin/sh\n");
if ($ME!="virtualserver") $ME="portforward";
/* Get all the LAN interface IP address. */
//IPT_scan_lan();
/* Build the useful inbound filter rules in iptables. */
//IPT_build_inbound_filter($START);

$cnt = query("/nat/count"); if ($cnt=="") $cnt = 0;
foreach ("/nat/entry")
{
	/* beyond the count are garbage */
	if ($InDeX>$cnt) break;



	/* Get the CHAIN */
	$UID = query("uid");
	if ($ME=="portforward")	$CHAIN="DNAT.PFWD.".$UID;
	else					$CHAIN="DNAT.VSVR.".$UID;
	/* Mark that there is no rules in the CHAIN. */
	XNODE_set_var($CHAIN.".USED", "0");
	/* Flush the CHAIN */

	/* Walk through the rules. */
	$ecnt = query($ME."/count"); if ($ecnt=="") $ecnt=0;
	foreach ($ME."/entry")
	{
		/* beyond the count are garbage */
		if ($InDeX>$ecnt) break;
		/* enable ? */
		if (query("enable")!=1 || query("inbfilter")=="denyall") continue;
		
		$iswol=0;
	
		/* check the destination host */
		$inf	= query("internal/inf");
		$hostid = query("internal/hostid");
		$ipaddr = XNODE_get_var($inf.".IPADDR");
		$mask	= XNODE_get_var($inf.".MASK");
		if ($ipaddr=="" || $mask=="" || $hostid=="" || $inf=="") continue;
		$ipaddr = ipv4ip($ipaddr, $mask, $hostid);
		if ($ipaddr=="") continue;

		if (query("tport_str")!="" || query("uport_str")!="")
		{
		}
		else
		{
			/* check the protocol */
			$prot_tcp = 0; $prot_udp = 0; $prot_other = 0; $offset = 0;
			$prot = query("protocol");
			if ($prot=="TCP+UDP") {	$prot_tcp++; $prot_udp++; }
			else if	($prot=="TCP")	$prot_tcp++;
			else if	($prot=="UDP")	$prot_udp++;
			else if	($prot=="Other")$prot_other++;
			else continue;
		
			if($prot_other==0)
			{
				/* check port setting */
				$ext_end	= query("external/end");
				$ext_start	= query("external/start");	if ($ext_start=="") continue;
				$int_start	= query("internal/start");	if ($int_start=="") $int_start = $ext_start;
				if		($int_start > $ext_start) $offset = $int_start - $ext_start;
				else if ($int_start < $ext_start) $offset = 65536 - $ext_start + $int_start;
				else							  $offset = 0;
		
				/* port */
				if ($ext_end=="" || $ext_end==$ext_start) $portcmd = "--dport ".$ext_start;	/* Single port forwarding */
				else $portcmd = "-m mport --ports ".$ext_start.":".$ext_end; /* Multi port forwarding */
			}
			/* DNAT */
			if ($offset=="0") $dnatcmd = "-j DNAT --to-destination ".$ipaddr;
			else $dnatcmd = "-j DNAT --to-shift ".$ipaddr.":".$offset;
			/* time */
			$sch = query("schedule");

			/* Inbound Filter*/
			if (query("inbfilter") != "")	$inbfn = cut(query("inbfilter"), 1, "-");

			
						/* Wake-On-Lan */
			if ($ME=="virtualserver" && query("description")=="Wake-On-Lan")
			{
				$stsp = XNODE_getpathbytarget("/runtime", "inf", "uid", "WAN-1", 0);
				if($stsp!="")
				{
					if ($prot_udp>0) 
					{
				  	  fwrite("a",$START, "iptables  -t nat -I PREROUTING  -p udp --dport ".$ext_start."  -j ACCEPT \n");
					  fwrite("a",$STOP,  "iptables  -t nat -D PREROUTING  -p udp --dport ".$ext_start." -j ACCEPT \n");
					}
					if ($prot_tcp>0) 
					{
				           fwrite("a",$START, "iptables -t nat -I PREROUTING -p tcp --dport ".$ext_start."  -j ACCEPT \n");
				           fwrite("a",$STOP,  "iptables -t nat -D PREROUTING -p tcp --dport ".$ext_start."  -j ACCEPT \n");
					}
					$udp_port= $ext_start;
					$tcp_port= $ext_start;
		
					$name = "WAN-1";	
		                        $wan_inf = PHYINF_getruntimeifname($name);
							
					$lan_inf="br0";
					fwrite("a",$START, "wol -u ".$udp_port." -t ".$tcp_port." -w ".$wan_inf." -i ".$lan_inf." &\n");
					fwrite("a",$STOP, "killall wol\n");
                
				}	
				$iswol =1;
			}
			if($iswol == 1)
			{
				$iswol=0;
				continue;
			}
	
		}
	}
}

?>
