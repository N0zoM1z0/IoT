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
	function back(){
		var login_who=checksessionStorage();
		if(login_who== "user"){
			window.location.href ="index.asp";
		}else{
			window.location.href = get_by_id("html_response_page").value;
		}
		
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>

<tr>
<td>
<form id="form1" name="form1" method="post">
<input type="hidden" id="html_response_page" name="html_response_page" value="wps_wifi_setup.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value="<!--# echo html_response_message -->">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<!--# echo html_response_return_page -->">
<input type="hidden" name="reboot_type" value="none">
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
    <img src="wlan_masthead.gif" width="836" height="92" align="middle">
      <br>
  </div>
    <table width="650" border="0" align="center"><br>
    <tr>
      <td><div class=box>
                      <h2 align="left">
                        <script>show_words(LW13)</script>
                      </h2>
        
        	<p align="center"><script>show_words(TEXT049);</script></p>
  		<p align="center">
	          <input name="button" id="button" type=button class=button_submit value="" onClick="back()">
	          <input name="button_2" id="button_2" type=button class=button_submit value="" onClick="window.location.href='wizard_wireless.asp'">
		  <script>
			get_by_id("button").value = TEXT073;
			get_by_id("button_2").value = _cancel;
		</script>
        </p>
      </div>
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
</form>
</td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
  
  </td>
</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script> </div>
</body>
</html>
