<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<style type="text/css">
<!--
.style1 {color: #FF6600}
-->
</style>
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>

<script language="JavaScript">
	function onPageLoad(){
		get_by_id("html_response_page").value = get_by_id("html_response_return_page").value;
	}
	
	function do_count_down(){
		get_by_id("button").disabled = true;
	
		get_by_id("show_sec").innerHTML = count;
		
		if (count == 0) {	       
	        get_by_id("button").disabled = false;
	        return;
	    }
	
	}

	function back(){
			window.location.href ="login.asp";
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<div >
<form id="form1" name="form1" method="post">
<input type="hidden" id="html_response_page" name="html_response_page" value="index.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value="<!--# echo html_response_message -->">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<!--# echo html_response_return_page -->">
<input type="hidden" name="reboot_type" value="none">
  <table width="838" height="100" border=0 align="center" cellPadding=0 cellSpacing=0 id=table_shell>
  <tbody>
  
  <tr>
    <td bgcolor="#FFFFFF">
      <div align="center">
        <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
          <tr>
            <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
            <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
			<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
			<td>&nbsp;</td>
          </tr>
        </table>
        <img src="/wlan_masthead.gif" width="836" height="92"></div></td>
    </tr>
  <tr>
    <td>
      <table width="838" border=0 align="center" cellPadding=0 cellSpacing=0 >
        <tbody>
        <tr>
          <td bgcolor="#FFFFFF"></td></tr>
        <tr>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF"><p>&nbsp;</p>            <table width="650" border="0" align="center">
            <tr>
              <td height="15"><div id=box_header>
                  <H1 align="left"><span class="style1">&nbsp;</span>
                      <!-- insert name=title -->
                  </H1>
                  <div align="left">
                    <p align="center"><script>
						document.write("User Name or Password incorrect");
					</script>
                        <!-- repeat name=msg -->
                    </p>
                    <p align="center">
                            <input name="button" id="button" type=button class=button_submit value="" onClick="back()">
				<script>get_by_id("button").value=LOGIN_AGAIN;</script>
                    </p>
                  </div>
              </div></td>
            </tr>
          </table>
            <p>&nbsp;</p></td>
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
        </tbody></table>     </td>
    </tr>
  </tbody></table></form>
  <div id="copyright"><script>show_words(_copyright);</script></div>
</div>


</BODY>
<script>
	onPageLoad();
</script>
</html>
