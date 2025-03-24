<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script language="Javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="Javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="Javascript" src="/wizard_lang.js"></script>
<script language="Javascript">
	var button_prev = 0;
	var browserName = navigator.userAgent.toLowerCase();
	var support_dual_band = 0; // 0: signal band 1:dual band

	function onPageLoad() {
		
		show_band_info();
		
		get_by_id("wlan_mode").style.display = "";
		get_by_id("wlan0_ssid2").value = ssid_decode("wlan0_ssid");
		get_by_id("wlan0_security").value = ssid_decode("wlan0_psk_pass_phrase");
		
		if(parseInt(support_dual_band) == 1){ //support 5g dual band
			get_by_id("wlan1_ssid2").value = ssid_decode("wlan1_ssid");
			get_by_id("wlan1_security").value = ssid_decode("wlan1_psk_pass_phrase");
		}	
	}

	function show_band_info(){
		/* spec 1.05 add check signal band or dual band */
		if("<!--#  echo wlan1_enable -->" != ""){
			support_dual_band = 1;
		}
					
		if(parseInt(support_dual_band) == 0){
			get_by_id("signal_name_str").innerHTML = wwz_wwl_intro_s3_2;	
			get_by_id("signal_band24g").style.display = "none";
			get_by_id("signal_pass_str").style.display = "";
			
			get_by_id("table_dualband").style.display = "none";
		}else{ //dual band
			get_by_id("signal_name_str").innerHTML = wwz_wwl_intro_s3_4;	
			get_by_id("signal_band24g").style.display = "";
			get_by_id("signal_pass_str").style.display = "none";
			
			get_by_id("table_dualband").style.display = "";
		}
	}

	function send_request() {
		/* when not support USB, skip the Wi-PnP */
		var psk_value = get_by_id("wlan0_security").value;
		var ssid = get_by_id("wlan0_ssid2").value;
		if(!(check_ssid("wlan0_ssid2"))){
				return false;
		}

		if(parseInt(support_dual_band) == 1){ //support 5g dual band
			var ssid1 = get_by_id("wlan1_ssid2").value;
			if(!(check_ssid("wlan1_ssid2"))){
				return false;
		}
		}	
		
		if(psk_value.length < 8) {
			alert(GW_WLAN_WPA_PSK_LEN_INVALID);
			return false;
		} else if(psk_value.length > 63) {
			if(!isHex(psk_value)) {
				alert(GW_WLAN_WPA_PSK_LEN_INVALID);
				return false;
			}
		}
		get_by_id("wlan0_ssid").value = ssid;
		get_by_id("wlan0_psk_pass_phrase").value = psk_value;
		
		if(parseInt(support_dual_band) == 1){ //support 5g dual band
			var psk_value1 = get_by_id("wlan1_security").value;
			var ssid1 = get_by_id("wlan1_ssid2").value;
			
			if(psk_value1.length < 8) {
				alert(GW_WLAN_WPA_PSK_LEN_INVALID);
				return false;
			} else if(psk_value1.length > 63) {
				if(!isHex(psk_value1)) {
					alert(GW_WLAN_WPA_PSK_LEN_INVALID);
					return false;
				}
			}
			get_by_id("wlan1_ssid").value = ssid1;
			get_by_id("wlan1_psk_pass_phrase").value = psk_value1;
		}	
		
		send_submit("form1");
	}

	function wz_cancel() {
		if(confirm(_setup_wizard_17)) {
			disable_all_btn(true);
			send_submit("form2");
		}
	}

	function go_back() {

		if(button_prev == 1) {
			get_by_id("wlan_mode").style.display = "";
			get_by_id("next_b2").style.display = "";
			get_by_id("wz_complete").style.display = "none";
			get_by_id("save_connect").style.display = "none";
			button_prev = 0;
		} else {
			
			/* spec 1.05: when dhcpc: prev redirect to setup_wizard_detect.asp */
			if(get_by_id("wan_proto").value == "dhcpc"){
				get_by_id("html_response_page").value = "setup_wizard_detect.asp";	
			}else{
				/* pppoe pptp l2tp: prev redirect to wan setting */ 
				get_by_id("html_response_page").value = "setup_wizard_wan.asp";	
			}	
			
			get_by_id("action").value = "response_page";
			disable_all_btn(true);
			send_submit("form1");
		}

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
				</div></td>
			</tr>
		</table></td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF"><p>&nbsp;</p>
		<table width="650" border="0" align="center">
			<tr>
				<td>
				<div class=box>
					<div id=w1>
						<div align="center"></div>
						<form id="form1" name="form1" method="post" action="apply_sec.cgi">
							<input type="hidden" name="html_response_page" id="html_response_page" value="setup_wizard_save.asp">
							<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
							<input type="hidden" name="html_response_return_page" value="setup_wizard_save.asp">
							<input type="hidden" name="reboot_type" value="none">
							<input type="hidden" id="action" name="action" value="response_page">
							<input type="hidden" id="setup_wizard_pre_page" name="setup_wizard_pre_page" value ="setup_wizard_wlan.asp">
							 <input type="hidden" id="asp_temp_10" name="asp_temp_10" value="<!--# echo asp_temp_10 -->">
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
							<input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value="<!--# echo wan_specify_dns -->">
							
							<!-- for wlan -->
							<input type="hidden" id="wlan0_ssid" name="wlan0_ssid" size="40" maxlength="32" value="<!--# echot wlan0_ssid -->">
							<input type="hidden" id="wlan0_psk_pass_phrase" name="wlan0_psk_pass_phrase" value="<!--# echot wlan0_psk_pass_phrase-->">
							<input type="hidden" id="wlan1_ssid" name="wlan1_ssid" size="40" maxlength="32" value="<!--# echot wlan1_ssid -->">
							<input type="hidden" id="wlan1_psk_pass_phrase" name="wlan1_psk_pass_phrase" value="<!--# echot wlan1_psk_pass_phrase-->">	

							<input type="hidden" id="wlan0_psk_cipher_type" name="wlan0_psk_cipher_type" value="both">
							<input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="5">
							<input type="hidden" id="wps_enable" name="wps_enable" value="1">

							<!-- for russia mode -->
							<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<!--# echo wan_pppoe_russia_enable -->">
							<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<!--# echo wan_pptp_russia_enable -->">
							<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<!--# echo wan_l2tp_russia_enable -->">
		
							<!-- wlan_mode -->
							<div id="wlan_mode" style="display:none">
								<h2 align="left"><script>show_words(STEP2);show_words(": ");show_words(_setup_wizard_wlan);</script></h2>
								<!--2.4GHz-->
								<table align="center" class=formarea width="90%">	
									<tr align="left">
										<td width="5%">&nbsp;</td>
										<td  colspan="2"><b><P align="left" class=box_msg><span id="signal_name_str"><script>show_words(wwz_wwl_intro_s3_2);</script></span>&nbsp;<span id="signal_band24g" style="display:none">(<script>show_words(GW_WLAN_RADIO_0_NAME);</script>)</span></P></b></td>
									</tr>
									<tr align="left">
										<td width="20">&nbsp;</td>
										<td colspan="2">
											<b><script>show_words(wwz_wwl_wnn);</script> :</b>
										</td>
									</tr>
									<tr align="left">
										<td width="20">&nbsp;</td>
										<td width="40"><input type="text" id="wlan0_ssid2" name="wlan0_ssid2" size="40" maxlength="32"></td>
											
										<td align="left">&nbsp;(<script>show_words(wwz_wwl_wnn_len);</script>)</td>
									</tr>
									<tr align="left">
										<td width="20">&nbsp;</td>
										<td colspan="2"><b><P align="left" class=box_msg><span id="signal_pass_str" style="display:none"><script>show_words(wwz_wwl_intro_s3_3);</script></span></P></b></td>
									</tr>
									<tr>
										<td width="20">&nbsp;</td>
										<td colspan="2" class=form_label>
											<b><script>show_words(wwz_wwl_wnp)</script> :</b>
										</td>	
									</tr>
									<tr>
										<td width="20">&nbsp;</td>
										<td>
											<input type="text" id="wlan0_security" name="wlan0_security" size="40" maxlength="63">
										</td>
										<td align="left">&nbsp;(<script>show_words(wwz_wwl_wnp_len);</script>)</td>
									</tr>
									
								</table>
								
								<!--5GHz-->
								<table align="center" class=formarea width="90%" id="table_dualband" style="display:none">	
									<tr align="left">
										<td width="5%">&nbsp;</td>
										<td  colspan="2"><b><P align="left" class=box_msg><script>show_words(wwz_wwl_intro_s3_4);</script>&nbsp;(<script>show_words(GW_WLAN_RADIO_1_NAME);</script>)</P></b></td>
									</tr>
									<tr align="left">
										<td width="20">&nbsp;</td>
										<td colspan="2">
											<b><script>show_words(wwz_wwl_wnn);</script> :</b>
										</td>
									</tr>
									<tr align="left">
										<td width="20">&nbsp;</td>
										<td width="40"><input type="text" id="wlan1_ssid2" name="wlan0_ssid2" size="40" maxlength="32"></td>
										
										<td align="left">&nbsp;(<script>show_words(wwz_wwl_wnn_len);</script>)</td>
									</tr>
									<tr align="left">
										<td width="20">&nbsp;</td>
										<td colspan="2"><b><P align="left" class=box_msg></P></b></td>
									</tr>
									<tr>
										<td width="20">&nbsp;</td>
										<td colspan="2" class=form_label>
											<b><script>show_words(wwz_wwl_wnp)</script> :</b>
										</td>	
									</tr>
									<tr>
										<td width="20">&nbsp;</td>
										<td>
										<input type="text" id="wlan1_security" name="wlan1_security" size="40" maxlength="63">
										</td>
										<td align="left">&nbsp;(<script>show_words(wwz_wwl_wnp_len);</script>)</td>
									</tr>
									
								</table>
																
								<br><br>	
							</div>
							<!-- wlan_mode -->
							<!-- wz_complete -->
							<div id="wz_complete" style="display:none">
								<h2 align="left"><script>show_words(_setupdone);</script></h2>
								<P align="left" class=box_msg><script>show_words(_setup_wizard_wlan_4)</script></P>
								<table width="650" align="center" class="formarea">
									<tr>
										<td colspan="3">
										<table>
											<tr>
												<td class="duple"><script>show_words(wwl_wnn);</script> :</td>
												<td>&nbsp;</td>
												<td><span id="show_ssid"></span></td>
											</tr>
											<tr>
												<td class="duple"><script>show_words(bws_SM);</script> :</td>
												<td>&nbsp;</td>
												<td><script>show_words(KR48);</script></td>
											</tr>
											<tr>
												<td class="duple"><script>show_words(bws_CT);</script> :</td>
												<td>&nbsp;</td>
												<td><script>show_words(bws_CT_3)</script></td>
											</tr>
											<tr>
												<td class="duple"><script>show_words(_psk);</script> :</td>
												<td>&nbsp;</td>
												<td><span id="show_key"></span></td>
											</tr>
										</table></td>
									</tr>
								</table>
								<P align="left" class=box_msg><script>show_words(wwa_intro_s4)</script></P>
							</div>
							<!-- wz_complete -->
							<br>
						</form>
						<form id="form2" name="form2" method="post" action="apply_sec.cgi">
							<input type="hidden" id="action" name="action" value="setup_wizard_cancel">
							<input type="hidden" id="html_response_page" name="html_response_page" value="login_pic.asp">
							<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="login_pic.asp">
						</form>
						<table align="center" class="formarea">
							<tr>
								<td>
									<input type="button" class="button_submit" id="cancel_b2" name="cancel_b2" value="Cancel" onclick="wz_cancel();">
									<input type="button" class="button_submit" id="prev_b2" name="prev_b2" value="Prev" onclick="go_back();">
									<input type="button" class="button_submit" id="next_b2" name="next_b2" value="Next" onclick="send_request();">
									<script>
										get_by_id("cancel_b2").value = _cancel;
										get_by_id("prev_b2").value = _prev;
										get_by_id("next_b2").value = _next;
									</script>
								</td>
							</tr>
						</table>
					</div>
				</div></td>
			</tr>
		</table><p>&nbsp;</p></td>
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
		</table></td>
	</tr>
</table>
<div id="copyright" align="center"><script>show_words(_copyright);</script></div>
</body>
</html>
