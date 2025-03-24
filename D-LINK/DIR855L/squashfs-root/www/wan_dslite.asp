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

function onPageLoad(){
	var global_ip;
	var default_gw;
	var aftr;
	var global_ip_tmp
	global_ip = document.getElementById("global_ip_w").value;
	global_ip_list = global_ip.split(",");
	for (var i = 0; i < global_ip_list.length; i++) {
		if (i==0) {
			document.getElementById("wan_ipv6_address").innerHTML = global_ip_list[i];
		} else {
			document.getElementById("wan_ipv6_address").innerHTML +="<br>&nbsp;";
			document.getElementById("wan_ipv6_address").innerHTML += global_ip_list[i];
		}               
	}

	default_gw = document.getElementById("default_gateway").value;
	document.getElementById("wan_ipv6_gateway").innerHTML= default_gw.toUpperCase();

	set_checked("<!--# echo wan_dslite_dhcp -->", get_by_name("wan_dslite_dhcp"));
	check_aftr_address();
	set_form_default_values("form1");
	var login_who= checksessionStorage();
	if(login_who== "user"){
		DisableEnableForm(document.form1,true);
	}       

}

function check_aftr_address(){
	var dslite_dhcp = get_by_name("wan_dslite_dhcp");
	var dslite_aftr;
	dslite_aftr = document.getElementById("aftr_address").value;
                if(dslite_dhcp[0].checked){
			get_by_id("wan_dslite_aftr").disabled = true;
			get_by_id("wan_dslite_aftr").value= dslite_aftr;
		}
		else{
			get_by_id("wan_dslite_aftr").disabled = false;
			get_by_id("wan_dslite_aftr").value= "<!--# echo wan_dslite_aftr -->";
		}
}

function send_dslite_request(){
        var ipv6_pppoe_share = "<!--# echo ipv6_pppoe_share -->";
	var ipv6_wan_proto = "<!--# echo ipv6_wan_proto -->";
	var ipv6_6rd_dhcp = "<!--# echo ipv6_6rd_dhcp -->";
	var dslite_dhcp = get_by_name("wan_dslite_dhcp");
	var aftr_address = get_by_id("wan_dslite_aftr").value;

        var aftr_address_msg = replace_msg(all_ipv6_addr_msg, IPV6_TEXT0);
        var temp_aftr_address = new ipv6_addr_obj(aftr_address.split(":"), aftr_address_msg, false, false);
	var b4_ipv4 = get_by_id("wan_dslite_ipv4").value;
        var is_modify = is_form_modified("form1");
	if(get_by_id("wan_proto").value != "<!--# echo wan_proto -->")
		is_modify = true;
        if (!is_modify && !confirm(_ask_nochange)) {
                        return false;
        }

	if (ipv6_wan_proto == "ipv6_pppoe" && ipv6_pppoe_share == "1"){
		alert(IPV6_TEXT1);
		return false;
	}

	if (ipv6_wan_proto == "ipv6_6rd" && ipv6_6rd_dhcp == "1"){
        	alert(IPV6_6rd_v6wan);
		return false;
	}
	
	if (ipv6_wan_proto != "ipv6_pppoe" && ipv6_wan_proto != "ipv6_autoconfig" 
		&& ipv6_wan_proto != "ipv6_autodetect" && dslite_dhcp[0].checked){
		alert(DSLITE_DHCP_INFO)
		return false
	}

	if((aftr_address == "" || Find_word(aftr_address, " ")) && !dslite_dhcp[0].checked){
		alert(LS46);
		return false;
	}

        if(Find_word(aftr_address, ":") && !dslite_dhcp[0].checked){
                if(check_ipv6_symbol(aftr_address,"::")==2){ // find two '::' symbol
                        return false;
                }else if(check_ipv6_symbol(aftr_address,"::")==1){    // find one '::' symbol
                        temp_aftr_address = new ipv6_addr_obj(aftr_address.split("::"), aftr_address_msg, false, false);
                        if (!check_ipv6_address(temp_aftr_address,"::")){
                                return false;
                        }
                }else{  //not find '::' symbol
                        temp_aftr_address = new ipv6_addr_obj(aftr_address.split(":"), aftr_address_msg, false, false);
                        if (!check_ipv6_address(temp_aftr_address,":"))
                                return false;
                }
        }
	
	if( !(b4_ipv4 == "" || (b4_ipv4 > 1 && b4_ipv4 < 8))){
		alert(DSLITE_B4_RANGE)
		return false;
	}

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
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wan_dslite.asp">
				<input type="hidden" id="action" name="action" value="wan_dslite">
			    	<input type="hidden" id="reboot_type" name="reboot_type" value="wan">
				<input type="hidden" id="global_ip_w" name="global_ip_w" value="<!--# exec cgi /bin/ipv6 global_ip_w -->">
				<input type="hidden" id="default_gateway" name="default_gateway" value="<!--# exec cgi /bin/ipv6 default_gateway -->">
				<input type="hidden" id="aftr_address" name="aftr_address" value="<!--# exec cgi /bin/ipv6 aftr_address -->">
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
				<input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_dslite_request()">
                <input name="button2" id="button2" type=reset class=button_submit value="" onClick="return page_cancel('form1', 'sel_wan.asp');">
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
                        <option value="dhcpc"><script>show_words(bwn_Mode_DHCP)</script></option>
                        <option value="pppoe"><script>show_words(bwn_Mode_PPPoE)</script></option>
                        <option value="pptp"><script>show_words(bwn_Mode_PPTP)</script></option>
                        <option value="l2tp"><script>show_words(bwn_Mode_L2TP)</script></option>
                        <option value="dslite" selected><script>show_words(DSLITE)</script></option>
                        <script>
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
                                        var str = "<option value=dslite>"+ bwn_Mode_MPPPoE + "</option>";
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
                      </select></td>
                    </tr>
                </table>
              </div>
              <div class=box id=show_static>
                <h2><script>show_words(DSLITE_AFTR_TITLE)</script> </h2>
                <p class="box_msg"><script>show_words(DSLITE_AFTR_INFO)</script></p>

                <table cellSpacing=1 cellPadding=1 width=525 border=0>
		<tr>
		  <td width="185" align=right class="duple"><script>show_words(DSLITE_CONFIG)</script></td>
                  <td width="331">&nbsp;
                  <input type="radio" name="wan_dslite_dhcp" value="1" onClick="check_aftr_address()" checked>
                  <script>show_words(DSLITE_DHCP)</script>
                  <input type="radio" name="wan_dslite_dhcp" value="0" onClick="check_aftr_address()">
                  <script>show_words(IPV6_6rd_manual)</script>
                  </td>
                </tr>

                  <tr>
                    <td width="185" class="duple"><script>show_words(DSLITE_AFTR)</script> :</td>
                    <td width="331">&nbsp;
                    <input type=text id="wan_dslite_aftr" name="wan_dslite_aftr" size="30" maxlength="39" value="">
		    </td>
                  </tr>
                  <tr>
                    <td width="185" class="duple"><script>show_words(DSLITE_B4)</script> :</td>
                    <td width="331">&nbsp;
                    192.0.0.<input type=text id="wan_dslite_ipv4" name="wan_dslite_ipv4" size="1" maxlength="1" value="<!--# echo wan_dslite_ipv4 -->"> <script>show_words(_optional)</script>
		    </td>
			<tr>
                              <td width="187" align=right class="duple"><script>show_words(TEXT071)</script> :</td>
                              <td width="331">&nbsp;
                                <b><span id="wan_ipv6_address"></span></b>
                              </td>
                       </tr>
			<tr>
                              <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT105)</script> :</td>
                              <td width="331">&nbsp;
                                <b><span id="wan_ipv6_gateway"></span></b>
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
<!-- insert name=restore_wan_type -->
</html>
