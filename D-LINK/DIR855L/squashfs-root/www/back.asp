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
	var wan_ip = "";
	var count = 50;
/* 
 * Date : 2010/06/09 Robert 
 * Reason : I have no sense why it need to do ajax action.
 */
/*
        function get_File() {
              xmlhttp = createRequest();
              if(xmlhttp){
                   var url;
                   var lan_ip="<!--# echo lan_ipaddr -->";
                   var temp_cURL = document.URL.split("/");
        	   var mURL = temp_cURL[2];
                   if(mURL == lan_ip){
                          url="http://"+lan_ip+"/device.xml=device_status";
                   }else{
                          url="http://"+mURL+"/device.xml=device_status";
                   }
                                
                   xmlhttp.onreadystatechange = xmldoc; 
                   xmlhttp.open("GET", url, true); 
                   xmlhttp.send(null); 
              }
        }

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

	function xmldoc(){
		try{
		     if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
                     	wan_ip = xmlhttp.responseXML.getElementsByTagName("phy_wan_ip")[0].firstChild.nodeValue;
		     }
		}catch(e){
		     wan_ip = "";
		}
	}
*/
	function onPageLoad(){
			var temp_count= "<!--# echo result_timer -->";
			if(temp_count != ""){
				count = parseInt(temp_count);
			}
			get_by_id("html_response_page").value = "please_wait.asp";
			//get_by_id("html_response_page").value = get_by_id("html_response_return_page").value;
	}
	
	function do_count_down(){
		get_by_id("button").disabled = true;
		get_by_id("show_sec").innerHTML = parseInt(count, 10);
		//get_File();
		if (count == 0) {
		       	get_by_id("button").disabled = false;
			if(!isNaN(wan_ip) || wan_ip == "0.0.0.0"){
				get_by_id("html_response_page").value = get_by_id("html_response_return_page").value;
			}

		        return;
	    	}
	    		
		if (count > 0) {
			count--;
			setTimeout('do_count_down()',1000);
	    	}
	}

	function back(){
		var login_who=checksessionStorage();
		var reject_url = get_by_id("reject_url").value;
		if(login_who== "user"){
			window.location.href ="index.asp";
		}else{
			if(get_by_id("html_response_page").value == "reject.html" && 
				reject_url != "")
				window.location = "http://"+reject_url;
			else
				window.location.href = get_by_id("html_response_page").value;
		}
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<div >
<form id="form1" name="form1" method="post">
<input type="hidden" id="html_response_page" name="html_response_page" value="index.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value="<!--# echo html_response_message -->">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<!--# echo html_response_return_page -->">
<input type="hidden" id="reject_url" name="reject_url" value="<!--# echo reject_url -->">
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
                    <p align="center">
				<script>show_words(_please_wait);</script>
				<span id='show_sec'></span>&nbsp;
				<script>show_words(_seconds);</script>
                    </p>
                    <p align="center">&nbsp;</p>
                    <p align="center">
                      <input name="button" id="button" type=button class=button_submit value="" onClick="back()">
				<script>get_by_id("button").value=_continue;</script>
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
	do_count_down();	
</script>
</html>
