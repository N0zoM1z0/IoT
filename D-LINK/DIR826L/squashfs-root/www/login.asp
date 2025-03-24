<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
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
	var salt = "345cd2ef";
	var dev_info = get_router_info();

	var hw_version 	= dev_info.hw_ver;
	var version 	= dev_info.fw_ver;
	var model		= dev_info.model;
	var login_Info 	= dev_info.login_info;
	var cli_mac 	= dev_info.cli_mac;
	var auth 		= config_val("graph_auth");
	document.title = get_words('TEXT000');

	if (config_val("es_configured") != '' && config_val("es_configured") == 0)
	{
		location.replace("wizard_router.asp");
	}

	var submit_button_flag = true;
	function encode_base64(psstr) {
		return encode(psstr,psstr.length); 
	}

	function encode (psstrs, iLen) {
		var map1="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/{}|[]\:;'<>?,.~!@#$%^&*()_-+=\"";
		var oDataLen = (iLen*4+2)/3;
		var oLen = ((iLen+2)/3)*4;
		var out='';
		var ip = 0;
		var op = 0;
		while (ip < iLen) {
			var xx = psstrs.charCodeAt(ip++);
			var yy = ip < iLen ? psstrs.charCodeAt(ip++) : 0;
			var zz = ip < iLen ? psstrs.charCodeAt(ip++) : 0;
			var aa = xx >>> 2;
			var bb = ((xx &   3) << 4) | (yy >>> 4);
			var cc = ((yy & 0xf) << 2) | (zz >>> 6);
			var dd = zz & 0x3F;
			out += map1.charAt(aa);
			op++;
			out += map1.charAt(bb);
			op++;
			out += op < oDataLen ? map1.charAt(cc) : '='; 
			op++;
			out += op < oDataLen ? map1.charAt(dd) : '='; 
			op++; 
		}
		return out; 
	}

	function check()
	{
		if(submit_button_flag){

			if (auth == 1){
				$('#graph_code').val($('#graph_code').val());
			}
			submit_button_flag = false;
			$('#username').val(encode_base64($('#login_n').val()));
			$('#password').val(encode_base64($('#log_pass').val()));
			if (!is_ascii($('#log_pass').val()))
			{
				$('#password').val($('#password').val()+'X');
				$('#log_pass').val($('#log_pass').val()+'X');
			}

			var param = {
				url:	'login.ccp',
				arg:	'username='+$('#username').val()+'&password='+$('#password').val()+
						'&graph_id='+$('#graph_id').val()+'&login_n='+$('#login_n').val()+
						'&log_pass='+$('#log_pass').val()+'&graph_code='+$('#graph_code').val()
			};

			send_submit("form1");
		}
		return true;
	}

	function chk_KeyValue(e){
		//var salt = "345cd2ef";
		if(browserName == "Netscape") {
			var pKey=e.which; 
		}
		if(browserName=="Microsoft Internet Explorer") { 
			var pKey=event.keyCode; 
		}
		if(pKey==13){
			if(check()){
				send_submit("form1");
			}
		}
	}

	function AuthShow(){
		$('#show_graph').hide();
		$('#show_graph2').hide();
		if (auth == 1){
			$('#show_graph').show();
			$('#show_graph2').show();

			var d = Math.random();
			$('#img_0').attr('src', '0.bmp?'+d);
			$('#img_1').attr('src', '1.bmp?'+d);
			$('#img_2').attr('src', '2.bmp?'+d);
			$('#img_3').attr('src', '3.bmp?'+d);
			$('#img_4').attr('src', '4.bmp?'+d);
		}
	}

	function ajax_submit(p)
	{
		var time=new Date().getTime();
		var ajax_param = {
			type: 	"POST",
			async:	true,
			url: 	p.url,
			data: 	p.arg+"&"+time+"="+time
		};

		$.ajax(ajax_param);
	}

	var browserName = navigator.appName;
	document.onkeyup=chk_KeyValue;

	$(document).ready( function () {
		//AuthShow(); 	//remove it, why it occurs an error at line: 103 (sometimes) ???
	});
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onLoad="document.form1.log_pass.focus();">
<table border=0 cellspacing=0 cellpadding=0 align=center width=30>
<tr>
<td></td>
</tr>
<tr>
<td>
<div align=left>
<table width=836 border=0 cellspacing=0 cellpadding=0 align=center>
<tr>
  <td align="center" valign="baseline" bgcolor="#FFFFFF">
  	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(model);</script></a></td>
        <td width="60%">&nbsp;</td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(hw_version);</script> &nbsp;</td>
      <td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(version);</script></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table></td>
</tr>
<tr>
<td align="center" valign="baseline" bgcolor="#FFFFFF">
<div align=center>
  <table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
    <tr>
      <td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
    </tr>
  </table>
  <br><br>
  <table width="650" border="0">
    <tr>
      <td height="10">
		<div id=box_header>
        <H1 align="left"><script>show_words(li_Login)</script></H1>
          <script>show_words(li_intro)</script><p>
			<form name="form1" id="form1" action="login.ccp" method="post">
				<input type="hidden" id="html_response_page" name="html_response_page" value="login.asp">
				<input type="hidden" id="login_name" name="login_name">
				<input type="hidden" id="login_pass" name="login_pass">
				<input type="hidden" id="username" name="username">
				<input type="hidden" id="password" name="password">
				<input type="hidden" id="graph_id" name="graph_id" value="">				
				<input type="hidden" id="alert_id" name="alert_id" value="">
          <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr height="24">
			<td width="15%"></td>
                <td align="right"><b><script>show_words(_username)</script> :&nbsp;</b></td>
              	<td><input type="text" id="login_n" name="login_n" value="Admin" tabindex="120" disabled /></td>
<!--				<select id="login_n" name="login_n">
					<option value="admin"><script>show_words(_admin)</script></option>
					</select>  -->
            </tr>
            <tr height="24">
			<td width="15%"></td>
                <td align="right"><b><script>show_words(_password)</script> :&nbsp;</b></td>
                <td><input type="password" id="log_pass" name="log_pass" value="" tabindex="120" onfocus="select();"/>&nbsp;&nbsp;
				<input class="button_submit_padleft" type="button" name="login" id="login" value="" style="width:60 " onclick="check()">
					<script>$('#login').val(get_words('li_Log_In'));</script></td>
            </tr>
            <tr height="54" id="show_graph" style="display:yes">
                <td width="30%"></td>
                <td colspan="2" width="280"><b><script>show_words(_authword)</script>&nbsp;</b>
                    <input type="password" id="graph_code" name="graph_code" value="" maxlength="8" onfocus="select();"/></td>
              </tr>
             <tr id="show_graph2" style="display:yes">
                <td width="30%"></td>
                <td width="90" nowrap>
					<table border="0" cellspacing=0 cellpadding=0>
					<tr>
						<td><img id="img_0"></td>
						<td><img id="img_1"></td>
						<td><img id="img_2"></td>
						<td><img id="img_3"></td>
						<td><img id="img_4"></td>
					</tr>
					</table>
				</td>
                <td><input class="button_submit_padleft" type=button name=Refresh id=Refresh value="" onClick="window.location.reload( true );" style="width:120 ">
				<script>$('#Refresh').val(get_words('regenerate'));</script></td>
              </tr>
             </table>
            </form>
        </div>
      </td>
      </tr>
  </table>

  <p>&nbsp;</p>
  </div></td>
</tr>
</table>
</div>
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
</table><br>
<div id="copyright"><script>show_words(_copyright);</script></div>
</body>
<script>
	AuthShow();
</script>
</html>
