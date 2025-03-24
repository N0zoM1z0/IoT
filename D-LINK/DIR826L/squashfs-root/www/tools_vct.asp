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
<script>
	var dev_info = get_router_info();
	document.title = get_words('TEXT000');
	var result = '';

/*	$(document).ready( function () {
		if(dev_info.login_info != "w"){
			$('#ping_ipaddr').attr('disabled',true);
			$('#ping6_ipaddr').attr('disabled',true);
			$('#ping').attr('disabled',true);
			$('#stop').attr('disabled',true);
			$('#ping_v6').attr('disabled',true);
			$('#stop_v6').attr('disabled',true);
		}
	});
*/

	function disablePinItem(opt)
	{
		$('#ping').attr('disabled',opt);
		$('#ping_ipaddr').attr('disabled',opt);
	}
	function disablePinItem6(opt)
	{
		$('#ping_v6').attr('disabled',opt);
		$('#ping6_ipaddr').attr('disabled',opt);
	}

	function check_ip(){
		if ($('#ping_ipaddr').val() == ""){
			alert(which_lang[tsc_pingt_msg2]);
			return;
		}
		
		disablePinItem(true);
		
		var paramPing = {
			url: "ping.ccp",
			arg: 'ccp_act=ping_v4&ping_addr='+$('#ping_ipaddr').val()
		};
		ajax_submit(paramPing);

		$('#ping_result').html('Testing...........');
		setTimeout("queryPingRet()",1*1000);
	}

	function check_ipv6_ip()
	{
		if ($('#ping6_ipaddr').val() == ""){
			alert(which_lang[tsc_pingt_msg2]);
			return false;
		}

		disablePinItem6(true);
		
		var paramPing = {
			url: "ping.ccp",
			arg: 'ccp_act=ping_v6&ping_addr='+$('#ping6_ipaddr').val()
		};
		ajax_submit(paramPing);
		
		$('#ping_result').html('Testing...........');

		setTimeout("queryPingRet6()",1*1000);
	} 

	function queryPingRet()
	{
		var paramQuery = {
			url: "ping.ccp",
			arg: "ccp_act=queryPingV4Ret"
		};

		get_config_obj(paramQuery);
		var ret = config_val("ping_result");
		switch(ret)
		{
			case "waiting":
				setTimeout("queryPingRet()",1*1000);
			return;

			case "success":
				disablePinItem(false);
				$('#ping_result').html(addstr(get_words('_ping_success'), $('#ping_ipaddr').val()));
			return;
			case "fail":
				disablePinItem(false);
				$('#ping_result').html(addstr(get_words('_ping_fail'), $('#ping_ipaddr').val()));
			return;
		}
	}
	function queryPingRet6()
	{
		var paramQuery = {
			url: "ping.ccp",
			arg: "ccp_act=queryPingV6Ret"
		};
		
		get_config_obj(paramQuery);
		
		var ret = config_val("ping_result");
		switch(ret)
		{
			case "waiting":
				setTimeout("queryPingRet6()",1*1000);
			return;
			
			case "success":
				disablePinItem6(false);
				$('#ping_result').html(addstr(get_words('_ping_success'), $('#ping6_ipaddr').val()));
			return;
			case "fail":
				disablePinItem6(false);
				$('#ping_result').html(addstr(get_words('_ping_fail'), $('#ping6_ipaddr').val()));
			return;
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

</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
	<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(dev_info.model);</script></a></td>
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
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(_setup)</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(_advanced)</script></a></td>
			<td id="topnavon"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_tools)</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(_status)</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(_support)</script></a></td>
		</tr>
	</table>
    <table id="topnav_container" border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(_admin)</script></a></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(_time)</script></a></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(_syslog)</script></a></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(_email)</script></a></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(_system)</script></a></div></li>
									<li><div><a href="tools_firmw.asp" onclick="return jump_if();"><script>show_words(_firmware)</script></a></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();"><script>show_words(_dyndns)</script></a></div></li>
								  	<li><div id="sidenavoff"><script>show_words(_syscheck)</script></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(_scheds)</script></a></div></li>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>
					</tr>
				</table>
	</td>
	<td valign="top" id="maincontent_container">
	<div id="maincontent">
	<!-- === BEGIN MAINCONTENT === -->
		<div id="box_header"> 
			<h1><script>show_words(tsc_pingt)</script></h1>
			<p><script>show_words(tsc_pingt_mesg)</script></p>
		</div>

		<div class=box> 
		<h2><script>show_words(tsc_pingt)</script></h2>

		<!--P>Ping Test is used to send &quot;Ping&quot; packets to test if a computer is on the Internet.</P-->
		<table cellSpacing=1 cellPadding=1 width=525 border=0>

		<form id="form5" name="form5" method="post" action="">
			<input type="hidden" id="html_response_page" name="html_response_page" value="tools_vct.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_vct.asp">
			<tr>
				<td>
				<div align="right"><strong>
				<script>show_words(tsc_pingt_h)</script>
				&nbsp;:&nbsp;</strong></div></td>
				<td height="20" valign="top">&nbsp;
				<input type="text" id="ping_ipaddr" name="ping_ipaddr" size=30 maxlength=63 value="" >
				<script>document.write('<input name="ping" id="ping" type="button" value="'+get_words('_ping')+'" onClick="check_ip()">')</script>
			</tr>
		</form>
		</table>

		</div>
		<div class=box> 
			<h2><script>show_words(tsc_pingt_v6)</script></h2>
			<!--P>Ping Test is used to send &quot;Ping&quot; packets to test if a computer is on the Internet.</P-->
			<table cellSpacing=1 cellPadding=1 width=525 border=0>

			<form id="form6" name="form6" method="post" action="">
				<input type="hidden" id="html_response_page" name="html_response_page" value="tools_vct.asp">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_vct.asp">
				<tr>
					<td>
					<div align="right"><strong>
					<script>show_words(tsc_pingt_h_v6)</script>
					&nbsp;:&nbsp;</strong></div></td>
					<td height="20" valign="top">&nbsp;
					<input type="text" id="ping6_ipaddr" name="ping6_ipaddr" size=30 maxlength=63 value="" >
					<script>document.write('<input name="ping_v6" id="ping_v6" type="button" value="'+get_words('_ping')+'" onClick="check_ipv6_ip()">')</script>
				</tr>
			</form>
			</table>
		</div>

		<div class=box> 
			<h2><script>show_words(tsc_pingr)</script></h2>

			<table cellSpacing=1 cellPadding=1 width=525 border=0>
			<tr>
				<td>
				<div align="center" width="100%"></div>
				</td>
				<td height="20" valign="top" align="center">&nbsp;<span id="ping_result"><script>show_words(tsc_pingt_msg1)</script></span></td>
			</tr>
			</table>
		</div>

		<!-- === END MAINCONTENT === -->
	</div>
	</td>

	<td valign="top" width="150" id="sidehelp_container" align="left">
		<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
		<tr>
			<td id=help_text><strong>
			<script>show_words(_hints)</script>
			&hellip;</strong> <p>
				<script>show_words(hhtsc_pingt_intro)</script><br>
				<script>show_words(htsc_pingt_h)</script>
			</p>
				<p class="more"><a href="support_tools.asp#System_Check" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
			</td>
		</tr>
		</table>
	</td>
	</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
</html>