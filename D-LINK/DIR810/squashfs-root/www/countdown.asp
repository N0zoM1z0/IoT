<html lang=en-US xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="uk.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript" src="pandoraBox.js"></script>
<script language="Javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="Javascript" src="js/xml.js"></script>
<script language="Javascript" src="js/object.js"></script>
<script language="JavaScript">
	var dev_info = get_router_info();

	function onPageLoad(){
		//get_by_id("html_response_page").value = get_by_id("html_response_return_page").value;
	}
	
	function do_count_down(){
		get_by_id("show_sec").innerHTML = count;

		if (count == 0) {	       
	        //back();
			get_by_id("bt_continue").disabled = false;
	        return;
	    }
		
		if (count > 0) {
	        count--;
	        setTimeout('do_count_down()',1000);
	    }
	
	}

	function back(){
		var login_who=dev_info.login_info;
		if(login_who!= "w"){
			window.location.href ="index.asp";
		}else{
			window.location.href = get_by_id("html_response_page").value;
		}
		
	}
	
	function do_redirect()
	{
		if(targetPage == "")
			window.location.href = "index.asp";
		else
			window.location.href = targetPage;
	}
	
</script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<style type="text/css">
<!--
.style1 {color: #FF6600}
-->
</style>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<div >
<form id="form1" name="form1" method="post">
<input type="hidden" id="html_response_page" name="html_response_page" value="index.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value='<% CmoGetCfg("html_response_message","none"); %>'>
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value='<% CmoGetCfg("html_response_return_page","none"); %>'>
<input type="hidden" name="reboot_type" value="none">
  <table width="838" height="100" border=0 align="center" cellPadding=0 cellSpacing=0 id=table_shell>
  <tr>
    <td bgcolor="#FFFFFF">
      <div align="center">
        <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
          <tr>
            <td width="100%">&nbsp;&nbsp;<script>show_words('TA2')</script>: <a href="http://www.dlink.com/us/en/support"><script>document.write(dev_info.model);</script></a></td>
            <td align="right" nowrap><script>show_words('TA3')</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
			<td align="right" nowrap><script>show_words('sd_FWV')</script>: <script>document.write(dev_info.fw_ver);</script></td>
			<td>&nbsp;</td>
          </tr>
        </table>
        <img src="wlan_masthead.gif" width="836" height="92"></div></td>
    </tr>
  <tr>
    <td>
      <table width="838" border=0 align="center" cellPadding=0 cellSpacing=0 >
        <tr>
          <td bgcolor="#FFFFFF"></td></tr>
        <tr>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr>
          <td bgcolor="#FFFFFF"><p>&nbsp;</p>
           <table width="650" border="0" align="center">
            <tr>
              <td height="15">
			  <div id=box_header>
                  <h1><script>show_words(sc_intro_sv)</script></h1>
				  
                  <p class="centered"><script>show_words(rb_wait)</script></p>
				  <p class="centered"><script>show_words(sc_intro_sv)</script></p>
				  <span id="for_lan_page">
                  <!--<p><script>show_words(rb_change)</script>
                  </p>-->
				  </span>
                  <br>
				  <p class="centered"><input name="bt_continue" id="bt_continue" type="button" value="" onClick="do_redirect()" disabled>
				  </p>
				  <script>get_by_id("bt_continue").value = get_words('_continue');</script>
              </div>
			  </td>
            </tr>

          </table>
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
        </table>     </td>
    </tr>
  </table></form>
<div id="copyright"><script>show_words('_copyright');</script></div>
</div>


</BODY>
<script>
	var count = 15;
	
	var targetPage = getUrlEntry('page');
	var temp_count = getUrlEntry('count');

	if(temp_count != null && temp_count != ""){
		count = parseInt(temp_count);
	}

	if(targetPage == "lan.asp")
	{
		get_by_id("for_lan_page").innerHTML = '<p>'+get_words(rb_change)+'</p>';
	}
	
	onPageLoad();
	do_count_down();
</script>
</html>
