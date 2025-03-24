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
<script language="JavaScript">
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');
	
	var DataArray = new Array();

	var param = {
		url: "session.ccp",
		arg: "ccp_act=querySession"
	};
	get_config_obj(param);
	var content_str = config_val("session_content");

	//20120203 silvia add to chk addr range
	var paramHost={
		'url': 	'get_set.ccp',
		'arg': 	'ccp_act=get&num_inst=1&oid_1=IGD_LANDevice_i_LANHostConfigManagement_&inst_1=11100'
	};
	get_config_obj(paramHost);

	var startaddr = config_val('lanHostCfg_MinAddress_');
	var endaddr = config_val('lanHostCfg_MaxAddress_');
	
	function set_session_Data(src_proto, timeout, state, direction, local_ip, local_port, remote_ip, remote_port, public_port, priority, onList) 
	{
		this.Proto = src_proto;
		this.Timeout = timeout;
		this.State = state;
		this.Dir = direction;
		this.Local_IP = local_ip;
		this.Local_port = local_port;
		this.Remote_IP = remote_ip;
		this.Remote_Port = remote_port;
		this.Public_port = public_port;
		this.Priority = priority;
		this.OnList = onList ;
	}

	function copy_session_Data(localInfo, internetInfo, proto, direction, status, expire, nat) 
	{
		this.local = localInfo;
		this.internet = internetInfo;
		this.proto = proto;
		this.Dir = direction;
		this.status = status;
		this.expire = expire;
		this.nat = nat
	}

	function set_session_table(){
		var index = 0;
		var detail_index = 0;
		for (var i = 0; i < localIPPort.length; i++)
		{
			if ( localIPPort[i] <= endaddr && localIPPort[i] >= startaddr)
			{
				DataArray[DataArray.length++] = new copy_session_Data(localIPPort[i], IntrenetIPPort[i], sessionProto[i],
												sessionDirection[i], sessionStatus[i], sessionExpire[i], sessionNAT[i]);
				detail_index++;
			}
		}
	}

	function session_list(){
		if(content_str.length > 0)
			document.write(content_str);
	}
</script>
<title>D-Link公司 | 无线路由器 | 主页</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
-->
</style>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
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
					<li><div id="sidenavoff"><script>show_words(YM157)</script></div></li>
					<li><div><a href="st_routing.asp"><script>show_words(_routing)</script></a></div></li>
					<li><div><a href="st_wireless.asp"><script>show_words(_wireless)</script></a></div></li>
					<li><div><a href="st_ipv6.asp"><script>show_words(IPV6_TEXT137)</script></a></div></li>
					<li><div><a href="st_routing6.asp"><script>show_words(v6_routing)</script></a></div></li>
				</ul>
			<!-- === END SIDENAV === -->
			</div>
			</td>
		</tr>
		</table>
	</td>
	<form id="form1" name="form1" method="post">
	<input type="hidden" id="internet_session_table" name="internet_session_table" value="">
	<td valign="top" id="maincontent_container">
	<div id="maincontent">
	<!-- === BEGIN MAINCONTENT === -->
	<div id="box_header"> 
		<h1><script>show_words(YM157)</script></h1>
		<p><script>show_words(sa_intro)</script></p>
	</div>
	<div class="box"> 
		<h2><script>show_words(YM157)</script></h2>
		<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
		<tr id="box_header">
			<TD><b><script>show_words(sa_Local)</script></b></TD>
			<TD><b><script>show_words(sa_NAT)</script></b></TD>
			<TD><b><script>show_words(sa_Internet)</script></b></TD>
			<TD><b><script>show_words(_protocol)</script></b></TD>
			<TD><b><script>show_words(sa_State)</script></b></TD>
			<TD><b><script>show_words(sa_Dir)</script></b></TD>
			<TD><b><script>show_words(sa_TimeOut)</script></b></TD>
		</tr>
		<script>session_list(); </script>
		</table>
	</div>
	</div>
	</td></form>
	<td valign="top" width="150" id="sidehelp_container" align="left">
		<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
		<tr>
			<td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong>
				<p><script>show_words(hhsa_intro)</script></p>
				<p class="more"><a href="support_status.asp#Internet_Sessions"><script>show_words(_more)</script>&hellip;</a></p>
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
</html>