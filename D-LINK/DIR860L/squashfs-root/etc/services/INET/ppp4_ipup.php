#!/bin/sh
<? /* $IFNAME, $DEVICE, $SPEED, $IP, $REMOTE, $PARAM */
include "/htdocs/phplib/trace.php";
include "/htdocs/phplib/xnode.php";
include "/htdocs/phplib/phyinf.php";
include "/htdocs/webinc/config.php";

/* for IP Collision check 	*/
TRACE_debug("ip_conflict_check wan_ip=".$IP);	
//+++ Jerry Kao, added for DLNA test (must force the router into bridge mode).
$layout = query("/device/layout");
if ($layout == "bridge")
	return 0;

$laninf = XNODE_getpathbytarget("", "inf", "uid", $LAN1, 0);
$uid = query($laninf."/inet");
$guest_inf = XNODE_getpathbytarget("", "inf", "uid", $LAN2, 0);  //LAN2 is guest zone
$uid2 = query($guest_inf."/inet");
$conflict=0;//IP Collision tag

foreach ("/inet/entry")
{
	//check lan
	if (query("uid") == $uid)
	{
		$lan_ip = query("ipv4/ipaddr");
		$lan_mask = query("ipv4/mask");
		TRACE_debug("ip_conflict_check lan_ip=".$lan_ip." mask=".$lan_mask);	
		$mask=$lan_mask;
		$lan_network_addr = ipv4networkid($lan_ip, $mask);
		$wan_network_addr = ipv4networkid($IP, $mask);
		TRACE_debug("ip_conflict_check lan_network_addr=".$lan_network_addr." wan_network_addr=".$wan_network_addr);
		if($wan_network_addr == $lan_network_addr) 
		{
			$conflict=1;
			if(strstr($lan_ip, "192.168.0")!="")
				{$lan_ip="192.168.100.1";}
			else
				{$lan_ip="192.168.0.1";}
			set("ipv4/ipaddr", $lan_ip);
			set("ipv4/mask", "24");
		}
	}
	//check guest zone
	if (query("uid") == $uid2)
	{
		$gzone_ip = query("ipv4/ipaddr");
		$gzone_mask = query("ipv4/mask");
		TRACE_debug("ip_conflict_check gzone_ip=".$gzone_ip." mask=".$gzone_mask);	
		$mask=$gzone_mask;
		$guest_network_addr = ipv4networkid($gzone_ip, $mask);
		$wan_network_addr = ipv4networkid($IP, $mask);
		TRACE_debug("ip_conflict_check guest_network_addr=".$guest_network_addr." wan_network_addr=".$wan_network_addr);
		if($wan_network_addr == $guest_network_addr) 
		{
			$conflict=1;
			foreach("/inet/entry") { if (query("uid") == $uid1)    {$lan_ip=query("ipv4/ipaddr");  }}
			TRACE_debug("lan ip = ".$lan_ip." guest ip=".$gzone_ip);
			if(strstr($gzone_ip, "192.168.7")!="")
			{
				if(strstr($lan_ip, "192.168.107")!="")
					{$gzone_ip="192.168.108.1";}
				else
					{$gzone_ip="192.168.107.1";}
			}
			else if(strstr($gzone_ip, "192.168.107")!="")
			{
				if(strstr($lan_ip, "192.168.7")!="")
					{$gzone_ip="192.168.108.1";}
				else
					{$gzone_ip="192.168.7.1";}
			}
			else if(strstr($gzone_ip, "192.168.108")!="")
			{
				if(strstr($lan_ip, "192.168.7")!="")
					{$gzone_ip="192.168.107.1";}
				else
					{$gzone_ip="192.168.7.1";}
			}
			TRACE_debug("guest ip change to ".$gzone_ip);
			set("ipv4/ipaddr", $gzone_ip);
			set("ipv4/mask", "24");				
		}
	}
}
if($conflict==1)
{
	event("DBSAVE");
	event("REBOOT");
}

$infp = XNODE_getpathbytarget("", "inf", "uid", $PARAM, 0);
if ($infp == "") exit;
$inet = query($infp."/inet");
if ($inet == "") exit;

$defaultroute = query($infp."/defaultroute");
/* create phyinf */
PHYINF_setup("PPP.".$PARAM, "ppp", $IFNAME);

$inetp = XNODE_getpathbytarget("/inet", "entry", "uid", $inet, 0);

/* create inf */
$stsp = XNODE_getpathbytarget("/runtime", "inf", "uid", $PARAM, 1);
$mtu = query($stsp."/pppd/mtu");
del($stsp."/inet");
set($stsp."/inet/uid",			$inet);
set($stsp."/inet/addrtype",		"ppp4");
set($stsp."/inet/uptime",		query("/runtime/device/uptime"));
set($stsp."/inet/ppp4/valid",	"1");
set($stsp."/inet/ppp4/mtu",           	$mtu);
set($stsp."/inet/ppp4/local",	$IP);
set($stsp."/inet/ppp4/peer",	$REMOTE);
set($stsp."/nativephyinf",		query($infp."/phyinf"));
set($stsp."/phyinf",			"PPP.".$PARAM);
set($stsp."/defaultroute",		$defaultroute);

/* Add this network in 'LOCAL' */
//marco
echo "echo 0 > /proc/sys/net/ipv4/ip_forward\n";	
echo 'ip route add '.$REMOTE.' dev '.$IFNAME.' src '.$IP.' table LOCAL\n';

if ($defaultroute!="")
{
	if($defaultroute == 0)
	{
		echo 'ip route add '.$REMOTE.' dev '.$IFNAME.' src '.$IP.' table '.$PARAM.'\n';
	}
	else if($defaultroute == 1)
	{
		echo '#pppd will insert defaultroute so we do not add defaultroute.\n';
	}
	else if($defaultroute > 1)
	{
		echo 'ip route add default via '.$REMOTE.' metric '.$defaultroute.' table default\n';
	}
}

/* user dns */
$cnt = 0;
if ($inetp != "")
{
	$cnt = query($inetp."/ppp4/dns/count");
	if ($cnt=="") $cnt = 0;
	$i = 0;
	while ($i < $cnt)
	{
		$i++;
		$value = query($inetp."/ppp4/dns/entry:".$i);
		if ($value != "") add($stsp."/inet/ppp4/dns", $value);
	}
}
/* auto dns */
if ($cnt == 0 && isfile("/etc/ppp/resolv.conf.".$PARAM)==1)
{
	$dnstext = fread("r", "/etc/ppp/resolv.conf.".$PARAM);
	$cnt = scut_count($dnstext, "");
	$i = 0;
	while ($i < $cnt)
	{
		$token = scut($dnstext, $i, "");
		if ($token == "nameserver")
		{
			$i++;
			$token = scut($dnstext, $i, "");
			add($stsp."/inet/ppp4/dns", $token);
		}
		$i++;
	}
}

/* We use PING peer IP to trigger the dailup at 'ondemand' mode.
 * So we need to update the command to PING the new gateway. */
$dial = XNODE_get_var($PARAM.".DIALUP");
if ($dial=="") $dial = query($inetp."/ppp4/dialup/mode");
if ($dial=="ondemand") 
{ 
	echo 'event '.$PARAM.'.PPP.DIALUP add "ping '.$REMOTE.'"\n';
	//hendry, for on demand, we at least dial once 
	echo 'event '.$PARAM.'.PPP.DIALUP\n';
}


/* 3G connection mode */
if (query($inetp."/ppp4/over")=="tty") echo "event TTY.UP\n";


/*
echo "event ".$PARAM.".UP\n";
echo "echo 1 > /var/run/".$PARAM.".UP\n";
*/

/* check if the other up script is finished */
$child = query($infp."/child");
if($child!="")
{
	$childip = query($stsp."/child/ipaddr");
	if($childip!="")
	{
		echo "echo IPV6CP is ready!! > /dev/console\n";

		/* user dns */
		$cnt = 0;
		if ($inetp != "")
		{
			$cnt = query($inetp."/ppp6/dns/count");
			if ($cnt=="") $cnt = 0;
			$i = 0;
			while ($i < $cnt)
			{
				$i++;
				$value = query($inetp."/ppp6/dns/entry:".$i);
				if ($value != "") add($stsp."/inet/ppp6/dns", $value);
			}
		}
		//set($stsp."/inet/addrtype",		"ppp10");
		set($stsp."/inet/addrtype",		"ppp4");

		$childpfx = query($stsp."/child/prefix");
		XNODE_set_var($child."_ADDRTYPE", "ipv6");
		XNODE_set_var($child."_IPADDR", $childip);
		XNODE_set_var($child."_PREFIX", $childpfx);
		XNODE_set_var($child."_PHYINF", "PPP.".$PARAM);
		echo "event ".$PARAM.".UP\n";
		echo "echo 1 > /var/run/".$PARAM.".UP\n";
		//echo "phpsh debug /etc/scripts/IPV6.INET.php ACTION=ATTACH INF=".$PARAM;
	}
	else 
	{
		echo "echo IPV6CP is not ready!! WAIT --- > /dev/console\n";
		//+++ add event for restart WAN-1 when PPPoE Share with IPv4,but without IPv6 on the ppp line.
		echo "event ".$PARAM.".UP\n";
		echo "echo 1 > /var/run/".$PARAM.".UP\n";
	}	
}
else
{
	echo "event ".$PARAM.".UP\n";
	echo "echo 1 > /var/run/".$PARAM.".UP\n";
}
?>
exit 0
