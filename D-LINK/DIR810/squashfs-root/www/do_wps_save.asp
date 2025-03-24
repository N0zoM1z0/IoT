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
	
	function do_count_down(){
		get_by_id("show_sec").innerHTML = count;

		if (count == 0) {
	        //back();
	        return false;
	    }

		if (count > 0) {
	        count--;
	        setTimeout('do_count_down()',1000);
	    }

	}

	function query_wps_state()
	{
		var paramQueryWPSPIN={
			url: "get_set.ccp",
			arg: "ccp_act=queryWPSPin"
		}

		get_config_obj(paramQueryWPSPIN);
		
		var WPSPinRet = config_val("WPSPinRet");
		
		if((WPSPinRet == "success") && (count <=116))
		{
			paramQueryWPSPIN.arg = "ccp_act=doEvent&ccpSubEvent=CCP_SUB_WPSSUCCESS";
			get_config_obj(paramQueryWPSPIN);
			var path = "wps_back_ok.asp";
			
			if(from == 'adv')
				path += "?from=adv";
			window.location.href = path;
			return;
		}
		else
		{
			paramQueryWPSPIN.arg = "ccp_act=doEvent&ccpSubEvent=CCP_SUB_WPSFAILURE";
			get_config_obj(paramQueryWPSPIN);
		}
		
		if(count == 0)
		{
			paramQueryWPSPIN.arg = "ccp_act=doEvent&ccpSubEvent=CCP_SUB_WPSTIMEOUT";
			get_config_obj(paramQueryWPSPIN);
			var path = "wps_back_fail.asp";
			
			if(from == 'adv')
				path += "?from=adv";
			window.location.href = path;
			return;
		}
		
		//count--;		
		//do_count_down();
		setTimeout('query_wps_state()',1000);
	}
	
	function back(){
		if(dev_info.login_info!= "w"){
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
<input type="hidden" id="html_response_page" name="html_response_page" value="wps_back_result.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value='<% CmoGetCfg("html_response_message","none"); %>'>
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value='<% CmoGetCfg("html_response_return_page","none"); %>'>
<input type="hidden" name="reboot_type" value="none">
  <table width=836 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
  <td bgcolor="#FFFFFF">    <div align="center">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support"><script>document.write(dev_info.model);</script></a></td>
		<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
		<td>&nbsp;</td>
      </tr>
    </table>
    <img src="wlan_masthead.gif" width="836" height="92" align="middle">
      <br>
  </div>
    <table width="650" border="0" align="center"><br>
    <tr>
      <td><div id=box_header>
        <h1 align="left"><script>show_words('_wps_use_pin');</script></h1>
        <p>&nbsp;</p>
        <p align="center"><script>show_words(wps_messgae1_1)</script> <font color="#FF0000"><span id="show_sec"></span></font>&nbsp;<script>show_words(YM8)</script> ...</p>
  		<p>&nbsp;</p>
      </div>
      </td>
    </tr>
  </table>
  <!--<iframe src="wps_autodetect.asp" style="display:none">
  </iframe>-->
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
<div id="copyright"><script>show_words(_copyright);</script></div>
</body>
<script>
	var count = 120;
	do_count_down();
	query_wps_state();
</script>
</html>
