<html>
	<head>
		<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
		<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
		<link rel="STYLESHEET" type="text/css" href="/css_router.css">
		<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
		<script type="text/javascript" src="/lang.js"></script>
		<script language="JavaScript" src="public.js"></script>
		<script language="JavaScript" src="public_msg.js"></script>
		<script language="JavaScript" src="public_ipv6.js"></script>
		<script language=JavaScript>
			var submit_button_flag = 0;
			
			function onPageLoad(){
				set_checked("<!--# echo tr069_inform_enable -->", get_by_id("d_enable"));
				set_checked("<!--# echo tr069_cwmp_enable -->", get_by_id("cwmp_enable"));
			}
		
			function send_request(){
				if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
					return;
				}
			
				get_by_id("tr069_inform_enable").value = get_checked_value(get_by_id("d_enable"));
				get_by_id("tr069_cwmp_enable").value = get_checked_value(get_by_id("cwmp_enable"));

					if(submit_button_flag == 0){
						submit_button_flag = 1;
						send_submit("form1");
					}
			}		
			
			function loadConfirm(){
				var btn_restore = get_by_id("load");
				
				if (btn_restore.disabled) {
					alert (ta_alert_4);
					return;
				}
				
				if (get_by_id("file").value == "") {
					alert(ta_alert_5);
					return;
				}
				
				var file_name=get_by_id("file").value;
				var ext_file_name=file_name.substring(file_name.lastIndexOf('.')+1,file_name.length);
//				if (ext_file_name!="bin"){ //check file name
//					 alert(rs_intro_1);
//					 return;
//				}
				
				btn_restore.disabled = true;
				
				var inf = get_by_id("restore_info");
				if(confirm(tool_system_1)){
					inf.innerHTML = tool_system_2;
					try {
						send_submit("form2");
					} catch (e) {
						alert("Error: " + e.message);
						inf.innerHTML = "&nbsp;";
						btn_restore.disabled = false;
					}
				}else{
					inf.innerHTML = "&nbsp;";
					btn_restore.disabled = false;
				}
			}
		
		</script>
		<style type="text/css">
			<!--
			.style1 {font-size: 11px}
			-->
		</style>
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
										<!--<script>show_left("Setup", 6);</script>-->
									</ul>
								</div>
							</td>			
						</tr>
					</table>			
				</td>
				<td valign="top" id="maincontent_container">
						<div id="maincontent">
							<!-- === BEGIN MAINCONTENT === -->
							<div id="box_header"> 
								<h1>TR-069 client - Configuration</h1>
								<p>
									WAN Management Protocol(TR-069) allows a Auto-Configuration Server (ACS) to perform auto-configuration, provision, collection, and diagnostics to this device.
								</p>	
								<br>
								<input id="button3" name="button3" type="button" class=button_submit value="" onClick="send_request()">
								<input id="button2" name="button2" type=reset class=button_submit value="" onclick="return page_cancel('form1', 'tools_tr069.asp');">
								<script>check_reboot();</script>
								<script>get_by_id("button3").value = _savesettings</script>
								<script>get_by_id("button2").value = _dontsavesettings</script>
							</div>
							
							<!-- MAIN -->
							<div class="box">
								<h2>TR-069 client - Setting</h2>
								<table cellSpacing=1 cellPadding=2 width=525 border=0>
									<form  name="form1" id="form1" method="post" action="apply.cgi">
									<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
									<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
									<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_tr069.asp">				
									<input type="hidden" id="action" name="action" value="tools_tr069">
									<tr>
										<td width=200 class="duple">Inform :</td>
										<td height=20>&nbsp;
											<input name="d_enable" type="checkbox" id="d_enable" value="1">
											<input type="hidden" id="tr069_inform_enable" name="tr069_inform_enable" value="<!--# echo tr069_inform_enable -->">
										</td>
									</tr>
									<tr>
										<td class="duple">Inform Interval :</td>
										<td height=20>&nbsp;&nbsp;
											<input type="text" id="tr069_inform_interval" name="tr069_inform_interval" size="40" maxlength="60" value="<!--# echo tr069_inform_interval -->">
										</td>
									</tr>
									<tr>
										<td width=200 class="duple">CWMP :</td>
										<td height=20>&nbsp;
											<input name="cwmp_enable" type="checkbox" id="cwmp_enable" value="1">
											<input type="hidden" id="tr069_cwmp_enable" name="tr069_cwmp_enable" value="<!--# echo tr069_cwmp_enable -->">
										</td>
									</tr>									
									<tr>
										<td class="duple">ACS URL :</td>
										<td height=20>&nbsp;&nbsp;
											<input type="text" id="tr069_acs_url" name="tr069_acs_url" size="40" maxlength="60" value="<!--# echo tr069_acs_url -->">
										</td>
									</tr>
									<tr>
										<td class="duple">ACS User Name :</td>
										<td height=20>&nbsp;&nbsp;
											<input type="text" id="tr069_acs_usr" name="tr069_acs_usr" size="40" maxlength="60" value="<!--# echo tr069_acs_usr -->">
										</td>
									</tr>
									<tr>
										<td class="duple">ACS Password :</td>
										<td height=20>&nbsp;&nbsp;
											<input type="text" id="tr069_acs_pwd" name="tr069_acs_pwd" size="40" maxlength="60" value="<!--# echo tr069_acs_pwd -->">
										</td>
									</tr>
									<tr>
										<td class="duple">Connection Request User Name :</td>
										<td height=20>&nbsp;&nbsp;
											<input type="text" id="tr069_cpe_usr" name="tr069_cpe_usr" size="40" maxlength="60" value="<!--# echo tr069_cpe_usr -->">
										</td>
									</tr>
									<tr>
										<td class="duple">Connection Request Password :</td>
										<td height=20>&nbsp;&nbsp;
											<input type="text" id="tr069_cpe_pwd" name="tr069_cpe_pwd" size="40" maxlength="60" value="<!--# echo tr069_cpe_pwd -->">
										</td>
									</tr>
									<tr>
										<td class="duple">Connection Request URL :</td>
										<td height=20>&nbsp;&nbsp;
											<input type="text" id="tr069_cpe_url" name="tr069_cpe_url" size="40" maxlength="60" value="<!--# echo tr069_cpe_url -->">
										</td>
									</tr>
									</form>
								</table>
							</div>
							<!-- MAIN -->
							
							<!-- UPLOAD -->
							<div class="box">
								<h2>TR-069 CA file upload</h2>
								<table width=525 border=0 cellpadding=0>		
									<form id="form2" name="form2" method="post" action="upload_tr_ca.cgi" enctype="multipart/form-data">
									<input type="hidden" id="html_response_page" name="html_response_page" value="tools_tr069.asp">
									<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_tr069.asp">
									<tr>
										<td height="72" valign="top" class="duple">Load CA file From Local Hard Drive:</td>
										<td valign="top">&nbsp;
											<input type=file id=file name=file size=20><br>&nbsp;
											<input type="button" value="" id="load" name="load" onclick="loadConfirm()"><br>
											<script>get_by_id("load").value = "Upload certificate from File";</script>
											<span class="msg_inprogress" id="restore_info">&nbsp;</span>
										</td>
									</tr>
									</form>
								</table>	
							</div>
							<!-- UPLOAD -->
							
							<!-- === END MAINCONTENT === -->
							<p>&nbsp;</p>
						</div>
				</td>
				<td valign="top" width="150" id="sidehelp_container" align="left">
					<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
						<tr>
							<td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong>
								<p><script></script></p>
								<p><script></script></p>
								<p class="more"><a href="support_internet.asp#Internet"><script>show_words(_more)</script>&hellip;</a></p>
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
	<script>
		reboot_needed(left["tools"].link[6]);
		onPageLoad();
		set_form_default_values("form1");
	</script>
</html>
