<html>
<head>
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
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
//2009/4/29 Tina addOPENDNS
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
//2009/4/29 Tina addOPENDNS
/*
	set_checked(get_by_id("opendns_enable").value, get_by_id("opendns_enable_sel"));
	if(get_by_id("opendns_enable_sel").checked)
		opendns_enable_selector(get_by_id("opendns_enable_sel").checked);
		*/
//OPENDNS

  show_hnat();
  //show_AdvDns();
	set_checked(get_by_id("dhcpc_use_ucast").value, get_by_id("dhcpc_use_ucast_sel"));
	set_checked(get_by_id("classless_static_route").value, get_by_id("classless_static_route_sel"));
	if (get_by_id("wan_mac").value === "<!--# echo sys_wan_mac -->") {
		get_by_id("wan_mac").value = "";
	}
	set_form_default_values("form1");
	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true);
	} 

}

function show_hnat(){
	if("<!--# echo hnat_enable -->" != ""){
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

//function check_hnat(name)
//{
//	var spi=get_by_id("spi_enable").value;
//	var qos=get_by_id("traffic_shaping").value;
//	var hnat=get_by_id("hnat_enable").value;
//	
//	if(name == "hnat_enable"){
//		if(spi == "1" || qos == "1"){
//			if(hnat == "1"){
//				alert("bc");
//				var msg1=HNAT_WAR4.replace(/%s1/, "True Gigabit Routing Connectivity");
//				var msg2=msg1.replace(/%s2/, "SPI and QoS engine");
//				if(confirm(msg2)){
//					get_by_id("spi_enable").value = "0";		
//					get_by_id("traffic_shaping").value = "0";
//					alert("yes");
//					return true;
//				}else{
//					alert("no");
//					return false;
//				}
//			}
//		}		
//	}
//	if(name == "spi_enable") {
//			var msg1=HNAT_WAR4.replace(/%s1/, "SPI");
//			var msg2=msg1.replace(/%s2/, "True Gigabit Routing Connectivity");
//			if(confirm(msg2)){
//				get_by_id("hnat_enable").value = "0";
//				return true;
//			}else{
//				return false;
//			}
//	}
//	if(name == "traffic_shaping") {
//			var msg1=HNAT_WAR4.replace(/%s1/, "QoS engine");
//			var msg2=msg1.replace(/%s2/, "True Gigabit Routing Connectivity");
//			if(confirm(msg2)){
//				get_by_id("hnat_enable").value = "0";
//				return true;
//			}else{
//				return false;
//			}
//	}			
//}

function send_dhcp_request(){
        var ipv6_pppoe_share = "<!--# echo ipv6_pppoe_share -->";
        var ipv6_wan_proto = "<!--# echo ipv6_wan_proto -->";
        if (ipv6_wan_proto == "ipv6_pppoe" && ipv6_pppoe_share == "1"){
                alert(IPV6_TEXT1);
                return false;
        }

	get_by_id("asp_temp_52").value = get_by_id("wan_proto").value;
	var is_modify = is_form_modified("form1");
	if (!is_modify && !confirm(_ask_nochange)) {
		return false;
	}
	var dns1 = get_by_id("wan_primary_dns").value;
	var dns2 = get_by_id("wan_secondary_dns").value;
	var mtu = get_by_id("wan_mtu").value;	 
	var c_hostname=get_by_id("hostname").value;

	var dns1_addr_msg = replace_msg(all_ip_addr_msg, wwa_pdns);
	var dns2_addr_msg = replace_msg(all_ip_addr_msg, wwa_sdns);
	var mtu_msg = replace_msg(check_num_msg, bwn_MTU, 1300, 1500);

	var temp_dns1_obj = new addr_obj(dns1.split("."), dns1_addr_msg, false, false);
	var temp_dns2_obj = new addr_obj(dns2.split("."), dns2_addr_msg, true, false);
	var temp_mtu = new varible_obj(mtu, mtu_msg, 1300, 1500, false);
	if(Find_word(c_hostname,"'") || Find_word(c_hostname,'"') || Find_word(c_hostname,"/")){
		alert(TEXT004);
		return false;
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
		if (!check_address(temp_dns1_obj)){
			return false;
		}
	}

	if (dns2 != "" && dns2 != "0.0.0.0"){
		if (!check_address(temp_dns2_obj)){
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

	if(usb_mode == "2" && usb_type == "2"  && real_wanmode =="dhcpc" ||usb_mode == "0" && usb_type == "2" && real_wanmode =="dhcpc"){ 
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


	if((get_by_id("wan_primary_dns").value =="" || get_by_id("wan_primary_dns").value =="0.0.0.0")&& ( get_by_id("wan_secondary_dns").value =="" || get_by_id("wan_secondary_dns").value =="0.0.0.0")){
		get_by_id("wan_specify_dns").value = 0;
	}else{
		get_by_id("wan_specify_dns").value = 1;
	}

	get_by_id("wan_mac").value= mac;
//2009/4/29 Tina add OPENDNS
/*
	get_by_id("opendns_enable").value = get_checked_value(get_by_id("opendns_enable_sel"));
	if(get_by_id("opendns_enable").value=="1"){
		get_by_id("dns_relay").value = "1";
		get_by_id("wan_primary_dns").disabled = false;
		get_by_id("wan_secondary_dns").disabled = false;
	}*/
//OPENDNS

	get_by_id("dhcpc_use_ucast").value = get_checked_value(get_by_id("dhcpc_use_ucast_sel"));
	//get_by_id("classless_static_route").value = get_checked_value(get_by_id("classless_static_route_sel"));
	get_by_id("hnat_enable").value = get_checked_value(get_by_id("hnatEnable"));
	
	if(is_modify)
		if(!check_hnat("hnat_enable"))
			return false;
	if(submit_button_flag == 0){
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
    <table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
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
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wan_dhcp.asp">
				<input type="hidden" id="action" name="action" value="wan_dhcp">
							
				<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# echo mac_clone_addr -->">			
				<input type="hidden" id="mac_clone_addr2" name="mac_clone_addr2" value="<!--# exec cgi /bin/clone mac_clone_addr -->">
                <input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value="<!--# echo wan_specify_dns -->">
				<input type="hidden" id="dhcpc_use_ucast" name="dhcpc_use_ucast" value="<!--# echo dhcpc_use_ucast -->">
				<input type="hidden" id="classless_static_route" name="classless_static_route" value="<!--# echo classless_static_route -->">
				<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<!--# echo asp_temp_51 -->">
				<input type="hidden" id="asp_temp_52" name="asp_temp_52" value="<!--# echo wan_proto -->">
				<input type="hidden" id="usb_type" name="usb_type" value="<!--# echo usb_type -->">
				<input type="hidden" id="from_usb3g" name="from_usb3g" value="<!--# echo asp_temp_72 -->"> 
				<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="0">
			    	<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="0">
			    <input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="0">
				<div id=maincontent>
			  <!-- === BEGIN MAINCONTENT === -->
              <div id=box_header>
                <h1><script>show_words(_WAN)</script></h1>                
				<p><script>show_words(bwn_intro_ICS)</script></p>
				<p><strong><b><script>show_words(_note)</script></b>:&nbsp;</strong>
				  <script>show_words(bwn_note_clientSW)</script>
				</p>
				<input id="button" name="button" type="submit" class=button_submit value="" onClick="return send_dhcp_request()">
				<input id="button2" name="button2" type="button" class=button_submit value="" onClick="return page_cancel('form1', 'sel_wan.asp');">
				<script>check_reboot();</script>
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
                        <option value="dhcpc" selected><script>show_words(bwn_Mode_DHCP)</script></option>
                        <option value="pppoe"><script>show_words(bwn_Mode_PPPoE)</script></option>
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
			<!--//2009/4/29 Tina add OPENDNS-->
			<input type="hidden" id="opendns_enable" name="opendns_enable" value="<!--# echo opendns_enable -->">
			<input type="hidden" id="dns_relay" name="dns_relay" value="<!--# echo dns_relay -->">
              <!--div class=box id="show_AdvDns">
                <h2><script>show_words(_title_AdvDns);</script></h2>
				<p class="box_msg"><script>show_words(_desc_AdvDns);</script></p>
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
                <td width="331">&nbsp;<input type="checkbox" id="hnatEnable" name="hnatEnable" value="1" >
                	<input type="hidden" id="hnat_enable" name="hnat_enable" value="<!--# echo hnat_enable -->">
			<input type="hidden" id="spi_enable" name="spi_enable" value="<!--# echo spi_enable -->">
			<input type="hidden" id="traffic_shaping" name="traffic_shaping" value="<!--# echo traffic_shaping -->">
                	</td>
                </tr>
                </table>
                </div>
                <!--HARDWARE NAT SETTING END-->          
              <div class=box id=show_dhcp>
                <h2><script>show_words(bwn_DIAICT)</script></h2>
                <p class="box_msg"><script>show_words(bwn_msg_DHCPDesc)</script></p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td width="185" align=right class="duple"><script>show_words(_hostname)</script> :</td>
                      <td width="331">&nbsp;
                          <input type=text id="hostname" name="hostname" size="25" maxlength="39" value="<!--# echo hostname -->">
                      </td>
                    </tr>
                    <tr style="display:none">
                      <td align=right class="duple"><script>show_words(_dhcprout);</script> :</td>
                      <td>&nbsp;<input type="checkbox" id="classless_static_route_sel" name="classless_static_route_sel" value="1"></td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(_use_unicasting)</script> :</td>
                      <td>&nbsp;
                          <input type="checkbox" id="dhcpc_use_ucast_sel" name="dhcpc_use_ucast_sel" value="1"><script>show_words(bw_WDUU_note)</script>
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(_dns1)</script> :</td>
                      <td>&nbsp;
                        <input type=text id="wan_primary_dns" name="wan_primary_dns" size="20" maxlength="15" value="<!--# echo wan_primary_dns -->">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(_dns2)</script> :</td>
                      <td>&nbsp;
                        <input type=text id="wan_secondary_dns" name="wan_secondary_dns" size="20" maxlength="15" value="<!--# echo wan_secondary_dns -->">
    				  </td>
                    </tr>
                    <tr>
                      <td align=right class="duple"><script>show_words(bwn_MTU);</script> :</td>
                      <td>&nbsp;
                          <input type=text id="wan_mtu" name="wan_mtu" size="10" maxlength="5" value="<!--# echo wan_mtu -->">
                          <script>show_words(bwn_bytes+_308)</script>1500
                      </td>
                    </tr>
                    <tr>
                      <td align=right valign=top class="duple"><script>show_words(_macaddr)</script> :</td>
                      <td>&nbsp;
                        <input type="text" id="wan_mac" name="wan_mac" size="20" maxlength="17" value="<!--# echo wan_mac -->" onChange="mac_clone()"><br>
                        &nbsp;<input id="clone" name="clone" type="button" value="" onClick="clone_mac_action()">
						<script>get_by_id("clone").value =_clone;</script>
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
                      <td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong> <p>
              			<script>show_words(LW35)</script> </p>									  
						<p><script>show_words(LW36)</script></p>
						<!--IFDEF	OPENDNS-->
						<!--p><script>show_words(_sp_desc2_AdvDNS)</script></p>
						<p><script>show_words(_sp_desc3_AdvDNS)</script></p>
						<p><script>show_words(_sp_desc4_AdvDNS)</script></p-->
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
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script> 
	reboot_needed(left["Setup"].link[0]);
	onPageLoad();
</script>
</html>
