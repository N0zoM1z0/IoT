<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
/*
 * Styles used only on this page.
 * WAN mode radio buttons
 */
#wan_modes p {
	margin-bottom: 1px;
}
#wan_modes input {
	float: left;
	margin-right: 1em;
}
#wan_modes label.duple {
	float: none;
	width: auto;
	text-align: left;
}
#wan_modes .itemhelp {
	margin: 0 0 1em 2em;
}

/*
 * Wizard buttons at bottom wizard "page".
 */
#wz_buttons {
	margin-top: 1em;
	border: none;
}
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="Javascript">
var submit_button_flag = 0;
	function loadSettings(){
		//set_checked(get_by_id("select_isp").value, get_by_name("wan_type"));
		set_checked("<!--# echo wan_proto -->", get_by_name("wan_type"));
		set_form_default_values("form1");
	}
	
	function select_wan_type(){
		set_checked(get_by_id("select_isp").value, get_by_name("wan_type"));
	}
	
	function send_request(){
		get_by_id("asp_temp_02").value = get_checked_value(get_by_name("wan_type"));
		
		if (get_by_id("asp_temp_02").value == "static"){
			get_by_id("html_response_page").value = "wizard_wan4b.asp";			
		}else if (get_by_id("asp_temp_02").value == "pppoe"){
			get_by_id("html_response_page").value = "wizard_wan4c.asp";
		}else if (get_by_id("asp_temp_02").value == "pptp"){
			get_by_id("html_response_page").value = "wizard_wan4d.asp";
		}else if (get_by_id("asp_temp_02").value == "l2tp"){
			get_by_id("html_response_page").value = "wizard_wan4e.asp";
		}else if (get_by_id("asp_temp_02").value == "bigpond"){
			get_by_id("html_response_page").value = "wizard_wan4f.asp";
		}
		if(get_by_id("asp_temp_43").value == "false"){
			get_by_id("asp_temp_43").value = is_form_modified("form1");
		}
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
	}
	function wizard_cancel(){
		if (get_by_id("asp_temp_43").value == "true" || is_form_modified("form1")){
			if(!confirm("Do you want to abandon all changes you made to this wizard?")) {
				return false;
			}
		}
		window.location.href="index.asp";
	}
</script>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onLoad="loadSettings();">
<table border=0 cellspacing=0 cellpadding=0 align=center width=30>
<tr>
<td></td>
</tr>
<tr>
<td>
<div align=left>
<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=92>
<tr height="92">
<td bgcolor="#FFFFFF">
  <div align="center">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
		<td>&nbsp;</td>
      </tr>
    </table>
    <img src="/wlan_masthead.gif" width="836" height="92" align="middle"></div></td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>
    <table width="650" border="0" align="center">
    <tr>
      <td><div class=box>
          <h2><script>show_words(wwa_title_s3);</script></h2>
          <div>
            <p class="box_msg"><script>show_words(wwa_intro_s3);</script></p>
              <select id="select_isp" name="select_isp" onChange="select_wan_type()">
                <option value="dhcpc"><script>show_words(wwa_selectisp_not);</script></option>
                <option value="dhcpc"><script>show_words(wwz_wan_option_1);</script></option>
                <option value="static"><script>show_words(wwz_wan_option_2);</script><</option>
                <option value="static"><script>show_words(wwz_wan_option_3);</script><</option>
                <option value="static"><script>show_words(wwz_wan_option_4);</script><</option>
                <option value="static"><script>show_words(wwz_wan_option_5);</script></option>
                <option value="dhcpc"><script>show_words(wwz_wan_option_6);</script></option>
                <option value="dhcpc"><script>show_words(wwz_wan_option_7);</script></option>
                <option value="static"><script>show_words(wwz_wan_option_8);</script></option>
                <option value="dhcpc"><script>show_words(wwz_wan_option_9);</script></option>
                <option value="dhcpc"><script>show_words(wwz_wan_option_10);</script></option>
                <option value="static"><script>show_words(wwz_wan_option_11);</script></option>
                <option value="static"><script>show_words(wwz_wan_option_12);</script></option>
                <option value="dhcpc"><script>show_words(wwz_wan_option_13);</script></option>
                <option value="dhcpc"><script>show_words(wwz_wan_option_14);</script></option>
                <option value="dhcpc"><script>show_words(wwz_wan_option_15);</script></option>
                <option value="dhcpc"><script>show_words(wwz_wan_option_16);</script></option>
                <option value="static"><script>show_words(wwz_wan_option_17);</script></option>
                <option value="dhcpc"><script>show_words(wwz_wan_option_18);</script></option>
                <option value="static"><script>show_words(wwz_wan_option_19);</script></option>
                <option value="static"><script>show_words(wwz_wan_option_20);</script></option>
                <option value="static"><script>show_words(wwz_wan_option_21);</script></option>
                <option value="dhcpc"><script>show_words(wwz_wan_option_22);</script></option>
                <option value="static"><script>show_words(wwz_wan_option_23);</script></option>
                <option value="static"><script>show_words(wwz_wan_option_24);</script></option>
                <option value="static"><script>show_words(wwz_wan_option_25);</script></option>
              </select>
          </div>
                  <div>
                    <P align="left" class=box_msg><script>show_words(wwa_msg_ispnot)</script></P>
                    <form id="form1" name="form1" method="post" action="apply.cgi">
		            <input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wan4a.asp">
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wan4a.asp">
					<input type="hidden" name="reboot_type" value="none">
					
					<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<!--# echo asp_temp_43 -->">
					<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="<!--# echo asp_temp_02 -->">
                    <table class=formarea >
                        <tr>
                          <td class=form_label>&nbsp;</td>
                          <td><input name="wan_type" type="radio" value="dhcpc">
                              <STRONG><script>show_words(_dhcpconn);</script></STRONG>
                              <div class=itemhelp><script>show_words(wwa_msg_dhcp);</script></div></td>
                        </tr>
                        <tr>
                          <td class=form_label>&nbsp;</td>
                          <td><input name="wan_type" type="radio" value="pppoe">
                              <STRONG><script>show_words( wwa_wanmode_pppoe);</script></STRONG>
                              <div class=itemhelp><script>show_words(wwa_msg_pppoe)</script></div></td>
                        </tr>
                        <tr>
                          <td class=form_label>&nbsp;</td>
                          <td><input name="wan_type" type="radio" value="pptp">
                              <STRONG><script>show_words(wwa_wanmode_pptp);</script></STRONG>
                              <div class=itemhelp><script>show_words(wwa_msg_pppoe)</script></div></td>
                        </tr>
                        <tr>
                          <td class=form_label>&nbsp;</td>
                          <td><input name="wan_type" type="radio" value="l2tp">
                              <STRONG><script>show_words(wwa_set_l2tp_title);</script></STRONG>
                              <div class=itemhelp><script>show_words(wwa_msg_pppoe)</script></div></td>
                        </tr>
                        <!--tr>
                          <td class=form_label>&nbsp;</td>
                          <td><input name="wan_type" type="radio" value="bigpond">
                              <STRONG>Username / Password Connection (Bigpond)</STRONG>
                              <div class=itemhelp>Choose this option if your Internet connection requires a username and password to get online. Most DSL modems use this connection type of connection. </div></td>
                        </tr-->
                        <tr>
                          <td class=form_label>&nbsp;</td>
                          <td><input name="wan_type" type="radio" value="static">
                              <STRONG><script>show_words(wwa_wanmode_sipa);</script></STRONG>
                              <div class=itemhelp><script>show_words(wwa_msg_static);</script></div></td>
                        </tr>
                    </table>
                    <br>
                    <table align="center" class="formarea">
                      <tr>
                        <td>
                          <input type="button" class="button_submit" id="prev_b" name="prev_b" value="Prev" onclick="window.location.href='wizard_wan2.asp'">
                          <input type="submit" class="button_submit" id="next_b" name="next_b" value="Next" onClick="return send_request()">
                          <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="Cancel" onclick="wizard_cancel();">
                          <input type="button" class="button_submit" id="wz_save_b" name="wz_save_b" value="Connect" disabled>
				<script>
                                	get_by_id("prev_b").value=_prev;
	                                get_by_id("next_b").value=_next;
        	                        get_by_id("cancel_b").value=_cancel;
                	                get_by_id("wz_save_b").value=_connect;
                        	</script>
                        </td>
                      </tr>
                    </table>
                  </form>
                  </div>
      </div></td>
    </tr>
  </table>
    <p>&nbsp;</p></td>
</tr>
</table>
</div>
</td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
  
  <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
    <tr>
      <td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
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
</html>
