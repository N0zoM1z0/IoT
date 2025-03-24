<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script>
	var submit_button_flag = 0;
	//2009/4/29 Tina add OPENDNS
	function opendns_enable_selector(value){
		if(value==true){
			get_by_id("wan_specify_dns").value ="1";
			if("<!--# echo feature_parental_control -->" == "1"){
				get_by_id("wan_primary_dns").value ="<!--# echo wan_primary_dns -->";
				get_by_id("wan_secondary_dns").value="<!--# echo wan_secondary_dns -->";
			}else{	
				get_by_id("wan_primary_dns").value ="204.194.232.200";
				get_by_id("wan_secondary_dns").value="204.194.234.200";
			}
			get_by_id("wan_primary_dns").disabled = true;
			get_by_id("wan_secondary_dns").disabled = true;		
		}else{
			get_by_id("wan_specify_dns").value ="0";
			get_by_id("wan_primary_dns").disabled = false;
			get_by_id("wan_secondary_dns").disabled = false;
			get_by_id("wan_primary_dns").value = "0.0.0.0";
			get_by_id("wan_secondary_dns").value =	"0.0.0.0";
		}
	}
	//OPENDNS
	
	function onPageLoad(){
		//2009/4/29 Tina add OPENDNS
		/*
		set_checked(get_by_id("opendns_enable").value, get_by_id("opendns_enable_sel"));
		if(get_by_id("opendns_enable_sel").checked)
			opendns_enable_selector(get_by_id("opendns_enable_sel").checked);
			*/
		//OPENDNS
	
		set_checked("<!--# echo wan_pptp_dynamic -->", get_by_name("wan_pptp_dynamic"));
		set_checked("<!--# echo wan_pptp_connect_mode -->", get_by_name("wan_pptp_connect_mode"));
		
		set_checked("<!--# echo wan_pptp_proto_client -->", get_by_name("wan_pptp_proto_client"));
                set_checked("<!--# echo wan_pptp_encryption_client -->", get_by_name("wan_pptp_encryption_client"));
		//check_connectmode();
		//clickPPTP();
//		show_AdvDns();
		if (get_by_id("wan_mac").value === "<!--# echo sys_wan_mac -->") {
			get_by_id("wan_mac").value = "";
		}
		var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);
		}else{
			check_connectmode();
			clickPPTP();
			change_type();
		}
		set_form_default_values("form1");
	}
	function show_AdvDns() {
		if("<!--# echo feature_parental_control -->" == "1"){
			get_by_id("show_AdvDns").style.display = "none";
		}else{
			get_by_id("show_AdvDns").style.display = "";
		}
	}	
	function clone_mac_action(){
		get_by_id("mac_clone_addr").value = get_by_id("mac_clone_addr2").value;
        get_by_id("wan_mac").value = get_by_id("mac_clone_addr").value;
	}

	function check_connectmode(){
		var conn_mode = get_by_name("wan_pptp_connect_mode");
		var idle_time = get_by_id("wan_pptp_max_idle_time");
		idle_time.disabled = !conn_mode[1].checked;
	}

	function clickPPTP(){
	  var fixIP = get_by_name("wan_pptp_dynamic");
	  var is_disabled;
	  
	  if (fixIP[0].checked) {
	     is_disabled = true
	  }
	  get_by_id("wan_pptp_ipaddr").disabled = is_disabled;
	  get_by_id("wan_pptp_netmask").disabled = is_disabled;
	  get_by_id("wan_pptp_gateway").disabled = is_disabled;
	  //get_by_id("wan_primary_dns").disabled = is_disabled;
	  //get_by_id("wan_secondary_dns").disabled = is_disabled;
	}

	function change_type() {
		var pptpd_proto = get_by_name("wan_pptp_proto_client");
		var pptp_encryption= get_by_name("wan_pptp_encryption_client");
		get_by_id("mppe_encryp").style.display="none";
		if (pptpd_proto[0].checked)
			get_by_name("wan_pptp_proto_client")[0].checked = true;

                else if (pptpd_proto[1].checked)
                         get_by_name("wan_pptp_proto_client")[1].checked = true;

		else if (pptpd_proto[2].checked) {
			get_by_id("mppe_encryp").style.display="";
			get_by_name("wan_pptp_proto_client")[2].checked = true;

			if(pptp_encryption[0].checked)
				get_by_name("wan_pptp_encryption_client")[0].checked= true;

			else if (pptp_encryption[1].checked)
				get_by_name("wan_pptp_encryption_client")[1].checked= true;
			
			else if (pptp_encryption[2].checked)
				get_by_name("wan_pptp_encryption_client")[2].checked= true;
		}
	}

 
	function send_pptp_request(){
	        var ipv6_pppoe_share = "<!--# echo ipv6_pppoe_share -->";
	        var ipv6_wan_proto = "<!--# echo ipv6_wan_proto -->";
		var ipv6_6rd_dhcp = "<!--# echo ipv6_6rd_dhcp -->";
        	if (ipv6_wan_proto == "ipv6_pppoe" && ipv6_pppoe_share == "1"){
                	alert(IPV6_TEXT1);
	                return false;
        	}

		if (ipv6_wan_proto == "ipv6_6rd" && ipv6_6rd_dhcp == "1"){
        		alert(IPV6_6rd_v6wan);
			return false;
		}

		get_by_id("asp_temp_52").value = get_by_id("wan_proto").value;

		var is_type_changed = false;
		if ("<!--# echo feature_russsia -->" == "1" && 
		    "<!--# echo wan_proto -->" == "pptp" && 
		    "<!--# echo wan_pptp_russia_enable -->" == "1")
			is_type_changed = true;

		var is_modify = is_form_modified("form1");
		if (!is_modify && !is_type_changed && !confirm(_ask_nochange)) {
			return false;
		}
		var fix_ip = get_by_name("wan_pptp_dynamic");
		var ip = get_by_id("wan_pptp_ipaddr").value;
		var mask = get_by_id("wan_pptp_netmask").value;  
		var gateway = get_by_id("wan_pptp_gateway").value;  
		var dns1 = get_by_id("wan_primary_dns").value;
		var dns2 = get_by_id("wan_secondary_dns").value;
		var server_ip = get_by_id("wan_pptp_server_ip").value;
		var user_name = get_by_id("wan_pptp_username").value;
		var idle = get_by_id("wan_pptp_max_idle_time").value;	    	
		var mtu = get_by_id("wan_pptp_mtu").value;
		
		var ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);
		var gateway_msg = replace_msg(all_ip_addr_msg, wwa_gw);
		var primary_dns_msg = replace_msg(all_ip_addr_msg, wwa_pdns);
		var second_dns_msg = replace_msg(all_ip_addr_msg, wwa_sdns);
		var server_ip_addr_msg = replace_msg(all_ip_addr_msg, _sys_ipaddr);
		
		var max_idle_msg = replace_msg(check_num_msg, bwn_MIT, 0, 9999);
		var mtu_msg = replace_msg(check_num_msg, bwn_MTU, 1300, 1400);
		
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
		var temp_dns1 = new addr_obj(dns1.split("."), primary_dns_msg, true, false);
		var temp_dns2 = new addr_obj(dns2.split("."), second_dns_msg, true, false);
		var temp_idle = new varible_obj(idle, max_idle_msg, 0, 9999, false);
		var temp_mtu = new varible_obj(mtu, mtu_msg, 1300, 1400, false);
		var temp_server_ip_obj = new addr_obj(server_ip.split("."), server_ip_addr_msg, false, false);
        
		if (fix_ip[1].checked){
			if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj, "PPTP")){
				return false;
			}
			if ((dns1 == "" || dns1 == "0.0.0.0") && (dns2 == "" || dns2 == "0.0.0.0")) {
				alert(GW_WAN_DNS_SERVERS_INVALID);
				return false;
			}
		}
		
		if(server_ip == ""){
			alert(MSG046);
			return false;
		}
	
		/* In order to enter domain name */
		if(!check_servername(server_ip)) {
	   		if (!check_address(temp_server_ip_obj)){
   				return false;
   			}
		}	
		if (user_name == ""){
			alert(wwa_pv5_alert_21);
			return false;
		}

		if (!check_username(user_name)){
			alert(GW_SMTP_USERNAME_INVALID);
			return false;
		}

	        if (get_by_id("pptppwd1").value == "" || get_by_id("pptppwd2").value == ""){
		 	alert(vpn_ipsec_pwd_empty);
			return false;
		}	
		if (!check_pwd("pptppwd1", "pptppwd2")){
			return false;
		}

	        if (get_by_name("wan_pptp_connect_mode") != "on_demand") {
			var idel_time = temp_idle.var_value.split("");
			if(idel_time == "") 
				get_by_id("wan_pptp_max_idle_time").value = "<!--# echo wan_pptp_max_idle_time -->";

		} else if (!check_varible(temp_idle)){
			return false;
		}
    	
		if (dns1 != "" && dns1 != "0.0.0.0"){
			if (!check_address(temp_dns1)){
				return false;
			}
		}
    	
		if (dns2 != "" && dns2 != "0.0.0.0"){
			if (!check_address(temp_dns2)){
				return false;
			}
		}
    	
		if (!check_varible(temp_mtu)){
			return false;
		}

		var pptp_proto = get_by_name("wan_pptp_proto_client");
		var pptp_encryption= get_by_name("wan_pptp_encryption_client");
		if(pptp_proto[0].checked)
			get_by_name("wan_pptp_proto_client").value = "pap";
		else if(pptp_proto[1].checked)
			get_by_id("wan_pptp_proto_client").value = "chap";
		else if(pptp_proto[2].checked) {
			get_by_name("wan_pptp_proto_client").value = "mschap-v2";

			if(pptp_encryption[0].checked)
				get_by_name("wan_pptp_encryption_client").value="none";
			else if(pptp_encryption[1].checked)
				get_by_name("wan_pptp_encryption_client").value="mppe-40";
			else if(pptp_encryption[2].checked)
				get_by_name("wan_pptp_encryption_client").value="mppe-128";
		}


		var wanmode = get_by_id("wan_proto").selectedIndex;
		var real_wanmode = get_by_id("asp_temp_52").value;
		var usb_mode = get_by_id("from_usb3g").value;
		var usb_type = get_by_id("usb_type").value;
		var pop_3 = usb_config6;
		var warn_1 = usb_config3;
		var warn_2 = usb_config4;
		if(usb_mode == "2" && usb_type == "2"  && real_wanmode =="pptp" ||usb_mode == "0" && usb_type == "2" && real_wanmode =="pptp"){ 
			alert(pop_3); 
			get_by_id("usb_type").value = "0"; // force to save usb_type	
			get_by_id("reboot_type").value = "all"; 
		}else if(usb_mode == "2" && usb_type == "0" && real_wanmode =="usb3g" ){ //3G USB
			get_by_id("usb_type").value = "0"; // force to save usb_type	
			get_by_id("reboot_type").value = "all";
		}else if(usb_mode == "2" && usb_type == "0" && wanmode !="5" ||usb_mode == "2" && usb_type == "1" && wanmode !="5" ){ //3G USB
			alert(warn_1);
			return false;
		}else if(usb_mode == "0" && wanmode !="5" ){ //network USB
			get_by_id("usb_type").value = "0"; // force to save usb_type	
			get_by_id("reboot_type").value = "all";
		}

		//2009/4/29 Tina add OPENDNS
		/*
		get_by_id("opendns_enable").value = get_checked_value(get_by_id("opendns_enable_sel"));
		if(get_by_id("opendns_enable").value=="1"){
			get_by_id("dns_relay").value = "1";
			get_by_id("wan_primary_dns").disabled = false;
			get_by_id("wan_secondary_dns").disabled = false;
		}
		*/
		//OPENDNS

		/*
		 * Validate MAC and activate cloning if necessary
		 */
		/* Mac should not be 00:00:00:00:00:00 or FF:FF:FF:FF:FF:FF*/
		if (!isInvalidMac(get_by_id("wan_mac").value)) {
			alert(_clone_error);
			return false;
		}
	
		var clonemac = get_by_id("wan_mac").value; 
		if (!check_mac(clonemac)){
			alert(_clone_error);
			return false;
		} 
		 	
		var mac = trim_string(get_by_id("wan_mac").value);
		if(!is_mac_valid(mac, false)) {
			get_by_id("wan_mac").value = "<!--# echo sys_wan_mac -->";
			return false;
		}else{
			get_by_id("wan_mac").value = mac;
		}
				
		if (dns1 != "" && dns1 != "0.0.0.0"){
			if (!check_address(temp_dns1)){
				return false;
			}
		}
    	
		if((get_by_id("wan_primary_dns").value =="" || get_by_id("wan_primary_dns").value =="0.0.0.0")
			&& ( get_by_id("wan_secondary_dns").value =="" || get_by_id("wan_secondary_dns").value =="0.0.0.0")){
			get_by_id("wan_specify_dns").value = 0;
		}else{
			get_by_id("wan_specify_dns").value = 1;
		}
		
		if(submit_button_flag == 0){
			if(get_by_id("pptppwd1").value !="WDB8WvbXdH"){
				get_by_id("wan_pptp_password").value = get_by_id("pptppwd1").value;
			}

			//Block PPPoE, PPTP, L2TP allow saving without password in the fist.
			if(get_by_id("wan_pptp_password").value == ""){
				alert(vpn_ipsec_pwd_empty);
				return false;
			}

			/*
			if(is_modify || get_by_id("asp_temp_51").value.length > 0){
				get_by_id("asp_temp_51").value = "wan";
				get_by_id("html_response_page").value = "wan_reboot_need.asp";
			}else{
				window.location.href = get_by_id("html_response_page").value;
			}
			*/
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
    }
</script>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_3g_if();"><!--# echo model_number --></a></td>
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
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<script>show_left("Setup", 0);</script>
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">	
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wan_pptp.asp">
				<input type="hidden" id="action" name="action" value="wan_pptp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="wan">
				<input type="hidden" id="result_timer" name="result_timer" value="20">
				<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# echo mac_clone_addr -->">
				<input type="hidden" id="mac_clone_addr2" name="mac_clone_addr2" value="<!--# exec cgi /bin/clone mac_clone_addr -->">
                <input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value="<!--# echo wan_specify_dns -->">
				<input type="hidden" id="wan_pptp_password"  name="wan_pptp_password" value="<!--# echo wan_pptp_password -->">
				<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<!--# echo asp_temp_51 -->">
				<input type="hidden" id="asp_temp_52" name="asp_temp_52" value="<!--# echo wan_proto -->">
				<input type="hidden" id="usb_type" name="usb_type" value="<!--# echo usb_type -->"> 
			    <input type="hidden" id="from_usb3g" name="from_usb3g" value="<!--# echo asp_temp_72 -->"> 
				<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="0">
			    <input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="0">
			    <input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="0">
				<input type="hidden" id="hnat_enable" name="hnat_enable" value="0">
				<input type="hidden" id="reboot_type" name="reboot_type" value="wan">
			<div id=maincontent>
			  <!-- === BEGIN MAINCONTENT === -->
              <div id=box_header>
                <h1><script>show_words(_WAN);</script></h1>
                <p><script>show_words(bwn_intro_ICS);</script></p>
                <p><strong><script>show_words(_note);</script>:&nbsp;</strong><script>show_words(bwn_note_clientSW);</script></p>
                <input name="button" id="button"type="submit" class=button_submit value="Save Settings" onClick="return send_pptp_request()">
	       <script>get_by_id("button").value=_savesettings;</script>
                <input name="button2" id="button2" type=reset class=button_submit value="Don't Save Settings" onClick="return page_cancel('form1', 'sel_wan.asp');">
				<script>check_reboot();</script>
	       <script>get_by_id("button2").value=_dontsavesettings;</script>
              </div>
              <div class=box>
                <h2><script>show_words(bwn_ict);</script></h2>
                <p class="box_msg"><script>show_words(bwn_msg_Modes);</script></p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td align=right width="185" class="duple"><script>show_words(bwn_mici);</script> :</td>
                      <td width="331">&nbsp; <select name="wan_proto" id="wan_proto" onChange="change_wan()">
                        <option value="static"><script>show_words(_sdi_staticip)</script></option>
                        <option value="dhcpc"><script>show_words(bwn_Mode_DHCP)</script></option>
                        <option value="pppoe"><script>show_words(bwn_Mode_PPPoE)</script></option>
                        <option value="pptp" selected><script>show_words(bwn_Mode_PPTP)</script></option>
                        <option value="l2tp"><script>show_words(bwn_Mode_L2TP)</script></option>
			<!-- <option value="dslite">DS-Lite</option> -->
			<script>
				 if ("<!--# echo feature_dslite -->" == "1") {
                                        var str = "<option value=dslite>"+ DSLITE + "</option>";
                                        show_words(str);
                                 }
                                if ("<!--# echo feature_usb -->" == "1") {
				 									var str="";
				 									if ("<!--# echo feature_usb_3g -->" == "1") {
														str += "<option value=usb3g>"+ usb_3g + "</option>";
														}
													if ("<!--# echo feature_usb_3g_phone -->" == "1") {
														str += "<option value=usb3g_phone>" + usb_3g_phone + "</option>";
													}
													show_words(str);
				 								}
				if ("<!--# echo feature_mpppoe -->" == "1") {
                                        var str = "<option value=mpppoe>"+ bwn_Mode_MPPPoE + "</option>";
                                        show_words(str);
                                 }
							if ("<!--# echo feature_russsia -->" == "1") {
								var str = "<option value=rus_pppoe>"+ bwn_Mode_RUS_PPPoE + "</option>";
								show_words(str);
							}
							if ("<!--# echo feature_russsia -->" == "1") {
								var str = "<option value=rus_pptp>"+ bwn_Mode_RUS_PPTP + "</option>";
								show_words(str);
							}
							if ("<!--# echo feature_russsia -->" == "1") {
								var str = "<option value=rus_l2tp>"+ bwn_Mode_RUS_L2TP + "</option>";
								show_words(str);
							}		 
                        </script>
                         <!--option value="bigpond"><script>show_words(bwn_Mode_BigPond)</script></option-->
                      </select></td>
                    </tr>
                </table>
              </div>
			<!--//2009/4/29 Tina add OPENDNS-->
			<input type="hidden" id="opendns_enable" name="opendns_enable" value="<!--# echo opendns_enable -->">
			<input type="hidden" id="dns_relay" name="dns_relay" value="<!--# echo dns_relay -->">
			<!--div class=box id="show_AdvDns">
			 <h2><script>show_words(_title_AdvDns);</script></h2>
			 <p class="box_msg"><script>show_words( _desc_AdvDns);</script></p>
			<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
				   <td width="185" align=right style="WIDTH: 190px;" class="duple"><script>show_words(_en_AdvDns);</script> :</td>
					<td width="331">&nbsp;<input type="checkbox" id="opendns_enable_sel" name="opendns_enable_sel" value="1" onclick="opendns_enable_selector(this.checked);"></td>
				</tr>
			</table>
			</div-->
			<!--//OPENDNS-->
              <div class=box id=show_pptp>
                <h2><script>show_words(_PPTP);</script>&nbsp;<script>show_words(INTERNET_CONNECTION_TYPE);</script></h2>
                <p class="box_msg"><script>show_words(_ispinfo);</script> </p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td width="185" align=right class="duple"><script>show_words(bwn_AM);</script> :</td>
                      <td width="331">&nbsp;
                      <input type=radio value="1" name="wan_pptp_dynamic" onClick=clickPPTP() checked>
                      	<script>show_words(bwn_Mode_DHCP);</script>
                      <input type=radio value="0" name="wan_pptp_dynamic" onClick=clickPPTP()>
                      	<script>show_words(_sdi_staticip);</script>
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(_PPTPip);</script> :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pptp_ipaddr" name="wan_pptp_ipaddr" size="20" maxlength="15" value="<!--# echo wan_pptp_ipaddr -->">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(_PPTPsubnet);</script> :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pptp_netmask" name="wan_pptp_netmask" size="20" maxlength="15" value="<!--# echo wan_pptp_netmask -->">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(_PPTPgw);</script> :</td>
                      <td>&nbsp;
                      	<input name="wan_pptp_gateway" type=text id="wan_pptp_gateway" size="20" maxlength="15" value="<!--# echo wan_pptp_gateway -->">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_PPTPSIPA);</script> :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pptp_server_ip" name="wan_pptp_server_ip" value="<!--# echo wan_pptp_server_ip -->">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_UN);</script> :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pptp_username" name="wan_pptp_username" size="20" maxlength="63" value="<!--# echo wan_pptp_username -->">
                      </td>
                    </tr>
                    <tr>
                      <td  align=right class="duple"><script>show_words(_password);</script> :</td>
                      <td>&nbsp;
                      	<input type=password id="pptppwd1" name="pptppwd1" size="20" maxlength="63" value="WDB8WvbXdH">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(_verifypw);</script> :</td>
                      <td>&nbsp;
                      	<input type=password id=pptppwd2 name=pptppwd2 size="20" maxlength="63" value="WDB8WvbXdH">
                      </td>
                    </tr>
		    <tr style="display:none">
			<td align=right class="duple"><script>show_words(_auth + " " + _protocol);;</script> :</td>
			<td>&nbsp;
			 <input name="wan_pptp_proto_client" type="radio" value="pap"  onClick="change_type()">
			  PAP
			 <input name="wan_pptp_proto_client" type="radio" value="chap"  onClick="change_type()">
			  CHAP
			 <input name="wan_pptp_proto_client" type="radio" value="mschap-v2"  onClick="change_type()" >
			  MSCHAP v2
			 </td>
			</td>
		    </tr>
		    <tr id="mppe_encryp" style="display:none">
			<td align=right class="duple"><script>show_words(vpn_pptp_l2tp_mppe_encrypt_mode);</script> :</td>
			<td>&nbsp;
			  RC4
				<input name="wan_pptp_encryption_client" type="radio" value="none" >
			  None
				<input name="wan_pptp_encryption_client" type="radio" value="mppe-40" >
			  40 bit
				<input name="wan_pptp_encryption_client" type="radio" value="mppe-128" >
			  128 bit
			 </td>
			</td>
		      </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_RM);</script> :</td>
                      <td>&nbsp;
                      <input type=radio name="wan_pptp_connect_mode" value="always_on" onClick="check_connectmode()">
					    <script>show_words(bwn_RM_0);</script>
					  <input type=radio name="wan_pptp_connect_mode" value="on_demand" onClick="check_connectmode()">
					    <script>show_words(bwn_RM_1);</script>
					  <input type=radio name="wan_pptp_connect_mode" value="manual" onClick="check_connectmode()">
					    <script>show_words(bwn_RM_2);</script>
    				  </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_MIT);</script> :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pptp_max_idle_time" name="wan_pptp_max_idle_time" maxlength="5" size="10" value="<!--# echo wan_pptp_max_idle_time -->">
                      	<script>show_words(bwn_min);</script>
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(wwa_pdns);</script> :</td>
                      <td>&nbsp;
	                      <input type=text id="wan_primary_dns" name="wan_primary_dns" size="20" maxlength="15" value="<!--# echo wan_primary_dns -->">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(wwa_sdns);</script> :</td>
                      <td>&nbsp;
	                      <input type=text id="wan_secondary_dns" name="wan_secondary_dns" size="20" maxlength="15" value="<!--# echo wan_secondary_dns -->">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_MTU);</script> :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pptp_mtu" name="wan_pptp_mtu" size="10" maxlength="5" value="<!--# echo wan_pptp_mtu -->">
                  <script>show_words(bwn_bytes+_308);</script>1400</td>
                    </tr>
                    <tr>
                      <td width=150 valign=top class="duple"><script>show_words(_macaddr);</script> :</td>
                      <td>&nbsp;
                      	<input type="text" id="wan_mac" name="wan_mac" size="20" maxlength="17" value="<!--# echo wan_mac -->"><br>
                      	&nbsp;<input name="clone" id="clone" type="button" value="Clone Your PC's MAC Address" onClick="clone_mac_action()">
								<script>get_by_id("clone").value = _clonemac;</script>
					  </td>
                    </tr>
          </table>
        </div>

		    </div>
</form>
           </td>
			
			
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
                          <p><script>show_words(LW35);</script></p>
                          <p><script>show_words(LW36);</script></p>
                          <p class="more"><a href="support_internet.asp#WAN" onclick="return jump_3g_if();"><script>show_words(_more);</script>&hellip;</a></p>
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
	<form id="wwan_form" name="wwan_form" method="post" action="apply.cgi">
	<input type="hidden" id="usb_type" name="usb_type" value="<!--# echo usb_type -->">
	<input type="hidden" id="asp_temp_72" name="asp_temp_72" value="<!--# echo asp_temp_72 -->"> 
	<input type="hidden" id="reboot_type" name="reboot_type" value="none">
	</form>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script> 
	reboot_needed(left["Setup"].link[0]);
	onPageLoad();
	set_form_default_values("form1");	
</script>
<!-- insert name=restore_wan_type -->
</html>
