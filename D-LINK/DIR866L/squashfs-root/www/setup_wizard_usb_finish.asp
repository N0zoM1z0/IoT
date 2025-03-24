<html>
	<head>
		<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
		<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
		<link rel="STYLESHEET" type="text/css" href="/css_router.css">
		<script language="Javascript" src="/lang_<!--# echo language -->.js"></script>
		<script language="Javascript" src="/lang.js"></script>
		<script language="Javascript" src="public.js"></script>
		<script language="Javascript">
			var button_prev = 0;
			var browserName = navigator.userAgent.toLowerCase();
			
			function onPageLoad()
			{
        get_by_id("admin_password").value = ssid_decode("admin_password_display");
				/* detect usb */
				var detect_usb = "";
				detect_usb = "<!--# exec cgi /bin/file_access usb_count -->";
				//alert("detect_usb:" + detect_usb);
				
				if(parseInt(detect_usb) == 0)  	// 0:no usb device
				{
					/* redirect to show fail page */
					get_by_id("html_response_page").value = "setup_wizard_usb_fail.asp";
					get_by_id("setup_wizard_pre_page").value = "setup_wizard_detect_usb.asp";
					get_by_id("action").value = "response_page"; //setup_wizard will really run setup
					disable_all_btn(true);
					send_submit("form1");
				}else{
					get_by_id("w1").style.display = "";
				
					/* copy wi-fi profile to usb */
					"<!--# exec cgi /bin/webBaseWifi profile -->"
					
					get_by_id("prev_b2").disabled = false;
					get_by_id("next_b2").disabled = false;
					get_by_id("cancel_b2").disabled = false;
				
				}
			}
			
			function send_request()
			{		
				if (confirm(_setup_wizard_info)){
					/* 1.04R1 modify bookmark lan device name : dlinkrouter */
					var title = _setup_wizard_info2;
					var url = "http://";
					/* get lan device name */
					if("<!--#  echo wlan0_mode -->" == "ap"){
						url += "<!--#  echo lan_device_name_ap -->";
					}else{ // rt
						url += "<!--#  echo lan_device_name -->";
					}				
				
					if(/msie/i.test(browserName) && !/opera/.test(browserName) || /firefox/i.test(browserName)){
						if (window.sidebar) { // Mozilla Firefox Bookmark
							window.sidebar.addPanel(title, url, "");
						} else if (window.external) { // IE Favorite
							window.external.AddFavorite(url, title);
						}
					}	
				}
				
				disable_all_btn(true);
				send_submit("form1");
			}
			
			function wz_cancel()
			{
				if (confirm(_setup_wizard_17)){
					disable_all_btn(true);
					send_submit("form2");
				}
			}
			
			function go_back()
			{
				get_by_id("html_response_page").value = "setup_wizard_detect_usb.asp";
				disable_all_btn(true);
				send_submit("form1");
			}
		
		</script>
	</head>
	<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onload="onPageLoad();">
		<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
			<tr>
				<td bgcolor="#FFFFFF">
					<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
						<tr>
							<td bgcolor="#FFFFFF">
								<div align=center>
									<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
										<tr>
											<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
											<td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
											<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
											<td>&nbsp;</td>
										</tr>
									</table>
									<img src="/wlan_masthead.gif" width="836" height="92" align="middle"> 
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td bgcolor="#FFFFFF">
					<p>&nbsp;</p>
					<table width="650" border="0" align="center">
						<tr>
							<td>
								<div class=box>
									<div id=w1 style="display:none">
										<div align="center"></div>
										<h2 align="left"><script>show_words(_setup_wizard_usb_title);</script></h2>
										<form id="form1" name="form1" method="post" action="apply.cgi">
											<input type="hidden" name="html_response_page" id="html_response_page" value="count_down.asp">
											<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
											<input type="hidden" name="html_response_return_page" value="/">
											<input type="hidden" name="reboot_type" value="none">
											<input type="hidden" id="action" name="action" value="setup_wizard">
											<input type="hidden" id="setup_wizard_pre_page" name="setup_wizard_pre_page" value ="setup_wizard_detect_usb.asp">
											<!-- password -->
											<input type="hidden" id="admin_password_display" name="admin_password_display" value="<!--# echot admin_password -->">
											<input type="hidden" id="admin_password" name="admin_password" value="">
											<input type="hidden" id="graph_auth_enable" name="graph_auth_enable" value="<!--# echo graph_auth_enable -->">
											<input type="hidden" id="graph_enable" name="graph_enable" value="<!--# echo graph_enable -->">
											<!-- time zone -->
											<input type="hidden" id="time_zone" name="time_zone" value="<!--# echo time_zone_area -->">
											<input type="hidden" id="time_zone_area" name="time_zone_area" value="<!--# echo time_zone_area -->">
											<!-- dhcp -->
											<input type="hidden" id="wan_mac" name="wan_mac" value="<!--# echo wan_mac -->">
											<input type="hidden" id="old_wan_mac" name="old_wan_mac" value="<!--# echo wan_mac -->">
											<!-- pppoe -->
											<input type="hidden" name="wan_pppoe_dynamic_00" id="wan_pppoe_dynamic_00" value="<!--# echo wan_pppoe_dynamic_00 -->">
											<input type="hidden" name="wan_pppoe_ipaddr_00" id="wan_pppoe_ipaddr_00" value="<!--# echo wan_pppoe_ipaddr_00 -->">
											<input type="hidden" id="wan_pppoe_username_00" name="wan_pppoe_username_00" value="<!--# echo wan_pppoe_username_00 -->">
											<input type="hidden" id="wan_pppoe_password_00" name="wan_pppoe_password_00" value="<!--# echo wan_pppoe_password_00 -->">		  
											<input type="hidden" id="pppoe_pwd2" name="pppoe_pwd2" value="<!--# echo wan_pppoe_password_00 -->">
											<input type="hidden" id="wan_pppoe_service_00" name="wan_pppoe_service_00" value="<!--# echo wan_pppoe_service_00 -->">
											<!-- pptp -->
											<input type="hidden" id="wan_pptp_dynamic" name="wan_pptp_dynamic" value="<!--# echo wan_pptp_dynamic -->">
											<input type="hidden" id="wan_pptp_ipaddr" name="wan_pptp_ipaddr" value="<!--# echo wan_pptp_ipaddr -->">
											<input type="hidden" id="wan_pptp_netmask" name="wan_pptp_netmask" value="<!--# echo wan_pptp_netmask -->">
											<input type="hidden" id="wan_pptp_gateway" name="wan_pptp_gateway" value="<!--# echo wan_pptp_gateway -->">
											<input type="hidden" id="wan_pptp_server_ip" name="wan_pptp_server_ip" value="<!--# echo wan_pptp_server_ip -->">
											<input type="hidden" id="wan_pptp_username" name="wan_pptp_username" value="<!--# echo wan_pptp_username -->">
											<input type="hidden" id="wan_pptp_password" name="wan_pptp_password" value="<!--# echo wan_pptp_password -->">
											<input type="hidden" id="pptp_password2" name="pptp_password2" value="<!--# echo wan_pptp_password -->">
											
											<!-- l2tp -->
											<input type="hidden" id="wan_l2tp_dynamic" name="wan_l2tp_dynamic" value="<!--# echo wan_l2tp_dynamic -->">
											<input type="hidden" id="wan_l2tp_ipaddr" name="wan_l2tp_ipaddr" value="<!--# echo wan_l2tp_ipaddr -->">
											<input type="hidden" id="wan_l2tp_netmask" name="wan_l2tp_netmask" value="<!--# echo wan_l2tp_netmask -->">
											<input type="hidden" id="wan_l2tp_gateway" name="wan_l2tp_gateway" value="<!--# echo wan_l2tp_gateway -->">
											<input type="hidden" id="wan_l2tp_server_ip" name="wan_l2tp_server_ip" value="<!--# echo wan_l2tp_server_ip -->">
											<input type="hidden" id="wan_l2tp_username" name="wan_l2tp_username" value="<!--# echo wan_l2tp_username -->">
											<input type="hidden" id="wan_l2tp_password" name="wan_l2tp_password" value="<!--# echo wan_l2tp_password -->">
											<input type="hidden" id="l2tp_password2" name="l2tp_password2" value="<!--# echo wan_l2tp_password -->">
											
											<!-- static -->
											<input type="hidden" id="wan_static_ipaddr" name="wan_static_ipaddr" value="<!--# echo wan_static_ipaddr -->">
											<input type="hidden" id="wan_static_netmask" name="wan_static_netmask" value="<!--# echo wan_static_netmask -->">
											<input type="hidden" id="wan_static_gateway" name="wan_static_gateway" value="<!--# echo wan_static_gateway -->">
											
											<!-- dns -->
											<input type="hidden" id="opendns_enable" name="opendns_enable" value="<!--# echo opendns_enable -->">
											<input type="hidden" id="opendns_mode" name="opendns_mode">
											<input type="hidden" id="wan_primary_dns" name="wan_primary_dns" value="<!--# echo wan_primary_dns -->">
											<input type="hidden" id="wan_secondary_dns" name="wan_secondary_dns" value="<!--# echo wan_secondary_dns -->">
											<input type="hidden" id="dns_relay" name="dns_relay" value="<!--# echo dns_relay -->">
											<!-- wlan0 info -->
											<input type="hidden" id="wlan0_ssid" name="wlan0_ssid" value="<!--# echo wlan0_ssid -->">
											<input type="hidden" id="wlan0_psk_pass_phrase" name="wlan0_psk_pass_phrase" value="<!--# echo wlan0_psk_pass_phrase -->">
											<input type="hidden" id="wlan0_security" name="wlan0_security" value="<!--# echo wlan0_security -->">
											<input type="hidden" id="wlan0_psk_cipher_type" name="wlan0_psk_cipher_type" value="<!--# echo wlan0_psk_cipher_type -->">
											<!-- for check cable -->
											<input type="hidden" id="wan_cable_status" name="wan_cable_status" value="<!--# echo wan_cable_status -->">
											<input type="hidden" id="net_status" name="net_status" value="<!--# echo net_status -->">
											
											<!-- for dhcp info -->	
											<input type="hidden" id="wan_ip_value" name="wan_ip_value" value="<!--# echo wan_ip_value -->">
											<input type="hidden" id="wan_netmask_value" name="wan_netmask_value" value="<!--# echo wan_netmask_value -->">
											<input type="hidden" id="wan_gateway_value" name="wan_gateway_value" value="<!--# echo wan_gateway_value -->">
											<input type="hidden" id="wan_dns1_value" name="wan_dns1_value" value="<!--# echo wan_dns1_value -->">
											<input type="hidden" id="wan_dns2_value" name="wan_dns2_value" value="<!--# echo wan_dns2_value -->">
											
											<input type="hidden" id="wan_proto" name="wan_proto" value="<!--# echo wan_proto -->">
											<input type="hidden" id="wan_specify_dns" name="wan_specify_dns">
											
											<!-- usb_detect_finish -->	 
											<div id="usb_detect_finish"> 
												<table width="589" align="center" class=formarea>
													<tr>
														<td>
															<p><br><script>show_words(USB_DETECT_3);</script></p>
															<p><script>show_words(USB_DETECT_4);</script></p>
															<p><script>show_words(USB_DETECT_5);</script></p>
															<p><script>show_words(USB_DETECT_6);</script></p>
														</td>
													</tr>
												</table>
											</div>
											<!-- usb_detect_finish -->
										
											<br>
											<br>
										</form>
										
										<form id="form2" name="form2" method="post" action="apply.cgi">
											<input type="hidden" id="action" name="action" value="setup_wizard_cancel">
											<input type="hidden" id="html_response_page" name="html_response_page" value="login_pic.asp">
											<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="login_pic.asp">
										</form>
										
										<table align="center" class="formarea">
											<tr>
												<td>
													<input type="button" class="button_submit" id="prev_b2" name="prev_b2" value="Prev" onclick="go_back()" disabled>				
													<input type="button" class="button_submit" id="next_b2" name="next_b2" value="Finish" onclick="send_request();" disabled>
													<input type="button" class="button_submit" id="cancel_b2" name="cancel_b2" value="Cancel" onclick="wz_cancel();" disabled>
													<script>
														get_by_id("prev_b2").value = _prev;
														get_by_id("next_b2").value = _finish;
														get_by_id("cancel_b2").value = _cancel;
													</script>
												</td>
											</tr>
										</table>
									
									</div>
								</div>
							</td>
						</tr>
					</table>
					<p>&nbsp;</p>
				</td>
			</tr>
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
		<div id="copyright" align="center"><script>show_words(_copyright);</script></div>
	</body>
</html>
