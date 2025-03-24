<html>
<head>
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
var dev_info = get_router_info();
document.title = get_words('TEXT000');

	var arr_page = [
		'err_checksum',
		'err_hwid',
		'err_file',
		'success'
	];
	var dev_info = get_router_info();

	function toggle_page(id) {
		if (arr_page == null || (arr_page instanceof Array) == false)
			return;
		for (var i=0; i<arr_page.length; i++) {
			if (id == i)
				$('#'+arr_page[i]).show();
			else
				$('#'+arr_page[i]).hide();
		}
	}

	$(document).ready( function () {
		var msg = getUrlEntry('msg');
		if (msg == 'lpupgrade') {
			$('#lp_failed').show();
		}
	});
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<!-- dlink header -->
<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
<tr>
	<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/us/en/support"><script>document.write(dev_info.model);</script></a></td>
	<td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
	<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
	<td>&nbsp;</td>
</tr>
</table>
<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
<tr>
	<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
</tr>
</table>
<!-- end of dlink header -->

<!-- main content -->
<table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="50%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
<tr>
	<td valign="top" align="center" id="maincontent_container">
	<div id="maincontent">
	<!--####################################-->
	<!--#########    main part    ##########-->
	<!--####################################-->
	
	<div id="err_checksum" style="width:600; display:none">
		Checksum error!
		<input type="button" id='btn_err_checksum' onclick="location.replace('tools_firmw.asp')">
		<script>$('#btn_err_checksum').val(get_words('_back'))</script>
	</div>
	
	<div id="err_hwid" style="width:600; display:none">
		Bad hardware ID!
		<input type="button" id='btn_err_hwid' onclick="location.replace('tools_firmw.asp')">
		<script>$('#btn_err_hwid').val(get_words('_back'))</script>
	</div>
	
	<div id="err_file" style="width:600; display:none">
		Bad file!
		<input type="button" id='btn_err_file' onclick="location.replace('tools_firmw.asp')">
		<script>$('#btn_err_file').val(get_words('_back'))</script>
	</div>
	
	<div id="success" style="width:600; display:none">
		Upgrading language! Please wait for several seconds. (count down)
	</div>
	
	<div id="lp_failed" style="width:600; display:none">
		<div id="maincontent">
		<div id="box_header">
			<h1 align="left"> 
				<script>show_words(ub_Upload_Failed)</script>
			</h1>
			<p><script>show_words(ub_intro_l1)</script></p>
			<p><script>show_words(ub_intro_l3)</script></p>
			<p><script>show_words(ub_intro_2)</script></p>
			<br>
			<input type="button" id='btn_err_lp_failed' onclick="location.replace('tools_firmw.asp')">
			<script>$('#btn_err_lp_failed').val(get_words('_back'))</script>
		</div>
		</div>
	</div>

	<!--####################################-->
	<!--#######  end of main part   ########-->
	<!--####################################-->
	</div>
	</td>
</tr>
</table>
<!-- end of main content -->

<!-- footer -->
<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
<tr>
	<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
	<td width="10">&nbsp;</td><td>&nbsp;</td>
</tr>
</table>	
<!-- end of footer -->
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
</html>