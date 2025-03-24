<html lang=en-US xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>D-LINK CORPORATION, INC | WIRELESS <!--# match wlan0_mode rt ROUTER --><!--# match wlan0_mode ap AP --> | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript">

//var update_st = -1;

function ReplaceAll(strOrg,strFind,strReplace){
	var index = 0;
	while(strOrg.indexOf(strFind,index) != -1){
		strOrg = strOrg.replace(strFind,strReplace);
		index = strOrg.indexOf(strFind,index);
	}
	return strOrg
}

get_json = function()
{       
	xml = createRequest();
	if (xml) {
		var url = "";
		var temp_cURL = document.URL.split("/");
		for (var i = 0; i < temp_cURL.length-1; i++) {
			if ( i == 1) continue;
			if ( i == 0)
				url += temp_cURL[i] + "//";
			else
				url += temp_cURL[i] + "/";
		}
		url += "auto_update_st.js";

		xml.open("GET", url, true);
		xml.onreadystatechange = GetJSONRequests;
		xml.send(null);
	}
	//if(update_st <= 0) {
		//time = setTimeout(get_json, 1000);
	//}
}

function createRequest() 
{
	var XMLhttpObject = false;
	if (window.XMLHttpRequest) {
		try {
			XMLhttpObject = new XMLHttpRequest();
		} catch (e) {
		}
	} else if (window.ActiveXObject) {
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


function GetJSONRequests()
{
	if (xml.readyState == 4 && xml.status == 200) {
		var obj = eval("(" + xml.responseText+")");
		var update_st = parseInt(obj["status"]);

		if(update_st == -3) { // Update type error.
			document.getElementById("message_1").style.display = "";
			get_by_id("button_1").disabled = false;
			var message = auto_update_TEXT01;
			document.getElementById("show_message_1").innerHTML = message;
			//setTimeout(get_json, 1000);

		} else if(update_st == -2) { // Download update file fail.
			document.getElementById("message_1").style.display = "";
			get_by_id("button_1").disabled = false;
			var message = auto_update_TEXT02;
			document.getElementById("show_message_1").innerHTML = message;
			//setTimeout(get_json, 1000);

		} else if(update_st == -1) { // Start to download update file.
			document.getElementById("message_1").style.display = "";
			get_by_id("button_1").disabled = true;
			var message = auto_update_TEXT03;
			document.getElementById("show_message_1").innerHTML = message;
			setTimeout(get_json, 1000);

		} else if(update_st == 0) { // Update file downloading.
			document.getElementById("message_1").style.display = "";
			get_by_id("button_1").disabled = true;
			var message = auto_update_TEXT04;
			document.getElementById("show_message_1").innerHTML = message;
			setTimeout(get_json, 1000);

		} else if(update_st == 1) { // Update file download success, start update firmware.
			document.getElementById("message_1").style.display = "";
			get_by_id("button_1").disabled = true;
			var message = auto_update_TEXT04;
			document.getElementById("show_message_1").innerHTML = message;

			send_submit("form2");

		} else if(update_st == 2) { // Update file download success, start update language pack.
			document.getElementById("message_1").style.display = "";
			get_by_id("button_1").disabled = true;
			var message = auto_update_TEXT05;
			document.getElementById("show_message_1").innerHTML = message;
			send_submit("form3");

		}
	}
}

function onPageLoad(){
	document.getElementById("html_response_page").value = document.getElementById("html_response_return_page").value;
	get_json();
/*	if(update_st == -1) {
		document.getElementById("message_1").style.display = "";
		var message = "Starting, please wait ...";
		document.getElementById("show_message").innerHTML = message;
		//time = setTimeout(get_json, 1000);
		setTimeout('onPageLoad()', 3000);

	} else if(update_st == 0) {
		document.getElementById("message_1").style.display = "";
		var message = "Update file downloading ...";
		document.getElementById("show_message").innerHTML = message;
		//time = setTimeout(get_json, 1000);
		setTimeout('onPageLoad()', 3000);

	} else if(update_st == 1) {
		document.getElementById("message_1").style.display = "none";
		document.getElementById("count_down").style.display = "";
		var message = "Updateing, please wait...";
		document.getElementById("show_message").innerHTML = message;
		do_count_down();
	}*/
}

function do_count_down(){
	document.getElementById("show_sec").innerHTML = count;
	get_by_id("button").disabled = true;

	if (count == 0) {	       
	        get_by_id("button").disabled = false;
		//back();
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
        <tr id="message_1" style="display:none">
          <td bgcolor="#FFFFFF"><p>&nbsp;</p>
           <table width="650" border="0" align="center">
            <tr>
              <td height="15"><div id=box_header>
                  <H1 align="left"><span class="style1">&nbsp;</span>
                      <!-- insert name=title -->
                  </H1>
                  <div align="left">
                    <p align="center"><span id="show_message_1"></span></p>
                    <p align="center">
                      <input name="button_1" id="button_1" type=button class=button_submit value="Continue" onClick="back()">
		      <script>get_by_id("button_1").value = _continue;</script>
                    </p>
                  </div>
              </div></td>
            </tr>
          </table>
          <p>&nbsp;</p>
          </td>
        </tr>
        <tr id="count_down" style="display:none">
          <td bgcolor="#FFFFFF"><p>&nbsp;</p>
           <table width="650" border="0" align="center">
            <tr>
              <td height="15"><div id=box_header>
                  <H1 align="left"><span class="style1">&nbsp;</span>
                      <!-- insert name=title -->
                  </H1>
                  <div align="left">
                    <p align="center"><span id="show_message_2"></span>... <script>show_words(wt_title);</script>&nbsp;<span id="show_sec"></span>&nbsp; <script>show_words(_seconds);</script>. 
                    </p>
                    <p align="center">&nbsp;</p>
                    <p align="center">
                      <input name="button" id="button" type=button class=button_submit value="Continue" onClick="back()">
		      <script>get_by_id("button").value = _continue;</script>
                    </p>
                  </div>
              </div></td>
            </tr>
          </table>
          <p>&nbsp;</p>
	            </td>
        </tr>
          </table>
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
<form id="form2" name="form2" method=POST action="apply.cgi" >
<!-- <input type="hidden" id="html_response_page" name="html_response_page" value="auto_ustatus.asp"> -->
 <input type="hidden" name="html_response_return_page" value="tools_firmw.asp">
 <input type="hidden" id="update_file_name" name="update_file_name" value="<!--# echo file_name -->">
 <input type="hidden" id="action" name="action" value="auto_up_fw">
</form>
<form id="form3" name="form3" method="POST" action="apply.cgi">
 <input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
 <input type="hidden" name="html_response_return_page" value="tools_firmw.asp">
 <input type="hidden" id="update_file_name" name="update_file_name" value="<!--# echo file_name -->">
 <input type="hidden" id="action" name="action" value="auto_up_lp">
</form>


</BODY>
<script>
	var count = 180;
//	var temp_count= "<!--# echo countdown_time -->";
//	if(temp_count != ""){
//		count = parseInt(temp_count);
//	}
	onPageLoad();
</script>
</html>
