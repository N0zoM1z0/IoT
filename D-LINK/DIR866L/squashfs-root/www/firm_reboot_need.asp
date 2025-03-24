<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
function do_reboot(is_true){
	if(is_true && get_by_id("asp_temp_51").value.length > 0){
		get_by_id("form1").action = "reboot.cgi";
		get_by_id("html_response_page").value = "reboot.asp";
		get_by_id("reboot_type").value = get_by_id("asp_temp_51").value;
		get_by_id("asp_temp_51").value = "";
		send_submit("form1");
	}else{
		window.location.href = get_by_id("html_response_return_page").value;
	}
}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();"><!--# echo model_number --></a></td>
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
			<td id="topnavoff"><a href="index.asp"><script>show_words(_setup)</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp"><script>show_words(_advanced);</script></a></td>
			<td id="topnavon"><a href="tools_admin.asp"><script>show_words(_tools);</script></a></td>
			<td id="topnavoff"><a href="st_device.asp"><script>show_words(_status);</script></a></td>
			<td id="topnavoff"><a href="support_men.asp"><script>show_words(_support);</script></a></td>
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
									<li><div><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_admin);</script></a></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(_time);</script></a></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(_syslog);</script></a></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(te_EmSt)</script></a></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(_system)</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(_firmware)</script></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();"><script>show_words(_dyndns)</script></a></div></li>
								  	<li><div><a href="tools_vct.asp" onclick="return jump_if();"><script>show_words(_syscheck)</script></a></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(_scheds);</script></a></div></li>
									
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="reboot_need">
				<div id=maincontent>
                  <div id=box_header>
                    <h1><script>show_words(YM1);</script></h1>
                  	<p><script>show_words(YM2);</script></p>
                  	<form id="form1" name="form1" method="post" action="apply.cgi">
						<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
						<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<!--# echo html_response_return_page -->">
						<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<!--# echo asp_temp_51 -->">
						<input type="hidden" id="reboot_type" name="reboot_type" value="none">
						<input class="button_submit" id="button1"type="button" value="" onclick="do_reboot(true);">
							<script>get_by_id("button1").value= YM3;</script>
						<input class="button_submit" id="button2" type="button" value="Reboot Later" onclick="do_reboot(false);">
							<script>get_by_id("button2").value=YM4;</script>
					</form>
                  </div>     
			  </div>
			</td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id="help_text">
							<strong><script>show_words(_hints);</script>&hellip;</strong>
							<p><script>show_words(ZM17);</script></p>
							<p class="more"><a href="support_tools.asp#Firmware" onclick="return jump_if();"><script>show_words(_more);</script>&hellip;</a></p>
					  </td>
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
