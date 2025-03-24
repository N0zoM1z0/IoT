<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<script type="text/javascript" src="uk.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript">
	var dev_info = get_router_info();

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;

	var param = {
		url: 	"get_set.ccp",
		arg: 	"ccp_act=get&num_inst=2"+
				"&oid_1=IGD_Layer3Forwarding_ForwardingV6_i_&inst_1=11000"+
				"&oid_2=IGD_Status_Routing6Table_i_&inst_2=11000"
	};
	get_config_obj(param);

	var array_enable 		 	= config_str_multi("fwdV6Rule_Enable_");
	var array_destipv6ip	 	= config_str_multi("fwdV6Rule_DestIPv6Address_");
	var array_destipv6prefix 	= config_str_multi("fwdV6Rule_DestIPv6AddressPrefixLength_");
	var array_sourceinterface	= config_str_multi("fwdV6Rule_SourceInterface_");
	var array_gatewayip	 	 	= config_str_multi("fwdV6Rule_GatewayIPAddress_");
	var array_metric		 	= config_str_multi("fwdV6Rule_ForwardingMetric_");

	//var rule_max_num = 10;
	var array_dynamic_ip6 = config_val("igdR6tList_Destination_").split(",");
	var array_dynamic_gw6 = config_val("igdR6tList_Gateway_").split(",");
	var array_dynamic_metric = config_val("igdR6tList_Metric_").split(",");
	var array_dynamic_iface = config_val("igdR6tList_Interface_").split(",");
	//  1/name/ip/netmask/gateway/WAN/metric

	function DataShow(){

		//Static
		for (var i=0; i<array_enable.length;i++)
		{
			if(array_enable[i]==1)
			{
				var iface = "";
				if (array_sourceinterface[i] === "1") {
					iface = "WAN";
				} else if(array_sourceinterface[i] === "2"){
					iface = "LAN";
				} else if(array_sourceinterface[i] === "0"){
					iface = "lo";
					array_gatewayip[i]="";
				} else if(array_sourceinterface[i] === "3"){
					continue;
					iface = "ath1";
					array_gatewayip[i]="::";
					array_metric[i]="256";
				} else {
					iface = "Error";
				}
				document.write("<tr bgcolor=\"#F0F0F0\">");
				document.write("<td>"+ filter_ipv6_addr(array_destipv6ip[i]) +"/"+ array_destipv6prefix[i] +"</td>");
				document.write("<td>"+ filter_ipv6_addr(array_gatewayip[i]) +"</td>");
				document.write("<td>"+ array_metric[i] +"</td>");
				document.write("<td>"+ iface +"</td>");
				document.write("</tr>\n");
			}
		}

		//dynamic
		for (var i=0; i<array_dynamic_iface.length;i++)
		{
			var iface = "";
			if (array_dynamic_iface[i] === "1") {
				iface = "WAN";
			} else if(array_dynamic_iface[i] === "2"){
				iface = "LAN";
			} else if(array_dynamic_iface[i] === "0"){
				continue;
			} else if(array_dynamic_iface[i] === "3"){
				iface = "ath1";
			} else {
				iface = "Error";
				continue;
			}

			document.write("<tr bgcolor=\"#F0F0F0\">");
			document.write("<td>"+ filter_ipv6_addr(array_dynamic_ip6[i]) +"</td>");
			document.write("<td>"+ filter_ipv6_addr(array_dynamic_gw6[i]) +"</td>");
			document.write("<td>"+ array_dynamic_metric[i] +"</td>");
			document.write("<td>"+ iface +"</td>");
			document.write("</tr>\n");
		}
	}
</script>
</head>
	<input type="hidden" id="dhcp_list" name="dhcp_list" value=''>
	<input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value=''>
	<input type="hidden" id="ipv6_pppoe_dynamic" name="ipv6_pppoe_dynamic" value=''>
	<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<input type="hidden" id="ipv6_6to4_tunnel_address" name="ipv6_6to4_tunnel_address" maxLength=80 size=80 value=''>
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
	<tr>
		<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><script>document.write(dev_info.model);</script></a></td>
		<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
		<td>&nbsp;</td>
	</tr>
	</table>
	<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
	<tr>
		<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
	</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
	<tr id="topnav_container">
		<td><img src="short_modnum.gif" width="125" height="25"></td>
		<td id="topnavoff"><a href="index.asp"><script>show_words(_setup)</script></a></td>
		<td id="topnavoff"><a href="adv_virtual.asp"><script>show_words(_advanced)</script></a></td>
		<td id="topnavoff"><a href="tools_admin.asp"><script>show_words(_tools)</script></a></td>
		<td id="topnavon"><a href="st_device.asp"><script>show_words(_status)</script></a></td>
		<td id="topnavoff"><a href="support_men.asp"><script>show_words(_support)</script></a></td>
	</tr>
	</table>
	<table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
	<tr>
		<td id="sidenav_container" valign="top" width="125" align="right">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td id="sidenav_container">
			<div id="sidenav">
				<!-- === BEGIN SIDENAV === -->
				<ul>
					<li><div><a href="st_device.asp"><script>show_words(_devinfo)</script></a></div></li>
					<li><div><a href="st_log.asp"><script>show_words(_logs)</script></a></div></li>
					<li><div><a href="st_stats.asp"><script>show_words(_stats)</script></a></div></li>
					<li><div><a href="internet_sessions.asp"><script>show_words(YM157)</script></a></div></li>
					<li><div><a href="st_routing.asp"><script>show_words(_routing)</script></a></div></li>
					<li><div><a href="st_wireless.asp"><script>show_words(_wireless)</script></a></div></li>
					<li><div><a href="st_ipv6.asp"><script>show_words(IPV6_TEXT137)</script></a></div></li>
					<li><div id="sidenavoff" style="text-transform:none"><script>show_words(v6_routing)</script></div></li>
				</ul>
				<!-- === END SIDENAV === -->
			</div>
			</td>
		</tr>
		</table>
		</td>
		<td valign="top" id="maincontent_container">
		<div id="maincontent">
		<!-- === BEGIN MAINCONTENT === -->
			<div id="box_header">
				<h1><script>show_words(v6_routing);</script></h1>
				<b><p><script>show_words(v6_routing_table);</script></p></b>
				<p><script>show_words(v6_routing_info);</script></p>
			</div>
			<div class="box">
			<h2><script>show_words(v6_routing_table);</script><span id="show_resert"></span></h2> 
			<table cellSpacing=1 cellPadding=2 width=525 bgcolor="#FFFFFF">
			<tr>
				<TD><b><script>show_words(_destip);</script></b></TD>
				<TD><b><script>show_words(_gateway);</script></b></TD>
				<TD><b><script>show_words(_metric);</script></b></TD>
				<TD><b><script>show_words(_interface);</script></b></TD>
			</tr>
			<script>DataShow();</script>
			</table>
			</div>
		</div>
		</td>
		<td valign="top" width="150" id="sidehelp_container" align="left">
			<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
			<tr> 
				<td id=help_text><strong></strong>
					<p></p>
					<p><a href="support_status.asp#stv6_routing" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	</form>
	<br>
	<div id="copyright"><script>show_words(_copyright);</script></div>
	<br>
</body>
</html>