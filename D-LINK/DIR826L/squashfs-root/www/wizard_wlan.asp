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
<script language="JavaScript">
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');
	
	var	param = {
		url: "get_set.ccp",
		arg: 'ccp_act=get&num_inst=1'+
				'&oid_1=IGD_LANDevice_i_WLANConfiguration_i_&inst_1=11000'
	};
	
	get_config_obj(param);
	
	var pre_page = "";
	var key_str0 = "";
	var key_str1 = "";
	var ssid = config_str_multi("lanWlanCfg_SSID_");
	var ssid2 = config_val("lanWlanCfg_SecSsidEnable_");

	var submit_button_flag = 0;
	var auto_length = 5;

	function onPageLoad(){
		
		$('#same_wlan_pwd').attr('checked',parseInt(config_val("lanWlanCfg_SamePwdEnable_")));	
		$('#show_ssid_1').attr('checked',parseInt(config_val("lanWlanCfg_SecSsidEnable_")));
		
		if(ssid)
		{
			$('#show_ssid0').val(ssid[0]);
			if(ssid2 == 1)
				$('#show_ssid1').val(ssid[2]);
			else
				$('#show_ssid1').val(ssid[0]);
		}else{
			$('#show_ssid0').val("dlink");
			if(ssid2 == 1)
				$('#show_ssid1').val("dlink_media");
			else
				$('#show_ssid1').val("dlink");
		}
		set_form_default_values("form1");
		show_5g_ssid();			
		display_page("p1");
	}
	
	function mis_length(){
		var mis_length = 8;
		if(parseInt($('#asp_temp_35').val()) < 2){
			mis_length = 13;
		}
		return mis_length;
	}

	function max_length(){
		var max_length = 63;
		if(parseInt($('#asp_temp_35').val()) < 2){
			max_length = 26;
		}
		return max_length;
	}
	
	function check_key(key0,key1){
		var temp_key0 = key0;
		var temp_key1 = key1;
		var mis = mis_length();
		var max = max_length();
		$('#asp_temp_36').val("hex");
		$('#asp_temp_50').val("1");
		var chk_key = '';

		for (var i=0;i<=1;i++)
		{
			var key = (i == 0)?(key0):(key1);
			var temp_key = (i == 0)?(temp_key0):(temp_key1);
			chk_key = key.split('');
			
			/* 20120424 Removed by Jerry, Dlink ask to correct it
			//20120228 silvia add chk hex type
			for (i=0;i<chk_key.length;i++)
			{
				if(!check_hex(chk_key[i]))
				{
					alert(get_words("wifi_pass_chk"));
					return false;
				}
			}
			*/
			if(parseInt($('#asp_temp_35').val()) == 1){
				if(key.length != mis && key.length != max && key.length != 5 && key.length != 10){
					alert(get_words("IPV6_TEXT2"));
					return false;
				}else{
					if(key.length == 5){
						mis = key.length;
						max = 10;
						$('#asp_temp_50').val(0);
					}else if(key.length == 10){
						mis = 5;
						max = key.length;
						$('#asp_temp_50').val(0);
					}
					if(key.length == max){
						for (var j = 0; j < key.length; j++){
							if (!check_hex(key.substring(j, j+1))){
								alert(get_words("IPV6_TEXT2"));  
								return false;
							}
						}
					}else{
						$('#asp_temp_36').val("ascii");
						temp_key = a_to_hex($('#key'+i).val());
					}
				}
			}else if(parseInt($('#asp_temp_35').val()) > 1){
				if (key.length < mis){
					alert(get_words("IPV6_TEXT2"));  
					return false;
				}else if (key.length > max){
					if(!isHex(key)){
						alert(get_words("IPV6_TEXT2"));
						return false;
					}
				}
				temp_key = $('#key'+i).val();
			}
		}

		$('#passpharse_0').val(temp_key0);
		$('#passpharse_1').val(temp_key1);
		$('#asp_temp_37').val($('#passpharse_0').val());
		$('#asp_temp_38').val($('#passpharse_1').val());
	}

	function send_request(){
		var login_who=dev_info.login_info;
		if(login_who!= "w"){
			window.location.href ="user_page.asp";
			return false;
		}else{
			if (check_ssid_0("show_ssid0") && check_ssid_0("show_ssid1")){
				//get_by_id("asp_temp_34").value = get_by_id("show_ssid").value;
				get_by_id("asp_temp_35").value = 2;

				if(get_by_name("auto_next_page")[0].checked){
					get_by_id("asp_temp_37").value = get_auto_wepkey(auto_length);
					get_by_id("asp_temp_38").value = get_auto_wepkey(auto_length);
					window.location.href ="wizard_wlan2.asp";
				}
				get_by_id("html_response_page").value = get_checked_value(get_by_name("auto_next_page"));
				if(submit_button_flag == 0){
					submit_button_flag = 1;
					//send_submit("form1");
				}
			}
		}
	}
	
	function get_auto_wepkey(length){
		var pass_word=""
		var seed = parseInt(Math.random() * 100,10);
		for (i=0; i<length ;i++ ){
			seed = (214013 * seed) & 0xffffffff;
		    if(seed & 0x80000000)
		        seed = (seed & 0x7fffffff) + 0x80000000 + 0x269ec3;
		    else
		        seed = (seed & 0x7fffffff) + 0x269ec3;
		    temp = ((seed >> 16) & 0xff);
		    if(temp < 0x10){
		        pass_word += "0" + temp.toString(16).toLowerCase();
			}else{
		        pass_word += temp.toString(16).toLowerCase();
		    }
		}
		return pass_word;
	}

	function wizard_cancel(){
		if (!is_form_modified("mainform")) {
			if(!confirm(get_words("_wizquit"))) {
				return false;
			}
		}
		window.location.href="wizard_wireless.asp";
	}
	
	function display_page(page)
	{
		if(page == "p1")
		{
			$('#p1').show();
			$('#p2').hide();
			$('#p3').hide();
		}
		else if(page == "p2")
		{
			pre_page = "p1";
			$('#p1').hide();
			$('#p2').show();
			$('#p3').hide();

			$('#show_psk').show();
			//$('#show_wep').hide();
			//get_by_id("key0").size = "64";
			//get_by_id("key1").size = "64";
		}
		else if(page == "p3")
		{
			$('#p1').hide();
			$('#p2').hide();
			$('#p3').show();

			$('#wpa_ssid0').html(sp_words($('#show_ssid0').val()));
			$('#wpa_ssid1').html(sp_words($('#show_ssid1').val()));
			$('#wpa_psk_key0').html(key_str0);
			$('#wpa_psk_key1').html(key_str1);
//			$('#show_wep_3').hide();
			$('#show_wpa0').show();
			$('#show_wpa1').show();
		}
	}
	
	function next_page_from_p1()
	{
		if(!check_ssid_0("show_ssid0"))
			return;
		var ssid_en = $('#show_ssid_1').attr("checked")?1 : 0;
		if(ssid_en==1)
		{
			if(!check_ssid_0("show_ssid1"))
			return;
		}

		pre_page = "p1";
		$('#p1').hide();
		//$('#asp_temp_35').val(1);			//wep
		$('#asp_temp_36').val("hex");
		if(get_by_name("auto_next_page")[0].checked == true)
		{
			key_str0 = get_auto_wepkey(auto_length);
			key_str1 = get_auto_wepkey(auto_length);
			display_page("p3");
		}
		else if(get_by_name("auto_next_page")[1].checked == true)
		{
			display_page("p2");
		}
		get_by_id("asp_temp_35").value = 2;
	}
	
	function next_page_from_p2()
	{
		var wwl_ssp_en = $("#same_wlan_pwd").attr("checked")?1 : 0;
		if(wwl_ssp_en == 0)
		{
			var key0 = $('#key0').val();
			var key1 = $('#key1').val();
		}
		else
		{
			var key2 = $('#key2').val();
			
			$('#key0').val(key2);
			$('#key1').val(key2);
			$('#passpharse_0').val(key2);
			$('#passpharse_1').val(key2);
			
			var key0 = $('#key0').val();
			var key1 = $('#key1').val();
		}
		if(check_key(key0,key1) == false)
			return;
		
		key_str0 = $('#passpharse_0').val();
		key_str1 = $('#passpharse_1').val();
		pre_page = "p2";
		
		display_page("p3");

		//get_by_id("show_wep_3").style.display = "none";
		$('#show_wpa0').show();
		$('#show_wpa1').show();
	}
	
	function submit_wizard()
	{
		var wwl_ssp_en = $("#same_wlan_pwd").attr("checked")?1 : 0;
		var wwl_sse_en = $("#show_ssid_1").attr("checked")?1 : 0;
		var paramWizard = {
			url: "get_set.ccp",
			arg: 'ccp_act=set&ccpSubEvent=CCP_SUB_WIRELESS&nextPage=wizard_wireless.asp'
		};

		var i = 0;
		while( i<2 )
		{
			var inst = (i == 0)?('1.1.1.'):('1.1.3.');
			var key_str = (i == 0)?(key_str0):(key_str1);
			paramWizard.arg += "&lanWlanCfg_Enable_"+ inst +"0.0=1";
			paramWizard.arg += "&lanWlanCfg_SSID_"+ inst +"0.0="+urlencode($('#show_ssid'+i).val());
			paramWizard.arg += "&lanWlanCfg_SecurityMode_"+ inst +"0.0=2";
			paramWizard.arg += "&wpaInfo_WPAMode_"+ inst +"1.0=0";
			paramWizard.arg += "&wpaInfo_AuthenticationMode_"+ inst +"1.0=0";
			paramWizard.arg += "&wpaInfo_EncryptionMode_"+ inst +"1.0=2";
			paramWizard.arg += "&wpaPSK_KeyPassphrase_"+ inst +"1.1="+urlencode(key_str);
			paramWizard.arg += "&wpsCfg_Status_"+ inst +"1.0=1";
			//paramWizard.arg += "&wpsCfg_SetupLock_"+ inst +"1.0=1";
			paramWizard.arg += "&lanWlanCfg_SamePwdEnable_"+ inst +"0.0="+wwl_ssp_en;
			paramWizard.arg += "&lanWlanCfg_SecSsidEnable_"+ inst +"0.0="+wwl_sse_en;
			i++;
		}
		get_config_obj(paramWizard);
	}

	function use_same_pwd()
	{
		var wwl_ssp_en = $("#same_wlan_pwd").attr("checked")?1 : 0;
		if(wwl_ssp_en == 1)
		{
			$('#wl_wsp24').hide();
			$('#wl_wsp5').hide();
			$('#wl_ssp').show();
		}
		else
		{
			$('#wl_wsp24').show();
			$('#wl_wsp5').show();
			$('#wl_ssp').hide();
		}
	}

	function show_5g_ssid()
	{
		var ssid_en = $('#show_ssid_1').attr("checked")?1 : 0;
		var ssid1 = $('#show_ssid0').val();
		if(ssid_en == 1)
		{
			$('#ssid1').show();
			$('#show_ssid1').val(ssid[2]);
		}
		else
		{
			$('#ssid1').hide();
			$('#show_ssid1').val(ssid1);
		}
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">

<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
<td>
<div align=left>
<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
<td bgcolor="#FFFFFF">
<div align=center>
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(dev_info.model);</script></a></td>
      <td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
      <td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
      <td>&nbsp;</td>
    </tr>
  </table>
 <img src="wlan_masthead.gif" width="836" height="92" align="middle"> </div></td>
</tr>
</table>
</div>
</td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
  <p>&nbsp;</p>
  <table width="650" border="0" align="center">
    <tr>
      <td>
	  <div class="box" id="p1"> 
              <h2 align="left"> 
                <script>show_words(wwz_wwl_title_s3)</script>
              </h2>
              <div align="center"> 
                <p class="box_msg" align="left">
                  <script>show_words(wwz_wwl_intro_s3_1)</script>
                </p>
            </div>
				<form id="form1" name="form1" method="post" action="apply.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wlan1.asp">
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wlan.asp">
					<input type="hidden" id="reboot_type" name="reboot_type" value="none">
					
					<input type="hidden" id="asp_temp_34" name="asp_temp_34" value=''>
					<input type="hidden" id="asp_temp_35" name="asp_temp_35" value="">
					<input type="hidden" id="asp_temp_37" name="asp_temp_37" value="">
					<input type="hidden" id="asp_temp_38" name="asp_temp_38" value="">
					<input type="hidden" id="asp_temp_36" name="asp_temp_36" value="hex">
					<input type="hidden" id="asp_temp_50" name="asp_temp_50" value="1"><!--64, 128 bits-->
					
					<!-------------------------------->
					<!--    start of option page    -->
					<!-------------------------------->
					<table align="center" class=formarea style="display:">
	                <tr align="left">
	                  <td width="20">&nbsp;</td>
	                  <td colspan="2" class=form_label>
	                  	<div class="style1">
                        <strong><script>show_words(wwz_wwl_wnn)</script>&nbsp
						<script>show_words(GW_WLAN_RADIO_0_NAME)</script>:</strong> 
                        <input type="text" id="show_ssid0" name="show_ssid0" size="20" maxlength="32" value="">
	                    </div>
	                  </TD>
	                </tr>
			<!--20120109 silvia add 5g -->
	                <tr align="left">
	                  <td width="20"></td>
	                  <td colspan="2" class=form_label>
	                  	<div class="style1"> 
						<INPUT type="checkbox" id="show_ssid_1" name="show_ssid_1" onClick="show_5g_ssid();">
                        <script>show_words(manul_5g_ssid)</script>
                      </div>
	                  </TD>
	                </tr>
	                <tr align="left" id="ssid1">
	                  <td width="20">&nbsp;</td>
	                  <td colspan="2" class=form_label>
	                  	<div class="style1">
                        <strong><script>show_words(wwz_wwl_wnn)</script>&nbsp
						<script>show_words(GW_WLAN_RADIO_1_NAME)</script>:</strong> 
                        <input type="text" id="show_ssid1" name="show_ssid1" size="20" maxlength="32" value="">
	                    </div>
	                  </TD>
	                </tr>
			<!--20120109 end of silvia add -->
	                <tr align="left">
	                  <td width="20"><INPUT type="radio" id="auto_next_page" name="auto_next_page" value="wizard_wlan2.asp" checked></td>
	                  <td colspan="2" class=form_label>
	                  	<div class="style1">
                        <script>show_words(wwz_auto_assign_key3)</script>
                      </div>
	                  </TD>
	                </tr>
	                <tr align="left">
	                  <td width="20">&nbsp;</td>
	                  
                    <td colspan="2" class=form_label> <p>
                        <script>show_words(wwz_auto_assign_key2)</script>
                      </p>
	                  </TD>
	                </tr>
	                <tr align="left">
	                  <td width="20"><INPUT type="radio" id="auto_next_page" name="auto_next_page" value="wizard_wlan1.asp"></td>
	                  <td colspan="2" class=form_label>
	                  	<div class="style1">
                        <script>show_words(wwz_manual_key)</script>
                      </div>
	                  </TD>
	                </tr>
	                <tr align="left">
	                  <td width="20">&nbsp;</td>
	                  
                    <td colspan="2" class=form_label> <p>
                        <script>show_words(wwz_manual_key2)</script>
                      </p>
	                  </TD>
	                </tr>
					<tr>
					<td class="box_msg" colspan="3"><br>
                      <script>show_words(wwl_s3_note_2)</script>
                      <br></td>
					</tr>
	                <tr align="center">
	                  <td colspan="3">
                          <input type="button" class="button_submit" id="prev_b" name="prev_b" value="" onclick=window.location.href="wizard_wireless.asp"> 
                          <input type="button" class="button_submit" id="next_b" name="next_b" value="" onClick="next_page_from_p1();">
                          <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="" onclick="wizard_cancel();"> 
                          <!--
						  <input type="button" class="button_submit" id="save_b" name="save_b" value="" onClick="return send_request()"> 
						  -->
						<script>get_by_id("prev_b").value = get_words("_prev");</script>
						<script>get_by_id("next_b").value = get_words("_next");</script>
						<script>get_by_id("cancel_b").value = get_words("_cancel");</script>
						<!--<script>get_by_id("save_b").value = get_words("_save");</script>-->
						
	                  </TD>
	                </tr>
	              </table>		
				  <!------------------------------>
				  <!--    End of option page    -->	
				  <!------------------------------>				  
            	</form>				
      </div>
	  
		<div class=box id="p2"> 
                <h2 align="left">
                  <script>show_words(wwl_title_s4_2)</script>
                </h2>				
				<!-------------------------------->
				<!--       start of page 2      -->
				<!-------------------------------->
				<table align="center" class="formarea" summary="wizard wep" style="display:">
			  <tr>
			  	<td class="box_msg" colspan="2">
				<br>
                      <script>show_words(wwl_s4_intro)</script>
                      <br>
                      <br>
				</td>
			  </tr>
              <tr id="show_psk" style="display:none">
                    <td class="box_msg" colspan="2"> <span class="itemhelp" id="wlan_passwd_wpa">
                      <script>show_words(wwl_s4_intro_za1)</script>
                      </span><br>
                      <br>
                      <span class="itemhelp" id="wlan_passwd_wpa">
                      <script>show_words(wwl_s4_intro_za2)</script>
                      </span><br>
                      <br>
                      <span class="itemhelp" id="wlan_passwd_wpa">
                      <script>show_words(wwl_s4_intro_za3)</script>
                      </span><br>
                      <br>
				</td>
              </tr>

<!-- ignore by silvia 20120109
              <tr id="show_wep" style="display:none">
                    <td class="box_msg" colspan="2"> <span class="itemhelp" id="wlan_passwd_wep"> 
                      <script>show_words(wwl_s4_intro_z1)</script>
                      </span><br>
                      <br>
                      <span class="itemhelp" id="wlan_passwd_wep">
                      <script>show_words(wwl_s4_intro_z2)</script>
                      </span><br>
                      <br>
                      <span class="itemhelp" id="wlan_passwd_wep">
                      <script>show_words(wwl_s4_intro_z3)</script>
                      </span><br>
                      <br>
                      <span class="itemhelp" id="wlan_passwd_wep">
                      <script>show_words(wwl_s4_intro_z4)</script>
                      </span><br>
                      <br>
				</td>
              </tr>
-->
			<tr>
				<td align="center" colspan=2>
					<input type="checkbox" id="same_wlan_pwd" onClick="use_same_pwd();"><script>show_words("wwl_SSP")</script>
				</td>
			</tr>
			<tr id="wl_wsp24">
				<td class="duple" width="450">
					<strong><script>show_words(GW_WLAN_RADIO_0_NAME)</script>
					<script>show_words(wwl_WSP)</script></strong> 
					&nbsp;:&nbsp;</td>
				<td width="220">
					<input id="key0" name="key0" type="text" size="20" maxlength="64">
					<input type="hidden" id="passpharse_0" name="passpharse_0" maxlength="64">
				</td>
			</tr>
			<!--silvia add 5g band-->
			<tr id="wl_wsp5">
				<td class="duple" width="450">
					<strong><script>show_words(GW_WLAN_RADIO_1_NAME)</script>
					<script>show_words(wwl_WSP)</script></strong> 
					&nbsp;:&nbsp;</td>
				<td width="220">
					<input id="key1" name="key1" type="text" size="20" maxlength="64">
					<input type="hidden" id="passpharse_1" name="passpharse_1" maxlength="64">
				</td>
			</tr>
			<tr id="wl_ssp">
				<td class="duple" width="450">
					<strong><script>show_words(wwl_WSP)</script></strong>&nbsp;:&nbsp;
				</td>
				<td width="220">
					<input id="key2" name="key2" type="text" size="20" maxlength="64">
					<input type="hidden" id="passpharse_2" name="passpharse_2" maxlength="64">
				</td>
			</tr>
			  <tr>
				  <td class="box_msg" colspan="2">
				  <br>
                      <script>show_words(wwl_s4_note)</script>
                      <br>
                      <br>
				  </td>
			  </tr>
			  <tr>
			  	    <td colspan="2"> <p align="center"> 
                        <input type="button" class="button_submit" id="prev_b_2" name="prev_b_2" value="" onclick="display_page('p1')">
                        <input type="button" class="button_submit" id="next_b_2" name="next_b_2" value="" onClick="next_page_from_p2()">
                        <input type="button" class="button_submit" id="cancel_b_2" name="cancel_b_2" value="" onclick="wizard_cancel();">
                       	<script>get_by_id("prev_b_2").value = get_words("_prev");</script>
						<script>get_by_id("next_b_2").value = get_words("_next");</script>
						<script>get_by_id("cancel_b_2").value = get_words("_cancel");</script>
                      </p>
			  	</td>
			  </tr>
            </table>	
			</div>
			<!-------------------------------->
			<!--       End of page 2        -->
			<!-------------------------------->			
			
			<!-------------------------------->
			<!--      Start of page 3       -->
			<!-------------------------------->	
			<div class=box id="p3"> 
              <h2 align="left">
                <script>show_words(_setupdone)</script>
              </h2>
              <div align="left"> 
                <p class="box_msg">
                  <script>show_words(wwl_intro_end)</script>
                </p>
						
			<table width="650" border="0" align="center" class="formarea" style="display:">
<!-- ignore by silvia 20120109
			<tr id="show_disable" style="display:none">
                          <td class="duple">
                            <script>show_words(wwl_wnn)</script>
                            &nbsp;:</td>
                    <td width="263"></td>
                    <td width="10">&nbsp;</td>
                  </tr>
                  <tr id="show_wep_3" style="display:none">
                    <td colspan="3">
                      <table>
                        <tr>
                                <td class="duple">
                                  <script>show_words(wwl_wnn)</script>
                                  &nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><span id="wep_ssid"></span></td>
                        </tr>
                        <tr>
                                <td class="duple">
                                  <script>show_words(wwl_WKL)</script>
                                  &nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><span id="key_len"></span>bits</td>
                        </tr>
                        <tr>
                                <td class="duple">
                                  <script>show_words(wwl_DWKL)</script>
                                  &nbsp;:</td>
                          <td>&nbsp;</td>
                          <td>1</td>
                        </tr>
                        <tr>
                                <td class="duple">
                                  <script>show_words(_auth)</script>
                                  :</td>
                          <td>&nbsp;</td>
                                <td>
                                   2007.07.05
															 <script>show_words(_both)</script>
                                </td>
                        </tr>
                        <tr id="summary_wep_tr">
                                <td class="duple">
                                  <script>show_words(wwl_WK)</script>
                                  &nbsp;:</td>
                          <td id="summary_wep_td">&nbsp;</td>
                          <td id="summary_wep_td"><span id="wep_key"></span>
						  </td>
                        </tr>
                    </table></td>
                  </tr>
-->
				<!--2.4G-->
				<tr id="show_wpa0" style="display:none">
					<td colspan="3">
					<table align="center" border="1" cellpadding="4" cellspacing="2" width="90%" rules="none">
					<tr>
						<td class="duple">
						<script>show_words(GW_WLAN_RADIO_0_NAME)</script>
						<script>show_words(wwl_wnn)</script>
						&nbsp;:</td>
						<td>&nbsp;</td>
						<td align="left"><span id="wpa_ssid0"></span></td>
					</tr>
					<tr>
						<td class="duple">
						<script>show_words(bws_SM)</script>
						&nbsp;:</td>
						<td width="10">&nbsp;</td>
						<td width="277">
						<script>show_words(KR48)</script>
						</td>
					</tr>
					<tr>
						<td class="duple">
						<script>show_words(bws_CT)</script>
						&nbsp;:</td>
						<td>&nbsp;</td>
						<td>
						<script>show_words(bws_CT_3)</script>
						</td>
					</tr>
					<tr >
						<td class="duple">
						<script>show_words(_psk)</script>
						&nbsp;:</td>
						<td>&nbsp;</td>
						<td><span id="wpa_psk_key0"></span></td>
					</tr>
					</table></td>
				</tr>
				<tr id="show_wpa1_auto" style="display:none">
					<td colspan="3">&nbsp;</td>
				</tr>
				<!--5G-->
				<tr id="show_wpa1" style="display:none">
					<td colspan="3">
					<table align="center" border="1" cellpadding="4" cellspacing="2" width="90%" rules="none">
					<tr>
						<td class="duple">
						<script>show_words(GW_WLAN_RADIO_1_NAME)</script>
						<script>show_words(wwl_wnn)</script>
						&nbsp;:</td>
						<td>&nbsp;</td>
						<td align="left"><span id="wpa_ssid1"></span></td>
					</tr>
					<tr>
						<td class="duple">
						<script>show_words(bws_SM)</script>
						&nbsp;:</td>
						<td width="10">&nbsp;</td>
						<td width="277">
						<script>show_words(KR48)</script>
						</td>
					</tr>
					<tr>
						<td class="duple">
						<script>show_words(bws_CT)</script>
						&nbsp;:</td>
						<td>&nbsp;</td>
						<td>
						<script>show_words(bws_CT_3)</script>
						</td>
					</tr>
					<tr >
						<td class="duple">
						<script>show_words(_psk)</script>
						&nbsp;:</td>
						<td>&nbsp;</td>
						<td><span id="wpa_psk_key1"></span></td>
					</tr>
					</table></td>
				</tr>

				<tr>
					<td colspan="3">
						<div align="center">
							<input type="button" class="button_submit" id="prev_b_3" name="prev_b_3" value="" onClick="display_page(pre_page);">
							<input type="button" class="button_submit" id="save_b_3" name="save_b_3" value="" onClick="submit_wizard();">
							<input type="button" class="button_submit" id="cancel_b_3" name="cancel_b_3" value="" onclick="wizard_cancel();">
							<script>$('#prev_b_3').val(get_words("_prev"));</script>
							<script>$('#save_b_3').val(get_words("_save"));</script>
							<script>$('#cancel_b_3').val(get_words("_cancel"));</script>
						</div>
					</td>
				</tr>

                </table>
				</div>
			</div>
				<!-------------------------------->
				<!--       End of page 3        -->
				<!-------------------------------->	

	  </td>
    </tr>
  </table>
  <p>&nbsp;</p>
 </td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
    <tr>
      <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
      <td width="10">&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table></td>
</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script></div>
<script>onPageLoad();use_same_pwd();</script>
</body>
</html>