<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | LOGIN</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script language="Javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="Javascript" src="/lang.js"></script>
<script language="Javascript" src="/public.js"></script>
<script>
	var submit_button_flag = true;
	var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	var t = parseInt("<!--# exec cgi /bin/check_auth_time timeout -->");

	function encode_base64(psstr)
	{
		return psstr;
	}

	function encode64(input)
	{
		var output = "";
		var chr1, chr2, chr3;
		var enc1, enc2, enc3, enc4;
		var i = 0;

		do {
			chr1 = input.charCodeAt(i++);
			chr2 = input.charCodeAt(i++);
			chr3 = input.charCodeAt(i++);

			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;

			if (isNaN(chr2)) {
				enc3 = enc4 = 64;
			} else if (isNaN(chr3)) {
				enc4 = 64;
			}

			output = output + keyStr.charAt(enc1) + keyStr.charAt(enc2) + 
				 keyStr.charAt(enc3) + keyStr.charAt(enc4);
		} while (i < input.length);
   
		return output;
	}

	function send_request()
	{
		var graph_enable = "<!--# echo graph_enable -->";
		if(get_by_id("login_n").value=="") {
			alert(username_alert);
			return false;
		}

		if (get_by_id("gcode_base64").value != encode64(get_by_id("graph_code").value.toUpperCase()) &&
			graph_enable == "open") {
			alert(auth+" "+_sdi_s9);
			graph_regenerate();
			return false;
		}
		if(submit_button_flag) {
			if (typeof(sessionStorage) !== "undefined")
				sessionStorage.setItem('account', get_by_id("login_n").value);
			get_by_id("login_name").value = base64Encode(get_by_id("login_n").value);
			get_by_id("log_pass").value = base64Encode(get_by_id("tmp_log_pass").value);
			get_by_id("graph_code").value = encode_base64(get_by_id("graph_code").value);
			submit_button_flag = false;
		}
		return true;
	}

	function onPageLoad()
	{
                var graph_auth_state = "<!--# echo graph_auth_state -->";

                if (graph_auth_state == "0") {
                        alert(_auth + " " + _sdi_s9);
			graph_regenerate();
		}

		var graph_en = "<!--# echo graph_enable -->";
		if(graph_en !== "open"){
			get_by_id("login1").style.display = "";
			get_by_id("login").style.display = "none";
		}else{
			get_by_id("login1").style.display = "none";
			get_by_id("login").style.display = "";
		}

		<!--# exec cgi /bin/nvram set graph_auth_state=1 -->

		if (t >= 0)
			session_timeout();
	}

	function graph_regenerate()
	{
		window.location.href="login_pic.asp";
		window.location.reload();
	}

	function session_timeout()
	{
		t = parseInt(t)-1;
		if (parseInt(t) <= 0 ) {
			graph_regenerate();
			return;
		} else {
			get_by_id("main").style.display ="none";
		}
		get_by_id("wtime").innerHTML = t;
		get_by_id("login_fail").style.display = "";
		setTimeout("session_timeout()", 1000);
	}

</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onLoad="onPageLoad();">
<table border=0 cellspacing=0 cellpadding=0 align=center width=30>
<tr>
<td></td>
</tr>
<tr>
<td>
<div align=left>
<table width=836 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
  <td align="center" valign="baseline" bgcolor="#FFFFFF">
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
      <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
	  <td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
	  <td>&nbsp;</td>
    </tr>
  </table>
  </td>
</tr>
<tr>
<td align="center" valign="baseline" bgcolor="#FFFFFF">
<div align=center>
  <table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td>
		</tr>
  </table>
  <font face=Arial></font>
  <p>
  <table width="650" border="0" >
    <tr>
	<form id="form1" name="form1" method="post" action=apply.cgi>
		<input type="hidden" id="html_response_page" name="html_response_page" value="login_pic.asp">
		<input type="hidden" id="login_name" name="login_name">
		<input type="hidden" id="log_pass" name="log_pass">
		<input type="hidden" id="action" name="action" value="do_graph_auth">

      <td><div id=box_header>
        <H1 align="left"><script>show_words(STORAGE_login_title);</script></H1>
        <div align="left" id="main">
          <script>show_words(STORAGE_login_intro);</script>

			<table width="357" border="0" align="center" id="show_normal">
				<tr>
					<td width="95"><strong><script>show_words(_username);</script>&nbsp;:</strong></td>
					<td width="252">
						<input type="text" id="login_n" name="login_n" size=20 maxlength=15
							onKeyPress='{ if (event.keyCode == 13) get_by_id("login").click(); }'>
					</td>
				</tr>
				<tr>
					<td><strong><script>show_words(_password);</script>&nbsp;:</strong></td>
					<td>
						<input type="password" name="tmp_log_pass" id="tmp_log_pass" size=20 maxlength=15
							onKeyPress='{ if (event.keyCode == 13) get_by_id("login").click(); }'>
						<input type="submit" id="login1" value="" onClick="return send_request()" style="display:none">
						<script>get_by_id("login1").value = LS316;</script>
</td>
				</tr>
			</table>
			<table width="357" border="0" align="center" id="show_graph" style="display:<!--# echo graph_enable -->">
				<tr>
					<td height="60" colspan="2">
						<strong><script>show_words(_authword);</script></strong>
						<span><input type=password name=graph_code id=graph_code size=20 maxlength=15></span>
					</td>
					<td width="48">&nbsp;</td>
				</tr>
				<tr>
					<td width="33">
						<!--# exec cgi /bin/graph_auth /tmp/auth.bmp -->
					</td>
					<td width="262">
						<input type=button id="refresh" name=Refresh value="" onClick="graph_regenerate();" style="width:100">
						<script>get_by_id("refresh").value = regenerate;</script>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>		
			<table width="357" border="0" align="center" id="show_submit">
				<tr>
					<td width="10"><div align="center">                    </div></td>
					<td width="284" align="center">
						<input type="submit" id="login" value="" style="width:170" onClick="return send_request()">
						<script>get_by_id("login").value = LS316;</script>
					</td>
					<td width="49"><div align="center"></div></td>
				</tr>
			</table>
		<!-- </form> -->
        </div>
	<div id="login_fail" style="display:none">
	<br/>
	<p align="center">
	<table width="357" border="0" align="center">
	  <tr>
		<td>User login fail more than 5 times. Please wait <span id="wtime"></span> &nbsp;seconds.</td>
	  </tr>
	</table>
	</p>
	<br/>
	</div>
      </div></td>
      </form>
      </tr>
  </table>
  <div id=maincontent></div>
  </div></td>
</tr>
</table>
</div>
</td>
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
</table><br>
<div align="center"><script>show_words(_copyright);</script></div>
</body>
</html>
