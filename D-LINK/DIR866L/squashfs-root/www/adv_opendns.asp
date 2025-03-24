<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();"><!--# echo model_number --></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
	<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
	<td>&nbsp;</td>
      </tr>
    </table>
    <table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
      <tr>
	<td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td>
      </tr>
    </table>
    <table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
      <tr id="topnav_container">
	<td><img src="/short_modnum.gif" width="125" height="25"></td>
<script>show_top("adv");</script>
      </tr>
    </table>
    <table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
      <tr>
	<td id="sidenav_container" valign="top" width="125" align="right">
	<table cellSpacing=0 cellPadding=0 border=0>
        <tbody>
          <tr>
            <td id=sidenav_container>
            <div id=sidenav>
              <UL><script>show_left("Advance", 20);</script></UL>
            </div>
            </td>
          </tr>
        </tbody>
    </table></td>
    <form id="form1" name="form1" method="post" action="apply.cgi">
      <input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
      <input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
      <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_opendns.asp">
      <input type="hidden" id="action" name="action" value="adv_opendns">
      <input type="hidden" id="en_opendns" name="en_opendns" value="<!--# echo en_opendns -->">
        <td valign="top" id="maincontent_container">
	<div id=maincontent>
	  <div id=box_header>
          <h1><script>show_words(adv_opendns);</script> : </h1>
	    <script>show_words(adv_opendns_desc);</script>
            <br><br>
            <input name="button" id="button" type="submit" class=button_submit value="" onClick="send_request()">
            <input name="button2" id="button2" type="button" class=button_submit value="" onClick="return page_cancel('form1', 'adv_opendns.asp');">
	    <script>
	      get_by_id("button").value = _savesettings;
	      get_by_id("button2").value = _dontsavesettings;
	    </script>
          </div>
          <div class=box>
          <h2><script>show_words(adv_opendns_h);</script></h2>
		<script>show_words(adv_opendns_h_desc);</script>
		<input type="checkbox" id="en_opdns" name="en_opdns" value="1">
          </div>
          <div class=box>
          <h2><script>show_words(adv_opendns_service);</script></h2>
		<script>show_words(adv_opendns_service_desc);</script>
		<center>
		<script>show_words(adv_opendns_device_id);</script> : <input type="text" id="device_id" name="device_id" value="<!--# echo device_id -->">
		</center>
          </div>

        </div>
        </td>
    </form>
      <td valign="top" width="150" id="sidehelp_container" align="left">
      <table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
      <tbody id="help_text">
        <tr><td><b><script>show_words(_hints);</script>&hellip;</b></td></tr>
	<tr><td><script>show_words(adv_opendns_help_msg);</script></td></tr>
	<tr><td><script>show_words(adv_opendns_help_msg1);</script></td></tr>
      </tbody>
      </table>
      </td>
    </tr>
    </table>
    <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
      <tr>
        <td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
	<td width="10">&nbsp;</td><td>&nbsp;</td>
      </tr>
    </table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
<script language="JavaScript">
	var submit_button_flag = 0;
	function onPageLoad()
	{
		set_checked(get_by_id("en_opendns").value, get_by_id("en_opdns"));
	}
	function send_request()
	{
		if (get_by_id("en_opdns").checked) {
			get_by_id("en_opendns").value = 1;
		} else {
			get_by_id("en_opendns").value = 0;
		}

		if (submit_button_flag == 0) {
			submit_button_flag = 1;
			return true;
		}
	}
	onPageLoad();
</script>    
</body>
</html>
