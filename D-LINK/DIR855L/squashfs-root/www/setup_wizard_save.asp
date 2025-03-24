<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script language="Javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="Javascript" src="/lang.js"></script>
<script language="Javascript" src="/public.js"></script>
<script language="Javascript" src="/wizard_lang.js"></script>
<script language="Javascript">
	var button_prev=0;
	var browserName = navigator.userAgent.toLowerCase();
	var support_dual_band = 0; // 0: signal band 1:dual band
	function chaek_daylight() {
		var rightNow = new Date();
		var jan1 = new Date(rightNow.getFullYear(), 0, 1, 0, 0, 0, 0);  // jan 1st
		var june1 = new Date(rightNow.getFullYear(), 6, 1, 0, 0, 0, 0); // june 1st
		var temp = jan1.toGMTString();
		var jan2 = new Date(temp.substring(0, temp.lastIndexOf(" ")-1));
		temp = june1.toGMTString();
		var june2 = new Date(temp.substring(0, temp.lastIndexOf(" ")-1));
		var std_time_offset = (jan1 - jan2) / (1000 * 60 * 60);
		var daylight_time_offset = (june1 - june2) / (1000 * 60 * 60);
		var dst;

		if (std_time_offset == daylight_time_offset) {
			dst = "0"; // daylight savings time is NOT observed
		} else {
			dst = "1"; // daylight savings time is observed
		}
		return dst;
	}
	
	function onPageLoad(){
		get_by_id("password").style.display = "";
		get_by_id("wz_zone").style.display = "none";
		get_by_id("wz_complete").style.display = "none";

		var d = new Date();
		var gmtH = -d.getTimezoneOffset()/60;
		var daylight_enable = chaek_daylight();
		// check daylight saveing time enable or disable
		gmtH = gmtH - chaek_daylight();

		var objtz = get_by_id("time_zone");
		var i;
		for (i = 0; i < objtz.options.length; i++) {
			if (objtz.options[i].value == (gmtH*16))
				break;
		}
		if (i<objtz.options.length) {
			objtz.selectedIndex = i;
			get_by_id("time_zone_area").value = i;
		} else
			objtz.selectedIndex = get_by_id("time_zone_area").value;
	}
	
	function show_band_info(){
		/* spec 1.05 add check signal band or dual band */
		if("<!--#  echo wlan1_enable -->" != ""){
			support_dual_band = 1;
		}
					
		if(parseInt(support_dual_band) == 0){
			get_by_id("signal_band24g").style.display = "none";	
			get_by_id("tr_5g_0").style.display = "none";
			get_by_id("tr_5g_1").style.display = "none";
			get_by_id("tr_5g_2").style.display = "none";
			
		}else{ //dual band 5g
			get_by_id("signal_band24g").style.display = "";	
			get_by_id("tr_5g_0").style.display = "";
			get_by_id("tr_5g_1").style.display = "";
			get_by_id("tr_5g_2").style.display = "";

		}
	}
	
	function wz_cancel() {
		if(confirm(_setup_wizard_17)) {
			disable_all_btn(true);
			send_submit("form2");
		}
	}
	function time_zone_selector() {
		get_by_id("time_zone_area").value = get_by_id("time_zone").selectedIndex;
	}
	
	function foolproof_password() {
		/* check admin password */
		var admin_passwd = get_by_id("admin_password").value;
		if(get_by_id("admin_password").value != get_by_id("admin_password2").value) {
			get_by_id("admin_password").value = "";
			get_by_id("admin_password2").value = "";
			alert(YM173);
			return false;
		}
		if(get_by_id("admin_password").value == '') {
			alert(_pass_empty);
			return false;
		}
		if(!is_ascii(get_by_id("admin_password").value) || !is_ascii(get_by_id("admin_password2").value)) {
			alert(MSG047);
			return false;
		}
		if(admin_passwd.length < 6) {
			alert(wizard_check_passwd_length);
			return false;
		}
		/* check checkbox graphical_enable */
		if(get_by_id("graphical_enable").checked) {
			get_by_id("graph_auth_enable").value = 1;
			get_by_id("graph_enable").value = "open";
		} else {
			get_by_id("graph_auth_enable").value = 0;
			get_by_id("graph_enable").value = "none";
		}

		return true;
	}
	
	function next(){
		if(button_prev == 2) {
			alert("i am last");
			//disable_all_btn(true);
		}else if(button_prev == 1) {
			//check timezone
			get_by_id("save_connect").style.display = "";
			get_by_id("next_b2").style.display = "none";
			get_by_id("password").style.display = "none";
			get_by_id("wz_zone").style.display = "none";
			
			show_band_info();
			get_by_id("wz_complete").style.display = "";
			get_by_id("show_ssid").innerHTML = get_by_id("wlan0_ssid").value;
			get_by_id("show_key").innerHTML = get_by_id("wlan0_psk_pass_phrase").value;
			
			if(parseInt(support_dual_band) == 1){
				get_by_id("show_ssid1").innerHTML = get_by_id("wlan1_ssid").value;
				get_by_id("show_key1").innerHTML = get_by_id("wlan1_psk_pass_phrase").value;
			}	
			
			button_prev++;
		}else{
			//check password
			if(!foolproof_password()) {
				return false;
			}
			get_by_id("save_connect").style.display = "none";
			get_by_id("next_b2").style.display = "";
			get_by_id("password").style.display = "none";
			get_by_id("wz_zone").style.display = "";
			get_by_id("wz_complete").style.display = "none";
			button_prev++;
		}
	}
	
	function go_back() {
		if(button_prev == 1) {
			get_by_id("password").style.display = "";
			get_by_id("wz_zone").style.display="none";
			get_by_id("next_b2").style.display = "";
			get_by_id("save_connect").style.display = "none";
			get_by_id("wz_complete").style.display="none";
			button_prev--;
		}else if(button_prev == 2) {
			
			get_by_id("password").style.display = "none";
			get_by_id("wz_zone").style.display="";
			get_by_id("next_b2").style.display = "";
			get_by_id("save_connect").style.display = "none";
			get_by_id("wz_complete").style.display="none";
			button_prev--;
		} else {
			get_by_id("html_response_page").value = "setup_wizard_wlan.asp";
			get_by_id("action").value = "response_page";
			get_by_id("setup_wizard_pre_page").value="setup_wizard_save.asp";
			disable_all_btn(true);
			send_submit("form1");
		}

	}
	
	function send_request() {
		var isIE = navigator.userAgent.search("MSIE") > -1;
		if(isIE && confirm(_setup_wizard_info)) {
			/* 1.04R1 modify bookmark lan device name : dlinkrouter */
			var title = _setup_wizard_info2;
			var url = "http://";
			/* get lan device name */
			if("<!--#  echo wlan0_mode -->" == "ap") {
				url += "<!--#  echo lan_device_name_ap -->";
			} else {// rt
				url += "<!--#  echo lan_device_name -->";
			}

			if(window.external) {// IE Favorite
				window.external.AddFavorite(url, title);
			}
		}

		disable_all_btn(true);
/* SSID string issue */
		var tmp_ssid = "", tmp_ssid1 = "";
		tmp_ssid = ssid_decode("wlan0_ssid");
		get_by_id("wlan0_ssid").value = tmp_ssid;
		if ("<!--# echo wlan1_enable -->" === "1") {
			tmp_ssid1 = ssid_decode("wlan1_ssid");
			get_by_id("wlan1_ssid").value = tmp_ssid1;
		}
/* End SSID */
		send_submit("form1");
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
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
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF"><p>&nbsp;</p>
		<table width="650" border="0" align="center">
			<tr>
				<td>
				<div class=box>
					<div id=w1>
					<form id="form1" name="form1" method="post" action="apply_sec.cgi">
					<input type="hidden" name="html_response_page" id="html_response_page" value="wizard_reboot.asp">
								<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
								<input type="hidden" name="html_response_return_page" value="http://www.dlink.com">
								<input type="hidden" name="countdown_time" id="countdown_time" value="25">
								<input type="hidden" name="reboot_type" value="none">
								<input type="hidden" id="action" name="action" value="setup_wizard_mydlink">
								<input type="hidden" id="setup_wizard_pre_page" name="setup_wizard_pre_page" value ="setup_wizard_wlan.asp">
								<input type="hidden" id="asp_temp_10" name="asp_temp_10" value="<!--# echo asp_temp_10 -->">
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
								<!-- 2.4G -->
								<input type="hidden" id="wlan0_ssid" name="wlan0_ssid" size="40" maxlength="32" value="<!--# echot wlan0_ssid -->">
								<input type="hidden" id="wlan0_psk_pass_phrase" name="wlan0_psk_pass_phrase" value="<!--# echot wlan0_psk_pass_phrase-->">
								<input type="hidden" id="wlan0_security" name="wlan0_security" value="wpa2auto_psk">
								<input type="hidden" id="wlan0_psk_cipher_type" name="wlan0_psk_cipher_type" value="both">
								<!-- 2.4G End -->
								<!-- 5G -->
								<input type="hidden" id="wlan1_ssid" name="wlan1_ssid" size="40" maxlength="32" value="<!--# echot wlan1_ssid -->">
								<input type="hidden" id="wlan1_psk_pass_phrase" name="wlan1_psk_pass_phrase" value="<!--# echot wlan1_psk_pass_phrase-->">
								<input type="hidden" id="wlan1_security" name="wlan1_security" value="wpa2auto_psk">
								<input type="hidden" id="wlan1_psk_cipher_type" name="wlan1_psk_cipher_type" value="both">
								<!-- 5G End -->
								<input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="5">
								<input type="hidden" id="disable_wps_pin" name="disable_wps_pin" value="1">
								<input type="hidden" id="wps_enable" name="wps_enable" value="1">	
								<!-- for russia mode -->
								<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<!--# echo wan_pppoe_russia_enable -->">
								<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<!--# echo wan_pptp_russia_enable -->">
								<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<!--# echo wan_l2tp_russia_enable -->">
								
								<!-- Step 4 password -->
								<div id="password" name="password" style="display:none">
									<h2 align="left"><script>show_words(STEP3);show_words(": ");show_words(_setup_wizard_3);</script></h2>
									<div align="left">
										<p class="box_msg"><script>show_words(_setup_wizard_9);</script></p>
										<table class=formarea>
											<tr>
												<td align=right class="duple"><script>show_words(_password)</script> :</td>
												<td>&nbsp;
													<input type="password" id="admin_password" name="admin_password" size=20 maxlength=15 value="<!--# echo admin_password -->">
												</td>
											</tr>
											<tr>
												<td align=right class="duple"><script>show_words(_verifypw)</script> :</td>
												<td>&nbsp;
													<input type="password" id="admin_password2" name="admin_password2" size=20 maxlength=15 value="<!--# echo admin_password -->">
												</td>
											</tr>
											<tr>
												<td class="duple"><script>show_words(_setup_wizard_10)</script> :</td>
												<td>
													<input type="checkbox" id="graphical_enable" name="graphical_enable">
													<input type="hidden" id="graph_auth_enable" name="graph_auth_enable">
													<input type="hidden" id="graph_enable" name="graph_enable">
												</td>
											</tr>
										</table>
									</div>
								</div>
								<!-- Step 4-->
								<!-- Step 5 select your time zone -->
										<div id="wz_zone" style="display:none">
											<h2 align="left"><script>show_words(STEP4);show_words(": ");show_words(_setup_wizard_4);</script></h2>
												<div align="left">
													<p class="box_msg"><script>show_words(_setup_wizard_11);</script></p>
													<p align="center">
														<input type="hidden" id="time_zone_area" name="time_zone_area" value="<!--# echo time_zone_area -->">
														<select size=1 id="time_zone" name="time_zone" onchange="time_zone_selector();">
															<option value="-192"><script>show_words(up_tz_00)</script></option>
															<option value="-176"><script>show_words(up_tz_01)</script></option>
															<option value="-160"><script>show_words(up_tz_02)</script></option>
															<option value="-144"><script>show_words(up_tz_03)</script></option>
															<option value="-128" selected><script>show_words(up_tz_04)</script></option>
															<option value="-112"><script>show_words(up_tz_05)</script></option>
															<option value="-112"><script>show_words(up_tz_06)</script></option>
															<option value="-112"><script>show_words(up_tz_06b)</script></option>
															<option value="-96"><script>show_words(up_tz_07)</script></option>
															<option value="-96"><script>show_words(up_tz_08)</script></option>
															<option value="-96"><script>show_words(up_tz_09)</script></option>
															<option value="-96"><script>show_words(up_tz_10)</script></option>
															<option value="-80"><script>show_words(up_tz_11)</script></option>
															<option value="-80"><script>show_words(up_tz_12)</script></option>
															<option value="-80"><script>show_words(up_tz_13b)</script></option>
															<option value="-64"><script>show_words(up_tz_15)</script></option>
															<option value="-64"><script>show_words(up_tz_14)</script></option>
															<option value="-64"><script>show_words(up_tz_16)</script></option>
															<option value="-56"><script>show_words(up_tz_17)</script></option>
															<option value="-48"><script>show_words(up_tz_18)</script></option>
															<option value="-48"><script>show_words(up_tz_19)</script></option>
															<option value="-48"><script>show_words(up_tz_20)</script></option>
															<option value="-32"><script>show_words(up_tz_21)</script></option>
															<option value="-16"><script>show_words(up_tz_22)</script></option>
															<option value="-16"><script>show_words(up_tz_23)</script></option>
															<option value="0"><script>show_words(up_tz_24)</script></option>
															<option value="1"><script>show_words(up_tz_25)</script></option>
															<option value="16"><script>show_words(up_tz_26)</script></option>
															<option value="16"><script>show_words(up_tz_27)</script></option>
															<option value="16"><script>show_words(up_tz_28)</script></option>
															<option value="16"><script>show_words(up_tz_29)</script></option>
															<option value="16"><script>show_words(up_tz_30)</script></option>
															<option value="32"><script>show_words(up_tz_31)</script></option>
															<option value="32"><script>show_words(up_tz_32)</script></option>
															<option value="32"><script>show_words(up_tz_33)</script></option>
															<option value="32"><script>show_words(up_tz_34)</script></option>
															<option value="32"><script>show_words(up_tz_35)</script></option>
															<option value="32"><script>show_words(up_tz_36)</script></option>
															<option value="48"><script>show_words(up_tz_37)</script></option>
															<option value="48"><script>show_words(up_tz_38)</script></option>
															<option value="48"><script>show_words(up_tz_40)</script></option>
															<option value="56"><script>show_words(up_tz_41)</script></option>
															<option value="64"><script>show_words(up_tz_43b)</script></option>
															<option value="64"><script>show_words(up_tz_42)</script></option>
															<option value="64"><script>show_words(up_tz_43)</script></option>
															<option value="72"><script>show_words(up_tz_44)</script></option>
															<option value="80"><script>show_words(up_tz_46)</script></option>
															<option value="88"><script>show_words(up_tz_47)</script></option>
															<option value="88"><script>show_words(up_tz_47b)</script></option>
															<option value="92"><script>show_words(up_tz_48)</script></option>
															<option value="96"><script>show_words(up_tz_51)</script></option>
															<option value="96"><script>show_words(up_tz_50)</script></option>
															<option value="104"><script>show_words(up_tz_52)</script></option>
															<option value="112"><script>show_words(up_tz_54b)</script></option>
															<option value="112"><script>show_words(up_tz_53)</script></option>
															<option value="128"><script>show_words(up_tz_59)</script></option>
															<option value="128"><script>show_words(up_tz_55)</script></option>
															<option value="128"><script>show_words(up_tz_57)</script></option>
															<option value="128"><script>show_words(up_tz_59b)</script></option>
															<option value="128"><script>show_words(up_tz_58)</script></option>
															<option value="128"><script>show_words(up_tz_56)</script></option>
															<option value="144"><script>show_words(up_tz_62b)</script></option>
															<option value="144"><script>show_words(up_tz_60)</script></option>
															<option value="144"><script>show_words(up_tz_61)</script></option>
															<option value="152"><script>show_words(up_tz_63)</script></option>
															<option value="152"><script>show_words(up_tz_64)</script></option>
															<option value="160"><script>show_words(up_tz_69b)</script></option>
															<option value="160"><script>show_words(up_tz_65)</script></option>
															<option value="160"><script>show_words(up_tz_66)</script></option>
															<option value="160"><script>show_words(up_tz_67)</script></option>
															<option value="160"><script>show_words(up_tz_68)</script></option>
															<option value="176"><script>show_words(up_tz_70b)</script></option>
															<option value="176"><script>show_words(up_tz_70)</script></option>
															<option value="192"><script>show_words(up_tz_72b)</script></option>
															<option value="192"><script>show_words(up_tz_71)</script></option>
															<option value="192"><script>show_words(up_tz_72)</script></option>
															<option value="208"><script>show_words(up_tz_73)</script></option>
															<option value="208"><script>show_words(up_tz_73b)</script></option>
														</select>
													</p>
												</div>
										</div><!-- wz_zone -->
										
										<!-- Step 5  -->
										<!-- Step wz_complete -->
										<div id="wz_complete" style="display:none">
											<h2 align="left"><script>show_words(_confirm_wifi_setting);</script></h2>
											<p align="left" class=box_msg><script>show_words(_setup_wizard_wlan_4)</script></p>
											
											<table width="650" align="center" class="formarea" border="0">
												<tr>
													<td colspan="3" align="center">
														<table border="0">
															<tr>
																<td align="right" nowrap><b><script>show_words(wwz_wwl_wnn);</script><span id="signal_band24g" style="">&nbsp;<script>show_words(GW_WLAN_RADIO_0_NAME);</script></span>&nbsp;:</b></td>
																<td>&nbsp;</td>
																<td><span id="show_ssid"></span></td>
															</tr>
															<tr>
																<td align="right" nowrap><b><script>show_words(wwz_wwl_wnp);</script> :</b></td>
																<td>&nbsp;</td>
																<td><span id="show_key"></span></td>
															</tr>
															
															<tr id="tr_5g_0" style="display:none">
																<td align="right" nowrap>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
															</tr>
															<tr id="tr_5g_1" style="display:none">
																<td align="right" nowrap><b><script>show_words(wwz_wwl_wnn);</script>&nbsp;<script>show_words(GW_WLAN_RADIO_1_NAME);</script>&nbsp;:</b></td>
																<td>&nbsp;</td>
																<td><span id="show_ssid1"></span></td>
															</tr>
															<tr id="tr_5g_2" style="display:none">
																<td align="right" nowrap><b><script>show_words(wwz_wwl_wnp);</script> :</b></td>
																<td>&nbsp;</td>
																<td><span id="show_key1"></span></td>
															</tr>
															
														</table>
													</td>
												</tr>
											</table>
											<br>
<!--											<p align="left" class=box_msg><script>show_words(setup_wizard_complete)</script></p> -->
										</div>
										<!-- Step wz_complete -->
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
										<input type="button" class="button_submit" id="next_b2" name="next_b2" value="Next" onclick="next();">
										<input type="button" class="button_submit" id="save_connect" name="save_connect" style="display:none" value="Save & Connect" onclick="send_request();">
										<script>
											get_by_id("prev_b2").value = _prev;
											get_by_id("next_b2").value = _next;
											get_by_id("save_connect").value = _save;
											get_by_id("cancel_b2").value = _cancel;
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
<script>
	onPageLoad();
</script>
</html>
