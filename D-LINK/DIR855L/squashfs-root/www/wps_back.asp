<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var count = 120;
	var result = 0;

	function createRequest() {
                var XMLhttpObject = null;
                try {
                        XMLhttpObject = new XMLHttpRequest();
                } catch (e) {
                        try {
                                XMLhttpObject = new ActiveXObject("Msxml2.XMLHTTP");
                        } catch (e) {
                                try {
                                        XMLhttpObject = new ActiveXObject("Microsoft.XMLHTTP");
                                } catch (e) {
                                        return null;
                                }
                        }
                }
                return XMLhttpObject;
        }

	function xmldoc()
	{
		var wps_status = 0;
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
			try{
				wps_status = parseInt(xmlhttp.responseText);
			}catch(e){
				wps_status = 0;
			}
			if (wps_status == 1) {
				result = 1;
				back();
			}
		}
	}

	function check_wps()
        {
                xmlhttp = createRequest();
                if(xmlhttp){
                        var url="";
                        var temp_cURL = document.URL.split("/");
                        for (var i = 0; i < temp_cURL.length-1; i++) {
                                if ( i == 1) continue;
                                if ( i == 0)
                                        url += temp_cURL[i] + "//";
                                else
                                        url += temp_cURL[i] + "/";
                        }
                        url += "check_wps.asp";
			xmlhttp.onreadystatechange = xmldoc;
                        xmlhttp.open("GET", url, true); 
                        xmlhttp.send(null); 
                }
		setTimeout('check_wps()',3000);
        }


	function do_count_down(){
		get_by_id("show_sec").innerHTML = count;
		
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
			if (parseInt(result) == 1) {
				window.location.href = "wireless.asp";
			} else {
				window.location.href = get_by_id("html_response_page").value;
			}
		}
		
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>

<tr>
<td>
<form id="form1" name="form1" method="post">
<input type="hidden" id="html_response_page" name="html_response_page" value="wps_back_result.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value="<!--# echo html_response_message -->">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<!--# echo html_response_return_page -->">
<input type="hidden" name="reboot_type" value="none">
  <table width=836 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
  <td bgcolor="#FFFFFF">    <div align="center">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
		<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
		<td>&nbsp;</td>
      </tr>
    </table>
    <img src="wlan_masthead.gif" width="836" height="92" align="middle">
      <br>
  </div>
    <table width="650" border="0" align="center"><br>
    <tr>
      <td width="50%"><div class=box>
        <h2 align="left"><!--Virtual Push Button--><script>show_words(LW13)</script></h2>
        <p>&nbsp;</p>
                      <p align="center">
                        <script>show_words(wps_message1_2);</script>
                        <font color="#FF0000"><span id="show_sec"></span></font>&nbsp;<script>show_words(_seconds)</script> 
                        &hellip;</p>
  		<p>&nbsp;</p>
      </div>
      </td>
    </tr>
  </table>
  <iframe src="wps_autodetect.asp" style="display:none">
  <script>
if(wps_status == "1"){
		window.location.href = "wireless.asp";
}

</script>
 </iframe>
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
</table>
</form>
</td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
  
  </td>
</tr>
</table>
<div id="copyright"><script>show_words(_copyright);</script> </div>
</body>
<script>
	check_wps();
	do_count_down();
</script>
</html>
