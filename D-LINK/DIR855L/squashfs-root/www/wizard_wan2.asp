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
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
	function loadSettings(){
		get_by_id("tzone").selectedIndex = get_by_id("asp_temp_41").value;
		set_form_default_values("form1");
	}
	
	function send_request(){
		get_by_id("asp_temp_01").value = get_by_id("tzone").value;
		get_by_id("asp_temp_41").value = get_by_id("tzone").selectedIndex;
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
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>

<tr>
<td>

  <table width=836 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
  <td bgcolor="#FFFFFF">    <div align="center">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
		<td>&nbsp;</td>
      </tr>
    </table>
    <img src="/wlan_masthead.gif" width="836" height="92" align="middle">
      <br>
  </div>
    <table width="650" border="0" align="center"><br>
    <tr>
      <td><div class=box>
        <h2 align="left"><script>show_words(wwa_title_s2);</script></h2>
        <p class="box_msg"><script>show_words(wwa_intro_s2);</script></p>
          <form id="form1" name="form1" method="post" action="apply.cgi">
          	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wan3.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wan3.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="<!--# echo asp_temp_01 -->">
			<input type="hidden" id="asp_temp_41" name="asp_temp_41" value="<!--# echo asp_temp_41 -->">
			<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<!--# echo asp_temp_43 -->">
            <P align="center">
                <select size=1 id="tzone" name="tzone">
															<option value="-192"><script>show_words(up_tz_00)</script></option>
															<option value="-176"><script>show_words(up_tz_01)</script></option>
															<option value="-160"><script>show_words(up_tz_02)</script></option>
															<option value="-144"><script>show_words(up_tz_03)</script></option>
															<option value="-128" selected><script>show_words(up_tz_04)</script></option>
															<option value="-112"><script>show_words(up_tz_05)</script></option>
															<option value="-112"><script>show_words(up_tz_06)</script></option>
															<option value="-112"><script>show_words(up_tz_06b)</script></option>
															<option value="-96"><script>show_words(up_tz_07)</script></option>
															<option value="-96"><script>show_words(up_tz_08)</script></option>
															<option value="-96"><script>show_words(up_tz_09)</script></option>
															<option value="-96"><script>show_words(up_tz_10)</script></option>
															<option value="-80"><script>show_words(up_tz_11)</script></option>
															<option value="-80"><script>show_words(up_tz_12)</script></option>
															<option value="-80"><script>show_words(up_tz_13b)</script></option>
															<option value="-64"><script>show_words(up_tz_15)</script></option>
															<option value="-64"><script>show_words(up_tz_14)</script></option>
															<option value="-64"><script>show_words(up_tz_16)</script></option>
															<option value="-56"><script>show_words(up_tz_17)</script></option>
															<option value="-48"><script>show_words(up_tz_18)</script></option>
															<option value="-48"><script>show_words(up_tz_19)</script></option>
															<option value="-48"><script>show_words(up_tz_20)</script></option>
															<option value="-32"><script>show_words(up_tz_21)</script></option>
															<option value="-16"><script>show_words(up_tz_22)</script></option>
															<option value="-16"><script>show_words(up_tz_23)</script></option>
															<option value="0"><script>show_words(up_tz_24)</script></option>
															<option value="1"><script>show_words(up_tz_25)</script></option>
															<option value="16"><script>show_words(up_tz_26)</script></option>
															<option value="16"><script>show_words(up_tz_27)</script></option>
															<option value="16"><script>show_words(up_tz_28)</script></option>
															<option value="16"><script>show_words(up_tz_29)</script></option>
															<option value="16"><script>show_words(up_tz_30)</script></option>
															<option value="32"><script>show_words(up_tz_31)</script></option>
															<option value="32"><script>show_words(up_tz_32)</script></option>
															<option value="32"><script>show_words(up_tz_33)</script></option>
															<option value="32"><script>show_words(up_tz_34)</script></option>
															<option value="32"><script>show_words(up_tz_35)</script></option>
															<option value="32"><script>show_words(up_tz_36)</script></option>
															<option value="48"><script>show_words(up_tz_37)</script></option>
															<option value="48"><script>show_words(up_tz_38)</script></option>
															<option value="48"><script>show_words(up_tz_40)</script></option>
															<option value="56"><script>show_words(up_tz_41)</script></option>
															<option value="64"><script>show_words(up_tz_43b)</script></option>
															<option value="64"><script>show_words(up_tz_42)</script></option>
															<option value="64"><script>show_words(up_tz_43)</script></option>
															<option value="72"><script>show_words(up_tz_44)</script></option>
															<option value="80"><script>show_words(up_tz_46)</script></option>
															<option value="88"><script>show_words(up_tz_47)</script></option>
															<option value="88"><script>show_words(up_tz_47b)</script></option>
															<option value="92"><script>show_words(up_tz_48)</script></option>
															<option value="96"><script>show_words(up_tz_51)</script></option>
															<option value="96"><script>show_words(up_tz_50)</script></option>
															<option value="104"><script>show_words(up_tz_52)</script></option>
															<option value="112"><script>show_words(up_tz_54b)</script></option>
															<option value="112"><script>show_words(up_tz_53)</script></option>
															<option value="128"><script>show_words(up_tz_59)</script></option>
															<option value="128"><script>show_words(up_tz_55)</script></option>
															<option value="128"><script>show_words(up_tz_57)</script></option>
															<option value="128"><script>show_words(up_tz_59b)</script></option>
															<option value="128"><script>show_words(up_tz_58)</script></option>
															<option value="128"><script>show_words(up_tz_56)</script></option>
															<option value="144"><script>show_words(up_tz_62b)</script></option>
															<option value="144"><script>show_words(up_tz_60)</script></option>
															<option value="144"><script>show_words(up_tz_61)</script></option>
															<option value="152"><script>show_words(up_tz_63)</script></option>
															<option value="152"><script>show_words(up_tz_64)</script></option>
															<option value="160"><script>show_words(up_tz_69b)</script></option>
															<option value="160"><script>show_words(up_tz_65)</script></option>
															<option value="160"><script>show_words(up_tz_66)</script></option>
															<option value="160"><script>show_words(up_tz_67)</script></option>
															<option value="160"><script>show_words(up_tz_68)</script></option>
															<option value="176"><script>show_words(up_tz_70b)</script></option>
															<option value="176"><script>show_words(up_tz_70)</script></option>
															<option value="192"><script>show_words(up_tz_72b)</script></option>
															<option value="192"><script>show_words(up_tz_71)</script></option>
															<option value="192"><script>show_words(up_tz_72)</script></option>
															<option value="208"><script>show_words(up_tz_73)</script></option>
															<option value="208"><script>show_words(up_tz_73b)</script></option>

		                 </select>
              </p>
          <br>
          <table align="center" class="formarea">
            <tr>
              <td>
                <input type="button" class="button_submit" id="prev_b" name="prev_b" value="Prev" onClick="window.location.href='wizard_wan1.asp'">
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
</td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
  
  </td>
</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script></div>
</body>
<script>
	loadSettings();
</script>
</html>
