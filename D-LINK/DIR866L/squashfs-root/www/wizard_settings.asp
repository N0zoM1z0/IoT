<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {color: #FF6600}
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="Javascript" src="/wizard_lang.js"></script>
<script language="Javascript" src="/public.js"></script>
<script language="JavaScript">
	var count = 15;
	
	
	function onPageLoad(){
		var temp_count= "<!--# echo countdown_time -->";
		if(temp_count != ""){
			count = parseInt(temp_count);
		}
		get_by_id("html_response_page").value = get_by_id("html_response_return_page").value;
	}
	
	function do_count_down(){
		if (count == 0) {	   
			//send_submit("form1");
	        window.location.href ="login_pic.asp";
			//back();
			return;
	    }else {				
			count--;
			setTimeout('do_count_down()',1000);
		}
		
	}

	function back(){
		var login_who=checksessionStorage();
		if(login_who== "user"){
			window.location.href ="index.asp";
		}else{
			window.location.href = get_by_id("html_response_page").value;
		}
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<div>
<div id="form1_show" name="form1_show" style="display">
<form id="form1" name="form1" method="post">
	<input type="hidden" id="html_response_page" name="html_response_page" value="index.asp">
	<input type="hidden" id="html_response_message" name="html_response_message" value="<!--# echo html_response_message -->">
	<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<!--# echo html_response_return_page -->">
	<input type="hidden" id="action" name="action" value="setup_wizard_cancel">
	<input type="hidden" id="setup_mydlink_cancel" name="setup_mydlink_cancel" value="1">
	<input type="hidden" name="reboot_type" value="none">
	<table width="838" height="100" border=0 align="center" cellPadding=0 cellSpacing=0 id=table_shell>
		<tr><td bgcolor="#FFFFFF"><div align="center">
			<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
				<tr>
				<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
				<td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
				<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
				<td>&nbsp;</td>
				</tr>
			</table>
			<img src="/wlan_masthead.gif" width="836" height="92">
		</div></td></tr>
		<tr>
			<td>
				
				<table width="838" border=0 align="center" cellPadding=0 cellSpacing=0 >		
					<tr><td bgcolor="#FFFFFF"></td></tr>
					<tr><td bgcolor="#FFFFFF"></td></tr>
					<tr><td bgcolor="#FFFFFF"><p>&nbsp;</p>
						<table width="650" border="0" align="center">
							<tr><td height="15"><div class=box>
								<h2><script>show_words(_savesettings);</script>&hellip;</h2>
								<p class="centered"><script>show_words(_setup_wizard_mydlink_info_12);</script></p>
								<p class="centered"><script>show_words(_please_wait);</script></p>
								<br>
							</div></td></tr>
							<tr>	
								<td><div align="center"><span id="show_sec"></span></div></td>								
							</tr>
						</table>
						<p>&nbsp;</p>
					</td></tr>
					<tr>
						<td bgcolor="#FFFFFF">
							<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
								<tr>
									<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
									<td width="10">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>     
			</td>
		</tr>
	</table>
</form>
</div>
<div id="copyright"><script>show_words(_copyright);</script></div>
</div>
</BODY>
<script>
	onPageLoad();
	do_count_down();
</script>
</html>
