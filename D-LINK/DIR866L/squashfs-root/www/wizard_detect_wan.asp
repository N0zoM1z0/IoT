<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
	#loading {
		position: relative;
		margin: 0px auto; /* firefox */
		*margin: 0px auto; /* IE7 */
		_margin: 0px auto; /* IE6 */
		width: 500px;
		height: 20px;
		background: #ffffff;
		border-width: thin;
		border-style: solid;
	}
	#loading div {
        	width: 0px;
		height: 20px;
		background: #ff6600;
	}

</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="Javascript" src="/wizard_lang.js"></script>
<script language="Javascript" src="/public.js"></script>
<script type="text/JavaScript" src="/jquery-1.6.1.min.js"></script>
<script type="text/Javascript" src="/jquery-DOMWindow.js"></script>
<script language="JavaScript">
	function COMM_RandomStr(len)
	{
	var c = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	var str = '';
	for (var i = 0; i < len; i+=1)
	{
	var rand_char = Math.floor(Math.random() * c.length);
	str += c.substring(rand_char, rand_char + 1);
	}
	return str;
	}
	document.cookie = "uid="+COMM_RandomStr(10)+"; path=/";

	var count = 2;

	function ip_ping_result() {
	var p_result_s;
	p_result_s = get_by_id("ping_result").value;
        
	if(p_result_s.match(" is alive")){
		window.location.href = "setup_wizard_mydlink.asp";
	}else{
		get_by_id("form1_show").style.display = "";
		if(p_result_s.match(" Unable to resolve,") || p_result_s.match(" No response from host")){
		$.openDOMWindow({
			modal:1,
			overlay:0,
			height:220, 
			width:535,  
			windowSourceID:'#show_box'
		});	
                get_by_id("show_msg").innerHTML=restart_wizard;
		}else{
			get_by_id("ping_result").value = p_result_s;
		}
	}
	}

	function onPageLoad(){
		get_by_id("html_response_page").value = get_by_id("html_response_return_page").value;
		ip_ping_result();
	}
	
	function do_count_down(){
		var p_result_s;
		p_result_s = get_by_id("ping_result").value;

		if(p_result_s.match(" Unable to resolve,") || p_result_s.match(" No response from host"))
			return;
		if (count == 0) {	   
			send_submit("form2");
			for(var i = 1; i < 11; i++) {
				_width = 50 * i + "px";
				$("#loading div").animate({
					width:_width
				});
			}			
			//back();
			return;
		}else {				
			count--;
			setTimeout('do_count_down()',1000);
		}
	}	

	function back(){
		var login_who=checksessionStorage();
		if(login_who== "user"){
			window.location.href ="index.asp";
		}else{
			window.location.href = get_by_id("html_response_page").value;
		}
	}

	function skip(idx){

		switch(idx) {	
			case 1:
				window.location.href = "setup_wizard_mydlink.asp";
				break;

			case 2:
				//window.location.href = "wizard_settings.asp";
				send_submit("form4");
				break;

			case 3:
				send_submit("form3");
				break;
		}	

		return false;
	}	

</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onLoad="onPageLoad();">
<div>
<form id="form2" name="form2" method="post" action="apply_sec.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_detect_wan.asp ">
					<input type="hidden" id="html_response_message" name="html_response_message" value="<!--# echo html_response_message -->">
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_detect_wan.asp">
					<input type="hidden" name="action" value="ping_test">
					<input type="hidden" name="reboot_type" value="none">
					<input type="hidden" id="wizard_detect" name="wizard_detect" value="1">
					<input type="hidden" id="ping_ipaddr" name="ping_ipaddr" size=30 maxlength=150 value="mydlink.com,dlink.com,dlink.com.cn,dlink.com.tw,google.com" >
					<input type="hidden" id="ping_result" name="ping_result" value="<!--# echo ping_result --><!--# echo ping6_result --><!-- repeat name=msg -->">
</form>

<div id="form1_show" name="form1_show" style="display:none">
<form id="form1" name="form1" method="post">
	<input type="hidden" id="html_response_page" name="html_response_page" value="index.asp">
	<input type="hidden" id="html_response_message" name="html_response_message" value="<!--# echo html_response_message -->">
	<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<!--# echo html_response_return_page -->">
	<input type="hidden" name="reboot_type" value="none">
	<table width="838" height="100" border=0 align="center" cellPadding=0 cellSpacing=0 id=table_shell>
		<tr><td bgcolor="#FFFFFF"><div align="center">
			<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
				<tr>
				<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
				<td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
				<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
				<td>&nbsp;</td>
				</tr>
			</table>
			<img src="/wlan_masthead.gif" width="836" height="92">
		</div></td></tr>
		<tr>
			<td>
				
				<table width="838" border=0 align="center" cellPadding=0 cellSpacing=0 >		
					<tr><td bgcolor="#FFFFFF"></td></tr>
					<tr><td bgcolor="#FFFFFF"></td></tr>
					<tr><td bgcolor="#FFFFFF"><p>&nbsp;</p>
						<table width="650" border="0" align="center">
							<tr><td height="15"><div class=box align="center">
								<h2 align="left"><script>show_words(STEP6);show_words(": ");show_words(_setup_wizard_6);</script></h2>
                                <p align="left"><script>show_words(setup_wizard_mydlink_info_14);</script></p>
								<br>
                                <div id="loading" align="left"><div id="div"></div></div>
                                <br>
                                <input type="button" class="button_submit" id="btn_skip" name="btn_skip" value="skip" onclick="skip(1);">
                                <input type="button" align="center" class="button_submit"id="btn_next" name="btn_next" value="next" disabled="true">

							
                            <script>
                                get_by_id("btn_skip").value = _skip;
                                get_by_id("btn_next").value = _next;
                            </script>    
                            </div></td></tr>
							<tr>	
								<td><div align="center"><span id="show_sec"></span></div></td>								
							</tr>
						</table>
						<p>&nbsp;</p>
					</td></tr>
					<tr>
						<td bgcolor="#FFFFFF">
							<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
								<tr>
									<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
									<td width="10">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>     
			</td>
		</tr>
	</table>
</form>
</div>
<form id="form3" name="form3" method="post" action="apply_sec.cgi">
    <input type="hidden" id="action" name="action" value="setup_wizard_skip">
    <input type="hidden" id="html_response_page" name="html_response_page" value="setup_wizard.asp">
    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="setup_wizard.asp">
</form>

<form id="form4" name="form4" method="post" action="apply_sec.cgi">
	<input type="hidden" id="action" name="action" value="setup_wizard_cancel">
	<input type="hidden" id="setup_mydlink_cancel" name="setup_mydlink_cancel" value="1">
	<input type="hidden" name="countdown_time" id="countdown_time" value="20">
	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_settings.asp">
	<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_settings.asp">
</form>

<div id="show_box" style=" display:none;" >
		<table width="98%" height="70%" border="0" align="center" bgcolor="#FFFFFF" cellspacing="5" >
			<tr>
				<td align="center" bgcolor="#FFFFFF"><span id="show_msg"></span></td>
			</tr>
			<tr>
				<td align="center" bgcolor="#FFFFFF">
	&nbsp;&nbsp;<input type="button" class="button_submit" id="btn2_skip" name="btn2_skip" value="skip" onclick="skip(2);">
	&nbsp;&nbsp;<input type="button" class="button_submit" id="btn2_ok" name="btn2_ok" value="ok" onclick="skip(3);">
		<script>
			get_by_id("btn2_skip").value = _skip;
			get_by_id("btn2_ok").value = _ok;
		</script>

                </td>
			</tr>
		</table>
</div>
 
<div id="copyright"><script>show_words(_copyright);</script></div>
</div>
</BODY>
<script>
	onPageLoad();
	do_count_down();
	
</script>
</html>
