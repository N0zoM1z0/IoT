<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="Javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script type="text/JavaScript" src="/jquery-1.6.1.min.js"></script> 
<script type="text/Javascript" src="/jquery-DOMWindow.js"></script> 
<script language="JavaScript">
function onPageLoad(){
        var login_who= checksessionStorage();
        if(login_who== "user"){
                get_by_id("wizard").disabled = true;
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
	<table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<script>show_left("Setup", 7);</script>
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				 
                  <div id=box_header>
                    <h1><script>show_words(STORAGE_title)</script></h1>
                  	<p><script>show_words(shareport_index_info)</script></p>
                  </div>
                  <div class=box>
                    <h2><script>show_words(shareport_index_wizard_title)</script></h2>
                    <P><script>show_words(shareport_index_wizard_info)</script></P>
                    <div class=centered><input name="wizard" id="wizard" type=button class=button_submit value="&#8482;" onClick="window.location.href='shareport_wizard.asp'"></div><br>
				<script>get_by_id("wizard").value = shareport_index_wizard_btn;</script>
                  </div>
                  <div class=box>
                    <h2><script>show_words(shareport_index_manual_title)</script></h2>
                    <P><script>show_words(shareport_index_manual_info)</script></P>
                    <div class=centered><input id="button2" name="button2" type=button class=button_submit value="" onClick="window.location.href='shareport_storage.asp'"></div><br>
				<script>get_by_id("button2").value = shareport_index_manual_btn;</script>
                  </div>
			  </div></td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong><script>show_words(_hints)</script>&hellip;</strong>
			  <p class="more"><script>show_words(STORAGE_HINT_1);</script></p>
			  <p class="more"><script>show_words(STORAGE_HINT_2);</script></p>
                          <p class="more"><a href="support_internet.asp#Internet"><script>show_words(_more)</script>&hellip;</a></p>
                      </td>
                    </tr>
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
