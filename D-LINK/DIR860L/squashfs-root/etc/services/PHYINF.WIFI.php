<?
include "/htdocs/phplib/xnode.php";

function schcmd($uid)
{
	/* Get schedule setting */
	$p = XNODE_getpathbytarget("", "phyinf", "uid", $uid, 0);
	$sch = XNODE_getschedule($p);
	$schid =  query($p."/schedule");
	if ($sch=="") $cmd = "start";
	else	{$cmd = XNODE_getschedule2013cmd($schid);}
	return $cmd;
}

/********************************************************************/
fwrite("w",$START, "#!/bin/sh\n");
fwrite("w", $STOP, "#!/bin/sh\n");

if(query("/device/layout")=="router")
{
	fwrite("a",$START,	
		"service PHYINF.BAND24G-1.1 ".schcmd("BAND24G-1.1")."\n".
		"service PHYINF.BAND24G-1.2 ".schcmd("BAND24G-1.2")."\n".
		"service PHYINF.BAND5G-1.1 ".schcmd("BAND5G-1.1")."\n".
		"service PHYINF.BAND5G-1.2 ".schcmd("BAND5G-1.2")."\n"
		);
	
	fwrite("a",$STOP,
		"service PHYINF.BAND24G-1.2 stop\n".
		"service PHYINF.BAND24G-1.1 stop\n".	
		"service PHYINF.BAND5G-1.2 stop\n".
		"service PHYINF.BAND5G-1.1 stop\n"
		);
}
else if(query("/device/layout")=="bridge")
{
	fwrite("a",$START,"service PHYINF.WIFI-STA ".schcmd("WIFI-STA")."\n");	
	fwrite("a",$STOP,"service PHYINF.WIFI-STA stop\n");	
}

fwrite("a",$START,	"exit 0\n");
fwrite("a",$STOP,	"exit 0\n");
?>
