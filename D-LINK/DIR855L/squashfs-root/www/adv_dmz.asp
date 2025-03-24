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
<script language="JavaScript">
	var submit_button_flag = 0;

	function onPageLoad(){
		set_checked(get_by_id("spi_enable").value, get_by_id("spiEnable"));
		set_checked("<!--# echo udp_nat_type -->", get_by_name("udp_nat_type"));
		set_checked("<!--# echo tcp_nat_type -->", get_by_name("tcp_nat_type"));
		set_checked(get_by_id("anti_spoof_check").value, get_by_id("anti_spoof_check_sel"));
		set_checked(get_by_id("dmz_enable").value, get_by_id("dmz_host"));
		set_checked("<!--# echo pptp_pass_through -->", get_by_id("pptp"));
		set_checked("<!--# echo ipsec_pass_through -->", get_by_id("ipsec"));
		set_checked("<!--# echo alg_rtsp -->", get_by_id("rtsp"));
		set_checked("<!--# echo alg_sip -->", get_by_id("sip"));
		var hw="<!--# echo sys_hw_version -->";
		
		if ("<!--# echo model_number -->" === "DIR-652"){
			if(hw == "B1" ){
				get_by_id("alg").style.display = "";
			}else{
				get_by_id("alg").style.display = "none";
			}
			
		}
		else 
			get_by_id("alg").style.display = "";

		//disable_obj();
		set_form_default_values("form1");
		var login_who= checksessionStorage();
                if(login_who== "user" || "<!--# echo wan_proto -->" == "dslite"){
                        DisableEnableForm(document.form1,true); 
                }else{
			//disable_obj
		}

		var is_disable = true;
		if (get_by_id("dmz_host").checked){
			is_disable = false;
		}
		
		get_by_id("dmz_ipaddr").disabled = is_disable;
		get_by_id("button22").disabled = is_disable;
		get_by_id("dhcp").disabled = is_disable;
		if("<!--# echo feature_nat_endpoint -->" ==="1"){
			get_by_id("nat_endpoint").style.display = "none"
		}
	}

	function clone_mac(){
		if (get_by_id("dhcp").selectedIndex > 0){
			get_by_id("dmz_ipaddr").value = get_by_id("dhcp").options[get_by_id("dhcp").selectedIndex].value;
		}else{
			alert(TEXT044);
		}
	}

	function send_request(){
		var is_modify = is_form_modified("form1");
		if (!is_form_modified("form1") && !confirm(LS3)) {
			return false;
		}
		get_by_id("spi_enable").value = get_checked_value(get_by_id("spiEnable"));
		get_by_id("pptp_pass_through").value = get_checked_value(get_by_id("pptp"));
		get_by_id("ipsec_pass_through").value = get_checked_value(get_by_id("ipsec"));
		get_by_id("l2tp_pass_through").value = get_checked_value(get_by_id("ipsec"));
		get_by_id("alg_rtsp").value = get_checked_value(get_by_id("rtsp"));
		get_by_id("alg_sip").value = get_checked_value(get_by_id("sip"));
		var dmz_ip = get_by_id("dmz_ipaddr").value;
		var lan_ip = "<!--# echo lan_ipaddr -->";
		var ip_addr_msg = replace_msg(all_ip_addr_msg,_ipaddr);
		var ip_obj = new addr_obj(dmz_ip.split("."), ip_addr_msg, false, false);
		var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), ip_addr_msg, false, false);

		var mask = "<!--# echo lan_netmask -->";
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		
		if (get_by_id("dmz_host").checked){
			if (!check_address(ip_obj))				
				return false;

			if(!check_LAN_ip(temp_lan_ip_obj.addr, ip_obj.addr, _ipaddr))
				return false;
		
			if(!check_domain(temp_lan_ip_obj, temp_mask_obj, ip_obj)) {
				alert(dmz_ip + aa_ACC_05);
				return false;
			}
	   	}

	   	if(is_modify)
			if(!check_hnat("spi_enable"))
				return false;
				
		get_by_id("dmz_enable").value = get_checked_value(get_by_id("dmz_host"));
		get_by_id("anti_spoof_check").value = get_checked_value(get_by_id("anti_spoof_check_sel"));
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
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
			<td height="29"><img src="/short_modnum.gif" width="125" height="25"></td>
<script>show_top("adv");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table cellSpacing=0 cellPadding=0 border=0>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <!-- === BEGIN SIDENAV === -->
                          <UL>
                            <script>show_left("Advance", 8);</script>
                          </UL>
                          <!-- === END SIDENAV === -->
                      	</div>
                      </td>
                    </tr>
                </table>
             </td>
<form id="form1" name="form1" method="post" action="apply.cgi">
<input type="hidden" id="html_response_page"  name="html_response_page" value="count_down.asp">
<input type="hidden" id="html_response_message"  name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
<input type="hidden" id="html_response_return_page"  name="html_response_return_page" value="adv_dmz.asp">
<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
<input type="hidden" id="action" name="action" value="adv_dmz">

<input type="hidden" id="dhcp_list" name="dhcp_list" value="<!--# exec cgi /bin/cmo_get_list dhcpd_leased_table -->">
<input type="hidden" id="dmz_schedule" name="dmz_schedule" value="<!--# echo dmz_schedule -->">

             <td valign="top" id="maincontent_container">
				<div id=maincontent>
				  <!-- === BEGIN MAINCONTENT === -->
                  <div id=box_header>
                    <h1><script>show_words(_firewalls);</script></h1>
                    <p><script>show_words(af_intro_x);</script></p>
                    <input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
                    <input name="button2" id="button2" type="button" class=button_submit value="" onclick="return page_cancel('form1', 'adv_dmz.asp');">
					<script>check_reboot();</script>
						<script>get_by_id("button").value = _savesettings;</script>
						<script>get_by_id("button2").value = _dontsavesettings;</script>
                  </div>
                  <div class=box>
                    <h2><script>show_words(_firewalls);</script></h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width=155 align=right class="duple"><script>show_words(af_ES);</script>:</td>
                          <td width="360">&nbsp;
						  <input type="checkbox" id="spiEnable" name="spiEnable" value="1">
						  <input type="hidden" id="spi_enable" name="spi_enable" value="<!--# echo spi_enable -->">
						  <input type="hidden" id="hnat_enable" name="hnat_enable" value="<!--# echo hnat_enable -->">
						  <input type="hidden" id="traffic_shaping" name="traffic_shaping" value="<!--# echo traffic_shaping -->">						  
						  </td>
                        </tr>
                    </table>
                  </div>
                  <div class=box id="nat_endpoint" style="display:none;">
                    <h2><script>show_words(_neft);</script></h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="udp_nat_type" name="udp_nat_type" value="1">
						  &nbsp;<script>show_words(af_EFT_0);</script>
						  </td>
                        </tr>
                        <tr>
                          <td width=155 align=right class="duple"><script>show_words(af_UEFT);</script>:</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="udp_nat_type" name="udp_nat_type" value="2">
						  &nbsp;<script>show_words(af_EFT_1);</script>
						  </td>
                        </tr>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="udp_nat_type" name="udp_nat_type" value="0">
						  &nbsp;<script>show_words(af_EFT_2);</script>
						  </td>
                        </tr>
                        <tr>
                          <td align=right colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="tcp_nat_type" name="tcp_nat_type" value="1">
						  &nbsp;<script>show_words(af_EFT_0);</script>
						  </td>
                        </tr>
                        <tr>
                          <td width=155 align=right class="duple"><script>show_words(af_TEFT);</script>:</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="tcp_nat_type" name="tcp_nat_type" value="2">
						  &nbsp;<script>show_words(af_EFT_1);</script>
						  </td>
                        </tr>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="tcp_nat_type" name="tcp_nat_type" value="0">
						  &nbsp;<script>show_words(af_EFT_2);</script>
						  </td>
                        </tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2><script>show_words(KR105);</script></h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width=155 align=right class="duple"><script>show_words(KR106);</script>:</td>
                          <td width="360">&nbsp;
						  <input type="checkbox" id="anti_spoof_check_sel" name="anti_spoof_check_sel" value="1">
						  <input type="hidden" id="anti_spoof_check" name="anti_spoof_check" value="<!--# echo anti_spoof_check -->">
						  </td>
                        </tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2><script>show_words(_dmzh);</script></h2>
                    <p><script>show_words(af_intro_1);</script></P>
                    <p><script>show_words(af_intro_2);</script></p>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td align=right width=155>
						  <input type="hidden" id="dmz_enable" name="dmz_enable" value="<!--# echo dmz_enable -->">
						  <script>show_words(_enable + " " +_dmzh);</script> :</td>
                          <td colSpan=3>&nbsp;
						   
						  <input type=checkbox id="dmz_host" name="dmz_host" value="1" onClick="disable_obj();"></td>
                        </tr>
                        <tr>
                          <td width="155" align=right><script>show_words(af_DI);</script> :</td>
                          <td width="96" valign="bottom"><input type=text id="dmz_ipaddr" name="dmz_ipaddr" size=16 maxlength=15 value="<!--# echo dmz_ipaddr -->" onkeypress="if(window.event.keyCode==13) return false;">
                          </td>
                          <td width="258" valign="bottom"><input id="button22" name="button22" type=button value="<<" style="width: 24; height: 24" onClick="clone_mac()">
                            <select id="dhcp" name="dhcp" size=1>
                              <option value="-1"><script>show_words(bd_CName);</script></option>
                              <script>set_mac_list("ip")</script>
                            </select>
						  </td>
                          <td width="3">&nbsp;</td>
                        </tr>
                    </table>
                  </div>
	   <div class=box id="alg">
                    <h2><script>show_words(af_algconfig);</script></h2>
            <table cellSpacing=1 cellPadding=1 width=525 border=0>
              <tr> 
                <td align=right width=155> <input type="hidden" id="pptp_pass_through" name="pptp_pass_through" value="<!--# echo pptp_pass_through -->">
                  <script>show_words(_PPTP);</script> :</td>
                <td colSpan=3>&nbsp; <input type=checkbox id="pptp" name="pptp" value="1"></td>
              </tr>
             <tr> 
                <td align=right width=155> <input type="hidden" id="ipsec_pass_through" name="ipsec_pass_through" value="<!--# echo ipsec_pass_through -->">
                  <script>show_words(as_IPSec);</script> :</td>
                <!-- For L2TP over IPsec-->
                <input type="hidden" id="l2tp_pass_through" name="l2tp_pass_through" value="<!--# echo l2tp_pass_through -->">
                <td colSpan=3>&nbsp; <input type=checkbox id="ipsec" name="ipsec" value="1"></td>
              </tr>
			  <tr> 
                <td align=right width=155> <input type="hidden" id="alg_rtsp" name="alg_rtsp" value="<!--# echo alg_rtsp -->">
                  <script>show_words(as_RTSP);</script> :</td>
                <td colSpan=3>&nbsp; <input type=checkbox id="rtsp" name="rtsp" value="1"></td>
              </tr>
			  <tr> 
                <td align=right width=155> <input type="hidden" id="alg_sip" name="alg_sip" value="<!--# echo alg_sip -->">
                  <script>show_words(as_SIP);</script> :</td>
                <td colSpan=3>&nbsp; <input type=checkbox id="sip" name="sip" value="1"></td>
              </tr>
            </table>
                  </div>				  
             </div>
            </td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
                        <p><script>show_words(hhaf_dmz);</script></p>
                        <p class="more"><a href="support_adv.asp#Firewall" onclick="return jump_if();"><script>show_words(_more);</script>&hellip;</a></p>
                      </td>
                    </tr>
                </table>
             </td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</form>
</body>
<script>
	reboot_needed(left["Advance"].link[8]);
	onPageLoad();
</script>
</html>
