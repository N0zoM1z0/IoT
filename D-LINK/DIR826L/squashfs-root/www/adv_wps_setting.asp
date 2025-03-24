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
<script language="JavaScript">
	var dev_info = get_router_info();

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;
	var param = {
			url: "get_set.ccp",
			arg: ""
	};
	param.arg = "ccp_act=get&num_inst=10";
	param.arg += "&oid_1=IGD_LANDevice_i_WLANConfiguration_i_WPS_&inst_1=11110";
	param.arg += "&oid_2=IGD_LANDevice_i_WLANConfiguration_i_&inst_2=11000";
	param.arg += "&oid_3=IGD_LANDevice_i_WLANConfiguration_i_WEP_&inst_3=11110";
	param.arg += "&oid_4=IGD_LANDevice_i_WLANConfiguration_i_WPA_&inst_4=11110";
	param.arg += "&oid_5=IGD_LANDevice_i_WLANConfiguration_i_WPA_PSK_&inst_5=11111";
	param.arg += "&oid_6=IGD_LANDevice_i_WLANConfiguration_i_WEP_WEPKey_i_&inst_6=11110";
	param.arg += "&oid_7=IGD_LANDevice_i_WLANConfiguration_i_WPA_&inst_7=11210";
	param.arg += "&oid_8=IGD_LANDevice_i_WLANConfiguration_i_WPA_&inst_8=11310";
	param.arg += "&oid_9=IGD_LANDevice_i_WLANConfiguration_i_WPA_&inst_9=11410";
	param.arg += "&oid_10=IGD_LANDevice_i_WLANConfiguration_i_WPS_&inst_10=11310";
	
	get_config_obj(param);

	var submit_button_flag = 0;
	var radius_button_flag = 0;
	var radius_button_flag_1 = 0;

	var current_pin = (config_val("wpsCfg_SelfPINNumber_")? config_val("wpsCfg_SelfPINNumber_"):"");
	var wlan_enable = (config_str_multi("lanWlanCfg_Enable_")? config_str_multi("lanWlanCfg_Enable_"): "0");
	var wlan_secMode = (config_str_multi("lanWlanCfg_SecurityMode_")? config_str_multi("lanWlanCfg_SecurityMode_"): "0");
	var wlan_wepKeyIdx = (config_val("wepInfo_KeyIndex_")? config_val("wepInfo_KeyIndex_"): "1");
	var wlan_wepAuth= (config_val("wepInfo_AuthenticationMode_")? config_val("wepInfo_AuthenticationMode_"): "0");
	var wlan_wpaAuth= (config_val("wpaInfo_AuthenticationMode_")? config_val("wpaInfo_AuthenticationMode_"): "0");
	var wlan_ssidBst= (config_str_multi("lanWlanCfg_BeaconAdvertisementEnabled_")? config_str_multi("lanWlanCfg_BeaconAdvertisementEnabled_"): "0");

	var wps_enable = (config_val("wpsCfg_Enable_")? config_val("wpsCfg_Enable_"): "0");
	var wps_state = (config_val("wpsCfg_Status_")? config_val("wpsCfg_Status_"): "0");	//only use status [0] for chk wps status

	var wps_locked = (config_str_multi("wpsCfg_SetupLock_")? config_str_multi("wpsCfg_SetupLock_"): "0");
	var encrMode = (config_str_multi("wpaInfo_EncryptionMode_")? config_str_multi("wpaInfo_EncryptionMode_"): "0");
	var wpaMode = (config_str_multi("wpaInfo_WPAMode_")?config_str_multi("wpaInfo_WPAMode_"):"0");

	function onPageLoad(){
		set_checked(wps_enable, get_by_id("wpsEnable"));
		set_checked(wps_state, get_by_name("config"));
		
		if ((wps_locked[0] == 1) || (wps_locked[1] == 1))
			set_checked(1, get_by_id("wpsLock"));
		else
			set_checked(0, get_by_id("wpsLock"));
		
		show_buttons();
		isenable();
		//remove_unconfigured();
		
		if(wlan_enable[0] == "0" && wlan_enable[2] == "0"){
			DisableEnableForm(form1,true);
		}

		var login_who= login_Info;
		if(login_who!= "w"){
			DisableEnableForm(form1,true);	
		}
	}

	function send_request()
	{
		//20120111 silvia add check wps enabled/disabled
		if (((wlan_secMode[0] == 1 || wlan_secMode[0] == 3 || encrMode[0] == 0 ||
			wlan_secMode[2] == 1 || wlan_secMode[2] == 3 || encrMode[2] == 0) &&
			(!((encrMode[0] == 0 && wpaMode[0] == 1) ||
			(encrMode[2] == 0 && wpaMode[2] == 1) ||
			(encrMode[0] == 1 && wpaMode[0] == 2) ||
			(encrMode[2] == 1 && wpaMode[2] == 2)))) ||
			((wlan_secMode[0] == 2 && wpaMode[0] == 2) ||
			(wlan_secMode[2] == 2 && wpaMode[2] == 2))
			)
		{
			if(!((wlan_secMode[0]==0) || wlan_secMode[2]==0)){
			alert(get_words(notify_wps));
			return false;
			}
		}

		//return to same page by Vic
			//return;

		//if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
		var wpsEnable_value = get_checked_value(get_by_id("wpsEnable"));
		var Lock_value = get_checked_value(get_by_id("wpsLock"));
		if (!is_wps_modified()) {
			if (!confirm(get_words(_ask_nochange))) {
				return false;
			}
		}

		if(!(ischeck_wps("auto"))){
				return false;
		}

		//if(security[1] == "eap" ||security1[1] == "eap" || vap1_security[1] == "eap"  || vap1_security1[1] == "eap" ){				//EAP
		if(((wlan_secMode[0] == "2") || (wlan_secMode[0] == "3")) && (wlan_wpaAuth == "1")){
			alert(get_words(TEXT026));
			return false;
		}

		//if(security[1] == "share" ||security1[1] == "share" || vap1_security[1] == "share"  || vap1_security1[1] == "share" ){				//EAP
		if((wlan_secMode[0] == "1") && (wlan_wepAuth == "1")){
			alert(get_words(_wps_albert_1));
			return false;
		}

		if((wlan_wepKeyIdx != "1") && (wlan_secMode[0] == "1")){
			alert(get_words(TEXT024));//Can't choose WEP key 2, 3, 4 when WPS is enable
			return false;
		}

		<!--save Wi-Fi value-->	
		get_by_id("wps_lock").value = get_checked_value(get_by_id("wpsLock"));
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;

		var param = {
			url: 	"get_set.ccp",
			arg: 	"ccp_act=set&ccpSubEvent=CCP_SUB_WIRELESS&nextPage=adv_wps_setting.asp"
		};
			param.arg += "&wpsCfg_Enable_1.1.1.1.0="+wpsEnable_value;
			param.arg += "&wpsCfg_Enable_1.1.3.1.0="+wpsEnable_value;
			param.arg += "&wpsCfg_SelfPINNumber_1.1.1.1.0="+$('#wps_pin').val();
			param.arg += "&wpsCfg_SelfPINNumber_1.1.3.1.0="+$('#wps_pin').val();		
			param.arg += "&wpsCfg_SetupLock_1.1.1.1.0="+get_checked_value(get_by_id("wpsLock"));
			param.arg += "&wpsCfg_SetupLock_1.1.3.1.0="+get_checked_value(get_by_id("wpsLock"));

			get_config_obj(param);
			return true;
		}else{
			return false;
		}
		
	}

	function is_wps_modified(){ //check wps change or not, false:not change, true:change
		var wpsEnable_value = get_checked_value(get_by_id("wpsEnable"));

		if((wpsEnable_value == wps_enable) && 
		   (get_by_id("show_wps_pin").innerHTML == current_pin)){
			return false;
		}else{
			return true;
		}
	}

	function isenable()
	{	//20120503 silvia add modify act of sec
		//wlan_secMode --> WEP PSK EAP	encrMode--> TKIP AES
		if (wlan_secMode[0] != 0 || wlan_secMode[2] != 0)
		{
			if (wlan_secMode[0] == 1 || wlan_secMode[0] == 3 || wlan_secMode[2] == 1 || wlan_secMode[2] == 3)
				get_by_id("wpsEnable").disabled = true;
			else if ((wlan_secMode[0] == 2 && (encrMode[0] == 0 || wpaMode[0] == 2))
			|| (wlan_secMode[2] == 2 && (encrMode[2] == 0 || wpaMode[2] == 2)))
				get_by_id("wpsEnable").disabled = true;
			else
				get_by_id("wpsEnable").disabled = false;
		}else{
			get_by_id("wpsEnable").disabled = false;
		}

/*
		if (((wlan_secMode[0] == 0 || wlan_secMode[0] == 2) && encrMode[0] != 0) &&
			((wlan_secMode[2] == 0 || wlan_secMode[2] == 2) && encrMode[2] != 0) ||
			(encrMode[0] == 0 && wpaMode[0] == 1) ||
			(encrMode[2] == 0 && wpaMode[2] == 1) ||
			(encrMode[0] == 1 && wpaMode[0] == 2) ||
			(encrMode[2] == 1 && wpaMode[2] == 2))
			get_by_id("wpsEnable").disabled = false;
		else
			get_by_id("wpsEnable").disabled = true;
*/

			if ((wlan_ssidBst[0] == 0) || (wlan_ssidBst[2] == 0))
			get_by_id("wpsEnable").disabled = true;
	}
	
	// for WPS function
	function show_buttons(){
		var enable = get_by_id("wpsEnable");
		var isenable = enable.checked;
		if(!enable.checked){
			get_by_id("show_wps_pin").innerHTML = current_pin;
		//}else if(get_by_id("wps_pin").value == "00000000" && get_by_id("wpsEnable").checked){
		}else if(current_pin == "00000000" && get_by_id("wpsEnable").checked){
			//get_by_id("wps_pin").value = get_by_id("wps_default_pin").value;
			get_by_id("show_wps_pin").innerHTML = current_pin;
		}
		get_by_id("wps_pin").value = current_pin;
		get_by_id("reset_pin").disabled = !isenable;
		get_by_id("generate_pin").disabled = !isenable;
		get_by_id("wps_wizard").disabled = !isenable;
		get_by_id("wpsLock").disabled = !isenable;

		if(wps_state != "1")
		{
			get_by_id("reset_to_unconfigured").disabled = true;
		}
		if($("#wpsLock").is(":checked"))
			lock();
	}
/*	
	//20120709 pascal add when SSID is default then remove the button
	function remove_unconfigured()
	{
		var param = {
			'url': 	'get_set.ccp',
			'arg': 	'&oid_1=IGD_Status_LANStatus_&inst_1=11000' +
					'&oid_2=IGD_LANDevice_i_WLANConfiguration_i_&inst_2=11100'
		};
		param.arg +='&ccp_act=get&num_inst=2';
		get_config_obj(param);
		
		var lan_mac = config_val('igdLanStatus_MACAddress_').split(":");
		var def_SSID = config_str_multi("lanWlanCfg_SSID_")[0];
		var chk_SSID = 'dlink-' +lan_mac[4] +lan_mac[5];
		
		if(def_SSID == chk_SSID)
			$('#set_unconfigured').hide();
		else
			$('#set_unconfigured').show();
	}
*/
	function lock(){
		var wpsLock = get_by_id("wpsLock").checked;
		$('#generate_pin').attr('disabled',wpsLock);
		$('#reset_pin').attr('disabled',wpsLock);
	}

	function set_pinvalue(obj_value){
		var param = {
			url: 	"get_set.ccp",
			arg: 	"ccp_act=set&ccpSubEvent=CCP_SUB_WIRELESS&nextPage=adv_wps_setting.asp"
		};
			param.arg += "&wpsCfg_SelfPINNumber_1.1.1.1.0=''";
			param.arg += "&wpsCfg_SelfPINNumber_1.1.3.1.0=''";	
			
		get_config_obj(param);
	}

	function compute_pin_checksum(val)
	{
		var accum = 0; 
		var code = parseInt(val)*10;

		accum += 3 * (parseInt(code / 10000000) % 10); 
		accum += 1 * (parseInt(code / 1000000) % 10); 
		accum += 3 * (parseInt(code / 100000) % 10); 
		accum += 1 * (parseInt(code / 10000) % 10);
		accum += 3 * (parseInt(code / 1000) % 10);
		accum += 1 * (parseInt(code / 100) % 10);
		accum += 3 * (parseInt(code / 10) % 10); 
		accum += 1 * (parseInt(code / 1) % 10); 
		var digit = (parseInt(accum) % 10);
		return ((10 - digit) % 10);
	}

	function genPinClicked()
	{
		var num_str="1";
		var rand_no;
		var num;

		while (num_str.length != 7) {
			rand_no = Math.random()*1000000000; 
			num = parseInt(rand_no, 10);
			num = num%10000000;
			num_str = num.toString();
		} 
		num = num*10 + compute_pin_checksum(num);
		num = parseInt(num, 10);
		get_by_id("wps_pin").value = num;
		get_by_id("show_wps_pin").innerHTML = num;
	}

	function Unconfigured_button(){	//20120102 silvia modify
		if(!confirm(get_words(wps_reboot_need)))
			return;
			
		var paramRestore = {
			url: 	"get_set.ccp",
			arg: 	"ccpSubEvent=CCP_SUB_WIRELESS_RESETOOB&nextPage=adv_wps_setting.asp"
		};

		var k = 0;
		var counts = 0;
		for (var inst=1;inst <=4;inst++)
		{
			paramRestore.arg +="&oid_" + (k+1) + "=IGD_LANDevice_i_WLANConfiguration_i_&inst_" + (k+1) + "=11" + inst + "00";
			paramRestore.arg +="&oid_" + (k+2) + "=IGD_LANDevice_i_WLANConfiguration_i_BridgeSetting_&inst_" + (k+2) + "=11" + inst + "10";
			paramRestore.arg +="&oid_" + (k+3) + "=IGD_LANDevice_i_WLANConfiguration_i_WEP_&inst_" + (k+3) + "=11" + inst + "10";
			paramRestore.arg +="&oid_" + (k+4) + "=IGD_LANDevice_i_WLANConfiguration_i_WPA_&inst_" + (k+4) + "=11" + inst + "10";
			paramRestore.arg +="&oid_" + (k+5) + "=IGD_LANDevice_i_WLANConfiguration_i_WPA_PSK_&inst_" + (k+5) + "=11" + inst + "10";
			paramRestore.arg +="&oid_" + (k+6) + "=IGD_LANDevice_i_WLANConfiguration_i_WPA_EAP_i_&inst_" + (k+6) + "=11" + inst + "11";
			paramRestore.arg +="&oid_" + (k+7) + "=IGD_LANDevice_i_WLANConfiguration_i_WPA_EAP_i_&inst_" + (k+7) + "=11" + inst + "12";
			paramRestore.arg +="&oid_" + (k+8) + "=IGD_LANDevice_i_WLANConfiguration_i_WPS_&inst_" + (k+8) + "=11" + inst + "10";
			
			counts = k+8;
			for (var ii = 1; ii<=8; ii++){
				paramRestore.arg +="&oid_" + (counts+ii) + "=IGD_LANDevice_i_WLANConfiguration_i_BridgeSetting_RemoteMAC_i_&inst_" + (counts+ii) + "=11" + inst + ii +"0";
			}
			counts +=ii-1; 
			for (var ii = 1; ii<=4; ii++){
				paramRestore.arg +="&oid_" + (counts+ii) + "=IGD_LANDevice_i_WLANConfiguration_i_WEP_WEPKey_i_&inst_" + (counts+ii) + "=11" + inst + ii +"0";
			}
			k = counts + ii-1;
		}
		paramRestore.arg +="&ccp_act=restoreObj&num_inst=" + k;
		get_config_obj(paramRestore);

		//20120312 silvia add when click unconfig PinLock use value original
		if ((wps_locked[0] == 1) || (wps_locked[1] == 1))
		{
			var paramForm = {
				url: "get_set.ccp",
				arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_WIRELESS&nextPage=wireless.asp'
			};
			paramForm.arg += "&wpsCfg_SetupLock_1.1.1.1.0=1";
			paramForm.arg += "&wpsCfg_SetupLock_1.1.3.1.0=1";

			get_config_obj(paramForm);
		}
	}

	function ischeck_wps(obj){
		var is_true = false;
		if(get_by_id("wpsEnable").checked){
			if(wlan_enable == "0"){
				alert(TEXT028);
				is_true = true;
			}
		}
		if(is_true){
			if(obj == "wps"){
				get_by_id("wpsEnable").checked = false;
			}
			return false;
		}
		return true;
	}

	function toWPSWizard()
	{
		if(wps_enable == '0')
		{
			//alert("開啟WI-FI保戶安裝設定尚未儲存，請先保存設定!");
			return;
		}
		window.location.href='wps_wifi_setup.asp?from=adv';	
	}

</script>

<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
<tr>
	<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx" onclick="return jump_if();"><script>document.write(model);</script></a></td>
	<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(hw_version);</script> &nbsp;</td>
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
        <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
        <tr>
          <td id="sidenav_container" valign="top" width="125" align="right">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td id="sidenav_container">
                            <div id="sidenav">
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
								<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(_adwwls)</script></a></div></LI>
								<LI><div id=sidenavoff><script>show_words(LY2)</script></div></LI>
								<LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(_advnetwork)</script></a></div></LI>
								<LI><div><a href="guest_zone.asp" onclick="return jump_if();"><script>show_words(_guestzone)</script></a></div></LI>
								<LI><div><a href="adv_ipv6_firewall.asp" onclick="return jump_if();">IPv6 Firewall</a></div></LI>
								<LI><div><a href="adv_ipv6_routing.asp" onclick="return jump_if();">IPv6 Routing</a></div></LI>
                          </UL>
                            </div>
                        </td>
                    </tr>
                </table>
			</td>
		
		<form id="form1" name="form1" method="post" action="apply.cgi">
		<input type="hidden" id="wps_default_pin" name="wps_default_pin" value="">
		<input type="hidden" id="wps_generate_pin" name="wps_generate_pin" value="">

		<input type="hidden" id="wlan0_enable" name="wlan0_enable" value="">
		<input type="hidden" id="wps_pin" name="wlan0_short_gi" value="">
		<input type="hidden" id="wps_configured_mode" name="wps_configured_mode" value="">

              <td valign="top" id="maincontent_container">
                <div id="maincontent">
                  <div id="box_header">
                        <h1><script>show_words(LY2)</script> </h1>
                        <p><script>show_words(LY3)</script></p>
				<input name="button" id="button" type="button" class=button_submit value="" onClick="return send_request()">
                        <input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'adv_wps_setting.asp');">
				<script>$('#button').val(get_words(_savesettings));</script>
				<script>$('#button2').val(get_words(_dontsavesettings));</script>
                    </div>
                    <div class="box">
                    <h2><script>show_words(LW4)</script></h2>

          <table cellSpacing=1 cellPadding=1 width=525 border=0>
            <tr>
              <td class="duple">
                  <script>show_words(_enable)</script> :</td>
              <td width="340">&nbsp; <input name="wpsEnable" type=checkbox id="wpsEnable" value="1" onClick="show_buttons();">
						<input type="hidden" id="wps_enable" name="wps_enable" value=""> 
              </td>
            </tr>
            <tr>
              <td class="duple">
                 <script>show_words(LW6_1)</script> :</td>
              <td>&nbsp; <input name="wpsLock" type="checkbox" id="wpsLock" value="1" onclick="lock();">
						<input type="hidden" id="wps_lock" name="wps_lock" value=""> 
            </tr>
			</table>
			<table id="set_unconfigured" style="display:none">
            <tr>
              <td class="duple">&nbsp;</td>
              <td>&nbsp;
                <input type="button" name="reset_to_unconfigured" id="reset_to_unconfigured" value="" onClick="Unconfigured_button();"></td>
					<script>$('#reset_to_unconfigured').val(get_words(resetUnconfiged));</script>
            </tr>
			</table>
                    </div>
                    <div class="box">
                        <h2><script>show_words(LY5)</script></h2>

          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr>
              <td class="duple"><script>show_words(LW9)</script> :</td>
              <td>&nbsp;&nbsp;<span id="show_wps_pin">
							<script>document.write(current_pin);</script>
                </span></td>
            </tr>
            <tr>
              <td class="duple">&nbsp;</td>
              <td width="340">&nbsp;
                <!--input type="button" name="generate_pin" id="generate_pin" value="Generate New PIN" onclick='set_pinvalue(get_by_id("wps_generate_pin").value);'-->
                <input type="button" name="generate_pin" id="generate_pin" value="" onclick='genPinClicked();'>
                <input type="button" name="reset_pin" id="reset_pin" value="" onclick='set_pinvalue(get_by_id("wps_default_pin").value);'></td>
						<script>$('#generate_pin').val(get_words(LW11));</script>
						<script>$('#reset_pin').val(get_words(LW10));</script>
            </tr>

          </table>
                    </div>
                            <div class="box">
                        <h2><script>show_words(LY10)</script></h2>
          <br>

          <table cellpadding="1" cellspacing="1" border="0" width="525">
            <tr>
              <td class="duple">&nbsp;</td>
					<td width="340">&nbsp;<input name="wps_wizard" id="wps_wizard" type="button" class="button_submit" value="" onClick="toWPSWizard();"></td>
					<script>$('#wps_wizard').val(get_words(LW13));</script>
            </tr>
          </table>
                </div>

                    </form>
            <td valign="top" width="150" id="sidehelp_container" align="left">
                <table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                  <tbody>
                    <tr>
                        <td id=help_text><strong><script>show_words(_hints)</script></strong></b>&hellip;</strong>
                        <p><script>show_words(LW14)</script></p>
                        <p><script>show_words(LW15)</script></p>
 <!--                       <p><script>show_words(LW16)</script></p>	-->
                        <p><script>show_words(LW17)</script></p><p><a href="support_adv.asp#Protected_Setup" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                        </td>
                    </tr>
                  </tbody>
                </table>
            </td>
        </tr>
    </table>
    <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
        <tr>
            <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
            <td width="10">&nbsp;</td>
            <td>&nbsp;</td>
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
