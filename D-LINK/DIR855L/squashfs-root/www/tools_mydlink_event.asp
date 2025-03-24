<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script language="JavaScript" src="/lang_<!--# echo language -->.js"></script>
<script language="JavaScript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	function push_event_click(obj_chk) {
		var is_disabled = !obj_chk;
		get_by_id("log_user_checkbox").disabled = is_disabled;
		get_by_id("log_fwup_checkbox").disabled = is_disabled;
		get_by_id("log_wire_checkbox").disabled = is_disabled;
	}
	
	function send_request(){	
		if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
			return false;
		}
		if(get_by_id("dnsquery_enable").checked)
			get_by_id("log_dnsquery_enable").value = "1";
		else
			get_by_id("log_dnsquery_enable").value = "0";
//---------------------------------------------------------------------------			
		if(get_by_id("push_event_traffic_shaping").checked)
			get_by_id("logopt_enable").value = "1";
		else
			get_by_id("logopt_enable").value = "0";	
//---------------------------------------------------------------------------		
		if(get_by_id("log_user_checkbox").checked)
			get_by_id("logopt_userloginfo").value = "1";
		else
			get_by_id("logopt_userloginfo").value = "0";				
//---------------------------------------------------------------------------		
		if(get_by_id("log_fwup_checkbox").checked)
			get_by_id("logopt_fwupgrade").value = "1";
		else
			get_by_id("logopt_fwupgrade").value = "0";				
//---------------------------------------------------------------------------		
		if(get_by_id("log_wire_checkbox").checked)
			get_by_id("logopt_wirelesswarn").value = "1";
		else
			get_by_id("logopt_wirelesswarn").value = "0";	
//---------------------------------------------------------------------------					
		if(get_by_id("trigger_event").checked)
			get_by_id("trigger_event_enable").value = "1";
		else
			get_by_id("trigger_event_enable").value = "0";		
	}
	
	function onPageLoad() {
		set_checked("<!--# echo log_dnsquery_enable -->", get_by_id("dnsquery_enable"));
		
		set_checked("<!--# echo logopt_enable -->", get_by_id("push_event_traffic_shaping"));
		set_checked("<!--# echo logopt_userloginfo -->", get_by_id("log_user_checkbox"));
		set_checked("<!--# echo logopt_fwupgrade -->", get_by_id("log_fwup_checkbox"));
		set_checked("<!--# echo logopt_wirelesswarn -->", get_by_id("log_wire_checkbox"));
		
		set_checked("<!--# echo trigger_event_enable -->", get_by_id("trigger_event"));
	
		if(get_by_id("push_event_traffic_shaping").checked){
			get_by_id("log_user_checkbox").disabled = false;
			get_by_id("log_fwup_checkbox").disabled = false;
			get_by_id("log_wire_checkbox").disabled = false;
		}else{
			get_by_id("log_user_checkbox").disabled = true;
			get_by_id("log_fwup_checkbox").disabled = true;
			get_by_id("log_wire_checkbox").disabled = true;
		}
		
		var login_who= "<!--# echo get_current_user -->";
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);	
		} 
			set_form_default_values("form1");		
	}
	
	function dnsquery_buttons(){
		var enable = get_by_id("dnsquery_enable");	
	}
	
	function trigger_buttons(){
		var enable = get_by_id("trigger_event");	
	}
	
</script>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
	<!--
	.style1 {font-size: 11px}
	-->
</style>
</head>
<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
  <tr>
<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();"><!--# echo model_number --></a></td>
	<td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
	<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
	<td>&nbsp;</td>
  </tr>
</table>
<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
	<tr><td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td></tr>
</table>
<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
	<tr id="topnav_container">
		<td><img src="/short_modnum.gif" width="125" height="25"></td>
	<script>show_top("tools");</script>
	</tr>
</table>
<table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
	<tr>
		<td id="sidenav_container" valign="top" width="125" align="right">
		<table cellSpacing=0 cellPadding=0 border=0>
		<tr>
		  <td id=sidenav_container>
			<div id=sidenav>
			  <UL>
				<ul><script>show_left("tools", 9);</script></ul>
			  </UL>
			</div>
		  </td>
		</tr>
		</table></td>
		
		<form id="form1" name="form1" method="post" action="apply.cgi">
		<input type="hidden" id="html_response_page" name="html_response_page" value="reboot.asp">
		<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_mydlink_event.asp">
		<input type="hidden" id="action" name="action" value="tools_mydlink_event">
		<input type="hidden" id="reboot_type" name="reboot_type" value="qos">
		<input type="hidden" id="log_dnsquery_enable" name="log_dnsquery_enable" value="<!--# echo log_dnsquery_enable -->">
		<input type="hidden" id="trigger_event_enable" name="trigger_event_enable" value="<!--# echo trigger_event_enable -->">
		<input type="hidden" id="logopt_enable" name="logopt_enable" value="<!--# echo logopt_enable -->">
		<input type="hidden" id="logopt_userloginfo" name="logopt_userloginfo" value="<!--# echo logopt_userloginfo -->">
		<input type="hidden" id="logopt_fwupgrade" name="logopt_fwupgrade" value="<!--# echo logopt_fwupgrade -->">
		<input type="hidden" id="logopt_wirelesswarn" name="logopt_wirelesswarn" value="<!--# echo logopt_wirelesswarn -->">
		
		<td valign="top" id="maincontent_container">
			<div id="maincontent">
			  <div id=box_header>
				<h1><script>show_words(_mydlink_even)</script></h1>
				  <script></script><br><br>
				  <input name="button" id="button" type="submit" class=button_submit value="" onClick=" return send_request()">
				  <input name="button1" id="button1" type="button" class=button_submit value="" onclick="return page_cancel('form1', 'tools_mydlink_event.asp');">
				  <script>check_reboot();</script>
				  <script>get_by_id("button").value = _savesettings;</script>
				  <script>get_by_id("button1").value = _dontsavesettings;</script>
			  </div>
			  <br>
			  <div class=box>
				<h2><script>show_words(_mydlink_info0)</script></h2>
				<table width=525>
				<tr>
					<td width="185" align=center class="duple"><script>show_words(_enable)</script> :</td>
					<td width="333">&nbsp;
					<input type="checkbox" id="dnsquery_enable" name="dnsquery_enable" value="1" onClick="dnsquery_buttons();">		
					</td>
				</tr>
				</table>
			  </div>
			  <br>
			  <div class=box>
				<h2><script>show_words(_mydlink_info1)</script></h2>
				<table width=525>
				<tr>
					<td width="185" align=center class="duple"><script>show_words(_enable)</script> :</td>
					<td width="333">&nbsp;
					<input type="checkbox" id="push_event_traffic_shaping" name="push_event_traffic_shaping" value="1" onClick="push_event_click(this.checked);">		
					</td>
				</tr>
				</table>
				
				<table cellSpacing=1 cellPadding=2 width=525 align="center">
					<tr>
					<td class=l_tb>
					<input type="checkbox" id="log_user_checkbox" name="log_user_checkbox" value="1">
					<script>show_words(_mydlink_info2)</script></td>

					<td class=l_tb>
					<input type="checkbox" id="log_fwup_checkbox" name="log_fwup_checkbox" value="1">
					<script>show_words(_mydlink_info3)</script></td>

					<td class=l_tb>
					<input type="checkbox" id="log_wire_checkbox" name="log_wire_checkbox" value="1">
					<script>show_words(_mydlink_info4)</script></td>

					</tr>
				</table>
				
			  </div>
			  <br>
			  <div class=box>
				<h2><script>show_words(_mydlink_info5)</script></h2>
				<table width=525>
				<tr>
					<td width="185" align=center class="duple"><script>show_words(_enable)</script> :</td>
					<td width="333">&nbsp;
					<input type="checkbox" id="trigger_event" name="trigger_event" value="1" onClick="trigger_buttons();">	
					</td>
				</tr>
				</table>
			  </div>
			</div>
		 </td></form>
		<td valign="top" width="150" id="sidehelp_container" align="left">
			<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff  cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
				<tr>
					<td id=help_text><strong><b><strong><script>show_words(_hints)</script></strong></b>&hellip;</strong>
						<p><script>show_words(hhase_intro)</script>
						<p class="more"><a href="support_adv.asp#Traffic_Shaping" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
				   </TD>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
	<tr>
		<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
		<td width="10">&nbsp;</td><td>&nbsp;</td>
	</tr>
</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
</html>
