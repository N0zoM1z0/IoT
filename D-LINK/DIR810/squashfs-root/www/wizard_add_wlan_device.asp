<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script type="text/javascript" src="uk.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');
	var from = getUrlEntry('from');

	var param = {
		url: "get_set.ccp",
		arg: ""
	};

	var j = 0;
	for (i=1;i<=4;i++){	
		param.arg +="&oid_"+(j+1)+"=IGD_LANDevice_i_WLANConfiguration_i_&inst_"+(j+1)+"=11"+i+"00";
		param.arg +="&oid_"+(j+2)+"=IGD_LANDevice_i_WLANConfiguration_i_WEP_&inst_"+(j+2)+"=11"+i+"10";
		param.arg +="&oid_"+(j+3)+"=IGD_LANDevice_i_WLANConfiguration_i_WEP_WEPKey_i_&inst_"+(j+3)+"=11"+i+"10";
		param.arg +="&oid_"+(j+4)+"=IGD_LANDevice_i_WLANConfiguration_i_WPS_&inst_"+(j+4)+"=11"+i+"10";
		param.arg +="&oid_"+(j+5)+"=IGD_LANDevice_i_WLANConfiguration_i_WPA_PSK_&inst_"+(j+5)+"=11"+i+"11";
		param.arg +="&oid_"+(j+6)+"=IGD_LANDevice_i_WLANConfiguration_i_WPA_&inst_"+(j+6)+"=11"+i+"10";
		j+=6;
	}

	param.arg += "&ccp_act=get&num_inst="+j;
	get_config_obj(param);	

	var wlan_enable = (config_str_multi("lanWlanCfg_Enable_")? config_str_multi("lanWlanCfg_Enable_"): "0");
	var wlan_ssid = (config_str_multi("lanWlanCfg_SSID_")? config_str_multi("lanWlanCfg_SSID_"): "");
	var wlan_secMode= (config_str_multi("lanWlanCfg_SecurityMode_")? config_str_multi("lanWlanCfg_SecurityMode_"): "0");
	var wlan_wepKeyIdx = (config_str_multi("wepInfo_KeyIndex_")? config_str_multi("wepInfo_KeyIndex_"): "1");
	var wlan_wepKeyType = (config_str_multi("wepInfo_KeyTypeForGUI_")? config_str_multi("wepInfo_KeyTypeForGUI_"): "1");

	var wlan_wepAuth= (config_str_multi("wepInfo_AuthenticationMode_")? config_str_multi("wepInfo_AuthenticationMode_"): "0");
	var wlan_wpaMode= (config_str_multi("wpaInfo_WPAMode_")? config_str_multi("wpaInfo_WPAMode_"): "0");
	var wlan_wpaAuth= (config_str_multi("wpaInfo_AuthenticationMode_")? config_str_multi("wpaInfo_AuthenticationMode_"): "0");
	var wlan_wpaKey = (config_str_multi("wpaPSK_KeyPassphrase_")? config_str_multi("wpaPSK_KeyPassphrase_"): "");
	
	var wlan_encType= (config_str_multi("wpaInfo_EncryptionMode_")? config_str_multi("wpaInfo_EncryptionMode_"): "0")
	
	var wlan_wepKeyLen= (config_str_multi("wepInfo_KeyLength_")? config_str_multi("wepInfo_KeyLength_"): "0");
	var wlan_wepKey64= config_str_multi("wepKey_KeyHEX64_");
	var wlan_wepKey128=config_str_multi("wepKey_KeyHEX128_");

	/**	Date:	2013-08-30
	 **	Author:	Silvia Chang
	 **	Reason:	TSD bug No.26118: Manual mode WPS
	 **	Note:	If WPS is disabled, even user key-in the page manually, do no display.
	 **/
	if (config_val("wpsCfg_Enable_") == 0)
	{
		var hasLogin = getCookie('hasLogin');  
		if (hasLogin == null || hasLogin == '0')
			location.replace("login.asp");
		else
			location.replace("wizard_wireless.asp");
	}

	var param = {
		url: "get_set.ccp",
		arg: ""
	};

	param.arg = "ccp_act=get&num_inst=4";
	for (i=1;i<=4;i++){
		param.arg +="&oid_"+i+"=IGD_LANDevice_i_WLANConfiguration_i_WPA_EAP_i_&inst_"+i+"=11"+i+"10";
	}
	get_config_obj(param);

	var wlan_eapKey = config_str_multi("wpaEap_RadiusServerPSK_");

	function onPageLoad()
	{
		var i = 0;
		var eap = 0;
		var wep = 0;
		for (i;i<4;)
		{
			if(wlan_secMode[i] == "0"){					//Disabled
				$('#secu_mode_'+i).html(get_words('_none'));
				$('#wep_'+i).hide();
				$('#wpa_'+i).hide();
			}else if(wlan_secMode[i] == "1"){						//WEP
				$('#wep_'+i).show();
				$('#wpa_'+i).hide();
				var default_key = wlan_wepKeyIdx[i];
				var key = new Array();
				if(wlan_wepKeyLen[i] == '0')
				{
					key[1] = wlan_wepKey64[wep+0];
					key[2] = wlan_wepKey64[wep+1];
					key[3] = wlan_wepKey64[wep+2];
					key[4] = wlan_wepKey64[wep+3];
				}
				else
				{
					key[1] = wlan_wepKey128[wep+0];
					key[2] = wlan_wepKey128[wep+1];
					key[3] = wlan_wepKey128[wep+2];
					key[4] = wlan_wepKey128[wep+3];
				}

				var displayWepKey = key[default_key];
				if(wlan_wepKeyType[i] == "1")
					displayWepKey = hex_to_a(displayWepKey);

				$('#show_wep_key_'+i).html("WEP KEY " + default_key + " : <strong>" + displayWepKey + "</strong>");
				if(wlan_wepAuth[i] == "0"){
					$('#secu_mode_'+i).html(get_words('_WEP')+" - "+get_words('_open'));
				}else if(wlan_wepAuth[i] == "1"){
					$('#secu_mode_'+i).html(get_words('_WEP')+" - "+get_words('bws_Auth_2'));
				}
				else if(wlan_wepAuth[i] == "2"){
					$('#secu_mode_'+i).html(get_words('_WEP')+" - "+get_words('_both'));
				}
			}else {	//WPA
				//alert(wlan_wpaMode);
				//alert(wlan_secMode);
				$('#wpa_'+i).show();
				$('#wpa_key_'+i).show();
				$('#wep_'+i).hide();
				if(wlan_wpaMode[i] == "2" && wlan_secMode[i] == "2"){		
					$('#secu_mode_'+i).html(get_words('_WPApersonal'));
				}else if(wlan_wpaMode[i] == "2" && wlan_secMode[i] == "3"){
					$('#secu_mode_'+i).html(get_words('_WPAenterprise'));
					$('#wpa_key_'+i).hide();
				}else if(wlan_wpaMode[i] == "1" && wlan_secMode[i] == "2"){
					$('#secu_mode_'+i).html("WPA2 - "+get_words('LW24'));
				}else if(wlan_wpaMode[i] == "1" && wlan_secMode[i] == "3"){
					$('#secu_mode_'+i).html("WPA2 - "+get_words('LW23'));
					$('#wpa_key_'+i).hide();
				}else if(wlan_wpaMode[i] == "0" && wlan_secMode[i] == "2"){
					$('#secu_mode_'+i).html(get_words('KR48'));
				}else if(wlan_wpaMode[i] == "0" && wlan_secMode[i] == "3"){
					$('#secu_mode_'+i).html(get_words('bws_WPAM_2')+" - "+get_words('LW23'));
					$('#wpa_key_'+i).hide();
				}
				if  (wlan_secMode[i] == "2")
					$('#show_wpa_key_'+i).html(sp_words(wlan_wpaKey[i]));
				else{
					var show_eap = wlan_eapKey[eap];
					if (wlan_eapKey[eap+1])
						show_eap+=","+wlan_eapKey[eap+1];
					$('#show_wpa_key_'+i).html(show_eap);
				}
			}
			eap +=2;
			wep +=4;
			i+=2;
		}

		show_tr();
	}

	function onOKClick()
	{
		if(from == 'adv')
			window.location.href = "adv_wps_setting.asp";
		else
			window.location.href = "wizard_wireless.asp";
	}

	function show_tr()	//20120920 Silvia add, chk wifi devices
	{
		for (i=0; i<4; i++)
		{
			if (wlan_enable[i] == 0)
				$('#tr_0' + i ).hide();
		}
	}
</script>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
	<td></td>
</tr>
<tr>
	<td>
	<div align=left>
		<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
		<tr>
			<td bgcolor="#FFFFFF"><div align=center>
			<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
				<tr>
					<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support"><script>document.write(dev_info.model);</script></a></td>
					<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
					<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<div align="center"><img src="wlan_masthead.gif" width="836" height="92" align="middle"></div>
			</td>
		</tr>
		</table>
	</div>
	</td>
</tr>
<tr>
	<td bgcolor="#FFFFFF"><p>&nbsp;</p>
	<table width="650" border="0" align="center">
	<tr>
		<td>

		<div class="box"> 
		<h2 align="left">
			<script>show_words(KR36)</script>
		</h2>

		<table align="center" width="94%" class="formarea" style="display:">
		<tr>
			<td class="box_msg"><script>show_words(wwl_intro_end)</script></td>
		</tr>

		<!--2.4G-->
		<tr id="tr_00">
			<td colspan="2" align="left"><br>
			<div class="box">
				<table align="center" border="0" cellpadding="20" cellspacing="0" width="90%">
				<tr>
					<td>
						<script>show_words(GW_WLAN_RADIO_0_NAME)</script>
						<script>show_words(help699)</script>: 
						<strong><script>document.write(sp_words(wlan_ssid[0]))</script></strong><br><br>
						<script>show_words(bws_SM)</script>: 
						<strong><span id="secu_mode_0"></span></strong><br><br>

						<div id="wpa_0" style="display:none">
							<script>show_words(bws_CT)</script>
							: <strong><font style="text-transform:uppercase;">
								<script>
								if(wlan_encType[0] == "0")
									document.write("TKIP");
								else if(wlan_encType[0] == "1")
									document.write("AES");
								else
									document.write("TKIP/AES");							
								</script>
							</font></strong><br><br>
						</div>
						<div  id="wpa_key_0" style="display:none">
							<script>show_words(LW25)</script>: 
							<strong><span id="show_wpa_key_0"></span></strong>
						</div>
						<div id="wep_0" style="display:none">
							<span id="show_wep_key_0"></span>
						</div>
					</td>
				</tr>
				</table>
			</div>
			</td>
		</tr>

		<!--2.4G guest zone	20111227 silvia add-->
		<!--
		**    Date:		2013-02-22
		**    Author:	Silvia Chang
		**    Note: 0019918: Setup-Wireless Settings, The Guest Zone information should not be displayed.
		-->
		<tr id="tr_01" style="display:none">
			<td colspan="2" align="left"><br>
			<div class="box">
			<table align="center" border="0" cellpadding="20" cellspacing="0" width="90%">
			<tr>
				<td>
					<script>show_words(_guestzone)</script>
					<script>show_words(help699)</script>: 
					<strong><script>document.write(sp_words(wlan_ssid[1]))</script></strong><br><br>
					<script>show_words(bws_SM)</script>: 
					<strong><span id="secu_mode_1"></span></strong><br><br>

					<div id="wpa_1" style="display:none">
						<script>show_words(bws_CT)</script>
						: <strong><font style="text-transform:uppercase;">
							<script>
							if(wlan_encType[1] == "0")
								document.write("TKIP");
							else if(wlan_encType[1] == "1")
								document.write("AES");
							else
								document.write("TKIP/AES");							
							</script>
						</font></strong><br><br>
					</div>
					<div id="wpa_key_1" style="display:none">
						<script>show_words(LW25)</script>: 
						<strong><span id="show_wpa_key_1"></span></strong>
					</div>
					<div id="wep_1" style="display:none">
						<span id="show_wep_key_1"></span>
					</div>
				</td>
			</tr>
			</table>
			</div>
			</td>
		</tr>

		<!--5G-->
		<tr id="tr_02">
			<td colspan="2" align="left"><br>
			<div class="box">
			<table align="center" border="0" cellpadding="20" cellspacing="0" width="90%">
			<tr>
				<td>
					<script>show_words(GW_WLAN_RADIO_1_NAME)</script>
					<script>show_words(help699)</script>: 
					<strong><script>document.write(sp_words(wlan_ssid[2]))</script></strong><br><br>
					<script>show_words(bws_SM)</script>: 
					<strong><span id="secu_mode_2"></span></strong><br><br>

					<div id="wpa_2" style="display:none">
						<script>show_words(bws_CT)</script>
						: <strong><font style="text-transform:uppercase;">
							<script>
							if(wlan_encType[2] == "0")
								document.write("TKIP");
							else if(wlan_encType[2] == "1")
								document.write("AES");
							else
								document.write("TKIP/AES");							
							</script>
						</font></strong><br><br>
					</div>
					<div  id="wpa_key_2" style="display:none">
						<script>show_words(LW25)</script>: 
						<strong><span id="show_wpa_key_2"></span></strong>
					</div>
					<div id="wep_2" style="display:none">
						<span id="show_wep_key_2"></span>
					</div>
				</td>
			</tr>
			</table>
			</div>
			</td>
		</tr>

		<!--5G guest zone-->
		<tr id="tr_03" style="display:none">
			<td colspan="2" align="left"><br>
			<div class="box">
			<table align="center" border="0" cellpadding="20" cellspacing="0" width="90%">
			<tr>
				<td>
					<script>show_words(_guestzone)</script>
					<script>show_words(help699)</script>: 
					<strong><script>document.write(sp_words(wlan_ssid[3]))</script></strong><br><br>
					<script>show_words(bws_SM)</script>: 
					<strong><span id="secu_mode_3"></span></strong><br><br>

					<div id="wpa_3" style="display:none">
						<script>show_words(bws_CT)</script>
						: <strong><font style="text-transform:uppercase;">
							<script>
							if(wlan_encType[3] == "0")
								document.write("TKIP");
							else if(wlan_encType[3] == "1")
								document.write("AES");
							else
								document.write("TKIP/AES");							
							</script>
						</font></strong><br><br>
					</div>
					<div  id="wpa_key_3" style="display:none">
						<script>show_words(LW25)</script>: 
						<strong><span id="show_wpa_key_3"></span></strong>
					</div>
					<div id="wep_3" style="display:none">
						<span id="show_wep_key_3"></span>
					</div>
				</td>
			</tr>
			</table>
			</div>
			</td>
		</tr>
		<!--end of silvia add-->

		<tr align="center">
			<td> 
				<input name="OK_b" id="OK_b" type="button" class=button_submit value="" onClick="onOKClick();">
				<script>$('#OK_b').val(get_words('_ok'));</script>&nbsp;
			</td>
		</tr>
		</table>
		</div>

		</td>
	</tr>
	</table>
	<p>&nbsp;</p></td>
</tr>
<tr>
	<td bgcolor="#FFFFFF"><table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
	<tr>
		<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
		<td width="10">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	</table>
	</td>
</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script></div>
</body>
<script>
	onPageLoad();
</script>
</html>