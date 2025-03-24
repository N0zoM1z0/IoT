<html>
<head>
<script type="text/javascript" src="uk.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
//20120111 ignore TCP,UDP endingpoint
	var dev_info = get_router_info();

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;

	var param = {
		url: 	"get_set.ccp",
		arg: 	"ccp_act=get&num_inst=6&"+
				"oid_1=IGD_Firewall_&inst_1=11000&"+
				"oid_2=IGD_&inst_2=10000&"+
				"oid_3=IGD_Status_LANStatus_Host_i_&inst_3=11110&"+
				"oid_4=IGD_&inst_4=10000&"+
				"oid_5=IGD_WANDevice_i_WANConnectionDevice_i_&inst_5=11100&"+
				"oid_6=IGD_WANDevice_i_TrafficControl_&inst_6=11100"
	};
	get_config_obj(param);

	var trafficshap_enable = config_val('wanTrafficShp_EnableTrafficShaping_');
	var spi_enable = config_val("firewallSetting_SPIEnable_");
	var dev_mode = config_val("igd_DeviceMode_");
	var wan_proto = config_val("wanConnDev_CurrentConnObjType_");
	var submit_button_flag = 0;

	function onPageLoad(){
		get_by_id("spi_enable").value = config_val("firewallSetting_SPIEnable_");
		set_checked(get_by_id("spi_enable").value, get_by_id("spiEnable"));
/*		if(config_val("firewallSetting_UDPEndpointFiltering_"))
			set_checked(config_val("firewallSetting_UDPEndpointFiltering_"), get_by_name("udp_nat_type"));
		if(config_val("firewallSetting_TCPEndpointFiltering_"))
			set_checked(config_val("firewallSetting_TCPEndpointFiltering_"), get_by_name("tcp_nat_type"));		
*/		
		get_by_id("anti_spoof_check").value = config_val("firewallSetting_AntiSpoofCheckEnable_");
		set_checked(get_by_id("anti_spoof_check").value, get_by_id("anti_spoof_check_sel"));
		get_by_id("dmz_enable").value = config_val("firewallSetting_DMZEnable_");
		set_checked(get_by_id("dmz_enable").value, get_by_id("dmz_host"));
		
		get_by_id("dmz_ipaddr").value = config_val("firewallSetting_DMZIPAddress_");
		if(config_val("firewallSetting_ALGPPTPEnable_"))
			set_checked(config_val("firewallSetting_ALGPPTPEnable_"), get_by_id("pptp"));
		if(config_val("firewallSetting_ALGL2TPEnable_"))
			set_checked(config_val("firewallSetting_ALGL2TPEnable_"), get_by_id("l2tp"));
		if(config_val("firewallSetting_ALGIPSECEnable_"))
			set_checked(config_val("firewallSetting_ALGIPSECEnable_"), get_by_id("ipsec"));
		if(config_val("firewallSetting_ALGRTSPEnable_"))
			set_checked(config_val("firewallSetting_ALGRTSPEnable_"), get_by_id("rtsp"));
		if(config_val("firewallSetting_ALGSIPEnable_"))
			set_checked(config_val("firewallSetting_ALGSIPEnable_"), get_by_id("sip"));

		var login_who= login_Info;
		if(login_who!= "w" || dev_mode == "1" || wan_proto == "10"){
			DisableEnableForm(form1,true);
		} else{
			disable_obj();
		}

		set_form_default_values("form1");
	}

	function clone_mac(){
		if (get_by_id("dhcp").selectedIndex > 0){
			get_by_id("dmz_ipaddr").value = get_by_id("dhcp").options[get_by_id("dhcp").selectedIndex].value;
		}else{
			alert(msg[SELECT_COMPUTER_ERROR]);
			//alert(get_words(GW_NAT_DMZ_CONFLICT_WITH_LAN_IP_INVALID));
			
		}
	}

	function send_request(){
		if (!is_form_modified("form1") && !confirm(get_words(_ask_nochange))) {
			return false;
		}

		get_by_id("spi_enable").value = get_checked_value(get_by_id("spiEnable"));
		get_by_id("pptp_pass_through").value = get_checked_value(get_by_id("pptp"));
		get_by_id("l2tp_pass_through").value = get_checked_value(get_by_id("l2tp"));
		get_by_id("ipsec_pass_through").value = get_checked_value(get_by_id("ipsec"));
		get_by_id("alg_rtsp").value = get_checked_value(get_by_id("rtsp"));
		get_by_id("alg_sip").value = get_checked_value(get_by_id("sip"));
		var dmz_ip = get_by_id("dmz_ipaddr").value;
		//var lan_ip = "<% CmoGetCfg("lan_ipaddr","none"); %>";
		var lan_ip = dev_info.lanIP;
		
		var ip_addr_msg = replace_msg(all_ip_addr_msg, get_words('help256'));
		var ip_obj = new addr_obj(dmz_ip.split("."), ip_addr_msg, false, false);
		var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), ip_addr_msg, false, false);
		
		if (get_by_id("dmz_host").checked){
			if(!check_LAN_ip(temp_lan_ip_obj.addr, ip_obj.addr)){
				return false;
			}
			if (!check_address(ip_obj)){				
				return false;
	   		}
	   	}
	   	
		get_by_id("dmz_enable").value = get_checked_value(get_by_id("dmz_host"));
		get_by_id("anti_spoof_check").value = get_checked_value(get_by_id("anti_spoof_check_sel"));
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			copy_data_to_cgi_struct();

			get_by_id("form2").submit();
		}
	}
	
	function disable_obj(){
		var is_disable = true;
		if (get_by_id("dmz_host").checked){
			is_disable = false;
		}
		
		get_by_id("dmz_ipaddr").disabled = is_disable;
		get_by_id("button22").disabled = is_disable;
		get_by_id("dhcp").disabled = is_disable;
	}
	
	function copy_data_to_cgi_struct()
	{
		get_by_id("firewallSetting_SPIEnable_").value = get_checked_value(get_by_id("spiEnable"));
		//get_by_id("firewallSetting_UDPEndpointFiltering_").value = 1 ;//get_radio_value(get_by_name("udp_nat_type"));
		//get_by_id("firewallSetting_TCPEndpointFiltering_").value = 2 ;//get_radio_value(get_by_name("tcp_nat_type"));
		get_by_id("firewallSetting_AntiSpoofCheckEnable_").value = get_checked_value(get_by_id("anti_spoof_check_sel"));
		get_by_id("firewallSetting_DMZEnable_").value = get_checked_value(get_by_id("dmz_host"));
		get_by_id("firewallSetting_DMZIPAddress_").value = get_by_id("dmz_ipaddr").value;
		get_by_id("firewallSetting_ALGPPTPEnable_").value = get_by_id("pptp_pass_through").value;
		get_by_id("firewallSetting_ALGL2TPEnable_").value = get_by_id("l2tp_pass_through").value;
		get_by_id("firewallSetting_ALGIPSECEnable_").value = get_by_id("ipsec_pass_through").value;
		get_by_id("firewallSetting_ALGRTSPEnable_").value = get_by_id("alg_rtsp").value;
		get_by_id("firewallSetting_ALGSIPEnable_").value = get_by_id("alg_sip").value;
	}
</script>

<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<form id="form1" name="form1" method="post" action="">
<input type="hidden" id="html_response_page"  name="html_response_page" value="back.asp">
<input type="hidden" id="html_response_message"  name="html_response_message" value="">
<script>get_by_id("html_response_message").value = get_words(sc_intro_sv);</script>
<input type="hidden" id="html_response_return_page"  name="html_response_return_page" value="adv_dmz.asp">
<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
<input type="hidden" id="dhcp_list" name="dhcp_list" value="">
<input type="hidden" id="dmz_schedule" name="dmz_schedule" value="">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        
      <td width="100%">&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support" onclick="return jump_if();"><script>document.write(model);</script></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>:<script>document.write(hw_version);</script>&nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(version);</script></td>
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
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
		</tr>
	</table>
<table id="footer_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table cellSpacing=0 cellPadding=0 border=0>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
						    <LI><div><a href="adv_virtual.asp" onClick="return jump_if();"><script>show_words(_virtserv)</script></a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(_pf)</script></a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(_specappsr)</script></a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(YM48)</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(_netfilt)</script></a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(_acccon)</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(_websfilter)</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(_inboundfilter)</script></a></div></LI>
							<LI><div id=sidenavoff><script>show_words(_firewalls)</script></div></LI>
                            <LI><div><a href="adv_routing.asp" onclick="return jump_if();"><script>show_words(_routing)</script></a></div></LI>
							<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(_adwwls)</script></a></div></LI>
                            <LI><div><a href="adv_wps_setting.asp" onclick="return jump_if();"><script>show_words(LY2)</script></a></div></LI>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(_advnetwork)</script></a></div></LI>
                            <LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>
                            <LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();"><script>show_words(if_iflist)</script></a></div></LI>
							<LI><div><a href="adv_ipv6_routing.asp" onclick="return jump_if();"><script>show_words(v6_routing)</script></a></div></LI>
                          </UL>
                      	</div>
                      </td>                    </tr>
                </table>
             </td>
             <td valign="top" id="maincontent_container">
				<div id=maincontent>
				  <!-- === BEGIN MAINCONTENT === -->
                  <div id=box_header>
                    <h1><script>show_words(_firewalls)</script></h1>
                    <p><script>show_words(af_intro_x)</script></p>
                    <input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
            		<input name="button2" id="button2" type=button class=button_submit value="" onclick="page_cancel('form1', 'adv_dmz.asp');">
           			 <script>get_by_id("button2").value = get_words(_dontsavesettings);</script>
            		<script>get_by_id("button").value = get_words(_savesettings);</script>
				  </div>
                  <div class=box>
                    <h2><script>show_words(af_ES)</script></h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width=155 align=right class="duple"><script>show_words(af_ES)</script>:</td>
                          <td width="360">&nbsp;
						  <input type="checkbox" id="spiEnable" name="spiEnable" value="1">
						  <input type="hidden" id="spi_enable" name="spi_enable" value="">
						  </td>
                        </tr>
                    </table>
                  </div>

<!-- 20120111 ignore by silvia
                  <div class=box>
                    <h2><script>show_words(_neft)</script></h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="udp_nat_type" name="udp_nat_type" value="0">
						  &nbsp;<script>show_words(af_EFT_0)</script>
						  </td>
                        </tr>
                        <tr>

                          <td width=155 align=right class="duple"><script>show_words(af_UEFT)</script>:</td>

                          <td width="360">&nbsp;
						  <input type="radio" id="udp_nat_type" name="udp_nat_type" value="1">

						  &nbsp;<script>show_words(af_EFT_1)</script>

						  </td>
                        </tr>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="udp_nat_type" name="udp_nat_type" value="2">

						  &nbsp;<script>show_words(af_EFT_2)</script>

						  </td>
                        </tr>
                        <tr>
                          <td align=right colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="tcp_nat_type" name="tcp_nat_type" value="0">

						  &nbsp;<script>show_words(af_EFT_0)</script>

						  </td>
                        </tr>
                        <tr>

                          <td width=155 align=right class="duple"><script>show_words(af_TEFT)</script>:</td>

                          <td width="360">&nbsp;
						  <input type="radio" id="tcp_nat_type" name="tcp_nat_type" value="1">

						  &nbsp;<script>show_words(af_EFT_1)</script>

						  </td>
                        </tr>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="tcp_nat_type" name="tcp_nat_type" value="2">

						  &nbsp;<script>show_words(af_EFT_2)</script>

						  </td>
                        </tr>
                    </table>
                  </div>
-->
                  <div class=box>

                    <h2><script>show_words(KR105)</script></h2>

                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width=155 align=right class="duple"><script>show_words(KR106)</script>:</td>
                          <td width="360">&nbsp;
						  <input type="checkbox" id="anti_spoof_check_sel" name="anti_spoof_check_sel" value="1">
						  <input type="hidden" id="anti_spoof_check" name="anti_spoof_check" value="">
						  </td>
                        </tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2><script>show_words(_dmzh)</script></h2>
                    <script>show_words(help165)</script></P>
                    <p><script>show_words(af_intro_2)</script></p>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td align=right width=155>
						  <input type="hidden" id="dmz_enable" name="dmz_enable" value="">

						  <script>show_words(af_ED)</script>

                  :</td>

                          <td colSpan=3>&nbsp;

						  <input type=checkbox id="dmz_host" name="dmz_host" value="1" onClick="disable_obj();"></td>
                        </tr>
                        <tr>

                          <td width="155" align=right><script>show_words(af_DI)</script> :</td>

                          <td width="96" valign="bottom"><input type=text id="dmz_ipaddr" name="dmz_ipaddr" size=16 maxlength=15 value="">
                          </td>
                          <td width="258" valign="bottom"><input id="button22" name="button22" type=button value="<<" style="width: 24; height: 24" onClick="clone_mac()">
                            <select id="dhcp" name="dhcp" size=1>

                              <option value="-1"><script>show_words(bd_CName)</script></option>

                              <script>get_host_list("ip")</script>
                            </select>
						  </td>
                          <td width="3">&nbsp;</td>
                        </tr>
                    </table>
                  </div>
                  
				   <div class=box>
                    <h2><script>show_words(af_algconfig)</script></h2>
                 
                    
            <table cellSpacing=1 cellPadding=1 width=525 border=0>
              <tr> 
                <td align=right width=155> <input type="hidden" id="pptp_pass_through" name="pptp_pass_through" value="">
                  <script>show_words(_PPTP)</script> :</td>
                <td colSpan=3>&nbsp; <input type=checkbox id="pptp" name="pptp" value="1"></td>
              </tr>
              <tr style='display:none'> 
                <td align=right width=155> <input type="hidden" id="l2tp_pass_through" name="l2tp_pass_through" value="">
                  <script>show_words(_L2TP)</script> :</td>
                <td colSpan=3>&nbsp; <input type=checkbox id="l2tp" name="l2tp" value="1"></td>
              </tr>
             <tr> 
                <td align=right width=155> <input type="hidden" id="ipsec_pass_through" name="ipsec_pass_through" value="">
                  <script>show_words(as_IPSec)</script> :</td>
                <td colSpan=3>&nbsp; <input type=checkbox id="ipsec" name="ipsec" value="1"></td>
              </tr>
			  <tr> 
                <td align=right width=155> <input type="hidden" id="alg_rtsp" name="alg_rtsp" value="">
                  <script>show_words(as_RTSP)</script> :</td>
                <td colSpan=3>&nbsp; <input type=checkbox id="rtsp" name="rtsp" value="1"></td>
              </tr>
			  <tr> 
                <td align=right width=155> <input type="hidden" id="alg_sip" name="alg_sip" value="">
                  <script>show_words(as_SIP)</script> :</td>
                <td colSpan=3>&nbsp; <input type=checkbox id="sip" name="sip" value="1"></td>
              </tr>
            </table>
                  </div>                  
                  
             </div>
            </td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong>
                        <p><script>show_words(hhaf_dmz)</script></p>
                        <p class="more"><a href="support_adv.asp#Firewall" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                      </td>
                    </tr>
                </table>
             </td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words('_copyright');</script></div>
<br>
</form>
<form id="form2" name="form2" method="post" action="get_set.ccp">
	<input type="hidden" name="ccp_act" value="set">
	<input type="hidden" name="ccpSubEvent" value="CCP_SUB_DMZ">
	<input type="hidden" name="ccpSubEvent2" value="CCP_SUB_ADVNET">
	<input type="hidden" name="ccpSubEvent3" value="CCP_SUB_NATTYPE">
	<input type="hidden" name="nextPage" value="adv_dmz.asp">	
	<input type="hidden" id="firewallSetting_SPIEnable_"  name="firewallSetting_SPIEnable_1.1.0.0.0" value="">	
	<input type="hidden" id="firewallSetting_UDPEndpointFiltering_"  name="firewallSetting_UDPEndpointFiltering_1.1.0.0.0" value="">	
	<input type="hidden" id="firewallSetting_TCPEndpointFiltering_"  name="firewallSetting_TCPEndpointFiltering_1.1.0.0.0" value="">	
	<input type="hidden" id="firewallSetting_AntiSpoofCheckEnable_"  name="firewallSetting_AntiSpoofCheckEnable_1.1.0.0.0" value="">
	<input type="hidden" id="firewallSetting_DMZEnable_"  name="firewallSetting_DMZEnable_1.1.0.0.0" value="">	
	<input type="hidden" id="firewallSetting_DMZIPAddress_"  name="firewallSetting_DMZIPAddress_1.1.0.0.0" value="">
	<input type="hidden" id="firewallSetting_ALGPPTPEnable_"  name="firewallSetting_ALGPPTPEnable_1.1.0.0.0" value="">	
	<input type="hidden" id="firewallSetting_ALGL2TPEnable_"  name="firewallSetting_ALGL2TPEnable_1.1.0.0.0" value="">	
	<input type="hidden" id="firewallSetting_ALGIPSECEnable_"  name="firewallSetting_ALGIPSECEnable_1.1.0.0.0" value="">
	<input type="hidden" id="firewallSetting_ALGRTSPEnable_"  name="firewallSetting_ALGRTSPEnable_1.1.0.0.0" value="">	
	<input type="hidden" id="firewallSetting_ALGSIPEnable_"  name="firewallSetting_ALGSIPEnable_1.1.0.0.0" value="">
	
	<input type="hidden" id="wanConnDev_HardwareNatEnable_1.1.1.0.0" name="wanConnDev_HardwareNatEnable_1.1.1.0.0" value="">
</form>
</body>
<script>
	onPageLoad();
</script>
</html>
