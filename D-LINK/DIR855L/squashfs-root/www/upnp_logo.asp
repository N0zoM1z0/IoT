<html>
	<head>
	<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
	<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
	<link rel="STYLESHEET" type="text/css" href="/css_router.css">
	<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
	<script language="Javascript" src="/lang.js"></script>
	<script language="JavaScript" src="public.js"></script>
	<script language="JavaScript">
		function send_start(){
			send_submit("form2");
		}
		
		function send_stop(){
			send_submit("form3");
		}
		
	</script>
	</head>
	
	<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
		<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
			<tr>
				<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
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
				<script>show_top("setup");</script>
			</tr>
		</table>
		<table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
			<tr>
				<td id="sidenav_container" valign="top" width="125" align="right">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td id="sidenav_container">
								<div id="sidenav">
									<ul>
										
									</ul>
								</div>
							</td>			
						</tr>
					</table>			
				</td>
				<td valign="top" id="maincontent_container">
					
					<form id="form2" name="form2" method="post" action="apply.cgi">
						<input type="hidden" id="html_response_page" name="html_response_page" value="upnp_logo.asp">
						<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="">
						<input type="hidden" id="action" name="action" value="upnp_start">
					</form>
					
					<form id="form3" name="form3" method="post" action="apply.cgi">
						<input type="hidden" id="html_response_page" name="html_response_page" value="upnp_logo.asp">
						<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="">
						<input type="hidden" id="action" name="action" value="upnp_stop">
					</form>
						
						<div id="maincontent">
							<!-- === BEGIN MAINCONTENT === -->
							<div id="box_header"> 
								<h1>UPNP</h1>
								<br>
								This page only for UPNP logo test, need stop and start upnp daemon... 
								Before testing CTT2.0.
								1. disabke WPS
								2. colse windows firewall.
								
								<br><br>
								<input id="button3" name="button3" type="button" class="" value="UPNP Start" onClick="send_start()">
								<input id="button2" name="button2" type=reset class="" value="UPNP Stop" onclick="send_stop()">
								
							</div>
														
							<!-- === END MAINCONTENT === -->
							<p>&nbsp;</p>
						</div>
			
					
				</td>
				<td valign="top" width="150" id="sidehelp_container" align="left">
					<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
						<tr>
							<td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong>
								<p><script></script></p>
								<p><script></script></p>
							</td>
						</tr>
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
	</body>
	</script>
</html>
