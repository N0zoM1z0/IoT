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
		get_by_id("wan_primary_dns").value = "0.0.0.0";
		get_by_id("wan_secondary_dns").value = "0.0.0.0";
		get_by_id("wan_primary_dns").disabled = false;
		get_by_id("wan_secondary_dns").disabled = false;		
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

   show_hnat();
   //show_AdvDns();
	set_checked("<!--# echo wan_pppoe_dynamic_00 -->", get_by_name("wan_pppoe_dynamic_00"));
	set_checked("<!--# echo wan_pppoe_connect_mode_00 -->", get_by_name("wan_pppoe_connect_mode_00"));
//	set_mac(get_by_id("wan_mac").value);
	//check_connectmode();
	//disable_poe_ip();
	if (get_by_id("wan_mac").value === "<!--# echo sys_wan_mac -->") {
                get_by_id("wan_mac").value = "";
        }

	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true);
	}else{
		check_connectmode();
		disable_poe_ip();
	}
	set_form_default_values("form1");	
}

function show_hnat(){
	
	/* DHP-1565 pppoe not suppport HNAT */
	if("<!--# echo hnat_enable -->" != "" && "<!--# echo model_number -->" != "DHP-1565"){
		get_by_id("show_hnat").style.display = "";
		set_checked(get_by_id("hnat_enable").value, get_by_id("hnatEnable"));
	}else{
		get_by_id("show_hnat").style.display = "none";
	}
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
function mac_clone(){
        get_by_id("mac_clone_addr").value = get_by_id("wan_mac").value;
}

function disable_poe_ip(){
		var fixIP = get_by_name("wan_pppoe_dynamic_00");
		var is_disabled;
				  
	  	if (fixIP[0].checked){
	    	is_disabled = true;
	  	}else{
	    	is_disabled = false;
	    }
	  	get_by_id("wan_pppoe_ipaddr_00").disabled = is_disabled;
	  	//get_by_id("wan_primary_dns").disabled = is_disabled;
	  	//get_by_id("wan_secondary_dns").disabled = is_disabled;
	}
		
    function set_poe_dynamic(type){
    	var fixIP = get_by_name("wan_pppoe_dynamic_00");
        if (type == 0){
            fixIP[0].checked = true;
            get_by_id("wan_pppoe_ipaddr_00").value = "0.0.0.0";	           
        }
    }
    
function check_connectmode(){
	var conn_mode = get_by_name("wan_pppoe_connect_mode_00");
	var idle_time = get_by_id("wan_pppoe_max_idle_time_00");
	idle_time.disabled = !conn_mode[1].checked;
}
    
function send_pppoe_request(){
    	get_by_id("asp_temp_52").value = get_by_id("wan_proto").value;

	var is_type_changed = false;
	if ("<!--# echo feature_russsia -->" == "1" && 
	    "<!--# echo wan_proto -->" == "pppoe" && 
	    "<!--# echo wan_pppoe_russia_enable -->" == "1")
		is_type_changed = true;

    	var is_modify = is_form_modified("form1");
    	if (!is_modify && !is_type_changed && !confirm(LS3)) {
			return false;
		}
    	var fixIP = get_by_name("wan_pppoe_dynamic_00");
    	var ip = get_by_id("wan_pppoe_ipaddr_00").value;
    	var dns1 = get_by_id("wan_primary_dns").value;
    	var dns2 = get_by_id("wan_secondary_dns").value;
    	var idle = get_by_id("wan_pppoe_max_idle_time_00").value;	    	
        var mtu = get_by_id("wan_pppoe_mtu").value;
        var user_name = get_by_id("wan_pppoe_username_00").value;
        
	var ip_addr_msg = replace_msg(all_ip_addr_msg, _ipaddr);
	var primary_dns_msg = replace_msg(all_ip_addr_msg, wwa_pdns);
	var second_dns_msg = replace_msg(all_ip_addr_msg, wwa_sdns);
	var max_idle_msg = replace_msg(check_num_msg, _idel_time, 0, 9999);
	var mtu_msg = replace_msg(check_num_msg, bwn_MTU, 1300, 1492);
        
        var temp_ip = new addr_obj(ip.split("."), ip_addr_msg, false, false);
        var temp_dns1 = new addr_obj(dns1.split("."), primary_dns_msg, true, false);
	var temp_dns2 = new addr_obj(dns2.split("."), second_dns_msg, true, false);
        var temp_idle = new varible_obj(idle, max_idle_msg, 0, 9999, false);
        var temp_mtu = new varible_obj(mtu, mtu_msg, 1300, 1492, false);
	var ipv6_wan_proto = "<!--# echo ipv6_wan_proto -->";
	var ipv6_6rd_dhcp = "<!--# echo ipv6_6rd_dhcp -->";

	if (ipv6_wan_proto == "ipv6_6rd" && ipv6_6rd_dhcp == "1"){
        	alert(IPV6_6rd_v6wan);
		return false;
	}

        if (fixIP[1].checked){
        	if (!check_address(temp_ip)){
        		return false;
        	}
        }
        
    	if (dns2 != "" && dns2 != "0.0.0.0"){
    		if (!check_address(temp_dns2)){
    			return false;
    		}
    	}
    	
	if (user_name == ""){
		alert(wwa_pv5_alert_21);
		return false;
	}

	if (!check_username(user_name)) {
		alert(GW_SMTP_USERNAME_INVALID);
		return false;
	}

	if (get_by_id("poe_pass_s").value == "" || get_by_id("poe_pass_v").value == ""){
		alert(vpn_ipsec_pwd_empty);
		return false;
	}
		
    	if (!check_pwd("poe_pass_s", "poe_pass_v")){
       		return false;
       	}

	if (get_by_name("wan_pppoe_connect_mode_00") != "on_demand") {
		var idel_time = temp_idle.var_value.split("");
		if(idel_time == "") 
				get_by_id("wan_pppoe_max_idle_time_00").value = "<!--# echo wan_pppoe_max_idle_time_00 -->";
	
       	} else if (!check_varible(temp_idle)){
    		return false;
    	}
    	
    	if (!check_varible(temp_mtu)){
    		return false;
    	}
    	
    	var wanmode = get_by_id("wan_proto").selectedIndex;
    	var real_wanmode = get_by_id("asp_temp_52").value;
    	var usb_mode = get_by_id("from_usb3g").value;
    	var usb_type = get_by_id("usb_type").value;
		var pop_3 = usb_config6;
		var warn_1 = usb_config3;
		var warn_2 = usb_config4;
	if(usb_mode == "2" && usb_type == "2"  && real_wanmode =="pppoe" ||usb_mode == "0" && usb_type == "2" && real_wanmode =="pppoe"){
		alert(pop_3);
		get_by_id("usb_type").value = "0"; // force to save usb_type	
    		//get_by_id("reboot_type").value = "all"; 
	}else if(usb_mode == "2" && usb_type == "0" && real_wanmode =="usb3g" ){ //3G USB
		get_by_id("usb_type").value = "0"; // force to save usb_type	
         	//get_by_id("reboot_type").value = "all";
	}else if(usb_mode == "2" && usb_type == "0" && wanmode !="5" ||usb_mode == "2" && usb_type == "1" && wanmode !="5" ){ //3G USB
           	alert(warn_1);
         	return false;
	}else if(usb_mode == "0" && wanmode !="5" ){ //network USB
		get_by_id("usb_type").value = "0"; // force to save usb_type	
         	//get_by_id("reboot_type").value = "all";
	}
            
    	
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

		get_by_id("hnat_enable").value = get_checked_value(get_by_id("hnatEnable"));
		if ("<!--# echo model_number -->" == "DHP-1565")
			get_by_id("hnat_enable").value = "0";
	
	if(is_modify)
		if(!check_hnat("hnat_enable"))
			return false;
	
		if(submit_button_flag == 0){
			if(get_by_id("poe_pass_s").value !="WDB8WvbXdH"){
				get_by_id("wan_pppoe_password_00").value = get_by_id("poe_pass_s").value;
			}

			//Block PPPoE, PPTP, L2TP allow saving without password in the fist.
			if(get_by_id("wan_pppoe_password_00").value == ""){
				alert(vpn_ipsec_pwd_empty);
				return false;
			}

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
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wan_poe.asp">
				<input type="hidden" id="action" name="action" value="wan_poe">
				<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# echo mac_clone_addr -->">
				<input type="hidden" id="mac_clone_addr2" name="mac_clone_addr2" value="<!--# exec cgi /bin/clone mac_clone_addr -->">
                <input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value="<!--# echo wan_specify_dns -->">  
				<input type="hidden" id="wan_pppoe_password_00" name="wan_pppoe_password_00" value="<!--# echo wan_pppoe_password_00 -->">
				<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<!--# echo asp_temp_51 -->">
				<input type="hidden" id="asp_temp_52" name="asp_temp_52" value="<!--# echo wan_proto -->">
				<input type="hidden" id="usb_type" name="usb_type" value="<!--# echo usb_type -->"> 
			    	<input type="hidden" id="from_usb3g" name="from_usb3g" value="<!--# echo asp_temp_72 -->"> 
				<input type="hidden" id="ipv6_pppoe_share" name="ipv6_pppoe_share" value="<!--# echo ipv6_pppoe_share -->">
				<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="0">
			    <input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="0">
			    <input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="0">
			<div id=maincontent>
			  <!-- === BEGIN MAINCONTENT === -->
              <div id=box_header>
                <h1><script>show_words(_WAN);</script></h1>
                <p><script>show_words(bwn_intro_ICS);</script></p>
                <p><strong><script>show_words(_note);</script>:&nbsp;</strong><script>show_words(bwn_note_clientSW);</script></p>
                <input name="button" id="button" type="submit" class=button_submit value="Save Settings" onClick="return send_pppoe_request()">
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
                        <option value="pppoe" selected><script>show_words(bwn_Mode_PPPoE)</script></option>
                        <option value="pptp"><script>show_words(bwn_Mode_PPTP)</script></option>
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
			<!--//2009/4/29Tina add OPENDNS-->
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
		<!--HARDWARE NAT SETTING START-->
                <div class=box id="show_hnat">
                <h2><script>show_words(HNAT_ENABLE);</script></h2>
			<table cellSpacing=1 cellPadding=1 width=525 border=0>
                <tr>
                <td width="185" align=right style="WIDTH: 190px;" class="duple"><script>show_words(HNAT_ENABLE_DESC);</script> :</td>
                <td width="331">&nbsp;<input type="checkbox" id="hnatEnable" name="hnatEnable" value="1">
                	<input type="hidden" id="hnat_enable" name="hnat_enable" value="<!--# echo hnat_enable -->">
			<input type="hidden" id="spi_enable" name="spi_enable" value="<!--# echo spi_enable -->">
			<input type="hidden" id="traffic_shaping" name="traffic_shaping" value="<!--# echo traffic_shaping -->">
                	</td>
                </tr>
                </table>
                </div>
                <!--HARDWARE NAT SETTING END-->        
              <div class=box id=show_poe >
                <h2><script>show_words(bwn_PPPOEICT);</script></h2>
				<p class="box_msg"><script>show_words(_ispinfo);</script> </p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td width="185" align=right class="duple"><script>show_words(bwn_AM);</script> :</td>
                      <td width="331">&nbsp;
                      	<input type="radio" name="wan_pppoe_dynamic_00" value="1" onClick="disable_poe_ip()" checked>
						    <script>show_words(bwn_Mode_DHCP);</script>
						<input type="radio" name="wan_pppoe_dynamic_00" value="0" onClick="disable_poe_ip()">
						    <script>show_words(_sdi_staticip);</script>
					  </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(_ipaddr);</script> :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pppoe_ipaddr_00" name="wan_pppoe_ipaddr_00" size="20" maxlength="15" value="<!--# echo wan_pppoe_ipaddr_00 -->">
					  </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_UN);</script> :</td>
                      <td>&nbsp;
                          <input type=text id="wan_pppoe_username_00" name="wan_pppoe_username_00" size="20" maxlength="63" value="<!--# echo wan_pppoe_username_00 -->">
					  </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(_password);</script> :</td>
                      <td>&nbsp;
                      	<input type=password id="poe_pass_s" name="poe_pass_s" size="20" maxlength="63" value="WDB8WvbXdH">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(_verifypw);</script> :</td>
                      <td>&nbsp;
                      	<input type=password id=poe_pass_v name=poe_pass_v size="20" maxlength="63" value="WDB8WvbXdH">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(_srvname);</script> :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pppoe_service_00" name="wan_pppoe_service_00" size="30" maxlength="39" value="<!--# echo wan_pppoe_service_00 -->"><script>show_words(_optional);</script>
    				  </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_RM);</script> :</td>
                      <td>&nbsp;
	                      <input type=radio name="wan_pppoe_connect_mode_00" value="always_on" onClick="check_connectmode()">
	    					<script>show_words(bwn_RM_0);</script>
	    				  <input type=radio name="wan_pppoe_connect_mode_00" value="on_demand" onClick="check_connectmode()">
	    					<script>show_words(bwn_RM_1);</script>
	    				  <input type=radio name="wan_pppoe_connect_mode_00" value="manual" onClick="check_connectmode()">
	    					<script>show_words(bwn_RM_2);</script>
	    			   </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_MIT);</script> :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pppoe_max_idle_time_00" name="wan_pppoe_max_idle_time_00" size="10" maxlength="5" value="<!--# echo wan_pppoe_max_idle_time_00 -->">
    					<script>show_words(bwn_min);</script>
    				  </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(wwa_pdns);</script> :</td>
                      <td>&nbsp;
	                      <input type=text id="wan_primary_dns" name="wan_primary_dns" size="20" maxlength="15" value="<!--# echo wan_primary_dns -->">
	                      <script>show_words(_optional);</script>
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(wwa_sdns);</script> :</td>
                      <td>&nbsp;
	                      <input type=text id="wan_secondary_dns" name="wan_secondary_dns" size="20" maxlength="15" value="<!--# echo wan_secondary_dns -->">
	                      <script>show_words(_optional);</script>
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_MTU);</script> :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pppoe_mtu" name="wan_pppoe_mtu" size="10" maxlength="5" value="<!--# echo wan_pppoe_mtu -->">
                  <script>show_words(bwn_bytes+_308);</script>1492</td>
                    </tr>
                    <tr>
                      <td width=150 valign=top class="duple"><script>show_words(_macaddr);</script> :</td>
                      <td>&nbsp;
                      	<input type="text" id="wan_mac" name="wan_mac" size="20" maxlength="17" value="<!--# echo wan_mac -->" onChange="mac_clone()"><br>
                      	&nbsp;<input name="clone" id="clone" type="button" value="" onClick="clone_mac_action()">
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
                          <p class="more"><a href="support_internet.asp#WAN" onclick="return jump_if();"><script>show_words(_more);</script>&hellip;</a></p>
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
</script>
<!-- insert name=restore_wan_type -->
</html>
