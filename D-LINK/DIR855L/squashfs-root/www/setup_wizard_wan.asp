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
	var wan_detect_id = 0;

	function onPageLoad() {
		var wan_mode = get_by_id("wan_proto").value;
		
		if(wan_mode == "pppoe") {

			if (get_by_id("wan_pppoe_russia_enable").value == "1")
				get_by_id("show_pppoe_title").innerHTML = wwa_title_set_russia_pppoe;
			get_by_id("wan_ip_pppoe_mode").style.display = "";

		} else if(wan_mode == "pptp") {

			if (get_by_id("wan_pptp_russia_enable").value == "1")
				get_by_id("show_pptp_title").innerHTML = wwa_title_set_russia_pptp;
			get_by_id("wan_ip_pptp_mode").style.display = "";

			if("<!--# echo wan_pptp_dynamic -->" == 1) {
				pptp_mode_selector("1");
			} else {
				pptp_mode_selector("0");
			}

		} else if(wan_mode == "l2tp") {

			if (get_by_id("wan_l2tp_russia_enable").value == "1")
				get_by_id("show_l2tp_title").innerHTML = wwa_title_set_russia_l2tp;
			get_by_id("wan_ip_l2tp_mode").style.display = "";

			if("<!--# echo wan_l2tp_dynamic -->" == 1) {
				l2tp_mode_selector("1");
			} else {
				l2tp_mode_selector("0");
			}

		} else if(wan_mode == "static") {
			get_by_id("wan_ip_static_mode").style.display = "";

		} else {
			//spec 1.05 skip dhcp setting
			//get_by_id("wan_ip_dhcp_mode").style.display = "";
		}

		if(wan_mode == "dhcpc" || wan_mode == "pppoe") {
			get_by_id("wan_dns_settings").style.display = "none";
		} else {
			get_by_id("wan_dns_settings").style.display = "";
		}

	}

	function clone_mac_action() {
		get_by_id("wan_mac").value = get_by_id("mac_clone_addr").value;
	}

	function pptp_mode_selector(address_mode) {
		var pptp_mode = get_by_name("wan_pptp_mode");

		if(address_mode == "1") {
			pptp_mode[0].checked = true;
		} else {
			pptp_mode[1].checked = true;
		}
		pptp_mode.value = address_mode;
		get_by_id("wan_pptp_ipaddr").disabled = pptp_mode[0].checked;
		get_by_id("wan_pptp_netmask").disabled = pptp_mode[0].checked;
		get_by_id("wan_pptp_gateway").disabled = pptp_mode[0].checked;
	}

	function l2tp_mode_selector(address_mode) {
		var l2tp_mode = get_by_name("wan_l2tp_mode");
		if(address_mode == "1") {
			l2tp_mode[0].checked = true;
		} else {
			l2tp_mode[1].checked = true;
		}
		l2tp_mode.value = address_mode;
		get_by_id("wan_l2tp_ipaddr").disabled = l2tp_mode[0].checked;
		get_by_id("wan_l2tp_netmask").disabled = l2tp_mode[0].checked;
		get_by_id("wan_l2tp_gateway").disabled = l2tp_mode[0].checked;
	}

	function foolproof_dhcp() {
		/*
		 * Validate MAC and activate cloning if necessary
		 */
		var clonemac = get_by_id("wan_mac").value;
		if(!check_mac(clonemac)) {
			alert(KR3);
			return false;
		}

		/* dhcp don't have dns setting, need check asp_temp_69 & asp_temp_70 value */
		if(get_by_id("asp_temp_69").value == "") {
			get_by_id("asp_temp_69").value = "0.0.0.0";
		}
		if(get_by_id("asp_temp_70").value == "") {
			get_by_id("asp_temp_70").value = "0.0.0.0";
		}

		var mac = trim_string(get_by_id("wan_mac").value);
		if(!is_mac_valid(mac, true)) {
			alert(KR3 + ":" + mac + ".");
			return false;
		} else {
			if(mac == "00:00:00:00:00:00")
				get_by_id("wan_mac").value = get_by_id("old_wan_mac").value;
			else
				get_by_id("wan_mac").value = mac;
		}

		return true;
	}

	function foolproof_pppoe() {
		get_by_id("wan_pppoe_dynamic_00").value = "1";
		//always set dynamic: 1.04R

		get_by_id("wan_pppoe_username_00").value = trim_string(get_by_id("wan_pppoe_username_00").value);

		/* pppoe don't have dns setting, need check asp_temp_69 & asp_temp_70 value */
		if(get_by_id("asp_temp_69").value == "") {
			get_by_id("asp_temp_69").value = "0.0.0.0";
		}
		if(get_by_id("asp_temp_70").value == "") {
			get_by_id("asp_temp_70").value = "0.0.0.0";
		}
		if (get_by_id("wan_pppoe_username_00").value == ""){
			alert(wwa_pv5_alert_21);
			return false;
		}
		if(!check_username(get_by_id("wan_pppoe_username_00").value)) {
			alert(GW_SMTP_USERNAME_INVALID);
			return false;
		}
		

        if (get_by_id("wan_pppoe_password_00").value == "") {
            alert(vpn_ipsec_pwd_empty);
            return false;
        }


		return true;
	}

	function foolproof_pptp() {
		var pptp_type = get_by_name("wan_pptp_mode");
		var ip = get_by_id("wan_pptp_ipaddr").value;
		var mask = get_by_id("wan_pptp_netmask").value;
		var gateway = get_by_id("wan_pptp_gateway").value;
		var server_ip = get_by_id("wan_pptp_server_ip").value;
		var server_ip_addr_msg = replace_msg(all_ip_addr_msg, _sys_ipaddr);
		var temp_server_ip_obj = new addr_obj(server_ip.split("."), server_ip_addr_msg, false, false);

		if(!is_ipv4_valid(get_by_id("wan_pptp_ipaddr").value)) {
			alert(LS46);
			form1.wan_pptp_ipaddr.select();
			form1.wan_pptp_ipaddr.focus();
			return false;
		}

		if(!is_ipv4_valid(get_by_id("wan_pptp_netmask").value)) {
			alert(LS202);
			form1.wan_pptp_netmask.select();
			form1.wan_pptp_netmask.focus();
			return false;
		}

		if(!is_ipv4_valid(get_by_id("wan_pptp_gateway").value)) {
			alert(LS204);
			form1.wan_pptp_gateway.select();
			form1.wan_pptp_gateway.focus();
			return false;
		}

		/* In order to enter domain name */
		if(!check_servername(get_by_id("wan_pptp_server_ip").value)) {
	   		if (!check_address(temp_server_ip_obj)){
				form1.wan_pptp_server_ip.select();
				form1.wan_pptp_server_ip.focus();
				return false;
			}
		}

		get_by_id("wan_pptp_username").value = trim_string(get_by_id("wan_pptp_username").value);

		if (get_by_id("wan_pptp_username").value == "") {
			alert(wwa_pv5_alert_21);
			return false;
		}

		if(!check_username(get_by_id("wan_pptp_username").value)) {
			alert(GW_SMTP_USERNAME_INVALID);
			return false;
		}

		get_by_id("wan_pptp_password").value = trim_string(get_by_id("wan_pptp_password").value);
		if(get_by_id("wan_pptp_password").value != get_by_id("pptp_password2").value) {
			alert(_pwsame);
			form1.wan_pptp_password.select();
			form1.wan_pptp_password.focus();
			return false;
		}

        if (get_by_id("wan_pptp_password").value == "" || get_by_id("pptp_password2").value == "") {
            alert(vpn_ipsec_pwd_empty);
            return false;
        } 

		if(pptp_type[1].checked)
			if(!check_ip_mask_gw("PPTP", ip, mask, gateway)) {
				return false;
			}
		if(pptp_type[1].checked) {
			get_by_id("wan_pptp_dynamic").value = "0";
		} else {
			get_by_id("wan_pptp_dynamic").value = "1";
		}

		if(!check_dns()) {
			return false;
		}

		return true;
	}

	function foolproof_l2tp() {
		var l2tp_type = get_by_name("wan_l2tp_mode");
		var ip = get_by_id("wan_l2tp_ipaddr").value;
		var mask = get_by_id("wan_l2tp_netmask").value;
		var gateway = get_by_id("wan_l2tp_gateway").value;
		var server_ip = get_by_id("wan_l2tp_server_ip").value;
		var server_ip_addr_msg = replace_msg(all_ip_addr_msg, _sys_ipaddr);
		var temp_server_ip_obj = new addr_obj(server_ip.split("."), server_ip_addr_msg, false, false);


		if(!is_ipv4_valid(get_by_id("wan_l2tp_ipaddr").value)) {
			alert(LS46);
			form1.wan_l2tp_ipaddr.select();
			form1.wan_l2tp_ipaddr.focus();
			return false;
		}

		if(!is_ipv4_valid(get_by_id("wan_l2tp_netmask").value)) {
			alert(LS202);
			form1.wan_l2tp_netmask.select();
			form1.wan_l2tp_netmask.focus();
			return false;
		}

		if(!is_ipv4_valid(get_by_id("wan_l2tp_gateway").value)) {
			alert(LS204);
			form1.wan_l2tp_gateway.select();
			form1.wan_l2tp_gateway.focus();
			return false;
		}

		/* In order to enter domain name */
		if(!check_servername(get_by_id("wan_l2tp_server_ip").value)) {
	   		if (!check_address(temp_server_ip_obj)){
				form1.wan_l2tp_server_ip.select();
				form1.wan_l2tp_server_ip.focus();
				return false;
			}
		}

		get_by_id("wan_l2tp_username").value = trim_string(get_by_id("wan_l2tp_username").value);
		
		if(get_by_id("wan_l2tp_username").value == "") {
			alert(wwa_pv5_alert_21);
			return false;
		}

		if(!check_username(get_by_id("wan_l2tp_username").value)) {
			alert(GW_SMTP_USERNAME_INVALID);
			return false;
		}

		get_by_id("wan_l2tp_password").value = trim_string(get_by_id("wan_l2tp_password").value);
		if(get_by_id("wan_l2tp_password").value != get_by_id("l2tp_password2").value) {
			alert(_pwsame);
			form1.wan_l2tp_password.select();
			form1.wan_l2tp_password.focus();
			return false;
		}

        if (get_by_id("wan_l2tp_password").value == "" || get_by_id("l2tp_password2").value == "") {
            alert(vpn_ipsec_pwd_empty);
            return false;
        }


		if(l2tp_type[1].checked) {
			if(!check_ip_mask_gw("L2TP", ip, mask, gateway)) {
				return false;
			}
		}

		if(l2tp_type[1].checked) {
			get_by_id("wan_l2tp_dynamic").value = "0";
		} else {
			get_by_id("wan_l2tp_dynamic").value = "1";
		}

		if(!check_dns()) {
			return false;
		}

		return true;
	}

	function foolproof_static() {
		var ip = get_by_id("wan_static_ipaddr").value;
		var mask = get_by_id("wan_static_netmask").value;
		var gateway = get_by_id("wan_static_gateway").value;

		if(!is_ipv4_valid(get_by_id("wan_static_ipaddr").value)) {
			alert(LS46);
			form1.wan_static_ipaddr.select();
			form1.wan_static_ipaddr.focus();
			return false;
		}

		if(!is_ipv4_valid(get_by_id("wan_static_netmask").value)) {
			alert(LS202);
			form1.wan_static_netmask.select();
			form1.wan_static_netmask.focus();
			return false;
		}

		if(!is_ipv4_valid(get_by_id("wan_static_gateway").value)) {
			alert(LS204);
			form1.wan_static_gateway.select();
			form1.wan_static_gateway.focus();
			return false;
		}

		if(!check_ip_mask_gw("WAN", ip, mask, gateway)) {
			return false;
		}

		if(!check_dns()) {
			return false;
		}

		if(get_by_id("asp_temp_69").value == "0.0.0.0" || get_by_id("asp_temp_69").value =="") {
			if(get_by_id("asp_temp_70").value == "0.0.0.0" || get_by_id("asp_temp_70").value =="") {
				alert(GW_WAN_DNS_SERVERS_INVALID);
			} else {
				alert(GW_WAN_DNS_SERVER_SECONDARY_WITHOUT_PRIMARY_INVALID);
			}
			return false;
		}
		return true;
	}

	function check_ip_mask_gw(wan_msg, ip, mask, gateway) {
		var ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);
		var subnet_mask_msg = replace_msg(all_ip_addr_msg, _subnet);
		var gateway_msg = replace_msg(all_ip_addr_msg, "Gateway address");

		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);

		if(!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj, wan_msg)) {
			return false;
		}

		return true;
	}

	function advanced_dns() {
		if(get_by_id("opendns_enable").value == "1") {
			get_by_id("opendns_mode").value = 4;
			get_by_id("dns_relay").value = 1;
			get_by_id("asp_temp_69").value = "204.194.232.200";
			get_by_id("asp_temp_70").value = "204.194.234.200";
			get_by_id("asp_temp_69").disabled = true;
			get_by_id("asp_temp_70").disabled = true;

		} else {
			get_by_id("opendns_mode").value = 1;
			get_by_id("asp_temp_69").value = "0.0.0.0";
			get_by_id("asp_temp_70").value = "0.0.0.0";
			get_by_id("asp_temp_69").disabled = false;
			get_by_id("asp_temp_70").disabled = false;

		}
	}
	
	function check_dns(){
	
		var dns1 = get_by_id("asp_temp_69").value;
		var dns2 = get_by_id("asp_temp_70").value;
		var dns1_addr_msg = replace_msg(all_ip_addr_msg, wwa_pdns);
		var dns2_addr_msg = replace_msg(all_ip_addr_msg, wwa_sdns);
		var temp_dns1_obj = new addr_obj(dns1.split("."), dns1_addr_msg, true, false);
		var temp_dns2_obj = new addr_obj(dns2.split("."), dns2_addr_msg, true, false);
		
		if (dns1 != "" && dns1 != "0.0.0.0"){
			if (!check_address(temp_dns1_obj)){
				return false;
			}
		}

		if (dns2 != "" && dns2 != "0.0.0.0"){
			if (!check_address(temp_dns2_obj)){
				return false;
			}
		}
		
		return true;
	}

	/*function check_dns() {
		
		//Allow blank as well as 0.0.0.0 for DNS servers.
		 
		get_by_id("asp_temp_69").value = trim_string(get_by_id("asp_temp_69").value);
		if(get_by_id("asp_temp_69").value == "") {
			get_by_id("asp_temp_69").value = "0.0.0.0";
		}

		get_by_id("asp_temp_70").value = trim_string(get_by_id("asp_temp_70").value);
		if(get_by_id("asp_temp_70").value == "") {
			get_by_id("asp_temp_70").value = "0.0.0.0";
		}

		if(!is_ipv4_valid(get_by_id("asp_temp_69").value)) {
			alert(YM128);
			form1.asp_tmep_69.select();
			form1.asp_temp_69.focus();
			return false;
		}

		if(!is_ipv4_valid(get_by_id("asp_temp_70").value)) {
			alert(YM129);
			form1.asp_temp_70.select();
			form1.asp_temp_70.focus();
			return false;
		}
		return true;
	}*/

	function send_request() {
		var wan_mode = get_by_id("wan_proto").value;
		var flag;

		if(wan_mode == "dhcpc") {
			flag = foolproof_dhcp();
		} else if(wan_mode == "pppoe") {
			flag = foolproof_pppoe();
		} else if(wan_mode == "pptp") {
			flag = foolproof_pptp();
		} else if(wan_mode == "l2tp") {
			flag = foolproof_l2tp();
		} else if(wan_mode == "static") {
			flag = foolproof_static();
		}

		if(flag) {
			get_by_id("wan_primary_dns").value = get_by_id("asp_temp_69").value;
			get_by_id("wan_secondary_dns").value = get_by_id("asp_temp_70").value;
			
			if(get_by_id("wan_primary_dns").value == "0.0.0.0" && get_by_id("wan_secondary_dns").value == "0.0.0.0"){
				get_by_id("wan_specify_dns").value = "0";
			}else{
				get_by_id("wan_specify_dns").value = "1";
			}
			
			disable_all_btn(true);
			send_submit("form1");
			return true;
		} else {
			return false;
		}
	}

	function wz_cancel() {
		if(confirm(_setup_wizard_17)) {
			disable_all_btn(true);
			send_submit("form2");
		}
	}

	function go_back() {
		get_by_id("html_response_page").value = "setup_wizard_detect.asp";
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
							<input type="hidden" name="html_response_page" id="html_response_page" value="setup_wizard_wlan.asp">
							<input type="hidden" name="html_response_message" value="">
							<input type="hidden" name="html_response_return_page" value="setup_wizard_wlan.asp">
							<input type="hidden" name="reboot_type" value="none">
							<input type="hidden" id="action" name="action" value="response_page">
							<input type="hidden" id="setup_wizard_pre_page" name="setup_wizard_pre_page" value ="setup_wizard_wan.asp">
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
							<input type="hidden" id="wan_primary_dns" name="wan_primary_dns" value="<!--# echo asp_temp_69 -->">
							<input type="hidden" id="wan_secondary_dns" name="wan_secondary_dns" value="<!--# echo asp_temp_70 -->">
							<input type="hidden" id="dns_relay" name="dns_relay" value="<!--# echo dns_relay -->">
							<input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value="<!--# echo wan_specify_dns -->">
							<!-- for dhcp info -->
							<input type="hidden" id="wan_ip_value" name="wan_ip_value" value="<!--# echo wan_ip_value -->">
							<input type="hidden" id="wan_netmask_value" name="wan_netmask_value" value="<!--# echo wan_netmask_value -->">
							<input type="hidden" id="wan_gateway_value" name="wan_gateway_value" value="<!--# echo wan_gateway_value -->">
							<input type="hidden" id="wan_dns1_value" name="wan_dns1_value" value="<!--# echo wan_dns1_value -->">
							<input type="hidden" id="wan_dns2_value" name="wan_dns2_value" value="<!--# echo wan_dns2_value -->">
							<input type="hidden" id="wan_proto" name="wan_proto" value="<!--# echo wan_proto -->">
							<input type="hidden" id="old_wan_mac" name="old_wan_mac" value="<!--# echo wan_mac -->">
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
		
							
							<!-- wan_ip_dchp_mode -->
							<div id="wan_ip_dhcp_mode" style="display:none">
								<h2 align="left"><script>show_words(_dhcpconn);</script></h2>
								<p class="box_msg"><script>show_words(wwa_msg_set_dhcp);</script></p>
								<table align="center" class=formarea>
									<tr>
										<td width="170" align=right class="duple"><script>show_words(_macaddr);</script> :</td>
										<td width="430">&nbsp; <input type="text" id="wan_mac" name="wan_mac" maxlength="17" size="20" value="<!--# echo wan_mac -->"><script>show_words(_optional)</script></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# exec cgi /bin/clone mac_clone_addr -->">
										<input name="clone" type="button" class="button_submit" id="clone" value="" onClick="clone_mac_action()">
										<script>get_by_id("clone").value = _clonemac;</script></td>
									</tr>
								</table>
							</div>
							<!-- wan_ip_dchp_mode -->
							<!-- wan_ip_pppoe_mode -->
							<div id="wan_ip_pppoe_mode" style="display:none">
								<h2 align="left" id="show_pppoe_title" name="show_pppoe_title"><script>show_words(wwa_title_set_pppoe);</script></h2>
								<p class="box_msg"><script>show_words(wwa_msg_set_pppoe);</script></p>
								<table align="center" class=formarea>
									<input type="hidden" id="wan_pppoe_dynamic_00" name="wan_pppoe_dynamic_00" value="<!--# echo wan_pppoe_dynamic_00 -->">
									<!-- fix pppoe setting to spec 1.04R1 -->
									<tr>
										<td width="170" align=right class="duple"><script>show_words(_username);</script> :</td>
										<td width="430">&nbsp; <input type=text id="wan_pppoe_username_00" name="wan_pppoe_username_00" size="20" maxlength="63" value="<!--# echo wan_pppoe_username_00 -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_password);</script> :</td>
										<td>&nbsp; <input type=text id="wan_pppoe_password_00" name="wan_pppoe_password_00" size="20" maxlength="63" value="<!--# echo wan_pppoe_password_00 -->"></td>
									</tr>
								</table>
							</div>
							<!-- wan_ip_pppoe_mode -->
							<!-- wan_ip_pptp_mode -->
							<div id="wan_ip_pptp_mode" style="display:none">
								<h2 align="left" id="show_pptp_title" name="show_pptp_title"><script>show_words(wwa_title_set_pptp);</script></h2>
								<p class="box_msg"><script>show_words(wwa_msg_set_pptp);</script></p>
								<table align="center" class=formarea >
									<tr>
										<td width="170" align=right class="duple"><script>show_words(bwn_AM);</script> :</td>
										<td width="430">&nbsp; <input name="wan_pptp_mode" type="radio" value="1" onClick="pptp_mode_selector(this.value)"><script>show_words(carriertype_ct_0);</script>&nbsp;&nbsp; 
										<input name="wan_pptp_mode" type="radio" value="0" onClick="pptp_mode_selector(this.value)">
										<input type="hidden" id="wan_pptp_dynamic" name="wan_pptp_dynamic" value="<!--# echo wan_pptp_dynamic -->">
										<script>show_words(_sdi_staticip);</script></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_PPTPip);</script> :</td>
										<td>&nbsp;<input type=text id="wan_pptp_ipaddr" name="wan_pptp_ipaddr" size="20" maxlength="15" value="<!--# echo wan_pptp_ipaddr -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_PPTPsubnet);</script> :</td>
										<td>&nbsp;<input type=text id="wan_pptp_netmask" name="wan_pptp_netmask" size="20" maxlength="15" value="<!--# echo wan_pptp_netmask -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_PPTPgw);</script> :</td>
										<td>&nbsp;<input type=text id="wan_pptp_gateway" name="wan_pptp_gateway" size="20" maxlength="15" value="<!--# echo wan_pptp_gateway -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(wwa_pptp_svraddr);</script> :</td>
										<td>&nbsp;<input type=text id="wan_pptp_server_ip" name="wan_pptp_server_ip" value="<!--# echo wan_pptp_server_ip -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_username);</script> :</td>
										<td>&nbsp;<input type=text id="wan_pptp_username" name="wan_pptp_username" size="20" maxlength="63" value="<!--# echo wan_pptp_username -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_password);</script> :</td>
										<td>&nbsp;<input type=password id="wan_pptp_password" name="wan_pptp_password" size="20" maxlength="63" value="<!--# echo wan_pptp_password -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_verifypw);</script> :</td>
										<td>&nbsp;<input type=password id="pptp_password2" name="pptp_password2" size="20" maxlength="63" value="<!--# echo wan_pptp_password -->"></td>
									</tr>
								</table>
							</div>
							<!-- wan_ip_pptp_mode -->
							<!-- wan_ip_l2tp_mode -->
							<div id="wan_ip_l2tp_mode" style="display:none">
								<h2 align="left" id="show_l2tp_title" name="show_l2tp_title"><script>show_words(wwa_title_set_l2tp);</script></h2>
								<p class="box_msg"><script>show_words(wwa_msg_set_l2tp)</script></p>
								<table align="center" class=formarea >
									<tr>
										<td width="170" align=right class="duple"><script>show_words(bwn_AM);</script> :</td>
										<td width="430">&nbsp; <input name="wan_l2tp_mode" type="radio" value="1" onClick="l2tp_mode_selector(this.value)" >
										<script>show_words(carriertype_ct_0);</script>&nbsp;&nbsp; <input name="wan_l2tp_mode" type="radio" value="0" onClick="l2tp_mode_selector(this.value)">
										<input type="hidden" id="wan_l2tp_dynamic" name="wan_l2tp_dynamic" value="<!--# echo wan_l2tp_dynamic -->">
										<script>show_words(_sdi_staticip);</script></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_L2TPip);</script> :</td>
										<td>&nbsp;<input type=text id="wan_l2tp_ipaddr" name="wan_l2tp_ipaddr" size="20" maxlength="15" value="<!--# echo wan_l2tp_ipaddr -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_L2TPsubnet);</script> :</td>
										<td>&nbsp;<input type=text id="wan_l2tp_netmask" name="wan_l2tp_netmask" size="20" maxlength="15" value="<!--# echo wan_l2tp_netmask -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_L2TPgw);</script> :</td>
										<td>&nbsp;<input type=text id="wan_l2tp_gateway" name="wan_l2tp_gateway" size="20" maxlength="15" value="<!--# echo wan_l2tp_gateway -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(wwa_l2tp_svra);</script> :</td>
										<td>&nbsp;<input type=text id="wan_l2tp_server_ip" name="wan_l2tp_server_ip" value="<!--# echo wan_l2tp_server_ip -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_username);</script> :</td>
										<td>&nbsp;<input type=text id="wan_l2tp_username" name="wan_l2tp_username" size="20" maxlength="63" value="<!--# echo wan_l2tp_username -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_password);</script> :</td>
										<td>&nbsp;<input type=password id="wan_l2tp_password" name="wan_l2tp_password" size="20" maxlength="63" value="<!--# echo wan_l2tp_password -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_verifypw);</script> :</td>
										<td>&nbsp;<input type=password id="l2tp_password2" name="l2tp_password2" size="20" maxlength="63" value="<!--# echo wan_l2tp_password -->"></td>
									</tr>
								</table>
							</div>
							<!-- wan_ip_l2tp_mode -->
							<!-- wan_ip_static_mode -->
							<div id="wan_ip_static_mode" style="display:none">
								<h2 align="left"><script>show_words(wwa_set_sipa_title);</script></h2>
								<p class="box_msg"><script>show_words(wwa_set_sipa_msg);</script></p>
								<table align="center" class=formarea>
									<tr>
										<td width="170" align=right class="duple"><script>show_words(_ipaddr);</script>&nbsp;:</td>
										<td width="430">&nbsp;<input type=text id="wan_static_ipaddr" name="wan_static_ipaddr" size="20" maxlength="15" value="<!--# echo wan_static_ipaddr -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(_subnet);</script>&nbsp;:</td>
										<td>&nbsp;<input type=text id="wan_static_netmask" name="wan_static_netmask" size="20" maxlength="15" value="<!--# echo wan_static_netmask -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(wwa_gw);</script>&nbsp;:</td>
										<td>&nbsp;<input type=text id="wan_static_gateway" name="wan_static_gateway" size="20" maxlength="15" value="<!--# echo wan_static_gateway -->"></td>
									</tr>
								</table>
							</div>
							<!-- wan_ip_static_mode -->
							<br>
							<!-- wan_dns_settings -->
							<div id="wan_dns_settings" style="display:none">
								<h2 align="left"><script>show_words(wwa_dnsset);</script></h2>
								<table align="center" class=formarea>
									<tr>
										<td width="170" align=right class="duple"><script>show_words(wwa_pdns);</script> :</td>
										<td width="430">&nbsp;<input type=text id="asp_temp_69" name="asp_temp_69" size="20" maxlength="15" value="<!--# echo wan_primary_dns -->"></td>
									</tr>
									<tr>
										<td align=right class="duple"><script>show_words(wwa_sdns);</script> :</td>
										<td>&nbsp;<input type=text id="asp_temp_70" name="asp_temp_70" size="20" maxlength="15" value="<!--# echo wan_secondary_dns -->"></td>
									</tr>
								</table>
								<br>
							</div>
							<!-- wan_dns_settings -->
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
								<input type="button" class="button_submit" id="next_b2" name="next_b" value="Next" onclick="send_request();">
								<script>
									get_by_id("prev_b2").value = _prev;
									get_by_id("next_b2").value = _next;
									get_by_id("cancel_b2").value = _cancel;
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
</html>
