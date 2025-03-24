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
<script>
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');

	var param = {
		url: "get_set.ccp",
		arg: ""
	};
	param.arg = "ccp_act=get&num_inst=5";
	param.arg +="&oid_1=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_&inst_1=11100";
	param.arg +="&oid_2=IGD_LANDevice_i_IPv6ConfigManagement_&inst_2=11100";
	param.arg +="&oid_3=IGD_Status_IPv6Status_&inst_3=11100";
	param.arg +="&oid_4=IGD_ULA_&inst_4=10000";
	param.arg +="&oid_5=IGD_Status_IPv6Status_&inst_5=11100";
	get_config_obj(param);

	var lan_ipv6_linklocal_addr = filter_ipv6_addr(config_val("igdIPv6Status_IPv6LanLinkLocalAddress_"));
	var enable_ula = config_val("igdULASetup_ULAEnable_");
	var lan_ipv6_ula_addr = filter_ipv6_addr(config_val("igdIPv6Status_IPv6LanULAAddress_"));
	var ipv6_type = config_val("wanIPv6ConnDev_CurrentConnObjType_");

    var submit_button_flag = 0;
    function onPageLoad() {
        $('#lan_link_local_ip').html(lan_ipv6_linklocal_addr.toUpperCase()+"/64");
        if(enable_ula !=0)
        	$('#lan_ula_ip').html(lan_ipv6_ula_addr.toUpperCase());
		else
			tr_ula_lan_ip.style.display="none";
    }

    function send_request()
    {
        if (submit_button_flag == 0) {
            submit_button_flag = 1;
			sendsubmit();
            return true;
        }
        return false;
    }
	
	function sendsubmit()
	{
		var param1 = {
			url: "get_set.ccp",
			arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_IPV6&nextPage=sel_ipv6.asp'
		};
		param1.arg += "&wanIPv6ConnDev_CurrentConnObjType_1.1.1.0.0=7";
		
		get_config_obj(param1);
	}
</script>
</head>
<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
	<tr>
		<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support"><script>document.write(dev_info.model);</script></a></td>
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
		<td id="topnavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
		<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
		<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
		<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
		<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
	</tr>
	</table>
	<table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
	<tr>
		<td id="sidenav_container" valign="top" width="125" align="right">
		<table cellSpacing=0 cellPadding=0 border=0>
			<tbody>
			<tr>
				<td id=sidenav_container>
				<div id=sidenav>
					<ul>
						<li><div id="sidenavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(sa_Internet)</script></a></div></li>
						<li><div id="sidenavon"><a href="wizard_wireless.asp" onclick="return jump_if();"><script>show_words(_wirelesst)</script></a></div></li>
						<li><div id="sidenavon"><a href="lan.asp" onclick="return jump_if();"><script>show_words(bln_title_NetSt)</script></a></div></li>						
						<li><div id="sidenavoff"><script>show_words(IPV6_TEXT137)</script></a></div></li>
						<li><div id="sidenavon"><a href="mydlink.asp" onclick="return jump_if();"><script>show_words(mydlink_S01)</script></a></div></li>
					</ul>
				</div>
				</td>
			</tr>
			</tbody>
		</table></td>

	<form id="form1" name="form1" method="post" action="">
		<td valign="top" id="maincontent_container">
			<!-- ######################### -->
			<!--          main part        -->
			<!-- ######################### -->
		<div id="maincontent">
			<div id=box_header>
				<h1><script>show_words(ipv6)</script></h1>
				<script>show_words(IPV6_TEXT28)</script><br>
				<br>
				<input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
				<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'ipv6_link_local.asp');">
				<script>$('#button').val(get_words('_savesettings'));</script>
				<script>$('#button2').val(get_words('_dontsavesettings'));</script>
			</div>
			<div class=box>
				<h2 style=" text-transform:none">
				<script>show_words(IPV6_TEXT29)</script></h2>
				<p class="box_msg"><script>show_words(IPV6_TEXT30)</script></p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
					<td align=right width="187" class="duple"><script>show_words(IPV6_TEXT31)</script> :</td>
					<td width="331">&nbsp; <select name="ipv6_w_proto" id="ipv6_w_proto" onChange='change_ipv6_type()'>
						<option value="0"><script>show_words(IPV6_TEXT138)</script></option>
						<option value="1"><script>show_words(IPV6_TEXT32)</script></option>
						<option value="2"><script>show_words(IPV6_TEXT107)</script></option>
						<option value="3"><script>show_words(IPV6_TEXT34)</script></option>
						<option value="4"><script>show_words(IPV6_TEXT35)</script></option>
						<option value="5"><script>show_words(IPV6_TEXT36)</script></option>
						<option value="6"><script>show_words(IPV6_TEXT139)</script></option>
						<option value="7" selected><script>show_words(IPV6_TEXT37)</script></option>
					</select></td>
				</tr>
				</table>
			</div>
			<div class=box id=lan_ipv6_settings>
				<h2 style=" text-transform:none"><script>show_words(IPV6_TEXT44)</script></h2>
				<p class="style2"><script>show_words(IPv6_Local_Info)</script></p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
					<td width="225" ><b><script>show_words(IPV6_TEXT47)</script> :</b></td>
					<td width="310">&nbsp;<b><span id="lan_link_local_ip"></span></b></td>
				</tr>
				<tr id="tr_ula_lan_ip">
					<td width="225" ><b><script>show_words(IPV6_ULA_TEXT08)</script> :</b></td>
					<td width="310">&nbsp;<b><span id="lan_ula_ip"></span></b></td>
				</tr>
				</table>
			</div>
		</td>
	</form>
		<td valign="top" width="150" id="sidehelp_container" align="left">
			<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
			<tbody>
			<tr>
				<td id=help_text><b><script>show_words(_hints)</script>&hellip;</b>
					<p><script>show_words(IPV6_TEXT58)</script></p>
					<p><script>show_words(IPV6_TEXT59)</script></p>
					<p><a href="support_internet.asp#ipv6" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
				</td>
			</tr>
			</tbody>
			</table>
		</td>
	</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
	<tr>
		<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
		<td width="10">&nbsp;</td><td>&nbsp;</td>
	</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
</html>