<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<style type="text/css">
<!--
.style4 {font-size: 10px}
-->
</style>
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
	function show_encryption(){
		get_by_id("asp_temp_34").value = ssid_decode("asp_temp_34");
		var security = get_by_id("asp_temp_35").value;
		get_by_id("show_disable").style.display = "none";
		get_by_id("show_wep").style.display = "none";
		get_by_id("show_wpa").style.display = "none";
		get_by_id("show_wpa2").style.display = "none";
		if (security == "1"){
			get_by_id("show_wep").style.display = "";
		}else if (security != "0"){			
			if (security == "3"){
				get_by_id("show_wpa2").style.display = "";
			}else{
				get_by_id("show_wpa").style.display = "";
			}
		}else{
			get_by_id("show_disable").style.display = "";
		}
	}
	
	function convert(data){
                data = ReplaceAll(data, "&#38;", "&");
                data = ReplaceAll(data, "&#160;", " ");
                data = ReplaceAll(data, '&#34;', '"');
                data = ReplaceAll(data, "&#39;", "'");
                data = ReplaceAll(data, "&#92;", "\\");
                return data;
        }
	
	function send_request(){
		var ssid = convert("<!--# echot asp_temp_34 -->");
		if("<!--# echo asp_temp_72 -->"  == "5G Mode") { // 5G Mode
			get_by_id("wlan0_radio_mode").value = "1";
			get_by_id("wlan1_ssid").value = ssid;
			get_by_id("wlan1_wep_display").value = "hex";
		}
		if("<!--# echo asp_temp_72 -->"  == "2.4G Mode") { // 2.4G Mode
			get_by_id("wlan0_radio_mode").value = "0";
			get_by_id("wlan0_ssid").value = ssid;
			get_by_id("wlan0_wep_display").value = "hex";
		}
		var wlan0_radio_mode = get_by_id("wlan0_radio_mode").value;
		var wlan0_op_mode = get_by_id("wlan0_op_mode").value;
		var security = "<!--# echo asp_temp_35 -->";

		if(wlan0_radio_mode == 0) {	// 2.4G Mode
			if(security == "0"){
				get_by_id("wlan0_security").value= "disable";
				get_by_id("wps_configured_mode").value = 1;
			}else if(security == "1"){
				var key_word = "<!--# echo asp_temp_72 -->";
				get_by_id("wlan0_wep_default_key").value= "1";
				if(key_word.length > 10){
					get_by_id("wlan0_security").value= "wep_open_128";
					if("<!--# echo asp_temp_36 -->" == "ascii"){
						get_by_id("wlan0_wep128_key_1").value= hex_to_a("<!--# echo asp_temp_37 -->");
					}else{
						get_by_id("wlan0_wep128_key_1").value= "<!--# echo asp_temp_72 -->";
					}
				}else{
					get_by_id("wlan0_security").value= "wep_open_64";
					if("<!--# echo asp_temp_36 -->" == "ascii"){
						get_by_id("wlan0_wep64_key_1").value= hex_to_a("<!--# echo asp_temp_37 -->");
					}else{
						get_by_id("wlan0_wep64_key_1").value= "<!--# echo asp_temp_37 -->";
					}
				}
				get_by_id("wlan0_wep_display").value= "<!--# echo asp_temp_36 -->";
				get_by_id("wps_configured_mode").value = 5;
			}else if(security == "2"){
				get_by_id("wlan0_security").value= "wpa_psk";
				get_by_id("wlan0_psk_pass_phrase").value= "<!--# echo asp_temp_37 -->";
				get_by_id("wlan0_psk_cipher_type").value= "both";
				get_by_id("wps_configured_mode").value = 5;	
			}else if(security == "3"){
				get_by_id("wlan0_security").value= "wpa2auto_psk";
				get_by_id("wlan0_psk_pass_phrase").value= "<!--# echo asp_temp_37 -->";
				get_by_id("wlan0_psk_cipher_type").value= "both";
				get_by_id("wps_configured_mode").value = 5;
			}else{
				alert(at_alert_wlan_msg0);
			}
		}

		if(wlan0_radio_mode == 1 && "<!--# echo 5g -->" === "1") {
			if(security == "0"){
				get_by_id("wlan1_security").value= "disable";
				get_by_id("wps_configured_mode").value = 1;
			}else if(security == "1"){
				var key_word = "<!--# echo asp_temp_37 -->";
				get_by_id("wlan1_wep_default_key").value= "1";
				if(key_word.length > 10){
					get_by_id("wlan1_security").value= "wep_open_128";
					if("<!--# echo asp_temp_36 -->" == "ascii"){
						get_by_id("wlan1_wep128_key_1").value= hex_to_a("<!--# echo asp_temp_37 -->");
					}else{
						get_by_id("wlan1_wep128_key_1").value= "<!--# echo asp_temp_37 -->";
					}
				}else{
					get_by_id("wlan1_security").value= "wep_open_64";
					if(get_by_id("asp_temp_36").value == "ascii"){
						get_by_id("wlan1_wep64_key_1").value= hex_to_a("<!--# echo asp_temp_37 -->");
					}else{
						get_by_id("wlan1_wep64_key_1").value= "<!--# echo asp_temp_37 -->";
					}
				}
				get_by_id("wlan1_wep_display").value= "<!--# echo asp_temp_36 -->";
				get_by_id("wps_configured_mode").value = 5;
			}else if(security == "2"){
				get_by_id("wlan1_security").value= "wpa_psk";
				get_by_id("wlan1_psk_pass_phrase").value= "<!--# echo asp_temp_37 -->";
				get_by_id("wlan1_psk_cipher_type").value= "both";
				get_by_id("wps_configured_mode").value = 5;	
			}else if(security == "3"){
				get_by_id("wlan1_security").value= "wpa2auto_psk";
				get_by_id("wlan1_psk_pass_phrase").value= "<!--# echo asp_temp_37 -->";
				get_by_id("wlan1_psk_cipher_type").value= "both";
				get_by_id("wps_configured_mode").value = 5;
			}else{
				alert(at_alert_wlan_msg0);
			}
		}

		if("<!--# echo asp_temp_36 -->"=="ascii"){
			get_by_id("asp_temp_37").value = hex_to_a("<!--# echo asp_temp_37 -->");
		}

		if ("<!--# echo wps_enable -->" === "1" && 
		  //  "<!--# echo wps_configured_mode -->" === "1" && 
		    get_by_id("wps_configured_mode").value === "5") {
				get_by_id("disable_wps_pin").value = "1";
		}

		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("html_response_return_page").value = "wizard_wireless.asp"
			get_by_id("wps_enable").value = 1;
			get_by_id("form1").submit();
			return;
		}
	}
	
	function wizard_cancel(){
		if (confirm (_wizquit)) {
			window.location.href="wizard_wireless.asp";
		}
	}
	function send_previous() {
                get_by_id("html_response_page").value = "wizard_wlan.asp";
		get_by_id("action").value="response_page";
                if(submit_button_flag == 0){
                        submit_button_flag = 1;
                        get_by_id("form1").submit();
		}
	}
	function go_back(){
		window.location.href = get_by_id("html_response_return_page").value;
	}

	function show_radio_mode(rmode){
		if ("<!--# echo 5g -->" === "1") {
			get_by_id(rmode).style.display="";
		}else{
			get_by_id(rmode).style.display="none";
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
<td bgcolor="#FFFFFF"><div align=center>
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
      <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
      <td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <div align="center"><img src="/wlan_masthead.gif" width="836" height="92" align="middle"></div></td>
</tr>
</table>
</div>
</td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>    
  <table width="650" border="0" align="center">
    <tr>
      <td><div class=box>
        <h2 align="left"><script>show_words(_setupdone);</script></h2>
        <div align="left">
          <p class="box_msg"><script>show_words(wwl_intro_end);</script></p>
          <form id="form1" name="form1" method="post" action="apply.cgi">
		<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
                <input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wireless.asp">
		<input type="hidden" id="action" name="action" value="wizard_wlan">
                <input type="hidden" id="reboot_type" name="reboot_type" value="all">
		<input type="hidden" id="asp_temp_34" name="asp_temp_34" value="<!--# echot asp_temp_34 -->">
		<input type="hidden" id="asp_temp_35" name="asp_temp_35" value="<!--# echo asp_temp_35 -->">
		<input type="hidden" id="asp_temp_36" name="asp_temp_36" value="<!--# echo asp_temp_36 -->">
		<input type="hidden" id="asp_temp_37" name="asp_temp_37" value="<!--# echo asp_temp_37 -->">
		<input type="hidden" id="asp_temp_50" name="asp_temp_50" value="<!--# echo asp_temp_50 -->">
		<input type="hidden" id="asp_temp_72" name="asp_temp_72" value="<!--# echo asp_temp_72 -->">
		<input type="hidden" id="wlan0_radio_mode" name="wlan0_radio_mode" value="<!--# echo wlan0_radio_mode-->">
		<input type="hidden" id="wlan0_op_mode" name="wlan0_op_mode" value="AP">
		<input type="hidden" id="wlan0_security" name="wlan0_security" value="<!--# echo wlan0_security -->">
		<input type="hidden" id="wlan0_ssid" name="wlan0_ssid" value="<!--# echot wlan0_ssid -->">
		<input type="hidden" id="wlan0_wep_default_key" name="wlan0_wep_default_key" value="<!--# echo wlan0_wep_default_key -->">
		<input type="hidden" id="wlan0_wep_display" name="wlan0_wep_display" value="<!--# echo wlan0_wep_display -->">
		<input type="hidden" id="wlan0_wep128_key_1" name="wlan0_wep128_key_1" value="<!--# echo wlan0_wep128_key_1 -->">
		<input type="hidden" id="wlan0_wep64_key_1" name="wlan0_wep64_key_1" value="<!--# echo wlan0_wep64_key_1 -->">
		<input type="hidden" id="wlan0_psk_pass_phrase" name="wlan0_psk_pass_phrase" value="<!--# echo wlan0_psk_pass_phrase -->">
		<input type="hidden" id="wlan0_psk_cipher_type" name="wlan0_psk_cipher_type" value="<!--# echo wlan0_psk_cipher_type -->">
		<input type="hidden" id="wlan1_security" name="wlan1_security" value="<!--# echo wlan1_security -->">
		<input type="hidden" id="wlan1_ssid" name="wlan1_ssid" value="<!--# echo wlan1_ssid -->">
		<input type="hidden" id="wlan1_wep_default_key" name="wlan1_wep_default_key" value="<!--# echo wlan1_wep_default_key -->">
		<input type="hidden" id="wlan1_wep_display" name="wlan1_wep_display" value="hex" value="<!--# echo wlan1_wep_display -->">
		<input type="hidden" id="wlan1_wep128_key_1" name="wlan1_wep128_key_1" value="<!--# echo wlan1_wep128_key_1 -->">
		<input type="hidden" id="wlan1_wep64_key_1" name="wlan1_wep64_key_1" value="<!--# echo wlan1_wep64_key_1 -->">
		<input type="hidden" id="wlan1_psk_pass_phrase" name="n1_wep128_key_1wlan1_psk_pass_phrase" value="<!--# echo wlan1_psk_pass_phrase -->">
		<input type="hidden" id="wlan1_psk_cipher_type" name="wlan1_psk_cipher_type" value="<!--# echo wlan1_psk_cipher_type -->">
		<input type="hidden" id="wps_configured_mode" name="wps_configured_mode">
		<input type="hidden" id="disable_wps_pin" name="disable_wps_pin" value="<!--# echo disable_wps_pin -->">
		<input type="hidden" id="wps_enable" name="wps_enable">
            <div>
              <div id=w2>
                <table width="650" align="center" class="formarea">
                  <tr id="show_disable" style="display:none">
                    <td class="duple"><script>show_words(wwl_wnn);</script>&nbsp;:</td>
                    <td>&nbsp;</td>
                    <td><!--# echo asp_temp_34 --></td>
                  </tr>
                  <tr id="show_wep" style="display:none">
                    <td colspan="3">

                      <table>
                        <tr id="wep_radio_mode">
                          <td class="duple"><script>show_words(wwz_wwl_rmode);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><!--# echo asp_temp_72 --></td>
                        </tr>
			<script>show_radio_mode("wep_radio_mode");</script>
                        <tr>
                          <td class="duple"><script>show_words(wwl_wnn);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><!--# echo asp_temp_34 --></td>
                        </tr>
                        <tr>
                          <td class="duple"><script>show_words(bws_WKL);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td>
                          	<script>
                          		var secu_length = get_by_id("asp_temp_50").value;
                          		document.write(key_num_array[secu_length]);
                          	</script>
                          	bits
                          </td>
                        </tr>
                        <tr>
                          <td class="duple"><script>show_words(wwl_DWKL);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td>1</td>
                        </tr>
                        <tr>
                          <td class="duple"><script>show_words(_auth);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><script>show_words(_open);</script></td>
                        </tr>
                        <tr id="summary_wep_tr">
                          <td class="duple"><script>show_words(wwl_WK);</script>&nbsp;:</td>
                          <td id="summary_wep_td">&nbsp;</td>
                          <td id="summary_wep_td">
			  <script>
				var show_word = get_by_id("asp_temp_37").value;
				if(get_by_id("asp_temp_35").value == "1"){
					if(get_by_id("asp_temp_36").value=="ascii"){
						 show_word = hex_to_a(get_by_id("asp_temp_37").value);
					}else if(get_by_id("asp_temp_36").value=="hex"){
						 show_word = get_by_id("asp_temp_37").value;
						}
				}
				document.write(show_word);
			  </script>
			  </td>
                        </tr>
                    </table>

		</td>
                  </tr>
                  <tr id="show_wpa" style="display:none">
                    <td colspan="3">

                      <table>
                        <tr id="wpa_radio_mode">
                          <td class="duple"><script>show_words(wwz_wwl_rmode);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><!--# echo asp_temp_72 --></td>
                        </tr>
			<script>show_radio_mode("wpa_radio_mode");</script>
                        <tr>
                        <tr>
                          <td class="duple"><script>show_words(wwl_wnn);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><!--# echo asp_temp_34 --></td>
                        </tr>
                        <tr>
                          <td class="duple"><script>show_words(bws_SM);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><script>show_words(bws_WPAM_1);</script></td>
                        </tr>
                        <tr>
                          <td class="duple"><script>show_words(bws_CT);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><script>show_words(bws_CT_3);</script></td>
                        </tr>
                        <tr>
                          <td class="duple"><script>show_words(help381);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><!--# echo asp_temp_37 --></td>
                        </tr>
                    </table>

		    </td>
                  </tr>
		  <tr id="show_wpa2" style="display:none">
                    <td colspan="3">

                      <table>
                        <tr id="wpa2_radio_mode">
                          <td class="duple"><script>show_words(wwz_wwl_rmode);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><!--# echo asp_temp_72 --></td>
                        </tr>
			<script>show_radio_mode("wpa2_radio_mode");</script>
                        <tr>
                          <td class="duple"><script>show_words(sd_NNSSID);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><!--# echo asp_temp_34 --></td>
                        </tr>
                        <tr>
                          <td class="duple"><script>show_words(bws_SM);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><script>show_words(KR48);</script></td>
                        </tr>
                        <tr>
                          <td class="duple"><script>show_words(bws_CT);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td><script>show_words(bws_CT_3);</script></td>
                        </tr>
                        <tr >
                          <td class="duple"><script>show_words(help381);</script>&nbsp;:</td>
                          <td>&nbsp;</td>
                          <td> <!--# echo asp_temp_37 --> </td>
                        </tr>
                    </table>

		    </td>
                  </tr>
                  <tr id="show_wpa2_auto" style="display:none">
		  <td colspan="3">&nbsp;</td>
                  </tr>
                </table>
                <div align="center"><br>
	    <input type="button" class="button_submit" id="prev_b" name="prev_b" value="" onClick="send_previous()">
	    <input type="submit" class="button_submit" id="save_b" name="save_b" value="" onClick="send_request();">
	    <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="" onClick="wizard_cancel();">
	    <script>
		get_by_id("prev_b").value=_prev;
		get_by_id("save_b").value=_save;
		get_by_id("cancel_b").value=_cancel;
	    </script>
                    <br>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div></td>
    </tr>
  </table>
    <p>&nbsp;</p></td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
    <tr>
      <td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
      <td width="10">&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table></td>
</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script></div>
</body>
<script>
	show_encryption();
</script>
</html>
