<html>
<head>
<title>D-LINK SYSTEMS, INC | WIRELESS <!--# match wlan0_mode rt ROUTER --><!--# match wlan0_mode ap AP --> | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
<script language="Javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="Javascript" src="/lang.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript">

	function onPageLoad(){
		get_by_id("html_response_page").value = get_by_id("html_response_return_page").value;
		var res_msg = "<!--# echo html_response_message -->";
		var str_flag = 0; /* Special string process */
		var str = "";
		if (res_msg === "conf_upload")
			str_flag = 1;

		/* replace message with multi-language */
		res_msg = replaceAll(res_msg, "hwid_fail", hwid_fail);
		res_msg = replaceAll(res_msg, "fw_upgrade", fw_upgrade);
		res_msg = replaceAll(res_msg, "update_fail", update_fail);
		res_msg = replaceAll(res_msg, "fw_fail", fw_fail);
		res_msg = replaceAll(res_msg, "lang_fail", lang_fail);
		res_msg = replaceAll(res_msg, "lang_verify_fail", lang_verify_fail);
		res_msg = replaceAll(res_msg, "lang_reload", lang_reload);
		res_msg = replaceAll(res_msg, "upfile_fail", upfile_fail);
		res_msg = replaceAll(res_msg, "conf_upload", conf_upload);
		res_msg = replaceAll(res_msg, "lanip_change", sc_intro_sv + "<count_down>" + rb_change);

		res_msg = res_msg.split("<count_down>");

		if (str_flag) {
			var new_msg = res_msg[0].replace(".", ",");
			var new_wt_title = wt_title.toLocaleLowerCase();
			str = new_msg + new_wt_title;
			str += "&nbsp;<span id=\"show_sec\"></span>&nbsp;" + _seconds + ".";
		} else {
			str = res_msg[0];
			if (str)
				str += "...";
			str += wt_title + "&nbsp;<span id=\"show_sec\"></span>&nbsp;" + _seconds + ".";
		}

		if(res_msg.length > 1) {
			str += "<br/><br/>" + res_msg[1];
		}
		get_by_id("show_msg").innerHTML = str;
	}

	function do_count_down(){
		get_by_id("btncont").disabled = true;
		get_by_id("show_sec").innerHTML = count;

		if (count == 0) {	       
			get_by_id("btncont").disabled = false;
			return;
		}
		
		if (count > 0) {
			count--;
			setTimeout('do_count_down()',1000);
		}
	}

	function back(){
		var login_who=checksessionStorage();
		if(login_who== "user") {
			window.location.href ="index.asp";
		} else {
			if (get_by_id("change_lan_ip").value == "1") /* change lan ip by lan.asp */
				window.location.href = "http://" + "<!--# echo lan_ipaddr -->"+ "/" + get_by_id("html_response_page").value;
			else if (get_by_id("change_lan_ip").value == "default") /* restore_default by tools_system.asp */
				window.location.href = "http://192.168.0.1";
			else
				window.location.href = get_by_id("html_response_page").value;
		}
	}
</script>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<style type="text/css">
<!--
.style1 {color: #FF6600}
-->
</style>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<div >
<form id="form1" name="form1" method="post">
<input type="hidden" id="html_response_page" name="html_response_page" value="index.asp">
<input type="hidden" name="html_response_message" value="<!--# echo html_response_message-->">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<!--# echo html_response_return_page -->">
<input type="hidden" id="change_lan_ip" name="change_lan_ip" value="<!--# echo change_lan_ip -->">
  <input type="hidden" name="reboot_type" value="none">
  <table width="838" height="100" border=0 align="center" cellPadding=0 cellSpacing=0 id=table_shell>
  <tbody>
  <tr>
    <td bgcolor="#FFFFFF">      <div align="center">
        <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
          <tr>
            <td width="100%"><script>show_words(TA2)</script>: <a href="http://support.dlink.com/"><!--# echo model_number --></a></td>
            <td align="right" nowrap>
		<script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;
		<script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA -->
	    </td>
          </tr>
        </table>
        <img src="/wlan_masthead.gif" width="836" height="92" border="0" usemap="#Map1">
        <map name="Map1">
          <area shape="rect" coords="11,20,161,71" href="http://www.dlink.com.tw">
        </map>
      </div></td>
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
                    <p align="center"><span id="show_msg"></span></p>
                    <p align="center">
                      <input name="btncont" id="btncont" type=button class=button_submit value="Continue" onClick="back()">
		      <script>get_by_id("btncont").value = _continue;</script>
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
  <div id="copyright" align="center"><script>show_words(_copyright);</script></div>
</div>


</BODY>
<script>
	var count = 50;
	var temp_count= "<!--# echo result_timer -->";
	if(temp_count != ""){
		count = parseInt(temp_count);
	}
	onPageLoad();
	do_count_down();

</script>
</html>
