<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script language="Javascript" src="/lang_<!--# echo language -->.js"></script>
<script language="Javascript" src="/wizard_lang.js"></script>
<script language="Javascript" src="jquery-1.6.1.min.js"></script>
<script language="Javascript" src="/public.js"></script>
<script language="Javascript">
	var browserName = navigator.userAgent.toLowerCase();
	var support_dual_band = 0; // 0: signal band 1:dual band
	
	function onPageLoad(){
		count = 15;
		get_by_id("step_title").style.display = "";
		get_by_id("mydlink_btn").style.display = "";
		get_by_id("mydlink_6_1").style.display = "";
		get_by_id("mydlink_6_2").style.display = "none";
		get_by_id("mydlink_6_3").style.display = "none";		
		get_by_id("mydlink_6_4").style.display = "none";		
	}
	
	function wz_cancel() {
		if(confirm(mydlink_skip)) {
			disable_all_btn(true);
			send_submit("form2");
		}
	}

	function next() {
		var form_name=document.getElementById('form1');
		var mydlink_account;
		var admin_password = "<!--# exec cgi /bin/stat_info mydlink_admin_check -->";

		if (admin_password.search("empty") != -1) {
			alert(_pass_empty);
			return false;
		} else if (admin_password.search("false") != -1) {
			alert(wizard_check_passwd_length);
			return false;
		}
	
		for (var i=0; i<form_name.mydlink_account.length; i++)
		{
			if (form_name.mydlink_account[i].checked)
			{
				mydlink_account=form_name.mydlink_account[i].value;
				break;
			}
		}
		
		get_by_id("mydlink_6_1").style.display = "none";
		get_by_id("btn_next").style.display = "none";
		get_by_id("btn_prev").style.display = "";
		
		if(mydlink_account == 1){
			get_by_id("mydlink_6_2").style.display = "none";
			get_by_id("mydlink_6_3").style.display = "";
			
			get_by_id("btn_signin").style.display = "";
		}else{
			get_by_id("mydlink_6_2").style.display = "";
			get_by_id("mydlink_6_3").style.display = "none";

			get_by_id("btn_signup").style.display = "";
		}
	}
	
	function go_back() {
		get_by_id("step_title").style.display = "";
		get_by_id("mydlink_6_1").style.display = "";
		get_by_id("mydlink_6_2").style.display = "none";
		get_by_id("mydlink_6_3").style.display = "none";	
		get_by_id("mydlink_6_4").style.display = "none";	
		
		get_by_id("mydlink_btn").style.display = "";
		get_by_id("btn_next").style.display = "";
		get_by_id("btn_prev").style.display = "none";
		get_by_id("btn_signup").style.display = "none";
		get_by_id("btn_signin").style.display = "none";
	}
	
	
	function foolproof_password() {
		/* check admin password */
		var password = get_by_id("mydlink_password2").value;
		var confirm_password = get_by_id("confirm_password").value;

		if (password.length < 6){
			alert("The Password MUST not be accepted if length is less than six.");
			return false;
		}

		if(password != confirm_password) {
			get_by_id("mydlink_password2").value = "";
			get_by_id("confirm_password").value = "";
			alert(YM173);
			return false;
		}
		if(!is_ascii(password) || !is_ascii(confirm_password)) {
			alert(MSG047);
			return false;
		}
		return true;
	}
	
	function mydlink_result(data){
		if(data.match("signin_success") != null){
			saving();
			do_count_down();
		} else if(data.match("signup_success") != null){
			saving();
			get_by_id("mail_addr2").value = get_by_id("mail_addr").value;
			get_by_id("mydlink_password3").value = get_by_id("mydlink_password2").value;
			fn_signin();
		} else {
			alert(_login_fail + data);
			go_back();	
		}
		get_by_id("btn_signin").disabled = false;
		get_by_id("btn_signup").disabled = false;

	}

	function saving() {
		get_by_id("step_title").style.display = "none";
		get_by_id("mydlink_6_1").style.display = "none";
		get_by_id("mydlink_6_2").style.display = "none";
		get_by_id("mydlink_6_3").style.display = "none";
		get_by_id("mydlink_6_4").style.display = "";
		get_by_id("mydlink_btn").style.display = "none";
	}

	function ajax_post(post_url, post_data){
		$.ajax({
			type: "POST",
			async: true,
			url: post_url,
			data: post_data,
			success: function(data){mydlink_result(data);},
			timeout: 30000,
			error: function(xhr, ajaxOptions, thrownError){ 
					alert(li_alert_1);
					get_by_id("btn_signin").disabled = false;
					get_by_id("btn_signup").disabled = false;
				}
			});
	}

	function fn_signup(){	
		var mail_addr = get_by_id("mail_addr").value;
		var mydlink_password = get_by_id("mydlink_password2").value;
		var f_name = get_by_id("f_name").value;
		var l_name = get_by_id("l_name").value;

		get_by_id("btn_signup").disabled = true;

		if ("<!--# echo mydlink_wizard_rt -->" == 0) {
			alert("You are already completed or skip the setup wizard.");
			get_by_id("btn_signup").disabled = false;
			return false;
		}

		if(!get_by_id("type1").checked){
			alert(check_accept_condition);
			get_by_id("btn_signup").disabled = false;
			return false;
		}

		if(!validateEmail(mail_addr)){
			get_by_id("btn_signup").disabled = false;
			return false;
		}

		if(!foolproof_password()) {
			get_by_id("btn_signup").disabled = false;
			return false;
		}
		
		if(f_name.length == 0) { 
			alert("First name " +_setup_wizard_mydlink_info_11); 
			get_by_id("btn_signup").disabled = false;
			return false; 
		} 

		if(l_name.length == 0){ 
			alert("Last name " + _setup_wizard_mydlink_info_11); 
			get_by_id("btn_signup").disabled = false;
			return false; 
		} 
		
		var post_data = { 			
			account_name: mail_addr,
			account_password: mydlink_password,
			first_name: f_name,
			last_name: l_name
		};
		
		ajax_post("/goform/signup", post_data);
		
	}

	function fn_signin(){
		var is_wizard = "1";

		if ("<!--# echo mydlink_wizard_rt -->" == 0) {
			alert("You are already completed or skip the setup wizard.");
			return false;
		}

		if (!validateEmail(get_by_id("mail_addr2").value)){
			return false;
		}
	
		get_by_id("btn_signin").disabled = true;

		var post_data = { 			
			account_name2: get_by_id("mail_addr2").value,
			account_password2: get_by_id("mydlink_password3").value,
			is_from_wizard: is_wizard
		};

		ajax_post("/goform/signin", post_data);
		
	}
	
	function goto_mydlink(){
		window.location.href = "http://mydlink.com";
	}

	function validateEmail(email) {
  		var regularExpression = /^[^\s]+@[^\s]+\.[^\s]{2,3}$/;
		var bad_email = _badfromemailaddr.replace("+ from_addr +",email);
  		if (regularExpression.test(email)) {
      		return true;
  		}else{
  			alert(bad_email);
      		return false;
  		}
	}

	function do_count_down(){
		if (count == 0) {
			alert(_signin_success);
                        window.location.href = "http://mydlink.com"; 
		}else {				
			count--;
			setTimeout('do_count_down()',1000);
		}

	}
	
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
	<tr>
		<td bgcolor="#FFFFFF">
			<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
				<tr>
					<td bgcolor="#FFFFFF">
					<div align=center>
						<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
							<tr>
								<td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
								<td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
								<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
								<td>&nbsp;</td>
							</tr>
						</table>
						<img src="/wlan_masthead.gif" width="836" height="92" align="middle">
					</div></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF"><p>&nbsp;</p>
		<table width="650" border="0" align="center">
			<tr>
				<td>
				<div class=box>
					<div id=w1>
					<form id="form1" name="form1" method="post" action="apply.cgi">
						<input type="hidden" name="html_response_page" id="html_response_page" value="reboot.asp">
						<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
						<input type="hidden" name="html_response_return_page" value="http://www.dlink.com">
						<input type="hidden" name="reboot_type" value="none">
						<input type="hidden" id="action" name="action" value="setup_wizard">
						<input type="hidden" id="setup_wizard_pre_page" name="setup_wizard_pre_page" value ="setup_wizard_wlan.asp">
														
						
						<h2 id="step_title" name="step_title" style="display:none" align="left"><script>show_words(STEP6);show_words(": ");show_words(_setup_wizard_6);</script></h2>
						<!-- Step 6-1 mydlink -->
						<div id="mydlink_6_1" name="mydlink_6_1" style="display:none">
							<div align="left">
								<p class="box_msg"><script>
									show_words(_setup_wizard_mydlink_info_0);
								</script></p>									
								<table align="center" class=formarea >
									<tr>
										<td align="left">
											<script>show_words(_setup_wizard_mydlink_info_1)</script>
										</td>
									</tr>
									
									<tr>
										<td align="left" ><input type="radio" name="mydlink_account" id="mydlink_account" value="1">
										
											<script>show_words(_setup_wizard_mydlink_info_2)</script>
										</td>
									</tr>
									<tr>
										<td align="left" ><input type="radio" name="mydlink_account" id="mydlink_account" value="0" checked>
										
											<script>show_words(_setup_wizard_mydlink_info_3)</script>
										</td>
									</tr>
								</table>
							</div>
						</div>
						
						<!-- Step 6-2 mydlink -->
						<div id="mydlink_6_2" name="mydlink_6_2" style="display:none">
							<div align="left">
								<p align="center" class="box_msg"><script>show_words(_setup_wizard_mydlink_info_4);</script></p>									
								<table align="center" width="550" class=formarea >
									<tr>
										<td width="200" align="right"><script>show_words(e_mail_addr);show_words(": ");</script></td>
										<td align="left">
											<input type="text" id="mail_addr" name="mail_addr" size=20 maxlength=128 value="">
										</td>
									</tr>
									<tr>
										<td align="right"><script>show_words(_password);show_words(": ");</script></td>
										<td align="left">	
											<input type="password" id="mydlink_password2" name="mydlink_password2" size=20 maxlength=128 value="">
										</td>
									</tr>
									<tr>
										<td align="right"><script>show_words(_confirm_password);show_words(": ");</script></td>
										<td align="left">	
											<input type="password" id="confirm_password" name="confirm_password" size=20 maxlength=128 value="">
										</td>
									</tr>
									<tr>
										<td align="right" ><script>show_words(f_name);show_words(": ");</script></td>
										<td align="left">
											<input type="text" id="f_name" name="f_name" size=20 maxlength=128 value="">
										</td>
									</tr>
									<tr>
										<td align="right" ><script>show_words(l_name);show_words(": ");</script></td>
										<td align="left">
											<input type="text" id="l_name" name="l_name" size=20 maxlength=128 value="">
										</td>
									</tr>
									<tr>
										<td align="right"><input type="checkbox" id="type1" name="type1" value="1"></td>
										<td align="left">
										<a href="http://mydlink.com/"><script>show_words(_setup_wizard_mydlink_info_5);</script></a>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<!-- Step 6-3 mydlink -->
						<div id="mydlink_6_3" name="mydlink_6_3" style="display:none">
							<div align="left">
								<p>								
								<table align="center" width="550" class=formarea >
									<tr>
										<td width="200" align="right"><script>show_words(e_mail_addr);show_words(": ");</script></td>
										<td align="left">
											<input type="text" id="mail_addr2" name="mail_addr2" size=20 maxlength=128 value="">
										</td>
									</tr>
									<tr>
										<td align="right"><script>show_words(_password);show_words(": ");</script></td>
										<td align="left">	
											<input type="password" id="mydlink_password3" name="mydlink_password3" size=20 maxlength=128>
										</td>
									</tr>
								</table>
							</div>
						</div>	
						<!-- Step 6-4 mydlink -->
						<div id="mydlink_6_4" name="mydlink_6_4" style="display:none">
							<div align="left">
								<h2><script>show_words(_savesettings);</script>&hellip;</h2>
								<p class="centered"><script>show_words(_setup_wizard_mydlink_info_12);</script></p>
								<p class="centered"><script>show_words(_please_wait);</script></p>
							</div>
						</div>					
					</form>
					<form id="form2" name="form2" method="post" action="apply_sec.cgi">
						<input type="hidden" id="action" name="action" value="setup_wizard_cancel">
						<input type="hidden" id="setup_mydlink_cancel" name="setup_mydlink_cancel" value="1">
						<input type="hidden" id="html_response_page" name="html_response_page" value="login_pic.asp">
						<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="login_pic.asp">
					</form>
					<form id="form3" name="form3" method="post" action="apply.cgi">
						<input type="hidden" id="action" name="action" value="setup_wizard_mydlink_btn_signup">
						<input type="hidden" id="html_response_page" name="html_response_page" value="">
						<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="http://mydlink.com">
						<input type="hidden" id="account_name" name="account_name" >
						<input type="hidden" id="account_password" name="account_password" >
						<input type="hidden" id="first_name" name="first_name" >
						<input type="hidden" id="last_name" name="last_name" >			
					</form>

					<form id="form4" name="form4" method="post" action="apply.cgi">
						<input type="hidden" id="action" name="action" value="setup_wizard_mydlink_signin">
						<input type="hidden" id="html_response_page" name="html_response_page" value="">
						<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="http://mydlink.com">
						<input type="hidden" id="account_name2" name="account_name2" >
						<input type="hidden" id="account_password2" name="account_password2" >		
					</form>
					
						<div id="mydlink_btn" name="mydlink_btn" style="display:none">
							<table align="center" class="formarea">
								<tr>
									<td>
										<input type="button" class="button_submit" id="btn_skip" name="btn_skip" onclick="wz_cancel();">
										<input type="button" class="button_submit" id="btn_prev" name="btn_prev" onclick="go_back();" style="display:none">
										<input type="button" class="button_submit" id="btn_next" name="btn_next" onclick="next();">
										<input type="button" class="button_submit" id="btn_signup" name="btn_signup" onclick="fn_signup();" style="display:none">
										<input type="button" class="button_submit" id="btn_signin" name="btn_signin" onclick="fn_signin();" style="display:none">								
										<script>
											get_by_id("btn_skip").value = _skip;
											get_by_id("btn_prev").value = _prev;
											get_by_id("btn_next").value = _next;
											get_by_id("btn_signup").value = _signup;
											get_by_id("btn_signin").value = LS316;
										</script>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div></td>
			</tr>
		</table><p>&nbsp;</p></td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF">
		<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
			<tr>
				<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
				<td width="10">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
	</tr>
</table>
<div id="copyright" align="center"><script>show_words(_copyright);</script></div>
</body>
<script>
	onPageLoad();
</script>
</html>
