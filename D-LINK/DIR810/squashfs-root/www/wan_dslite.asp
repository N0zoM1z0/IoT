<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<script type="text/javascript" src="uk.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript">
var dev_info = get_router_info();
    var submit_button_flag = 0;
	document.title = get_words('TEXT000');
	
	var param = {
		url: "get_set.ccp",
		arg: ""
	};
	param.arg = "ccp_act=get&num_inst=7";
	param.arg +="&oid_1=IGD_WANDevice_i_WANConnectionDevice_i_&inst_1=11100";
	param.arg +="&oid_2=IGD_WANDevice_i_WANConnectionDevice_i_DSLite_i_&inst_2=11110";
	param.arg +="&oid_3=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_&inst_3=11100";
	param.arg +="&oid_4=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_PPPoE_i_&inst_4=11110";
	param.arg +="&oid_5=IGD_WANDevice_i_WANIPv6ConnectionDevice_i_6RD_i_&inst_5=11110";
	param.arg +="&oid_6=IGD_Status_IPv6Status_&inst_6=11100";
	param.arg +="&oid_7=IGD_Status_WANStatus_&inst_7=11100";
	get_config_obj(param);
	
    var ipv6_6to4_lan_prefix;
	//IPv6 connection type
	var ipv6_type = config_val("wanConnDev_CurrentConnObjType_");
	
	//AFTR address internet connection type
	var dslite_config_type = config_val("dsLiteConn_ConfigurationType_");
	var b4_ipv4_addr = config_val("dsLiteConn_B4IPv4Address_");
	//var wan_ipv6_Addr = config_val("dsLiteConn_WANIPv6Address_");
	//var wan_ipv6_default_gateway = config_val("dsLiteConn_WANIPv6DefaultGateway_");
	var ipv6_wan_proto = config_val("wanIPv6ConnDev_CurrentConnObjType_");
	var ipv6_pppoe_share = config_val("ipv6PPPoEConn_SessionType_"); 
	var ipv6_6rd_dhcp = config_val("ipv66rdConn_ConfigurationType_");
	var wan_ipv6_Addr;
	if(config_val('igdIPv6Status_IPAddressIANA_'))
		wan_ipv6_Addr = filter_ipv6_addr(config_val('igdIPv6Status_IPAddressIANA_'));
	else
		wan_ipv6_Addr = filter_ipv6_addr(config_val('igdIPv6Status_IPAddress_'));
	var wan_ipv6_default_gateway = filter_ipv6_addr(config_val('igdIPv6Status_DefaultGateway_'));
	var dslite_dsdomain = filter_ipv6_addr(config_val('igdWanStatus_DsLiteAFTR_'));
	var aftr_addr = filter_ipv6_addr(config_val("dsLiteConn_AFTRIPv6Address_"));
	aftr_addr = (aftr_addr == '::')?'':aftr_addr;
	
    function onPageLoad()
    {
		set_checked(dslite_config_type, get_by_name("ipv6_dslite_configuration"));
		$('#aftr_ipv6_addr').val(aftr_addr);
		var array_addr = b4_ipv4_addr.split(".");
		if(array_addr[3]=="0")
			get_by_id("b4_ipv4_addr_suffix").value = "";
		else
			get_by_id("b4_ipv4_addr_suffix").value = array_addr[3];
		document.getElementById("wan_ipv6_addr").innerHTML= wan_ipv6_Addr.toUpperCase();
		document.getElementById("ipv6_wan_default_gateway").innerHTML = wan_ipv6_default_gateway.toUpperCase();
		enable_dslite_dhcpv6();

		set_form_default_values("form1");
		var login_who= dev_info.login_Info;
    }

	function enable_dslite_dhcpv6(){
		var enable_dhcpv6 = get_by_name("ipv6_dslite_configuration");
		get_by_id("aftr_ipv6_addr").disabled = enable_dhcpv6[0].checked;
		$('#aftr_ipv6_addr').val((enable_dhcpv6[0].checked)?dslite_dsdomain:aftr_addr);
	}	
   
	function send_request(){
		var enable_dhcpv6 = get_by_name("ipv6_dslite_configuration");
		var ipv6_static = get_by_id("aftr_ipv6_addr").value;
		var ipv6_static_msg = replace_msg(all_ipv6_addr_msg,"IPv6 address");
		var temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split(":"), ipv6_static_msg, false, false);

		if (ipv6_wan_proto == "3" && ipv6_pppoe_share == "0"){
			alert(which_lang[IPV6_TEXT161a]);
			return false;
		}

		if (ipv6_wan_proto == "6" && ipv6_6rd_dhcp == "1"){
				alert(which_lang[IPV6_TEXT162]);
			return false;
		}
		
		if (ipv6_wan_proto != "3" && ipv6_wan_proto != "2" 
			&& ipv6_wan_proto != "0" && enable_dhcpv6[0].checked){
			alert(which_lang[IPV6_TEXT163])
			return false
		}
		
		if (ipv6_wan_proto != "3" && ipv6_wan_proto != "2" 
			&& ipv6_wan_proto != "1" && ipv6_wan_proto != "0" && enable_dhcpv6[1].checked){
			alert(which_lang[IPV6_TEXT173])
			return false
		}

		if((ipv6_static == "" || Find_word(ipv6_static, " ")) && !enable_dhcpv6[0].checked){
			alert(which_lang[KR2]);
			return false;
		}

/**
**    Date:		2013-11-13
**    Author:	Silvia Chang
**    Reason:	fix TSD bug No.19270: DS-Lite GUI issue
**/
/*
			if(enable_dhcpv6[1].checked){
				if(check_ipv6_symbol(ipv6_static,"::")==2){ // find more than one '::' symbol
					return false;
			}else if(check_ipv6_symbol(ipv6_static,"::")==1){    // find one '::' symbol
					temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split("::"), ipv6_static_msg, false, false);
					if (!check_ipv6_address(temp_ipv6_static,"::")){
						return false;
					}
			}else{  //not find '::' symbol
					temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split(":"), ipv6_static_msg, false, false);
					if (!check_ipv6_address(temp_ipv6_static,":")){
						return false;
					}
			}
		}
*/
		if(get_by_id('b4_ipv4_addr_suffix').value!="")
		{
			if (!check_integer(get_by_id('b4_ipv4_addr_suffix').value, 2, 7)) {
				alert(which_lang[IPV6_TEXT159]);
				return false;
			}
		}
		if (submit_button_flag == 0) {
			submit_button_flag = 1;
			copyDataToDataModelFormat();
			send_submit("form2");
			return true;
		}

		return false;
	}

	function copyDataToDataModelFormat()
	{
		get_by_id("dsLiteConn_ConfigurationType_1.1.1.1.0").value = get_checked_value(get_by_name("ipv6_dslite_configuration"));
		get_by_id("dsLiteConn_AFTRIPv6Address_1.1.1.1.0").value = get_by_id("aftr_ipv6_addr").value;
		if(get_by_id("b4_ipv4_addr_suffix").value=="")
			get_by_id("dsLiteConn_B4IPv4Address_1.1.1.1.0").value = "192.0.0.0";
		else	
			get_by_id("dsLiteConn_B4IPv4Address_1.1.1.1.0").value = "192.0.0." + get_by_id("b4_ipv4_addr_suffix").value;
	}

//20120727 silvia modify b4_ipv4_addr_suffix 192.0.0 to 192.168.0 req from TSD
//20130118 silvia modify again, revert it, req from Pre-test and RFC define
</script>

<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>
<body onload="onPageLoad();" topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support"><script>document.write(dev_info.model);</script></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
        <td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
        <td>&nbsp;</td>
      </tr>
    </table>
    <table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
        </tr>
    </table>
    <table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
        <tr id="topnav_container">
            <td><img src="short_modnum.gif" width="125" height="25"></td>
            <td id="topnavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
            <td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
            <td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
            <td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
            <td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
        </tr>
    </table>
        <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
            <td id="sidenav_container" valign="top" width="125" align="right">
                <table cellSpacing=0 cellPadding=0 border=0>
                  <tbody>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
							<ul>
								<li><div id="sidenavoff"><script>show_words(sa_Internet)</script></div></li>
								<li><div id="sidenavon"><a href="wizard_wireless.asp" onclick="return jump_if();"><script>show_words(_wirelesst)</script></a></div></li>
								<li><div id="sidenavon"><a href="lan.asp" onclick="return jump_if();"><script>show_words(bln_title_NetSt)</script></a></div></li>								
								<li><div id="sidenavon"><a href="setup_ipv6.asp" onclick="return jump_if();"><script>show_words(IPV6_TEXT137)</script></a></div></li>
								<li><div id="sidenavon"><a href="mydlink.asp" onclick="return jump_if();"><script>show_words(mydlink_S01)</script></a></div></li>
							</ul>
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table></td>

            
				<form id="form2" name="form2" method="post" action="get_set.ccp">
					<input type="hidden" name="ccp_act" value="set">
					<input type="hidden" name="ccpSubEvent" value="CCP_SUB_WAN">
					<input type="hidden" name="nextPage" value="sel_wan.asp">
					<input type="hidden" name="wanConnDev_CurrentConnObjType_1.1.1.0.0" id="wanConnDev_CurrentConnObjType_1.1.1.0.0" value="10">
					<input type="hidden" name="dsLiteConn_ConfigurationType_1.1.1.1.0" id="dsLiteConn_ConfigurationType_1.1.1.1.0" value="">
					<input type="hidden" name="dsLiteConn_AFTRIPv6Address_1.1.1.1.0" id="dsLiteConn_AFTRIPv6Address_1.1.1.1.0" value="">
					<input type="hidden" name="dsLiteConn_B4IPv4Address_1.1.1.1.0" id="dsLiteConn_B4IPv4Address_1.1.1.1.0" value="">
					
					<span id="forAPMode"></span>
				</form>
			<form id="form1" name="form1" method="post" action="">
			<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
            <input type="hidden" id="html_response_message" name="html_response_message" value="">
            <script>get_by_id("html_response_message").value = sc_intro_sv;</script>
            <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_ipv6_6to4.asp">
            <input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value=''>
            <input type="hidden" id="ipv6_dhcpd_start" name="ipv6_dhcpd_start" value=''>
            <input type="hidden" id="ipv6_dhcpd_end" name="ipv6_dhcpd_end" value=''>
            <input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value=''>
            <input type="hidden" maxLength=80 size=80 name="ipv6_6to4_tunnel_address" id="ipv6_6to4_tunnel_address" value=''>
            <input type="hidden" maxLength=80 size=80 name="ipv6_6to4_lan_addr" id="ipv6_6to4_lan_addr" value=''>
            <input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value=''>
            <input type="hidden" id="ipv6_ra_adv_valid_lifetime_l_one" name="ipv6_ra_adv_valid_lifetime_l_one" value=''>
            <input type="hidden" id="ipv6_6to4_lan_ip" name="ipv6_6to4_lan_ip" value=''>
            <input type="hidden" id="page_type" name="page_type" value="IPv6">
            <input type="hidden" id="ipv6_wan_specify_dns" name="ipv6_wan_specify_dns" value="1">

            <td valign="top" id="maincontent_container">
                <div id="maincontent">
          <div id=box_header>
                    <h1>IPv6</h1>
                    <script>show_words(IPV6_TEXT28)</script><br>
                    <br>
                        <input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
                        <input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'sel_wan.asp');">                      
						<script>get_by_id("button").value = get_words('_savesettings');</script>
                        <script>get_by_id("button2").value = get_words('_dontsavesettings');</script>
                 </div>
                  <div class=box>

                <h2><script>show_words(bwn_ict)</script></h2>
                <p class="box_msg"><script>show_words(bwn_msg_Modes)</script></p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td align=right width="185" class="duple"><script>show_words(bwn_mici)</script> :</td>
                      <td width="331">&nbsp; <select name="wan_proto" id="wan_proto" onChange="change_wan()">
                    	<option value="0"><script>show_words(_sdi_staticip)</script></option>
                        <option value="1"><script>show_words(bwn_Mode_DHCP)</script></option>
                        <option value="2"><script>show_words(bwn_Mode_PPPoE)</script></option>
                        <option value="3"><script>show_words(bwn_Mode_PPTP)</script></option>
                        <option value="4"><script>show_words(bwn_Mode_L2TP)</script></option>
			   <option value="10" selected><script>show_words(IPV6_TEXT140)</script></option>
                        <!--option value="bigpond">BigPond (Australia)</option-->
                      </select></td>
                    </tr>
                   </table>
                  </div>
             <div class=box>
	                <h2 style=" text-transform:none"><script>show_words(IPV6_TEXT146)</script>  : </h2>
					<p class="box_msg"><script>show_words(IPV6_TEXT148)</script> </p>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width="185" align=right class="duple"><script>show_words(IPV6_TEXT149)</script> :</td>
                          <td width="331">&nbsp;
                            <input type="radio" name="ipv6_dslite_configuration" value="0" onClick="enable_dslite_dhcpv6()" checked>
								<script>show_words(IPV6_TEXT150)</script>
                            <input type="radio" name="ipv6_dslite_configuration" value="1" onClick="enable_dslite_dhcpv6()">
								<script>show_words(IPV6_TEXT144)</script>
                          </td>
                        </tr>
						<tr>
                          <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT151)</script> :</td>
                          <td width="331">&nbsp;<input type=text id="aftr_ipv6_addr" name="aftr_ipv6_addr" size="20" maxlength="39" value=''></td>
                        </tr>
						<tr>
	                      <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT152)</script> :</td>
                          <td width="331">&nbsp;192.0.0.<input type=text id="b4_ipv4_addr_suffix" name="b4_ipv4_addr_suffix" size="5" maxlength="39" value=''>
						  &nbsp;<script>show_words(_optional)</script></td>
						  <!--Range should be in 192.0.0.2~192.0.0.7-->
                        </tr>
						<tr>
	                      <td width="187" align=right class="duple"><script>show_words(TEXT071)</script> :</td>
                          <td width="331">&nbsp;<b><span id="wan_ipv6_addr"></span></b></td>
                        </tr>
						<tr>
	                      <td width="187" align=right class="duple"><script>show_words(IPV6_TEXT153)</script> :</td>
                          <td width="331">&nbsp;<b><span id="ipv6_wan_default_gateway"></span></b></td>
                        </tr>
                    </table>
                 </div>

               </td>
          </form>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b><script>show_words(_hints)</script>&hellip;</b>
                      	<p><script>show_words(IPV6_TEXT58)</script></p>
              			<p><script>show_words(IPV6_TEXT59)</script></p>
						<p><a href="support_adv.asp#ipv6" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                      </td>
                    </tr>
                  </tbody>
              </table></td>
        </tr>
    </table>
    <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
            <td width="10">&nbsp;</td><td>&nbsp;</td>
        </tr>
    </table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
</html>
