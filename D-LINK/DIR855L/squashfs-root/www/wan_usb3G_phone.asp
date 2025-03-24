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
/*IFDEF	OPENDNS*/
function opendns_enable_selector(value){
	if(value==true){
		get_by_id("wan_specify_dns").value ="1";
		get_by_id("wan_primary_dns").value ="204.194.232.200";
		get_by_id("wan_secondary_dns").value="204.194.234.200";
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
/*ENDIF	OPENDNS*/
function onPageLoad(){
/*IFDEF	OPENDNS*/
/*
	set_checked(get_by_id("opendns_enable").value, get_by_id("opendns_enable_sel"));
	if(get_by_id("opendns_enable_sel").checked){
		opendns_enable_selector(get_by_id("opendns_enable_sel").checked);
	}
		//set_checked("<!--# echo usb3g_phone_reconnect_mode -->", get_by_name("usb3g_phone_reconnect_mode"));
	var usb_type_tmp = "<!--# echo usb_type -->";
	if(usb_type_tmp == "3" || usb_type_tmp == "4" || usb_type_tmp == "5"){
		set_selectIndex(usb_type_tmp, get_by_id("usb_type"));
	}else{
		set_selectIndex("0", get_by_id("usb_type"));
	}
*/
/*ENDIF	OPENDNS*/
	set_checked(get_by_id("dhcpc_use_ucast").value, get_by_id("dhcpc_use_ucast_sel"));
	set_form_default_values("form1");
	var login_who= checksessionStorage();
		if(login_who== "user"){
			DisableEnableForm(document.form1,true);	
		} 
}

	function confirm_reboot_change_ip(){
		var login_who=checksessionStorage();
		if(login_who== "user"){
			window.location.href ="count_down.asp";
		}else{
			if(confirm(usb_reboot+"\n"+up_rb_2+"\n"+up_rb_1)){
			}else{
				return false;
			}
		}
	}
    
	function send_request(){
		var lan_ipaddr = "<!--# echo lan_ipaddr -->";
		var lan_ip_array = lan_ipaddr.split(".");

		get_by_id("asp_temp_52").value = get_by_id("wan_proto").value;
		var is_modify = is_form_modified("form1");
    	if (!is_modify && !confirm(_ask_nochange)) {
			return false;
		}
		var dns1 = get_by_id("wan_primary_dns").value;
	    var dns2 = get_by_id("wan_secondary_dns").value;
//	    var mtu = get_by_id("wan_mtu").value;	 
	    var c_hostname=get_by_id("hostname").value;
	    
	    var dns1_addr_msg = replace_msg(all_ip_addr_msg,wwa_pdns);
		var dns2_addr_msg = replace_msg(all_ip_addr_msg,wwa_sdns);
//		var mtu_msg = replace_msg(check_num_msg, bwn_MTU, 600, 1500);
	    
	    var temp_dns1_obj = new addr_obj(dns1.split("."), dns1_addr_msg, false, false);
		var temp_dns2_obj = new addr_obj(dns2.split("."), dns2_addr_msg, true, false);
//	    var temp_mtu = new varible_obj(mtu, mtu_msg, 600, 1500, false);
		if(Find_word(c_hostname,"'") || Find_word(c_hostname,'"') || Find_word(c_hostname,"/")){
			alert(GW_DHCP_CLIENT_CLIENT_NAME_INVALID);
			return false;
		}
		var re = /[^A-Za-z0-9_\-]/;	
		if(re.test(c_hostname)){
			alert(_hostname_err);
		return false;
		}

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

    	var wanmode = get_by_id("wan_proto").selectedIndex;
    	var real_wanmode = get_by_id("asp_temp_52").value;
    	var usb_mode = get_by_id("usb_type").value;
//    	var usb_type = get_by_id("usb_type").value;
//		var pop_3 = usb_config6; 		 
//		var warn_1 = usb_config3; 		 
//    	var warn_2 = usb_config4;
		if(usb_mode == "3" || usb_mode == "5"){ //windows mobile or android			
			get_by_id("usb_type").value = (usb_mode == "3") ? "3" : "5";
			if((lan_ip_array[0] == "192") && (lan_ip_array[1] == "168") && (lan_ip_array[2] == "0")){
				if(confirm_reboot_change_ip() == false){
					return false;
		}
				get_by_id("reboot_type").value=_shutdown;
				get_by_id("html_response_page").value="reboot.asp";

			}
		}
		else if(usb_mode == "4"){ // iphone
			get_by_id("usb_type").value = "4";
			if((lan_ip_array[0] == "192") && (lan_ip_array[1] == "168") && (lan_ip_array[2] == "20")){
		if(confirm_reboot_change_ip() == false){
			return false;
		}
				get_by_id("reboot_type").value=_shutdown;
				get_by_id("html_response_page").value="reboot.asp";
			}
		}
		else{
			alert("Please choose phone type !");
			return false;
		}


//		if(usb_mode == "2" && usb_type == "2"  && real_wanmode =="dhcpc" ||usb_mode == "0" && usb_type == "2" && real_wanmode =="dhcpc"){ 
//    	    alert(pop_3); 
//    	    get_by_id("usb_type").value = "0"; // force to save usb_type	
//         	get_by_id("reboot_type").value = "all"; 
//		}else if(usb_mode == "2" && usb_type == "0" && real_wanmode =="usb3g" ){ //3G USB
//           	get_by_id("usb_type").value = "0"; // force to save usb_type	
//         	get_by_id("reboot_type").value = "all";
//		}else if(usb_mode == "2" && usb_type == "0" && wanmode !="5" ||usb_mode == "2" && usb_type == "1" && wanmode !="5" ){ //3G USB
//           	alert(warn_1);
//         	return false;
//		}else if(usb_mode == "0" && wanmode !="5" ){ //network USB
//    	    get_by_id("usb_type").value = "0"; // force to save usb_type	
//         	get_by_id("reboot_type").value = "all";
//          }
            
             			
		if((get_by_id("wan_primary_dns").value =="" || get_by_id("wan_primary_dns").value =="0.0.0.0")&& ( get_by_id("wan_secondary_dns").value =="" || get_by_id("wan_secondary_dns").value =="0.0.0.0")){
			get_by_id("wan_specify_dns").value = 0;
		}else{
			get_by_id("wan_specify_dns").value = 1;
		}
		
    	//get_by_id("wan_mac").value= mac;
    	get_by_id("dhcpc_use_ucast").value = get_checked_value(get_by_id("dhcpc_use_ucast_sel"));
		/*IFDEF	OPENDNS*/
		/*
		get_by_id("opendns_enable").value = get_checked_value(get_by_id("opendns_enable_sel"));
		if(get_by_id("opendns_enable").value=="1"){
			get_by_id("dns_relay").value = "1";
			get_by_id("wan_primary_dns").disabled = false;
			get_by_id("wan_secondary_dns").disabled = false;
		}
		/*ENDIF	OPENDNS*/
    	
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			/*
			if(is_modify || get_by_id("asp_temp_51").value.length > 0){
				get_by_id("asp_temp_51").value = "wan";
				get_by_id("html_response_page").value = "wan_reboot_need.asp";
			}else{
				window.location.href = get_by_id("html_response_page").value;
			}
			*/
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
				<!--
				<form name="lang_form" id="lang_form" action="switch_language.cgi" method=post>
				<input type="hidden" id="html_response_lang" name="html_response_lang" value="wan_dhcp.asp">
				<input type="hidden" id="language" name="language" value= "<!--# echo language -->">
				<select name="site" id="site" style="vertical-align:top; height:15px; font-size:8pt;" onChange="set_lang();">
				
				<option value="de"><script>show_words(DE)</script></option>
				<option value="en"><script>show_words(EN)</script></option>
				<option value="es"><script>show_words(ES)</script></option>
				<option value="fr"><script>show_words(FR)</script></option>
				<option value="it"><script>show_words(IT)</script></option>
				
				</select>
				</form>
				-->
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">	
				<form id="form1" name="form1" method="post" action="apply.cgi">		
				<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = sc_intro_sv;</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wan_usb3G_phone.asp">
				<input type="hidden" id="action" name="action" value="wan_usb3gphone">
							
<!--				<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# exec cgi /bin/clone mac_clone_addr -->"> -->
				<input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value="<!--# echo wan_specify_dns -->">
				<input type="hidden" id="dhcpc_use_ucast" name="dhcpc_use_ucast" value="<!--# echo dhcpc_use_ucast -->">
<!--				<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<!--# echo asp_temp_51 -->"> -->
				<input type="hidden" id="asp_temp_52" name="asp_temp_52" value="<!--# echo wan_proto -->">
				<input type="hidden" id="reboot_type" name="reboot_type" value="all">
<!--				<input type="hidden" id="usb_type" name="usb_type" value="<!--# echo usb_type -->">  -->
			    <input type="hidden" id="from_usb3g" name="from_usb3g" value="<!--# echo asp_temp_72 -->"> 
<!--
			    <input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="0">
-				<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="0">  
-->
				<div id=maincontent>
			  <!-- === BEGIN MAINCONTENT === -->
				<div id=box_header>
				<h1><script>show_words(_WAN)</script></h1>
				<p>
				<script>show_words(bwn_intro_ICS)</script>
				</p>
				<p><strong><b> 
				<script>show_words(_note)</script>
				</b>:&nbsp;</strong>
				<script>show_words(bwn_note_clientSW)</script>
				</p>
				<input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
				<input name="button2" id="button2" type=reset class=button_submit value="" onclick="return page_cancel('form1', 'sel_wan.asp');">
				<script>get_by_id("button").value = _savesettings;</script>
				<script>get_by_id("button2").value = _dontsavesettings;</script>
				</div>
				<div class=box>
				<h2><script>show_words(bwn_ict)</script></h2>
				<p class="box_msg"><script>show_words(bwn_msg_Modes)</script></p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
					<tr>
						<td align=right width="185" class="duple"><script>show_words(bwn_mici)</script> :</td>
						<td width="331">&nbsp; <select name="wan_proto" id="wan_proto" onChange="change_wan()">
							<option value="static"><script>show_words(_sdi_staticip)</script></option>
							<option value="dhcpc"><script>show_words(bwn_Mode_DHCP)</script></option>
							<option value="pppoe"><script>show_words(bwn_Mode_PPPoE)</script></option>
							<option value="pptp"><script>show_words(bwn_Mode_PPTP)</script></option>
							<option value="l2tp"><script>show_words(bwn_Mode_L2TP)</script></option>
							<!--option value="pptp">Russia PPTP (Dual Access)</option-->
							<!--option value="pppoe">Russia PPPoE (Dual Access)</option-->
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
									show_words(str);
				 				}
							</script>
							<option value="usb3g_phone" selected><script>show_words(usb_3g_phone)</script></option>
							<!--option value="bigpond"><script>show_words(bwn_Mode_BigPond)</script></option-->
						</select></td>
					</tr>
				</table>
				</div>
				<!--IFDEF	OPENDNS-->
				<input type="hidden" id="opendns_enable" name="opendns_enable" value="<!--# echo opendns_enable -->">
				<input type="hidden" id="dns_relay" name="dns_relay" value="<!--# echo dns_relay -->">
				<!--div class=box>				
				<h2><script>show_words(_title_AdvDns);</script></h2>
				<p class="box_msg"><script>show_words(_desc_AdvDns);</script></p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
				<tr>
				<td width="185" align=right style="WIDTH: 190px;" class="duple"><script>show_words(_en_AdvDns);</script> :</td>
				<td width="331">&nbsp;<input type="checkbox" id="opendns_enable_sel" name="opendns_enable_sel" value="1" onclick="opendns_enable_selector(this.checked);"></td>
				</tr>
				</table>
				</div>
				<!--ENDIF	OPENDNS-->
				<div class=box id=show_dhcp>
				<h2><script>show_words(bwn_wwanICT)</script></h2>
				<p class="box_msg"><script>show_words(_phone_info)</script></p>
				<table cellSpacing=1 cellPadding=1 width=525 border=0>
					<tr>
						<td width="185" align=right class="duple"> <script>show_words(_phone)</script> :</td>
						<td width="331">&nbsp; 
							<select name="usb_type" id="usb_type" size=1>
								<option value="0">-- <script>show_words(_select_phone)</script> --</option>
								<option value="3"><script>show_words(usb_window_mobile_5)</script></option>
								<option value="4"><script>show_words(usb_iphone)</script></option> 
								<option value="5"><script>show_words(android_phone)</script></option> 
							</select>
						</td>
					</tr>
					<tr>
						<td width="185" align=right class="duple">
							<script>show_words(_hostname)</script>:
						</td>
						<td width="331">&nbsp;
							<input type=text id="hostname" name="hostname" size="25" maxlength="39" value="<!--# echo hostname -->">
                      	</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(_use_unicasting)</script>:
						</td>
						<td>&nbsp;
							<input type="checkbox" id="dhcpc_use_ucast_sel" name="dhcpc_use_ucast_sel" value="1">
							<script>show_words(bw_WDUU_note)</script>
						</td>
					</tr>
<!--
					<tr>
						<td align=right class="duple"> <script>show_words(bwn_RM)</script>:
						</td>
						<td>&nbsp;
							<input type=radio name="usb3g_phone_reconnect_mode" value="always_on" onClick="check_connectmode()">
							<script>show_words(bwn_RM_0)</script>
							<input type=radio name="usb3g_phone_reconnect_mode" value="on_demand" onClick="check_connectmode()">
							<script>show_words(bwn_RM_1)</script>
							<input type=radio name="usb3g_phone_reconnect_mode" value="manual" onClick="check_connectmode()">
							<script>show_words(bwn_RM_2)</script>
						</td>
					</tr>
-->
					<tr>
						<td align=right class="duple">
							<script>show_words(_dns1)</script>:
						</td>
						<td>&nbsp;
							<input type=text id="wan_primary_dns" name="wan_primary_dns" size="20" maxlength="15" value="<!--# echo wan_primary_dns -->">
						</td>
					</tr>
					<tr>
						<td align=right class="duple">
							<script>show_words(_dns2)</script>:
						</td>
						<td>&nbsp;
							<input type=text id="wan_secondary_dns" name="wan_secondary_dns" size="20" maxlength="15" value="<!--# echo wan_secondary_dns -->">
						</td>
					</tr>
					<tr>
<!--
                <td align=right class="duple">
                  <script>show_words(bwn_MTU)</script>
                  :</td>
                      <td>&nbsp;
                          <input type=text id="wan_mtu" name="wan_mtu" size="10" maxlength="5" value="<!--# echo wan_mtu -->">
                  <script>show_words(bwn_bytes)</script>
                  <script>show_words(_308)</script>
                  1500</td>
                    </tr>
                    <tr>
                      
                <td align=right valign=top class="duple">
                  <script>show_words(_macaddr)</script>
                  :</td>
                      <td>&nbsp;
                      	<input type="text" id="wan_mac" name="wan_mac" size="20" maxlength="17" value="<!--# echo wan_mac -->"><br>
                 &nbsp;<input name="clone" id="clone" type=button class=button_submit value="" onclick="clone_mac_action()"> 
						<script>get_by_id("clone").value = _clone;</script>
					  </td>
                    </tr>
-->
				</table>
				</div>
				</div>
			</form>
           </td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints)</script>
            &hellip;</strong> <p>
              <script>show_words(LW35)</script>
            </p>
            <p><script>show_words(LW36)</script></p>
            <!--IFDEF	OPENDNS-->
            <!--p><script>show_words(_sp_desc2_AdvDNS)</script></p>
			<p><script>show_words(_sp_desc3_AdvDNS)</script></p>
			<p><script>show_words(_sp_desc4_AdvDNS)</script></p>
			<!--END	OPENDNS-->
                          <p class="more"><a href="support_internet.asp#WAN" onclick="return jump_3g_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
<div id="copyright"><script>show_words(_copyright)</script></div>
<br>
</body>
<script> 
	onPageLoad();
	//get_lang();
</script>
</html>
