<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script language="Javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="Javascript" src="/lang.js"></script>
<script language="Javascript" src="/public.js"></script>
<script language="Javascript" src="/wizard_lang.js"></script>
<script lang="javasddcript" src="/jquery-1.6.1.min.js"></script>
<style type="text/css">
	#loading {
		position: relative;
		margin: 0px auto; /* firefox */
		*margin: 0px auto; /* IE7 */
		_margin: 0px auto; /* IE6 */
		width: 500px;
		height: 20px;
		background: #ffffff;
		border-width: thin;
		border-style: solid;
	}
	#loading div {
		width: 0px;
		height: 20px;
		background: #ff6600;
	}
</style>
<script language="Javascript">
	var wan_detect_id = 0;
	var wan_info_id = 0;
	var detect_try_again_id = 0;
	var redirect_to_wan_id = 0;
	var page_index = 0;
	/* 0: wan_disconnect 1:try_again 2:wan_detect 3:wan_mode_select */
	var wan_detect_type = "";
	var russia_mode = 0;

	function onPageLoad() {
		var wan_mode = "";

		if("<!--# echo setup_wizard_pre_page -->" == "setup_wizard.asp") {
			/* from setup_wizard */
			get_wan_info();

		} else if("<!--# echo setup_wizard_pre_page -->" == "setup_wizard_wan.asp") {
			/* from setup_wizard_wan */
			if(get_by_id("asp_temp_10").value == 2)
				get_wan_info();
			else{
			wan_mode = get_by_id("wan_proto").value;
			if (get_by_id("wan_pppoe_russia_enable").value == "1")
				wan_mode = "russia_pppoe";
			if (get_by_id("wan_pptp_russia_enable").value == "1")
				wan_mode = "russia_pptp";
			if (get_by_id("wan_l2tp_russia_enable").value == "1")
				wan_mode = "russia_l2tp";
			wan_mode_selector(wan_mode);
			guide_me();
			}
			
		} else if("<!--# echo setup_wizard_pre_page -->" == "setup_wizard_wlan.asp") {
			/* from setup_wizard_wlan: is dhcpc */
			if(get_by_id("asp_temp_10").value == 3) {
				wan_mode_selector("dhcpc");
				guide_me();
			}else if(get_by_id("asp_temp_10").value == 2)
				get_wan_info();
			else {
				wan_mode_selector("dhcpc");
				guide_me();
			}

		}
		if ("<!--# echo feature_russsia -->" == "1") {
			get_by_id("show_russia_pppoe").style.display = "";
			get_by_id("show_russia_pptp").style.display = "";
			get_by_id("show_russia_l2tp").style.display = "";
		}
	}

	function createRequest() {
		var XMLhttpObject = false;
		if(window.XMLHttpRequest) {
			try {
				XMLhttpObject = new XMLHttpRequest();
			} catch (e) {
			}
		} else if(window.ActiveXObject) {
			try {
				XMLhttpObject = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					XMLhttpObject = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					return null;
				}
			}
		}
		return XMLhttpObject;
	}

	function get_wan_info() {
		xmlhttp = new createRequest();
		if(xmlhttp) {
			var url = "";
			var temp_cURL = document.URL.split("/");
			for(var i = 0; i < temp_cURL.length - 1; i++) {
				if(i == 1)
					continue;
				if(i == 0)
					url += temp_cURL[i] + "//";
				else
					url += temp_cURL[i] + "/";
			}
			url += "device_status.xml";
			xmlhttp.onreadystatechange = wan_info_xmldoc;
			xmlhttp.open("GET", url, true);
			xmlhttp.send(null);
		}
		wan_info_id = setTimeout("get_wan_info()", 3000);
	}

	function wan_info_xmldoc() {
		if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			try {
				get_by_id("wan_cable_status").value = xmlhttp.responseXML.getElementsByTagName("wan_cable_status")[0].firstChild.nodeValue;
				get_by_id("net_status").value = xmlhttp.responseXML.getElementsByTagName("wan_network_status")[0].firstChild.nodeValue;
				get_by_id("wan_ip_value").value = xmlhttp.responseXML.getElementsByTagName("wan_ip")[0].firstChild.nodeValue;
				get_by_id("wan_netmask_value").value = xmlhttp.responseXML.getElementsByTagName("wan_netmask")[0].firstChild.nodeValue;
				get_by_id("wan_gateway_value").value = xmlhttp.responseXML.getElementsByTagName("wan_default_gateway")[0].firstChild.nodeValue;
				get_by_id("wan_dns1_value").value = xmlhttp.responseXML.getElementsByTagName("wan_primary_dns")[0].firstChild.nodeValue;
				get_by_id("wan_dns2_value").value = xmlhttp.responseXML.getElementsByTagName("wan_secondary_dns")[0].firstChild.nodeValue;

				if(get_by_id("wan_dns1_value").value == "NULL") {
					get_by_id("wan_dns1_value").value = "0.0.0.0";
				}

				if(get_by_id("wan_dns2_value").value == "NULL") {
					get_by_id("wan_dns2_value").value = "0.0.0.0";
				}

				clearTimeout(wan_info_id);

				if(get_by_id("wan_cable_status").value == "connect") {
					/* check network status when wan cable connect */
					wan_detect();
					/* Avoid DUT response too late. */
					$("#loading div").animate({width : "50px"});
					wan_detect_xmldoc();
				} else {
					wan_disconnect();
				}

			} catch(e) {
			}
		}
	}

	function redirect_to_wlan() {
		/* clear delay execute function */
		clear_timing_events();
		get_by_id("asp_temp_10").value = 2;
		get_by_id("wan_proto").value = wan_detect_type;

		get_by_id("html_response_page").value = "setup_wizard_wlan.asp";
		get_by_id("setup_wizard_pre_page").value = "setup_wizard_detect.asp";

		disable_all_btn(true);
		send_submit("form1");
	}

	function redirect_to_wan() {
		/* clear delay execute function */
		clear_timing_events();
		get_by_id("asp_temp_10").value = 2;
		get_by_id("wan_proto").value = wan_detect_type;

		get_by_id("html_response_page").value = "setup_wizard_wan.asp";
		get_by_id("setup_wizard_pre_page").value = "setup_wizard_detect.asp";

		disable_all_btn(true);
		send_submit("form1");
	}


	function wan_detect_xmldoc() {
		$.ajax({
                	type: "GET",
	                url: "auto-detect.asp",
        	        async: true,
                	cache: false,
        	        complete : function(data){
                	        try{

					wan_detect();

					for(var i = 2; i < 6; i++) {
						_width = 100 * i + "px";
						$("#loading div").animate({
							width : _width
						});
					}
					wan_detect_type = data.responseText;
					wan_detect_type = trim_string(wan_detect_type);


					/* when function return, enable next button */

					if(wan_detect_type != "") {
						get_by_id("next_b").disabled = false;
					}

					if(wan_detect_type === "pppoe") {
						/* when wan_detect_type is pppoe, auto redirect to pppoe setting page */
						redirect_to_wan_id = setTimeout("redirect_to_wan()", 3000);
					} else if(wan_detect_type === "dhcpc") {
						/* when wan_detect_type is dhcp, auto redirect to wlan setting page */
						redirect_to_wan_id = setTimeout("redirect_to_wlan()", 3000);
					} else {//nothing
					/* unable to detect */
						detect_try_again_id = setTimeout("detect_try_again()", 2500);
					}
					clearTimeout(wan_detect_id);

				}catch(e){
				}
				wan_detect_id = setTimeout("wan_detect_xmldoc()", "3000");
			}
	        });
	}

	function wan_mode_selector(wan_cfg) {
		var wan_type = 1;
		var offset = 0;
		// pppoe
		var wan_mode = get_by_name("wan_mode");

		if ("<!--# echo feature_russsia -->" == "1") {
			get_by_id("wan_pppoe_russia_enable").value = "0";
			get_by_id("wan_pptp_russia_enable").value = "0";
			get_by_id("wan_l2tp_russia_enable").value = "0";
		}

		if(wan_cfg == "dhcpc") {
			wan_type = 0;
		} else if(wan_cfg == "pppoe") {
			wan_type = 1;
		} else if(wan_cfg == "pptp") {
			wan_type = 2;
		} else if(wan_cfg == "l2tp") {
			wan_type = 3;
		} else if(wan_cfg == "russia_pppoe") {
			wan_cfg = "pppoe";
			get_by_id("wan_pppoe_russia_enable").value = "1";
			wan_type = 1;
			russia_mode = 1;
			offset = 3;
		} else if(wan_cfg == "russia_pptp") {
			wan_cfg = "pptp";
			get_by_id("wan_pptp_russia_enable").value = "1";
			wan_type = 2;
			russia_mode = 1;
			offset = 3;
		} else if(wan_cfg == "russia_l2tp") {
			wan_cfg = "l2tp";
			get_by_id("wan_l2tp_russia_enable").value = "1";
			wan_type = 3;
			russia_mode = 1;
			offset = 3;
		} else if(wan_cfg == "static") {
			wan_type = 4;
			if ("<!--# echo feature_russsia -->" == "1")
				offset = 3;
		}
 
		get_by_id("wan_proto").value = wan_cfg;
		wan_mode[wan_type + offset].checked = true;
	}

	function wan_disconnect() {
		//button
		get_by_id("prev_b").style.display = "";
		get_by_id("next_b").style.display = "none";
		get_by_id("cancel_b").style.display = "none";
		get_by_id("wz_try_b").style.display = "";
		get_by_id("wz_guide_b").style.display = "none";
		get_by_id("cancel_b2").style.display = "";

		//show data
		get_by_id("wan_disconnect").style.display = "";
		get_by_id("wan_mode_select").style.display = "none";
		get_by_id("wan_detect_mode").style.display = "none";
		page_index = 0;
	}

	function detect_try_again() {
		/* clear delay execute function */
		clear_timing_events();

		//button
		get_by_id("prev_b").style.display = "none";
		get_by_id("next_b").style.display = "none";
		get_by_id("cancel_b").style.display = "";
		get_by_id("wz_try_b").style.display = "none";
		get_by_id("wz_try_b2").style.display = "";
		get_by_id("wz_guide_b").style.display = "";
		get_by_id("cancel_b2").style.display = "none";

		//show data
		get_by_id("wan_disconnect").style.display = "none";
		get_by_id("wan_detect_mode").style.display = "";
		get_by_id("wan_mode_select").style.display = "none";

		//loading bar (when wan_detect_mode show)
		get_by_id("wan_detecting").style.display = "none";
		get_by_id("wan_un_detect").style.display = "";
		
		get_by_id("loading").style.display = "none";
	
		page_index = 1;
		/* current page is wan_mode_select */
	}

	function wan_detect() {
		//button
		get_by_id("prev_b").style.display = "";
		get_by_id("next_b").style.display = "";
		get_by_id("next_b").disabled = true;
		get_by_id("cancel_b").style.display = "";
		get_by_id("wz_try_b").style.display = "none";
		get_by_id("wz_try_b2").style.display = "none";
		get_by_id("wz_guide_b").style.display = "none";
		get_by_id("cancel_b2").style.display = "none";

		//show data
		get_by_id("wan_disconnect").style.display = "none";
		get_by_id("wan_detect_mode").style.display = "";
		get_by_id("wan_mode_select").style.display = "none";

		//loading bar (when wan_detect_mode show)
		get_by_id("wan_detecting").style.display = "";
		get_by_id("wan_un_detect").style.display = "none";
		$("#loading div").empty();
		get_by_id("loading").style.display = "";
		page_index = 2;
		/*  current page is wan_mode_select */
	}

	function guide_me() {
		//button
		get_by_id("prev_b").style.display = "";
		get_by_id("next_b").style.display = "";
		get_by_id("cancel_b").style.display = "";
		get_by_id("wz_try_b").style.display = "none";
		get_by_id("wz_try_b2").style.display = "none";
		get_by_id("wz_guide_b").style.display = "none";
		get_by_id("cancel_b2").style.display = "none";

		//show data
		get_by_id("wan_disconnect").style.display = "none";
		get_by_id("wan_detect_mode").style.display = "none";
		get_by_id("wan_mode_select").style.display = "";
		page_index = 3;
		/*  current page is wan_mode_select */
	}

	function send_guide_me(){
		wan_mode_selector("dhcpc");
		guide_me();
	}

	function send_request() {
		/* clear delay execute function */
		clear_timing_events();

		if(page_index == 2) {/* wan_detect_mode */
			/* when detecting, click next show wan_mode_select */
			wan_mode_selector("dhcpc");
			guide_me();
		} else if(page_index == 3) {/* wan_mode_select */
			get_by_id("asp_temp_10").value = 3;
			if(get_by_name("wan_mode")[0].checked){
				get_by_id("html_response_page").value = "setup_wizard_wlan.asp";
				get_by_id("setup_wizard_pre_page").value = "setup_wizard_detect.asp";
	
				disable_all_btn(true);
				send_submit("form1");
			}else{
				/* wan_mode_select ->  setup_wizard_wan.asp */
				disable_all_btn(true);
				send_submit("form1");	
			}			
			
		}
	}

	function replay_page() {

		get_by_id("html_response_page").value = "setup_wizard_detect.asp";
		get_by_id("setup_wizard_pre_page").value = "setup_wizard.asp";
		disable_all_btn(true);
		send_submit("form1");
	}

	function wz_cancel() {
		/* clear delay execute function */
		clear_timing_events();

		if(confirm(_setup_wizard_17)) {
			disable_all_btn(true);
			send_submit("form2");
		} else {
			/* if confirm cancel, reload and detct again */
			replay_page();
		}
	}

	function go_back() {
		/* clear delay execute function */
		clear_timing_events();

		if(page_index == 3) {/* wan_select -> to wan_detect_mode*/
			get_by_id("html_response_page").value = "setup_wizard_detect.asp";
			get_by_id("setup_wizard_pre_page").value = "setup_wizard.asp";

			disable_all_btn(true);
			send_submit("form1");
		} else {/* wan_detect_mode -> setup_wizard.asp */
			get_by_id("html_response_page").value = "setup_wizard.asp";

			disable_all_btn(true);
			send_submit("form1");
		}
	}

	function clear_timing_events() {
		/* clear delay execute function */
		clearTimeout(wan_info_id);
		clearTimeout(wan_detect_id);
		clearTimeout(redirect_to_wan_id);
		clearTimeout(detect_try_again_id);
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
							<input type="hidden" name="html_response_page" id="html_response_page" value="setup_wizard_wan.asp">
							<input type="hidden" name="html_response_message" value="">
							<input type="hidden" name="html_response_return_page" value="setup_wizard_wan.asp">
							<input type="hidden" name="reboot_type" value="none">
							<input type="hidden" id="action" name="action" value="response_page">
							<input type="hidden" id="setup_wizard_pre_page" name="setup_wizard_pre_page" value ="setup_wizard_detect.asp">
							<input type="hidden" id="asp_temp_10" name="asp_temp_10" value="<!--# echo asp_temp_10 -->">
							<!-- password -->
							<input type="hidden" id="admin_password" name="admin_password" value="<!--# echot admin_password -->">
							<input type="hidden" id="graph_auth_enable" name="graph_auth_enable" value="<!--# echo graph_auth_enable -->">
							<input type="hidden" id="graph_enable" name="graph_enable" value="<!--# echo graph_enable -->">
							<!-- time zone -->
							<input type="hidden" id="time_zone" name="time_zone" value="<!--# echo time_zone_area -->">
							<input type="hidden" id="time_zone_area" name="time_zone_area" value="<!--# echo time_zone_area -->">
							<!-- dns -->
							<input type="hidden" id="opendns_enable" name="opendns_enable" value="<!--# echo opendns_enable -->">
							<input type="hidden" id="opendns_mode" name="opendns_mode">
							<input type="hidden" id="wan_primary_dns" name="wan_primary_dns" value="<!--# echo wan_primary_dns -->">
							<input type="hidden" id="wan_secondary_dns" name="wan_secondary_dns" value="<!--# echo wan_secondary_dns -->">
							<input type="hidden" id="dns_relay" name="dns_relay" value="<!--# echo dns_relay -->">
							<input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value="<!--# echo wan_specify_dns -->">
							<input type="hidden" id="wan_proto" name="wan_proto" value="<!--# echo wan_proto -->">
							<!-- for dhcp info -->
							<input type="hidden" id="wan_ip_value" name="wan_ip_value" value="<!--# echo wan_ip_value -->">
							<input type="hidden" id="wan_netmask_value" name="wan_netmask_value" value="<!--# echo wan_netmask_value -->">
							<input type="hidden" id="wan_gateway_value" name="wan_gateway_value" value="<!--# echo wan_gateway_value -->">
							<input type="hidden" id="wan_dns1_value" name="wan_dns1_value" value="<!--# echo wan_dns1_value -->">
							<input type="hidden" id="wan_dns2_value" name="wan_dns2_value" value="<!--# echo wan_dns2_value -->">
							<!-- for check cable -->
							<input type="hidden" id="wan_cable_status" name="wan_cable_status" value="<!--# echo wan_cable_status -->">
							<input type="hidden" id="net_status" name="net_status" value="<!--# echo net_status -->">
							
							<!-- for wlan -->
							<input type="hidden" id="wlan0_ssid" name="wlan0_ssid" size="40" maxlength="32" value="<!--# echot wlan0_ssid -->">
							<input type="hidden" id="wlan0_psk_pass_phrase" name="wlan0_psk_pass_phrase" value="<!--# echot wlan0_psk_pass_phrase-->">
							<input type="hidden" id="wlan1_ssid" name="wlan1_ssid" size="40" maxlength="32" value="<!--# echot wlan1_ssid -->">
							<input type="hidden" id="wlan1_psk_pass_phrase" name="wlan1_psk_pass_phrase" value="<!--# echot wlan1_psk_pass_phrase-->">	
							<input type="hidden" id="wlan0_security" name="wlan0_security" value="wpa2auto_psk">
							<input type="hidden" id="wlan0_psk_cipher_type" name="wlan0_psk_cipher_type" value="both">
							<input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="5">
							<input type="hidden" id="wps_enable" name="wps_enable" value="1">

							<!-- for russia mode -->	
							<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<!--# echo wan_pppoe_russia_enable -->">
							<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<!--# echo wan_pptp_russia_enable -->">
							<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<!--# echo wan_l2tp_russia_enable -->">
							
							<!-- wan_disconnect -->
							<div id="wan_disconnect" style="display:none">
								<h2 align="left"><script>show_words(STEP1);show_words(": ");show_words(_setup_wizard_06);</script></h2>
								<div align="left">
									<p class="box_msg"><script>show_words(_setup_wizard_18);</script></p>
									<center><img src=/network.jpg></center>
								</div>
							</div>
							<!-- wan_disconnect -->
							<!-- wan_detect_mode -->
							<div id="wan_detect_mode">
								<h2 align="left"><script>show_words(STEP1);show_words(": ");show_words(_setup_wizard_06);</script></h2>
								<div id="wan_detecting" align="left" >
									<p class="box_msg"><script>show_words(_setup_wizard_14);</script></p>
									<table align="center" class=formarea>
										<tr align="center">
											<div id="loading">
												<div></div>
											</div>
										</tr>
									</table>
								</div>
								<div id="wan_un_detect" style="display:none">
									<p class="box_msg"><script>show_words(_setup_wizard_unable);</script></p>
								</div>
							</div>
							<!-- wan_detect_mode -->
							<!-- wan_mode_select -->
							<div id="wan_mode_select" style="display:none">
								<h2 align="left"><script>show_words(STEP1);show_words(": ");show_words(_setup_wizard_06);</script></h2>
								<div align="left">
									<p class="box_msg"><script>show_words(_setup_wizard_16);</script>:</p>
									<table class=formarea >
										<tr>
											<td class=form_label>&nbsp;</td>
											<td>
												<input id="wan_mode" name="wan_mode" type="radio" value="dhcpc" onchange="wan_mode_selector(this.value);">
												<STRONG><script>show_words(_dhcpconn);</script></STRONG>
												<div class=itemhelp><script>show_words(wwa_msg_dhcp);</script></div>
											</td>
										</tr>
										<tr>
											<td class=form_label>&nbsp;</td>
												<td>
												<input id="wan_mode" name="wan_mode" type="radio" value="pppoe" onchange="wan_mode_selector(this.value);">
												<STRONG><script>show_words(wwa_wanmode_pppoe);</script></STRONG>
												<div class=itemhelp><script>show_words(_setup_wizard_pppoe);</script></div>
											</td>
										</tr>
										<tr>
											<td class=form_label>&nbsp;</td>
											<td>
												<input id="wan_mode" name="wan_mode" type="radio" value="pptp" onchange="wan_mode_selector(this.value);">
												<STRONG><script>show_words(wwa_wanmode_pptp);</script></STRONG>
												<div class=itemhelp><script>show_words(wwa_msg_pptp);</script></div>
											</td>
										</tr>
										<tr>
											<td class=form_label>&nbsp;</td>
											<td>
												<input id="wan_mode" name="wan_mode" type="radio" value="l2tp" onchange="wan_mode_selector(this.value);">
												<STRONG><script>show_words(wwa_wanmode_l2tp);</script></STRONG>
												<div class=itemhelp><script>show_words(wwa_msg_l2tp);</script></div>
											</td>
										</tr>
                                        				<script>
										if ("<!--# echo feature_russsia -->" == "1"){
											var wwa_wanmode_russia_pppoe = wwa_wanmode_pppoe.replace("PPPoE", "Russia PPPoE");
											var wwa_wanmode_russia_pptp = wwa_wanmode_pptp.replace("PPTP", "Russia PPTP");
											var wwa_wanmode_russia_l2tp = wwa_wanmode_l2tp.replace("L2TP", "Russia L2TP");

											document.write("<tr id=\"show_russia_pppoe\" style=\"display:none\">");
											document.write("<td class=form_label >&nbsp;</td>");
											document.write("<td><input name=\"wan_mode\" type=\"radio\" value=\"russia_pppoe\" onchange=\"wan_mode_selector(this.value);\">");
												document.write(" <STRONG><script>show_words(wwa_wanmode_russia_pppoe);<\/script></STRONG>");
												document.write("<div class=itemhelp><script>show_words(_rus_pppoe);<\/script></div></td>");
											document.write("</tr>");
											document.write("<tr id=\"show_russia_pptp\" style=\"display:none\">");
											document.write("<td class=form_label>&nbsp;</td>");
											document.write("<td><input name=\"wan_mode\" type=\"radio\" value=\"russia_pptp\" onchange=\"wan_mode_selector(this.value);\">");
												document.write(" <STRONG><script>show_words(wwa_wanmode_russia_pptp);<\/script></STRONG>");
												document.write("<div class=itemhelp><script>show_words(_rus_pptp);<\/script></div></td>");
											document.write("</tr>");
											document.write("<tr id=\"show_russia_l2tp\" style=\"display:none\">");
											document.write("<td class=form_label>&nbsp;</td>");
											document.write("<td><input name=\"wan_mode\" type=\"radio\" value=\"russia_l2tp\" onchange=\"wan_mode_selector(this.value);\">");
												document.write(" <STRONG><script>show_words(wwa_wanmode_russia_l2tp);<\/script></STRONG>");
												document.write("<div class=itemhelp><script>show_words(_rus_l2tp);<\/script></div></td>");
											document.write("</tr>");
										}
									</script>
										<tr>
											<td class=form_label>&nbsp;</td>
											<td><input name="wan_mode" type="radio" value="static" onchange="wan_mode_selector(this.value);">
												<STRONG><script>show_words(wwa_wanmode_sipa);</script></STRONG>
												<div class=itemhelp><script>show_words(wwa_set_sipa_msg);</script></div></td>
										</tr>
									</table>
								</div>
							</div>
							<!-- wan_mode_select -->
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
                                    <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="Cancel" style="display:none" onclick="wz_cancel();">
									<input type="button" class="button_submit" id="cancel_b2" name="cancel_b2" value="Cancel" style="display:none" onclick="wz_cancel();">
									<input type="button" class="button_submit" id="prev_b" style="display:none" name="prev_b" value="Prev" onclick="go_back()">
									<input type="button" class="button_submit" id="next_b" style="display:none" name="next_b" value="Next" onclick="send_request();">
									<input type="button" class="button_submit" style="display:none" id="wz_try_b" name="wz_try_b" value="Try again" onclick="replay_page();">
									<input type="button" class="button_submit" style="display:none" id="wz_try_b2" name="wz_try_b2" value="Try again" onclick="replay_page();">
									<input type="button" class="button_submit" style="display:none" id="wz_guide_b" name="wz_guide_b" value="" onclick="send_guide_me();">
<script>
									get_by_id("cancel_b2").value = _cancel;
									get_by_id("prev_b").value = _prev;
									get_by_id("next_b").value = _next;
									get_by_id("cancel_b").value = _cancel;
									get_by_id("wz_try_b2").value = IPv6_wizard_button_0;
									get_by_id("wz_try_b").value = _connect;
									get_by_id("wz_guide_b").value = _setup_wizard_15;
								</script></td>
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
