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
//OPENDNS


function onPageLoad(){
//2009/4/29 Tina add OPENDNS
/*
	set_checked(get_by_id("opendns_enable").value, get_by_id("opendns_enable_sel"));
	if(get_by_id("opendns_enable_sel").checked)
		opendns_enable_selector(get_by_id("opendns_enable_sel").checked);
		*/
//OPENDNS

	set_form_default_values("form1");
	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true);
	} 

}

function clone_mac_action(){
	get_by_id("wan_mac").value = get_by_id("mac_clone_addr").value;
}

function change_wan(){
    var html_file;
    
    switch(get_by_id("wan_proto").selectedIndex){
		case 0 :
	    	html_file = "wan_static.asp";
	    	break;	   	
		case 1 :
	    	html_file = "wan_dhcp.asp";
	    	break;
		case 2 :
	    	html_file = "wan_poe.asp";
	    	break;
	    case 3 :
	    	html_file = "wan_pptp.asp";
	    	break;
		case 4 :
			html_file = "wan_l2tp.asp";
	    	break;
		case 5 :
			html_file = "wan_bigpond.asp";
	    	break;
	}
	
	location.href = html_file;
}

	function send_bigpond_request(){
	        var ipv6_pppoe_share = "<!--# echo ipv6_pppoe_share -->";
	        var ipv6_wan_proto = "<!--# echo ipv6_wan_proto -->";
	        if (ipv6_wan_proto == "ipv6_pppoe" && ipv6_pppoe_share == "1"){
        	        alert(IPV6_TEXT1);
	                return false;
	        }
		get_by_id("asp_temp_52").value = get_by_id("wan_proto").value;
		var is_modify = is_form_modified("form1");
    	if (!is_modify && !confirm(LS3)) {
			return false;
		}
		if (!check_pwd("bigpond_pass_s", "bigpond_pass_v")){
       		return false;
       	}
       	var dns1 = get_by_id("wan_primary_dns").value;
        var dns2 = get_by_id("wan_secondary_dns").value;
        var mtu = get_by_id("wan_mtu").value;
        
        var dns1_addr_msg = replace_msg(all_ip_addr_msg,"Primary DNS Address");
		var dns2_addr_msg = replace_msg(all_ip_addr_msg,"Secondary DNS Address");
		var mtu_msg = replace_msg(check_num_msg, "MTU", 200, 1500);
		
		var temp_dns1_obj = new addr_obj(dns1.split("."), dns1_addr_msg, false, false);
		var temp_dns2_obj = new addr_obj(dns2.split("."), dns2_addr_msg, true, false);
		var temp_mtu = new varible_obj(mtu, mtu_msg, 200, 1500, false);
		
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
       	
		var wanmode = get_by_id("wan_proto").selectedIndex;
       	var real_wanmode = get_by_id("asp_temp_52").value;
    	var usb_mode = get_by_id("from_usb3g").value;
    	var usb_type = get_by_id("usb_type").value;
		var pop_3 = usb_config6; 		 
    	var warn_1 = usb_config3; 		 
    	var warn_2 = usb_config4;
    	if(usb_mode == "2" && usb_type == "2" && wanmode =="7" ||usb_mode == "0" && usb_type == "2" && wanmode !="5"){ 
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
		var clonemac = get_by_id("wan_mac").value; 
		if (!check_mac(clonemac)){
			alert(msg[MAC_ADDRESS_ERROR]);
			return false;
		}  
		 		
		var mac = trim_string(get_by_id("wan_mac").value);
		if(!is_mac_valid(mac, true)) {
			alert ("Invalid MAC address:" + mac + ".");
			return false;
		}else{
			get_by_id("wan_mac").value = mac;
		}
		
		if(submit_button_flag == 0){
			if(get_by_id("bigpond_pass_s").value !="WDB8WvbXdH"){
				get_by_id("wan_bigpond_password").value = get_by_id("bigpond_pass_s").value;
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
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();"><!--# echo model_number --></a></td>
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
			<td id="topnavon"><a href="index.asp" onclick="return jump_3g_if();"><script>show_words(_setup)</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_3g_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_3g_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_3g_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_3g_if();"><script>show_words(_support)</script></a></td>
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
									<li><div id="sidenavoff"><script>show_words(sa_Internet)</script></div></li>
									<li><div id="sidenavon"><a href="wizard_wireless.asp" onclick="return jump_3g_if();"><script>show_words(ss_WStats)</script></a></div></li>
									<li><div id="sidenavon"><a href="lan.asp" onclick="return jump_3g_if();"><script>show_words(bln_title)</script></a></div></li>
									<li><div id="sidenavon"><a href="usb_setting.asp" onclick="return jump_3g_if();"><script>show_words(bln_title_usb)</script></a></div></li>
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
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wan_bigpond.asp">
				<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# echo mac_clone_addr -->">	
				<input type="hidden" id="wan_bigpond_password" name="wan_bigpond_password" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
				<input type="hidden" id="wan_bigpond_auth" name="wan_bigpond_auth" value="<!--# echo wan_bigpond_auth -->">
				<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<!--# echo asp_temp_51 -->">
				<input type="hidden" id="asp_temp_52" name="asp_temp_52" value="<!--# echo wan_proto -->">
				<input type="hidden" id="usb_type" name="usb_type" value="<!--# echo usb_type -->">
			    <input type="hidden" id="from_usb3g" name="from_usb3g" value="<!--# echo asp_temp_72 -->"> 
				<input type="hidden" id="reboot_type" name="reboot_type" value="wan">
			<div id=maincontent>
			  <!-- === BEGIN MAINCONTENT === -->
              <div id=box_header>
                <h1><script>show_words(_WAN);</script></h1>
                <p><script>show_words(bwn_intro_ICS2)</script></p>
                <p><strong><script>show_words(_note)</script>:&nbsp;</strong><script>show_words(bwn_note_clientSW);</script></p>
                <input name="button" id="button" type=submit class=button_submit value="" onClick="return send_bigpond_request()">
                <input name="button2" id="button" type=reset class=button_submit value="" onClick="return page_cancel('form1', 'sel_wan.asp');">
				<script>get_by_id("button").value = _dontsavesettings</script>
				<script>get_by_id("button2").value = _savesettings</script>
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
                        <option value="pptp"><script>show_words(bwn_Mode_PPTP)</script></option>
                        <option value="l2tp"><script>show_words(bwn_Mode_L2TP)</script></option>
						<option value="usb3g"><script>show_words(usb_3g)</script></option>
                        <option value="usb3g_phone"><script>show_words(usb_3g_phone)</script></option>
                        <option value="bigpond" selected><script>show_words(bwn_Mode_BigPond)</script></option>
                      </select></td>
                    </tr>
                </table>
              </div>
			<!--//2009/4/29 Tina add OPENDNS-->
			<input type="hidden" id="opendns_enable" name="opendns_enable" value="<!--# echo opendns_enable -->">
			<input type="hidden" id="dns_relay" name="dns_relay" value="<!--# echo dns_relay -->">
			<!--div class=box>
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
              <div class=box id=show_bigpond>
                <h2><script>show_words(wwa_wanmode_bigpond)</script> : </h2>
				<p class="box_msg"><script>show_words(_ispinfo);</script> </p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td width="185" align=right class="duple"><script>show_words(bwn_BPS)</script> :</td>
                      <td width="331">&nbsp;
                      	<input type=text id="wan_bigpond_server" name="wan_bigpond_server" size="20" maxlength="63" value="<!--# echo wan_bigpond_server -->">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_BPU)</script> :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_bigpond_username" name="wan_bigpond_username" size="20" maxlength="63" value="<!--# echo wan_bigpond_username -->">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_BP)</script> :</td>
                      <td>&nbsp;
                      	<input type=password id="bigpond_pass_s" name="bigpond_pass_s" size="20" maxlength="63" value="WDB8WvbXdH">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(_verifypw);</script></td>
                      <td>&nbsp;
                      	<input type=password id=bigpond_pass_v name=bigpond_pass_v size="20" maxlength="63" value="WDB8WvbXdH">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(wwa_pdns);</script></td>
                      <td>&nbsp;
	                      <input type=text id="wan_primary_dns" name="wan_primary_dns" size="20" maxlength="15" value="<!--# echo wan_primary_dns -->">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(wwa_sdns);</script></td>
                      <td>&nbsp;
	                      <input type=text id="wan_secondary_dns" name="wan_secondary_dns" size="20" maxlength="15" value="<!--# echo wan_secondary_dns -->">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_MTU);</script></td>
                      <td>&nbsp;
                      	<input type=text id="wan_mtu" name="wan_mtu" size="10" maxlength="5" value="<!--# echo wan_mtu -->">
                      	<script>show_words(bwn_MTU_def);</script>
                      </td>
                    </tr>
                     <tr>
                      <td width=150 valign=top class="duple"><script>show_words(_macaddr);</script></td>
                      <td>&nbsp;
                      	<input type="text" id="wan_mac" name="wan_mac" size="20" maxlength="17" value="<!--# echo wan_mac -->"><br>
                      	&nbsp;<input name="clone" id= "clone" type="button" value="" onClick="clone_mac_action()">
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
                          <p class="more"><a href="support_internet.asp#WAN" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
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
	onPageLoad();
</script>
<!-- insert name=restore_wan_type -->
</html>
