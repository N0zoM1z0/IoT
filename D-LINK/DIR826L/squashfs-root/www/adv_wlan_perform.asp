<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script>
	var dev_info = get_router_info();

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;

	var param = {
		url: 	"get_set.ccp",
		arg: 	"ccp_act=get&num_inst=1&"+
				"oid_1=IGD_LANDevice_i_WLANConfiguration_i_&inst_1=11000"
	};
	get_config_obj(param);

	var array_wlanEnable 		= config_str_multi("lanWlanCfg_Enable_");
	var array_power 			= config_str_multi("lanWlanCfg_TransmitPower_");
	var array_partitionEnable	= config_str_multi("lanWlanCfg_WlanPartitionEnable_");
	var array_wmmEnable			= config_str_multi("lanWlanCfg_WMMEnable_");
	var array_shortGiEnable		= config_str_multi("lanWlanCfg_ShortGIEnable_");
	var array_chanwidth			= config_str_multi("lanWlanCfg_ChannelWidth_");
	var array_coexi				= config_str_multi("lanWlanCfg_BSSCoexistenceEnable_");
	
	var submit_button_flag = 0;
	function onPageLoad()
	{
		//20120111 silvia add Coexistence	0419 Modify
		set_checked(array_coexi[0], get_by_name('coexi'));
		if (array_chanwidth[0] == 0)
		{
			$('#coexi0').attr('disabled',true);
			$('#coexi1').attr('disabled',true);
			set_checked(0, get_by_name('coexi'));
		}

		var j=0;
		for (var i=0;i<=1;i++){
			if(array_power)
				$("#wlan"+i+"_txpower")[0].selectedIndex = array_power[j];
			if(array_partitionEnable)
				set_checked(array_partitionEnable[j], $("#wlan"+i+"_partition_sel")[0]);
			if(array_wmmEnable)
				set_checked(array_wmmEnable[j], $("#wlan"+i+"_wmm_enable_sel")[0]);
			//if(array_shortGiEnable)
				//set_checked(array_shortGiEnable[j], $("#wlan"+i+"_short_gi_sel")[0]);
			j+=2;
			$('#wlan'+i+'_wmm_enable_sel').attr('disabled',true);
		}
		var wlan0_enable = "";
		var wlan1_enable = "";
		if(array_wlanEnable){
			wlan0_enable = array_wlanEnable[0];
			wlan1_enable = array_wlanEnable[2];
		}else{
			wlan0_enable = "0";
			wlan1_enable = "0";
		}
		if(wlan0_enable =="0" && wlan1_enable =="0")
			DisableEnableForm(form1,true);

		var login_who= login_Info;
		if(login_who!= "w")
			DisableEnableForm(form1,true);
	}

	function send_request(){
		if (!is_form_modified("form1") && !confirm(get_words(_ask_nochange)))
			return false;

		if(submit_button_flag == 0){
			submit_button_flag = 1;
			var str="ccp_act=set&ccpSubEvent=CCP_SUB_WIRELESS&nextPage=adv_wlan_perform.asp";
			
			var times2 = 1;
			var j = 0;
			while (j <=1){
				for (var i=times2;i<=(times2+1);){
				//for (var j=0;j<2;i++){
					str+="&lanWlanCfg_TransmitPower_1.1."+i+".0.0=" + $("#wlan"+j+"_txpower")[0].selectedIndex +
					"&lanWlanCfg_WlanPartitionEnable_1.1."+i+".0.0=" + get_checked_value($("#wlan"+j+"_partition_sel")[0])+
					//"&lanWlanCfg_ShortGIEnable_1.1."+i+".0.0=" + get_checked_value($("#wlan"+j+"_short_gi_sel")[0])+
					"&lanWlanCfg_WMMEnable_1.1."+i+".0.0=" + get_checked_value($("#wlan"+j+"_wmm_enable_sel")[0]);
					i++;
				}
				if (times2 == 3)
					break;
				else
					times2+=2;
				j++;
			}
			str+="&lanWlanCfg_BSSCoexistenceEnable_1.1.1.0.0="+get_checked_value(get_by_name('coexi'));
			param.url="get_set.ccp";
			param.arg=str;
			get_config_obj(param);
			return true;
		}else{
			return false;
		}
		return false;
	}
</script>

<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
      <td width="100%">&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx" onclick="return jump_if();"><script>document.write(model);</script></a></td>
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
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">		<tr>
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
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(_firewalls)</script></a></div></LI>
                            <LI><div><a href="adv_routing.asp" onclick="return jump_if();"><script>show_words(_routing)</script></a></div></LI>
							<LI><div id=sidenavoff><script>show_words(_adwwls)</script></div></LI>
							<LI><div><a href="adv_wps_setting.asp" onclick="return jump_if();"><script>show_words(LY2)</script></a></div></LI>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(_advnetwork)</script></a></div></LI>
                            <LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>
							<LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();"><script>show_words(if_iflist)</script></a></div></LI>
							<LI><div><a href="adv_ipv6_routing.asp" onclick="return jump_if();"><script>show_words(v6_routing)</script></a></div></LI>
                          </UL>
                       </div>
                      </td>
                    </tr>
                </table>
			</td>
		<form id="form1" name="form1" method="post" action="apply.cgi">
		<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
		<input type="hidden" id="html_response_message" name="html_response_message" value="">
		<script>get_by_id("html_response_message").value = get_words(sc_intro_sv);</script>
		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_wlan_perform.asp">
		<input type="hidden" id="wlan0_auto_txrate" name="wlan0_auto_txrate" value="">
		<input type="hidden" id="wlan0_wmm_enable" name="wlan0_wmm_enable" value="">
		<input type="hidden" id="wlan0_11d_enable" name="wlan0_11d_enable" value="">
		<input type="hidden" id="wlan0_partition" name="wlan0_partition" value="">
		<input type="hidden" id="wlan0_short_gi" name="wlan0_short_gi" value="">
		
		<td valign="top" id="maincontent_container">
			<!-- ######################### -->
			<!--          main part        -->
			<!-- ######################### -->
		<div id=maincontent>
			<div id=box_header>
				<h1><script>show_words(_advwls)</script></h1>
				<p><script>show_words(aw_intro)</script></p>
				<input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
				<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'adv_wlan_perform.asp');">
				<script>$("#button").val(get_words(_savesettings));</script>
				<script>$("#button2").val(get_words(_dontsavesettings));</script>
			</div>
			<br>

			<div class=box>
				<h2><script>show_words(aw_title_2)</script></h2>
				<table width=525>
				<tr>
					<td align=right class="duple"><script>show_words(wwl_band)</script> :</td>
					<td>&nbsp;<b><script>show_words(KR16)</script></b></td>
				</tr>
				<tr>
					<td width="183" align=right class="duple"><script>show_words(aw_TP)</script> :</td>
					<td width="330">
					<select id="wlan0_txpower" name="wlan0_txpower" size="1" >
						<option value="19"><script>show_words(aw_TP_0)</script></option>
						<option value="15"><script>show_words(aw_TP_1)</script></option>
						<option value="3"><script>show_words(aw_TP_2)</script></option>
					</select>
					</td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(KR4_ww)</script> :</td>
					<td><INPUT type="checkbox" id="wlan0_partition_sel" name="wlan0_partition_sel" value="1"></td>
				</tr>
				<tr>
					<td align=right class="duple"><script>show_words(aw_WE)</script> :</td>
					<td><INPUT name="wlan0_wmm_enable_sel" type="checkbox" id="wlan0_wmm_enable_sel" value="1"></td>
				</tr>
<!--				<tr>
					<td align=right class="duple"><script>show_words(aw_sgi)</script> :</td>
					<td><INPUT type="checkbox" id="wlan0_short_gi_sel" name="wlan0_short_gi_sel" value="1"></td>
				</tr>
-->				<tr>
					<td class="duple">
						<script>show_words(coexi)</script>:</td>
					<td width="340">
						<input type="radio" id="coexi1" name="coexi" value="1">
						<script>show_words(_enable)</script>
						<input type="radio" id="coexi0" name="coexi" value="0">
						<script>show_words(_disable)</script>
					</td>
				</tr>
				</table>
            </div>
			<div class=box>
				<h2><script>show_words(aw_title_2)</script></h2>
				<TABLE width=525>
				<tr> 
					<td align=right class="duple"><script>show_words(wwl_band)</script> :</td>
					<td>&nbsp;<b><script>show_words(KR17)</script></b></td>
				</tr>
				<tr> 
					<td width="183" align=right class="duple"><script>show_words(aw_TP)</script> :</td>
					<td width="330"> <select id="wlan1_txpower" name="wlan1_txpower" size="1" >
						<option value="19"><script>show_words(aw_TP_0)</script></option>
						<option value="15"><script>show_words(aw_TP_1)</script></option>
						<option value="3"><script>show_words(aw_TP_2)</script></option>
					</select> </td>
				</tr>
					<td align=right class="duple"><script>show_words(KR4_ww)</script> :</td>
					<td> <INPUT type="checkbox" id="wlan1_partition_sel" name="wlan1_partition_sel" value="1"> </td>
				</tr>
				<tr> 
					<td align=right class="duple"><script>show_words(aw_WE)</script> :</td>
					<td> <INPUT name="wlan1_wmm_enable_sel" type="checkbox" id="wlan1_wmm_enable_sel" value="1"> </td>
				</tr>
<!--				<tr> 
					<td align=right class="duple"><script>show_words(aw_sgi)</script> :</td>
					<td> <INPUT type="checkbox" id="wlan1_short_gi_sel" name="wlan1_short_gi_sel" value="1"> </td>
				</tr>
-->				</table>
			</div>

		</td>
            </form>
<td valign="top" width="150" id="sidehelp_container" align="left">
                <table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
	                   
          <td id=help_text><strong><b><strong>
            <script>show_words(_hints)</script>
					</strong></b>&hellip;</strong> <p><script>show_words(hhaw_1)</script></p>
					<p><script>show_words(hhaw_wmm)</script></p>
	                   
	                   <p class="more"><a href="support_adv.asp#Advanced_Wireless" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
	                   </TD>
                    </tr>
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
<div id="copyright"><script>show_words('_copyright');</script></div>
<br>
</body>
<script>
	onPageLoad();
	set_form_default_values("form1");
</script>
</html>
