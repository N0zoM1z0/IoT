<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>

<script language=JavaScript>
function check_ip(){
		if (get_by_id("ping_ipaddr").value == "" || get_by_id("ping_ipaddr").value =="0.0.0.0"){
			alert(tsc_pingt_msg2);
			return false;
		}else{
			return true;
			//send_submit("form5");
		}
	}
function check_ipv6_ip(){
		if (get_by_id("ping6_ipaddr").value == ""){
			alert(tsc_pingt_msg2);
			return false;
		}else{
			return true;
			//send_submit("form5");
		}
	} 
function onPageLoad(){
	
	var login_who= checksessionStorage();
	if("<!--# echo feature_ipv6 -->" == "1")
		get_by_id("show_ping6").style.display = "";
	else
		get_by_id("show_ping6").style.display = "none";
	if(login_who== "user"){
		get_by_id("ping").disabled = true;
		get_by_id("ping6").disabled = true;
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
<script>show_top("tools");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<script>show_left("tools", 7);</script>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">			  <div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				  <div id="box_header"> 
						<h1><script>show_words(tsc_pingt)</script></h1>
						<p><script>show_words(tsc_pingt_mesg)</script></p>
				  </div>
				  <div class=box>
                    <h2><script>show_words(tsc_pingt)</script></h2>
                    <!--P>Ping Test is used to send &quot;Ping&quot; packets to test if a computer is on the Internet.</P-->
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                      
                        <form id="form5" name="form5" method="post" action="ping_response.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="tools_vct.asp">
	   				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_vct.asp">
					<input type="hidden" name="action" value="ping_test">
                          <tr>
                            <td>
                              <div align="right"><strong><script>show_words(tsc_pingt_h)</script>&nbsp;:&nbsp;</strong></div></td>
                            <td height="20" valign="top">&nbsp;
							 <input type="text" id="ping_ipaddr" name="ping_ipaddr" size=30 maxlength=63 value="<!--# echo ping_ipaddr -->" >
                              <input type="submit" id="ping" name="ping" value="ping" onClick="return check_ip()"></td>
                          </tr> </form>                      
                    </table>
						
				  </div>
<div class=box id="show_ping6"> 
	<h2><script>show_words(ipv6_tsc_pingt)</script></h2>
	<table cellSpacing=1 cellPadding=1 width=525 border=0>
		<form id="form6" name="form6" method="post" action="ping6_response.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="tools_vct.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_vct.asp">
			<input type="hidden" name="action" value="ping6_test">
			<tr><td> <div align="right" style=" text-transform:none"><strong><script>show_words(TEXT075)</script>:&nbsp;</strong></div></td>
				<td height="20" valign="top">&nbsp;
				<input type="text" id="ping6_ipaddr" name="ping6_ipaddr" size=30 maxlength=63 value="<!--# echo ping6_ipaddr -->" >
				<input type="submit" id="ping6" name="ping6" value="ping" onClick="return check_ipv6_ip()"></td>
			</tr>
		</form>                   
	</table>
</div>

<div class=box>
                    <h2><script>show_words(tsc_pingr)</script></h2>
                    
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
					  <tr>
						<td>
							<div align="center"><strong><script>show_words(tsc_pingt_msg1)</script></strong></div>
						</td>
					  </tr>
                      <tr>
                            <td><div align="center">
                              <!--# echo ping_result -->
                              <!--# echo ping6_result -->
                              <!-- repeat name=msg --></div></td>
                      </tr>
                            <td height="20" valign="top">&nbsp;</td>
                          </tr>                    
                    </table>
						
			  </div>
					<!-- === END MAINCONTENT === -->
                </div></td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id=help_text><strong><script>show_words(_hints);</script>&hellip;</strong>
					    <p><script>show_words(hhtsc_pingt_intro)</script><br><script>show_words(htsc_pingt_h)</script></p>
					    <p class="more"><a href="support_tools.asp#System_Check" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
					  </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
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
