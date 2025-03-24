<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="Javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	function onPageLoad() {
		var mydlink_ser = "<!--# echo register_st -->"; //nvram server key
		var mydlink_acc = "<!--# echo mydlink_EmailAccount -->"; //nvram mtdkink account
		var login_who = checksessionStorage();
		if(login_who == "user") {
			//get_by_id("wizard").disabled = true;
            get_by_id("button").disabled = true;
            get_by_id("button1").disabled = true;
            get_by_id("button2").disabled = true;
		}
		
		if (mydlink_ser == 1){
			get_by_id("mydlink_status").innerHTML = _registered;
			get_by_id("mydlink_emailaccount").innerHTML = mydlink_acc;
			get_by_id("button1").disabled = true;
			
		}else{
			get_by_id("mydlink_status").innerHTML = _n_registered;
			get_by_id("show_mydlink_account").style.display = "none";
			//get_by_id("button1").disabled = false;
		}

		get_by_id("button").style.display = "none";
		get_by_id("button2").style.display = "none";
	}

	function check_admin_password() {
		var admin_password = "<!--# exec cgi /bin/stat_info mydlink_admin_check -->";
		if (admin_password.search("empty") != -1) {
			alert(_pass_empty);
			window.location.href = "tools_admin.asp";
			return false;
		} else if (admin_password.search("false") != -1) {
			alert(wizard_check_passwd_length);
			return false;
		} else
			window.location.href='setup_mydlink.asp';
	}
	
	function do_test_mail(){
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
	<tr>
		<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
		<td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
		<td>&nbsp;</td>
	</tr>
</table>
<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
	<tr>
		<td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td>
	</tr>
</table>
<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
	<tr id="topnav_container">
		<td><img src="/short_modnum.gif" width="125" height="25"></td>
		<script>show_top("setup");</script>
	</tr>
</table>
<table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
	<tr>
		<td id="sidenav_container" valign="top" width="125" align="right">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td id="sidenav_container">
				<div id="sidenav">
					<ul>
						<script>show_left("Setup", 11);</script>
					</ul>
				</div></td>
			</tr>
		</table></td>
		<td valign="top" id="maincontent_container">
		<div id=maincontent>
			<div id=box_header>
				<h1><script>show_words(_mydlink_set)</script></h1>
				<p><script>show_words(_mydlink_info6)</script></p>
				<input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
				<input name="button2" id="button2" type="button" class=button_submit value="" onclick="return page_cancel('form1', 'adv_virtual.asp');">
				<script>check_reboot();</script>
				<script>get_by_id("button").value = _savesettings;</script>
				<script>get_by_id("button2").value = _dontsavesettings;</script>
			</div>
			<div class=box>
				<h2><script>show_words(_mydlink)</script></h2>
				<table cellpadding="1" cellspacing="1" border="0" width="525">
					<tr>
						<td class="duple"><script>show_words(_mydlink_service)</script>:</td>
						<td width="340">&nbsp;&nbsp;<span id="mydlink_status"></span></td>
					</tr>
					<tr id="show_mydlink_account">
						<td class="duple"><script>show_words(_mydlink_account)</script>:</td>
						<td width="340">&nbsp;&nbsp;<span id="mydlink_emailaccount"></span></td>
					</tr>
				</table>
			</div>
			<div class=box>
				<h2><script>show_words(_reg_mydlink_service)</script></h2>
				<table cellpadding="1" cellspacing="1" border="0" width="525">
					<tr>
						<td>
						<td width="340">&nbsp;
							<input id="button1" name="button1" type=button class=button_submit value="" onClick="check_admin_password()">
							<script>get_by_id("button1").value = _reg_mydlink_service;</script>
						</td>
						</td>
					</tr>
				</table>
			</div>
			
		</div></td>
		<td valign="top" width="150" id="sidehelp_container" align="left">
		<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
			<tr>
				<td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong>
					<!--<p><script>show_words(LW33)</script></p>-->
					<!--<p><script>show_words(LW34)</script></p>-->
					<p class="more"><a href="support_internet.asp#Internet"><script>show_words(_more)</script>&hellip;</a></p>
				</td>
			</tr>
		</table></td>
	</tr>
</table>
<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
	<tr>
		<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
		<td width="10">&nbsp;</td><td>&nbsp;</td>
	</tr>
</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script>
</div>
<br>
</body>
<script>
    reboot_needed(left["Setup"].link[6]);
	onPageLoad();
</script>
</html>
