<html lang=en-US xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
<head><title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script language="JavaScript">
	function ReplaceAll(strOrg,strFind,strReplace){
		var index = 0;
		while(strOrg.indexOf(strFind,index) != -1){
				strOrg = strOrg.replace(strFind,strReplace);
				index = strOrg.indexOf(strFind,index);
		}
		return strOrg
	}

	function onPageLoad(){
		document.getElementById("html_response_page").value = document.getElementById("html_response_return_page").value;
		var message = ReplaceAll(document.getElementById("html_response_message").value," ","").split(",");
		if(message.length>1){
			var obj_name = message[0].toLowerCase();
			document.getElementById(obj_name +"_1").style.display = "";
			if(obj_name == "success"){
				do_count_down();
			}
		}
	}
	
	function do_count_down(){
		document.getElementById("show_sec").innerHTML = count;
		
		if (count == 0) {	       
	        back();
	        return false;
	    }
		
		
		
		if (count > 0) {
	        count--;
	        setTimeout('do_count_down()',1000);
	    }
	
	}

	function back(){
		var login_who=checksessionStorage();
		if(login_who== "user"){
			window.location.href ="index.asp";
		}else{
			window.location.href = document.getElementById("html_response_page").value;
		}
		
	}
</script>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<style type="text/css">
<!--
.style1 {color: #FF6600}
-->
</style>
<script language="JavaScript" src="/lang_<!--# echo language -->.js"></script>
<script language="JavaScript" src="public.js"></script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<div >
<form id="form1" name="form1" method="post">
<input type="hidden" id="html_response_page" name="html_response_page" value="index.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value="<!--# echo html_response_message -->">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<!--# echo html_response_return_page -->">
<input type="hidden" name="reboot_type" value="none">
  <table width="838" height="100" border=0 align="center" cellPadding=0 cellSpacing=0 id=table_shell>
  <tr>
    <td bgcolor="#FFFFFF">
      <div align="center">
        <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
          <tr>
            <td width="100%">&nbsp;&nbsp;<script>show_words(TA2);</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
            <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
	    <td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --> &nbsp;</td>
	    <td>&nbsp;</td>
          </tr>
        </table>
        <img src="/wlan_masthead.gif" width="836" height="92"></div></td>
    </tr>
  <tr>
    <td>
      <table width="838" border=0 align="center" cellPadding=0 cellSpacing=0 >
        <tr>
          <td bgcolor="#FFFFFF"></td></tr>
        <tr>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr id="success_1" style="display:none">
          <td bgcolor="#FFFFFF"><p>&nbsp;</p>
           <table width="650" border="0" align="center">
            <tr>
              <td height="15"><div id=box_header>
                  <h1><script>show_words(_uploadgood);</script></h1>
                  <p>
                  	<script>show_words(_upgintro);</script>
                  </p>
                  <br>
              </div></td>
            </tr>
          </table>
          <p>&nbsp;</p>
          </td>
        </tr>
        <tr id="fail_1" style="display:none">
          <td bgcolor="#FFFFFF"><p>&nbsp;</p>
           <table width="650" border="0" align="center">
            <tr>
              <td height="15"><div id=box_header>
                  <h1><script>show_words(ub_Upload_Failed)</script></h1>
                  <p>
                  	<script>show_words(ub_intro_1);</script>
                  </p>
                  <p>
                  	<script>show_words(ub_intro_2);</script>
                  </p>
                  <p>
                  	<script>show_words(ub_intro_3);</script>
                  </p>
                  <p>
                  	<input type="button" class="button_submit" value="continue" id="Continue" name="Continue" onclick="back();">
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
              <td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
              <td width="10">&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table></td>
        </tr>
        </table>     </td>
    </tr>
  </table></form>
  <div id="copyright"><script>show_words(_copyright);</script></div>
</div>


</BODY>
<script>
	var count = 15;
	var temp_count= "<!--# echo countdown_time -->";
	if(temp_count != ""){
		count = parseInt(temp_count);
	}
	onPageLoad();
</script>
</html>
