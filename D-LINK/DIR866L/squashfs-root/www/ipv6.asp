<html>
<head>
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-weight: bold;
}
.style2 {font-size: 11px}
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script language="JavaScript" src="/lang_<!--# echo language -->.js"></script>
<script language="JavaScript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
function onPageLoad(){
        var login_who= checksessionStorage();
        if(login_who== "user"){
                get_by_id("button1").disabled = true;
        } 
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
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<script>show_left("Setup", 9);</script>
								</ul>
							</div>
						</td>
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">
				<div id=maincontent>
                  <div id=box_header>
                    <h1><script>show_words(IPv6_wizard_0);</script></h1>
					<script>show_words(IPV6_wizard_info_0);</script>
				  </div>
                  <div class=box>
                    <h2><script>show_words(IPv6_wizard_1);</script></h2>
                    <script>show_words(IPV6_wizard_info_1);</script><br><br>
                    <center><input name="button1" id="button1" type="button" class="button_submit" value="" onClick="window.location.href='wizard_ipv6_1.asp'"></center>
					<script>get_by_id("button1").value = IPv6_wizard_1;</script>
                    <br></br>                    
                    <strong><script>show_words(_note);</script>:</strong><script>show_words(vpn_note_info);</script>
                  </div>
                  <div class=box>
                    <h2><script>show_words(IPv6_wizard_15);</script></h2>
                    <script>show_words(IPV6_wizard_info_11);</script>
		    <br></br>
                    <center><input name="button2" id="button2" type=button class=button_submit value="" onClick="window.location.href='adv_ipv6_ula.asp'"></center>
					<script>get_by_id("button2").value = IPv6_wizard_16;</script>
                    </p>
                  </div>              
                  <div class=box>
                    <h2><script>show_words(IPv6_wizard_2);</script></h2>
                    <script>show_words(IPV6_wizard_info_2);</script>
		    <br></br>
                    <center><input name="button3" id="button3" type=button class=button_submit value="" onClick="window.location.href='adv_ipv6_sel_wan.asp'"></center>
					<script>get_by_id("button3").value = IPv6_wizard_2;</script>
                    </p>
                  </div>              
			  </div></td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong><br>
                          <br>
                           <script>show_words(IPV6_wizard_help_1);</script>
                          <p></p>
                          <p class="style2"><script>show_words(IPV6_wizard_help_2);</script></p>
			  <p class="more"><a href="support_internet.asp#IPV6"><script>show_words(_more)</script>&hellip;</a></p>
			</td>
                    </tr>
                  </tbody>
			  </table></td>
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
<script>
        onPageLoad();
</script>
</html>
