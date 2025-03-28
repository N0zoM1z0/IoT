<?
include "/htdocs/phplib/xnode.php";

fwrite("w",$START, "#!/bin/sh\n");
fwrite("a",$START, "service IPTVSVR restart\n");
fwrite("w",$STOP,  "#!/bin/sh\n");
fwrite("a",$STOP, "service IPTVSVR stop\n");

/* refresh the chain of WAN interfaces */
$i = 1;
while ($i>0)
{
	$ifname = "WAN-".$i;
	$ifpath = XNODE_getpathbytarget("", "inf", "uid", $ifname, 0);
	if ($ifpath == "") { $i=0; break; }
	fwrite("a",$_GLOBALS["START"], "service IPT.".$ifname." restart\n");
	fwrite("a",$_GLOBALS["STOP"],  "service IPT.".$ifname." restart\n");
	$i++;
}
fwrite("a",$START, "service WOL restart\n");
?>
