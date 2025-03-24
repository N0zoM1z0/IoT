<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	function onPageLoad(){
		var wps_enable = "<!--# echo wps_enable -->";
		if(wps_enable == "1"){
			get_by_id("wps_enable").style.display = "";
			get_by_id("wps_disable").style.display = "none";
		}else{
			get_by_id("wps_enable").style.display = "none";
			get_by_id("wps_disable").style.display = "";
		}
	}
	function send_request(){
		var login_who="<!--# get_current_user -->";
		if(login_who== "user"){
			window.location.href ="user_page.asp";
			return false;
		}else{
		if(!get_by_name("config_method_radio")[0].checked && !get_by_name("config_method_radio")[1].checked){
			alert("Please choose configuration mode!!");
			return false;
		}
		window.location.href = get_checked_value(get_by_name("config_method_radio"));
	}
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onLoad="onPageLoad();">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
  <tr>
    <td>
	<table width=836 border=0 cellspacing=0 cellpadding=0 align=center height=100>
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
		 </table>
		  <img src="wlan_masthead.gif" width="836" height="92" align="middle">
		<br>
		</div>
		<form id="form1" name="form1" method="post">
		  <input type="hidden" name="reboot_type" value="none">
		 	<table width="650" border="0" align="center"><br>
						<tr>
						  <td>
						  <div id="wps_enable" class="box" style="display:none">
							<h2 align="left"><script>show_words(wps_KR35)</script></h2>
							
                      <p class="box_msg"><script>show_words(wps_KR37)</script></p>
														
                      <P> <b> 
                        <script>show_words(KR50)</script>
                        </b> 
                        <INPUT type="radio" id="config_method_radio" name="config_method_radio" value="do_wps.asp" checked >
                        <LABEL for=config_method_radio_auto><b> </b></LABEL>
                        <script>show_words(wps_KR51)</script>
                      </P>
                      <P> <b> 
                        <script>show_words(bwn_RM_2)</script>
                        </b> 
                        <INPUT type="radio" id="config_method_radio" name="config_method_radio" value="wizard_add_wlan_device.asp">
                        <LABEL for=config_method_radio_2><b> </b></LABEL>
                        <script>show_words(wps_KR42)</script>
                      </P>
					<p align="center">
                       <input type="button" class="button_submit" id="next_b" name="next_b" value="" onClick="send_request()">
                      <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="" onClick="window.location.href='wizard_wireless.asp'">
                      <script>get_by_id("next_b").value = _next;</script>
					  <script>get_by_id("cancel_b").value = _cancel;</script>
							</p>
						  </div>
						  <p></p>
						  <div id="wps_disable" class="box" style="display:none">
                      <h2 align="left"><script>show_words(KR36)</script></h2>
							 <p>The WPS Function is currently set to disable. Please click "Yes" to enable it or "No" to exit the wizard.</p>
							<p>&nbsp;</p>
							<p align="center">
								<input type="button" class="button_submit" name="yes" id="yes" value="yes" onClick="window.location.href='adv_wps_setting.asp'">
								<input type="button" class="button_submit" name="no" id="no" value="no" onClick="window.location.href='wizard_wireless.asp'">
							</p>
						  </div>
						  </td>
						</tr>
					</table></form>
				  </td>
				</tr>
				<tr>
				  <td bgcolor="#FFFFFF">
					  <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
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
		
		</td>
	</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script> </div>
</body>
</html>
