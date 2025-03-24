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

		var msg = gup("msg");
		if(msg == "fwupgrade" || msg == 'reboot')
		{
			$('.ip_info').hide();
		}
		else
		{
			$('.ip_info').show();
		}
	}

	function gup( name ){  
		name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");  
		var regexS = "[\\?&]"+name+"=([^&#]*)";  
		var regex = new RegExp( regexS );  
		var results = regex.exec( window.location.href );  
		if( results == null )    
			return "";  
		else    
			return results[1];
	}
	
	function do_count_down(){
		get_by_id("show_sec").innerHTML = count;
		
		if (count == 0) {	       
	        back();
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
<input type="hidden" id="html_response_page" name="html_response_page" value="login.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value='<% CmoGetCfg("html_response_message","none"); %>'>
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value='<% CmoGetCfg("html_response_return_page","none"); %>'>
<input type="hidden" name="reboot_type" value="none">
  <table width="838" height="100" border=0 align="center" cellPadding=0 cellSpacing=0 id=table_shell>
  <tr>
    <td bgcolor="#FFFFFF">
      <div align="center">
        <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
          <tr>
            <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://www.dlink.com/default.aspx"><script>document.write(dev_info.model);</script></a></td>
            <td align="right" nowrap><script>show_words(TA3)</script>: <script>document.write(dev_info.hw_ver);</script> &nbsp;</td>
			<td align="right" nowrap><script>show_words(sd_FWV)</script>: <script>document.write(dev_info.fw_ver);</script></td>
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
              <td height="15"><div id=box_header>
                  <h1><script>show_words(rb_Rebooting)</script>&hellip;</h1>
                  <p class="centered"><script>show_words(rb_wait)</script></p>
                  <p class="ip_info"><script>show_words(rb_change)</script>
                  </p>
                  <br>
              </div></td>
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
	var count = 60;
	//var temp_count= "<% CmoGetCfg("countdown_time","none"); %>";
	var temp_count = getUrlEntry('count');
	if(temp_count != ""){
		count = parseInt(temp_count);
	}
	onPageLoad();
	do_count_down();
</script>
</html>
