<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
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
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>

<script language="JavaScript">
	var submit_button_flag = 0;

	function clone_mac_action(){
		get_by_id("asp_temp_03").value = get_by_id("mac_clone_addr").value;
	}	
		
	function send_request(){
		var c_host = get_by_id("host").value
		/*
		 * Validate MAC and activate cloning if necessary
		 */		
		 
		var mac = get_by_id("asp_temp_03").value; 
		//if (!check_mac_00(mac)){
		if (!check_mac(mac)){
			alert(_clone_error);
			return false;
		} 
		 	
		var mac = trim_string(get_by_id("asp_temp_03").value);
		if(!is_mac_valid(mac, true)) {
			alert ("Invalid MAC address:" + mac + ".");
			return false;
		}else{
			get_by_id("asp_temp_03").value = mac;
		}
		
		if(Find_word(c_host,"'") || Find_word(c_host,'"') || Find_word(c_host,"/")){
			alert("Host name invalid. the legal characters can not enter ',/,''");
			return false
		}
		
		get_by_id("asp_temp_04").value = get_by_id("host").value;
		
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
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=30>
<tr>
<td>
<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
<td bgcolor="#FFFFFF">
  <div align="center">
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
      <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
		<td>&nbsp;</td>
    </tr>
  </table>  <img src="/wlan_masthead.gif" width="836" height="92" align="middle"></td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>
  <table width="650" border="0" align="center">
    <tr>
      <td><div class=box>
          <h2 align="left"><script>show_words(_dhcpconn);</script>;</script>)</h2>
          <div align="left">
            <p class="box_msg"><script>show_words(wwa_msg_set_dhcp);</script></p>
            <form id="form1" name="form1" method="post" action="apply.cgi">
            <input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wan5.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wan4a.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<!--# exec cgi /bin/clone mac_clone_addr -->">
			<input type="hidden" id="asp_temp_04" name="asp_temp_04">
			<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<!--# echo asp_temp_43 -->">
              <div>
                  <table align="center" class=formarea>
                      <tr>
                        <td width="137" align=right class="duple"><script>show_words(_macaddr);</script>&nbsp;:</td>
                        <td width="473">
                          <input type="text" id="asp_temp_03" name="asp_temp_03" maxlength="17" size="20" value="<!--# echo asp_temp_03 -->">
                           <script>show_words(_optional);</script>
                        </td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td><input name="clone" type="button" class="button_submit" id="clone" value="" onClick="clone_mac_action()"></td>
				<script>get_by_id("clone").value=_clonemac;</script>
                      </tr>
                      <tr>
                        <td align=right class="duple"><script>show_words(help260);</script>&nbsp;:</td>
                        <td>
                          <input type=text id=host name=host size="25" maxlength="39" value="<!--# echo asp_temp_04 -->">
                        </td>
                      </tr>
                      <tr>
                        <td colspan="2" class="itemhelp"><script>show_words(wwa_note_hostname);</script></td>
                      </tr>
                      <tr>
                        <td class=form_label>&nbsp;</td>
                        <td><input type="button" class="button_submit" id="prev_b" name="prev_b" value="" onClick="window.location.href='wizard_wan3.asp'">
                  			<input type="submit" class="button_submit" id="next_b" name="next_b" value="" onClick="return send_request()">
                            <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="" onClick="wizard_cancel();">
                            <input type="button" class="button_submit" id="wz_save_b" name="wz_save_b" value="" disabled>
				 <script>
                                        get_by_id("prev_b").value=_prev;
                                        get_by_id("next_b").value=_next;
                                        get_by_id("cancel_b").value=_cancel;
                                        get_by_id("wz_save_b").value=_connect;
                                </script>
                        </td>
                      </tr>
                  </table>
              </div>
            </form>
          </div>
      </div></td>
    </tr>
  </table>    <p>&nbsp;</p>    </td>
</tr>
</table>
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
<script>
	set_form_default_values("form1");
</script>
</html>
