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
<script>
	var dev_info = get_router_info();
	var rtList = null;
	
	var param = {
		url: "get_set.ccp",
		arg: 'ccp_act=get&num_inst=2'+
			'&oid_1=IGD_Status_RoutingTable_i_&inst_1=11000'+
			'&oid_2=IGD_Layer3Forwarding_Forwarding_i_&inst_2=11000'
	};
	get_config_obj(param);
	
	rtList = {
		'addr':			new String(config_val('igdRtList_Destination_')).split(','),
		'mask':			new String(config_val('igdRtList_Netmask_')).split(','),
		'gw':			new String(config_val('igdRtList_Gateway_')).split(','),
		'iface':		new String(config_val('igdRtList_Interface_')).split(','),
		'metric':		new String(config_val('igdRtList_Metric_')).split(','),
		'type':			new String(config_val('igdRtList_Type_')).split(','),
		'creator':		new String(config_val('igdRtList_Creator_')).split(',')
	}

	var adv_route = {
		'enable':	config_str_multi("fwdRule_Enable_"),
		'name':		config_str_multi("fwdRule_Name_"),
		'addr':		config_str_multi("fwdRule_DestIPAddress_"),
		'mask':		config_str_multi("fwdRule_DestSubnetMask_"),
		'gw':		config_str_multi("fwdRule_GatewayIPAddress_"),
		'metric':	config_str_multi("fwdRule_ForwardingMetric_"),
		'iface':	config_str_multi("fwdRule_SourceInterface_")
	};

	function compare_creator(idx)
	{
		i = idx;
		for (var j =0;j<adv_route.addr.length;j++)
		{
			if (adv_route.enable[j] == 0)
			{
				if((rtList.addr[i] == adv_route.addr[j]) && (rtList.mask[i] == adv_route.mask[j]) &&
					(rtList.gw[i] == adv_route.gw[j]) && (mapIface(rtList.iface[i]) == 'WAN') &&
					(rtList.metric[i] == adv_route.metric[j]))
						return 'Admin';
			}
		}
		return 'System';
	}

	function mapIface(idx)
	{
		switch (idx) {
		case '1':
			return 'LAN';
		case '2':
			return 'Local Loopback';
		default:
			return 'WAN';
		}
	}

/*	
	function creator_up(idx)
	{
		switch (idx) {
		case '0':
			return 'System';
		case '1':
			return 'Admin';
		}
	}

	function wantype_up(idx)
	{
		switch (idx) {
		case '0':
			return 'INTERNET';
		case '1':
			return 'DHCP Option';
		case '2':
			return 'STATIC';
		case '3':
			return 'INTRANET';
		case '4':
			return 'LOCAL';
		}
	}
*/

	//20120203 silvia add to change addr and mask string
/*
	function compare_addr(addr)
	{
		if (addr == "0.0.0.0")
			return "default";
		else if (addr == "239.255.255.250")
			return "239.0.0.0";
		else
			return addr;
	}
*/
	function routingTable_list()
	{
		if (rtList.addr == null || rtList.addr=='')
			return;
		/*
		var str = 	'<tr>'+
						'<td align="center" bgcolor="#DDDDDD"><b>' + get_words('_NetworkAddr') + '</b></td>'+
						'<td align="center" bgcolor="#DDDDDD"><b>' + get_words('_NetworkMask') + '</b></td>'+
						'<td align="center" bgcolor="#DDDDDD"><b>' + get_words('_GWAddr') + '</b></td>'+
						'<td align="center" bgcolor="#DDDDDD"><b>' + get_words('_Interface') + '</b></td>'+
						'<td align="center" bgcolor="#DDDDDD"><b>' + get_words('_Metric') + '</b></td>'+
						'<td align="center" bgcolor="#DDDDDD"><b>' + get_words('_Type') + '</b></td>'+
					'</tr>';
		*/
		var str = 	'<tr>'+
						'<TD><b>'+get_words(_DestIP)+'</b></TD>'+	
						'<TD><b>'+get_words(_netmask)+'</b></TD>'+
						'<TD><b>'+get_words(_gateway)+'</b></TD>'+
						'<TD><b>'+get_words(_metric)+'</b></TD>'+	
						'<TD><b>'+get_words(_interface)+'</b></TD>'+
						'<TD><b>'+get_words(_type)+'</b></TD>'+
						'<TD><b>'+get_words(_creator)+'</b></TD>'+
					'</tr>';
		for (var i = 0; i < rtList.addr.length ; i++){
			str += ("<tr bgcolor=\"#F0F0F0\">");
			str += ("<td><font face=\"Arial\" size=\"2\">"+ ((rtList.addr[i] == "239.255.255.250") ? "239.0.0.0":rtList.addr[i] )+"</font></td>");
			//str += ("<td><font face=\"Arial\" size=\"2\">"+ compare_addr(rtList.addr[i])+"</font></td>");
			str += ("<td><font face=\"Arial\" size=\"2\">"+ ((rtList.addr[i] == "239.255.255.250") ? "255.0.0.0":rtList.mask[i] )+"</font></td>");
			str += ("<td><font face=\"Arial\" size=\"2\">"+ rtList.gw[i] +"</font></td>");
			str += ("<td><font face=\"Arial\" size=\"2\">"+ rtList.metric[i] +"</font></td>");
			str += ("<td><font face=\"Arial\" size=\"2\">"+ mapIface(rtList.iface[i]) +"</font></td>");
			str += ("<td><font face=\"Arial\" size=\"2\">"+ (rtList.type[i]==0? 'Dynamic':'Static') +"</font></td>");	//wantype_up(rtList.type[i]) +"</font></td>");
			str += ("<td><font face=\"Arial\" size=\"2\">"+ compare_creator(i)+"</font></td>");	//creator_up(rtList.creator[i]) +"</font></td>");
			str += ("</tr>");		
		}
		$('#list_container').html(str);
	}
	$(document).ready( function () {
		routingTable_list();
	});

</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<form id="form1" name="form1" method="post" action="st_device.cgi">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
	<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(dev_info.model);</script></a></td>
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
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">		<tr>
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
									<li><div id="sidenavoff"><script>show_words(_routing)</script></div></li>
									<li><div><a href="st_wireless.asp"><script>show_words(_wireless)</script></a></div></li>
									<li><div><a href="st_ipv6.asp"><script>show_words(IPV6_TEXT137)</script></a></div></li>
									<li><div><a href="st_routing6.asp"><script>show_words(v6_routing)</script></a></div></li>
                                </ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>
					</tr>
                <td>
                 <!-- repeat name="extTab" -->
                </td>
				</table>
			</td>
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
					<div id="box_header">
						<h1><script>show_words(_routing)</script></h1>
						<b><script>show_words(sr_RTable)</script></b><br><br>
						<script>show_words(sr_intro)</script>
					</div>
					<br>
					<div class="box">
						<h2><script>show_words(sr_RTable)</script></h2>
							<table cellSpacing=1 cellPadding=2 width=525 bgcolor="#FFFFFF" id="list_container">
                            </table>
					</div>
                </div></td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id=help_text><strong></strong>
							<p></p>
							<p><a href="support_status.asp#routing" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
	get_lang();
</script>
</html>