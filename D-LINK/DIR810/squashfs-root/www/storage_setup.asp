<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<link rel="stylesheet" href="js/jquery.treeview.css" />
<link rel="stylesheet" href="js/jquery-ui.css" type="text/css"/>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<script type="text/javascript" src="uk.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="Javascript" src="js/jquery.treeview.js"></script>
<script language="Javascript" src="js/jquery-ui.min.js"></script>
<script language="JavaScript">
	var dev_info = get_router_info();
	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;
	var sendSubmit  = false;
	
	document.title = get_words('TEXT000');
</script>
</head>
<body onload="" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
		<tr>
			<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support"><script>document.write(model);</script></a></td>
			<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(hw_version);</script> &nbsp;</td>
			<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(version);</script></td>
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
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">        <tr>
		<td id="sidenav_container" valign="top" width="125" align="right">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td id="sidenav_container">
						<div id="sidenav">
							<ul>
								<li><div id="sidenavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(sa_Internet)</script></a></div></li>
								<li><div id="sidenavon"><a href="wizard_wireless.asp" onclick="return jump_if();"><script>show_words(_wirelesst)</script></a></div></li>
								<li><div id="sidenavon"><a href="lan.asp" onclick="return jump_if();"><script>show_words(bln_title_NetSt)</script></a></div></li>
								<li><div id="sidenavoff"><script>show_words(storage)</script></div></li>
								<li><div id="sidenavon"><a href="setup_ipv6.asp" onclick="return jump_if();"><script>show_words(IPV6_TEXT137)</script></a></div></li>
								<li><div id="sidenavon"><a href="mydlink.asp" onclick="return jump_if();"><script>show_words(mydlink_S01)</script></a></div></li>
							</ul>
						</div>
					</td>
				</tr>
			</table>
		</td>
		<td valign="top" id="maincontent_container">
			<!-- ######################### -->
			<!--          main part        -->
			<!-- ######################### -->
		<div id=maincontent>
			<div id=box_header> <!-- remember to add all the <script></script> back to the string -->
				<h1><script>show_words(storage)</script></h1>
				<p><script>show_words(sh_port_tx_01)</script></p>
				<p><script>show_words(sh_port_tx_02)</script></p>
			</div>

			<div class=box>
				<h2><script>show_words(sh_port_tx_03)</script></h2>
				<P><script>show_words(sh_port_tx_04)</script></P>
				<P class=centered><input value='&trade;' name="wizard_storage" id="wizard_storage" type="button" class=button_submit onclick=window.location.href="wizard_storage.asp">
				<script>$("#wizard_storage").val(get_words(sh_port_tx_00a)+$("#wizard_storage").val() +" "+ get_words(sh_port_tx_00b) +" "+get_words(wwa_setupwiz));</script>
				</p>
			</div>

			<div class=box>
				<h2><script>show_words(sh_port_tx_05)</script></h2>
				<P><script>show_words(sh_port_tx_06)</script></P>
				<P class=centered><input value='&trade;' name="storage" id="storage" type="button" class=button_submit onclick=window.location.href="storage.asp">
				<script>$("#storage").val(get_words(sh_port_tx_00a)+$("#storage").val() +" "+ get_words(sh_port_tx_00b) +" "+get_words(ES_manual_btn));</script>
				</p>
			</div>
		</div></td>
  			<!-- ######################### -->
			<!--      end of main part     -->
			<!-- ######################### -->
		<td valign="top" width="150" id="sidehelp_container" align="left">
			<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
				<tr>
					<td id=help_text>
						<strong><script>show_words(_hints)</script>&hellip;</strong> 
						<p><script>show_words(sto_help)</script></p>
						<p class="more"><a href="support_internet.asp#storage" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
					</td>					
				</tr>
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
<script>

</script>
</html>
