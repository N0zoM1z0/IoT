<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
.style5 {font-size: 11px}
-->
</style>
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>

<script language="JavaScript">	
	function onPageLoad(){
		
		//email notification
		set_checked(get_by_id("log_email_enable").value, get_by_id("email_enable"));
		set_checked(get_by_id("log_email_auth").value, get_by_id("email_auth"));
		
		//mail_schedule
		var mail_schedule = get_by_id("log_email_schedule").value.split("/");
		//on log full check
		set_checked(mail_schedule[0], get_by_id("email_sch_enable"));
		//on schedule check
		set_checked(mail_schedule[1], get_by_id("by_email_sch"));
		set_selectIndex(mail_schedule[3], get_by_id("email_schedule"));
		//key_word(get_by_id("email_schedule"), "email_detail");
		click_schedule();
		get_by_id("email_detail").readOnly = true;
		disable_schedule()
		disable_notifcation();

/*
		var login_who= checksessionStorage();
                if(login_who== "user"){
                        DisableEnableForm(document.form1,true); 
                }else{
                        disable_schedule()
                        disable_notifcation();
                }
*/		var login_who= checksessionStorage();
        if(login_who== "user"){
                DisableEnableForm(document.form1, true);
        }
	}
	function click_schedule(){
		var schedule = get_by_id("email_schedule");
		if(schedule.selectedIndex < 1){
			//get_by_id("email_detail").value = schedule.value;
			get_by_id("email_detail").value = _never;
		}else if(schedule.selectedIndex > 0){
			var idx = parseInt(schedule.selectedIndex) - 1;
			get_by_id("email_detail").value = show_schedule_detail(idx);
		}
	}
	function check_mail(){
		var tmp_smtp_port = get_by_id("log_email_server_port").value;
		var smtp_port_msg = replace_msg(check_num_msg, te_SMTPSv_Port, 1, 65535);
		var smtp_port_obj = new varible_obj(tmp_smtp_port, smtp_port_msg, 1, 65535, false);
		var email_sender =  get_by_id("log_email_sender").value;
		var email_recipien = get_by_id("log_email_recipien").value;
		var pattern = /^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/;

		if(email_sender == ""){
			alert(_blankfromemailaddr);
			return false;
		}else if (email_sender.search(pattern) == -1){
			alert(_badfromemailaddr.replace("+ from_addr +", email_sender));
			return false;
		}else if(email_recipien == ""){
			alert(_blanktomemailaddr);
			return false;
		}else if(email_recipien.search(pattern) == -1){
			alert(_badtoemailaddr.replace("+ to_addr +", email_recipien));
			return false;
		}else if (get_by_id("log_email_server").value == ""){
			alert(_blanksmtpmailaddr);
			return false;
		}else if (!check_varible(smtp_port_obj)){
			return false;
		}else if (get_by_id("log_email_password").value != get_by_id("email_pw2").value){
			alert(YM102);
			return false;
		}
        
		if(get_by_id("email_auth").checked){
	 		if(get_by_id("log_email_username").value == ""){
				alert(te_Acct+" "+adv_ug_checkug_msg2);
				return false;
		 	}else if(get_by_id("log_email_password").value == ""){
				alert(_password+" "+adv_ug_checkug_msg2);
				return false;
			}else if(get_by_id("email_pw2").value == ""){
				alert(_verifypw+" "+adv_ug_checkug_msg2);
				return false;
			}
		}	

		return true;
	}
	
	function get_detail(){
	  	key_word(get_by_id("email_schedule"), "email_detail");
	}
	
	function disable_emai_auth(){
		if(get_by_id("email_enable").checked){
	  	get_by_id("log_email_username").disabled = !get_by_id("email_auth").checked;
	  	get_by_id("log_email_password").disabled = !get_by_id("email_auth").checked;
	  	get_by_id("email_pw2").disabled = !get_by_id("email_auth").checked;
		}		
	}		
	
	function disable_notifcation(){
	  	get_by_id("log_email_sender").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("log_email_recipien").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("log_email_server").disabled = !get_by_id("email_enable").checked;
		get_by_id("log_email_server_port").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("email_auth").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("log_email_username").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("log_email_password").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("email_pw2").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("email_sch_enable").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("by_email_sch").disabled = !get_by_id("email_enable").checked;
	  	if(!get_by_id("email_enable").checked){
	  		get_by_id("email_schedule").disabled = !get_by_id("email_enable").checked;
	  		get_by_id("email_detail").disabled = !get_by_id("email_enable").checked;
	  	}	
	  	else{
	  		get_by_id("email_schedule").disabled = !get_by_id("by_email_sch").checked;
	  		get_by_id("email_detail").disabled = !get_by_id("by_email_sch").checked;
	  	}		  	
		disable_emai_auth();
	}	

	function disable_schedule(){
	  	get_by_id("email_schedule").disabled = !get_by_id("by_email_sch").checked;
	  	get_by_id("email_detail").disabled = !get_by_id("by_email_sch").checked;
	}		

	function check_date(){
		var is_change = false;
		if(!is_change){
			if(get_by_id("log_email_enable").value != get_checked_value(get_by_id("email_enable"))){
				is_change = true;
			}else if(get_by_id("log_email_sender").value != "<!--# echo log_email_sender -->"){
				is_change = true;
			}else if(get_by_id("log_email_recipien").value != "<!--# echo log_email_recipien -->"){
				is_change = true;
			}else if(get_by_id("log_email_server").value != "<!--# echo log_email_server -->"){
				is_change = true;
			}else if(get_by_id("log_email_auth").value != get_checked_value(get_by_id("email_auth"))){
				is_change = true;
			}else if(get_by_id("log_email_username").value != "<!--# echo log_email_username -->"){
				is_change = true;
			}else if(get_by_id("log_email_password").value != "<!--# echo log_email_password -->"){
				is_change = true;
			}else if(get_by_id("log_email_schedule").value != (get_checked_value(get_by_id("email_sch_enable")) +"/"+get_checked_value(get_by_id("by_email_sch"))+"/"+ get_by_id("email_schedule").value)){
				is_change = true;
			}
		}
		if(is_change){
			if (!confirm(up_jt_1+"\n"+up_jt_2+"\n"+up_jt_3)){
				return;
			}
		}
		location.href="tools_schedules.asp";
	}
	
	function send_request(){
		if (!is_form_modified("form1") && !confirm(_ask_nochange)) {
			return false;
		}

		if(get_by_id("email_enable").checked){
			if(!check_mail()){
				return false;
			}
		}		
		get_by_id("log_email_enable").value = get_checked_value(get_by_id("email_enable"));
		get_by_id("log_email_auth").value = get_checked_value(get_by_id("email_auth"));
		//save mail_schedule
		get_by_id("log_email_schedule").value = get_checked_value(get_by_id("email_sch_enable")) +"/"+get_checked_value(get_by_id("by_email_sch"))+"/0/"+ get_by_id("email_schedule").value;
		get_by_id("form1").submit();
	}
</script>	
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();"><!--# echo model_number --></a></td>
        <td align="right" nowrap><script>show_words(TA3)</script>: <!--# echo sys_hw_version --> &nbsp;</td>
				<td align="right" nowrap><script>show_words(sd_FWV)</script>: <!--# echo sys_fw_version --><!--# echox sys_region NA --></td>
				<td>&nbsp;</td>
      </tr>
  </table>
	<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td align="center" valign="middle"><img src="/wlan_masthead.gif" width="836" height="92"></td>
		</tr>
</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td><img src="/short_modnum.gif" width="125" height="25"></td>
			<script>show_top("tools");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
                  <tbody>
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<script>show_left("tools", 3);</script>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
                  </tbody>
				</table>			
			</td>
			
			<input type="hidden" id="schedule_rule_0" name="schedule_rule_0" value="<!--# echo schedule_rule_00 -->">
			<input type="hidden" id="schedule_rule_1" name="schedule_rule_1" value="<!--# echo schedule_rule_01 -->">
			<input type="hidden" id="schedule_rule_2" name="schedule_rule_2" value="<!--# echo schedule_rule_02 -->">
			<input type="hidden" id="schedule_rule_3" name="schedule_rule_3" value="<!--# echo schedule_rule_03 -->">
			<input type="hidden" id="schedule_rule_4" name="schedule_rule_4" value="<!--# echo schedule_rule_04 -->">
			<input type="hidden" id="schedule_rule_5" name="schedule_rule_5" value="<!--# echo schedule_rule_05 -->">
			<input type="hidden" id="schedule_rule_6" name="schedule_rule_6" value="<!--# echo schedule_rule_06 -->">
			<input type="hidden" id="schedule_rule_7" name="schedule_rule_7" value="<!--# echo schedule_rule_07 -->">
			<input type="hidden" id="schedule_rule_8" name="schedule_rule_8" value="<!--# echo schedule_rule_08 -->">
			<input type="hidden" id="schedule_rule_9" name="schedule_rule_9" value="<!--# echo schedule_rule_09 -->">
			<input type="hidden" id="schedule_rule_10" name="schedule_rule_10" value="<!--# echo schedule_rule_10 -->">
			<input type="hidden" id="schedule_rule_11" name="schedule_rule_11" value="<!--# echo schedule_rule_11 -->">
			<input type="hidden" id="schedule_rule_12" name="schedule_rule_12" value="<!--# echo schedule_rule_12 -->">
			<input type="hidden" id="schedule_rule_13" name="schedule_rule_13" value="<!--# echo schedule_rule_13 -->">
			<input type="hidden" id="schedule_rule_14" name="schedule_rule_14" value="<!--# echo schedule_rule_14 -->">
			<input type="hidden" id="schedule_rule_15" name="schedule_rule_15" value="<!--# echo schedule_rule_15 -->">
			<input type="hidden" id="schedule_rule_16" name="schedule_rule_16" value="<!--# echo schedule_rule_16 -->">
			<input type="hidden" id="schedule_rule_17" name="schedule_rule_17" value="<!--# echo schedule_rule_17 -->">
			<input type="hidden" id="schedule_rule_18" name="schedule_rule_18" value="<!--# echo schedule_rule_18 -->">
			<input type="hidden" id="schedule_rule_19" name="schedule_rule_19" value="<!--# echo schedule_rule_19 -->">
			<input type="hidden" id="schedule_rule_20" name="schedule_rule_20" value="<!--# echo schedule_rule_20 -->">
			<input type="hidden" id="schedule_rule_21" name="schedule_rule_21" value="<!--# echo schedule_rule_21 -->">
			<input type="hidden" id="schedule_rule_22" name="schedule_rule_22" value="<!--# echo schedule_rule_22 -->">
			<input type="hidden" id="schedule_rule_23" name="schedule_rule_23" value="<!--# echo schedule_rule_23 -->">
			<input type="hidden" id="schedule_rule_24" name="schedule_rule_24" value="<!--# echo schedule_rule_24 -->">
			<input type="hidden" id="schedule_rule_25" name="schedule_rule_25" value="<!--# echo schedule_rule_25 -->">
			<input type="hidden" id="schedule_rule_26" name="schedule_rule_26" value="<!--# echo schedule_rule_26 -->">
			<input type="hidden" id="schedule_rule_27" name="schedule_rule_27" value="<!--# echo schedule_rule_27 -->">
			<input type="hidden" id="schedule_rule_28" name="schedule_rule_28" value="<!--# echo schedule_rule_28 -->">
			<input type="hidden" id="schedule_rule_29" name="schedule_rule_29" value="<!--# echo schedule_rule_29 -->">
			<input type="hidden" id="schedule_rule_30" name="schedule_rule_30" value="<!--# echo schedule_rule_30 -->">
			<input type="hidden" id="schedule_rule_31" name="schedule_rule_31" value="<!--# echo schedule_rule_31 -->">
			
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="count_down.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value=""><script>get_by_id("html_response_message").value = sc_intro_sv;</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_email.asp">
			
			<input type="hidden" id="log_email_schedule" name="log_email_schedule" value="<!--# echo log_email_schedule -->">
			<input type="hidden" id="log_email_enable" name="log_email_enable" value="<!--# echo log_email_enable -->">
			<input type="hidden" id="action" name="action" value="st_log_setting">
			<td valign="top" id="maincontent_container">			  <div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				<div id="box_header"> 
						<h1><script>show_words(_email)</script></h1>
						<script>show_words(te_intro_Em)</script>
						<br><br>
						  <input id="button3" name="button3" type="button" class=button_submit value="" onClick="send_request()">
                          <input id="button2" name="button2" type=reset class=button_submit value="" onclick="return page_cancel('form1', 'tools_email.asp');">
						  <script>check_reboot();</script>
							<script>get_by_id("button3").value = _savesettings</script>
							<script>get_by_id("button2").value = _dontsavesettings</script>
				</div>
			  	<div class="box">
                    <h2><script>show_words(_enable)</script></h2>
            		<table cellSpacing=1 cellPadding=2 width=525 border=0>
                      <tr>
                        <td class="duple"><script>show_words(te_EnEmN)</script> :</td>
                        <td width="340">&nbsp;<input type="Checkbox" id="email_enable" name="email_enable" value="1" onClick="disable_notifcation();"></td>
                      </tr>
					</table>
				</div>
			  	<div class="box">
                    <h2><script>show_words(te_EmSt)</script></h2>
            		<table cellSpacing=1 cellPadding=2 width=525 border=0>
                      <tr>
                        <td class="duple"><script>show_words(te_FromEm)</script> :</td>
                        <td width="340">&nbsp;
	                        <input type=text id="log_email_sender" name="log_email_sender" size=30 maxlength=128 value="<!--# echo log_email_sender -->">
						</td>
                      </tr>
                      <tr>
                        <td class="duple"><script>show_words(te_ToEm)</script> :</td>
                        <td width="340">&nbsp;
	                        <input type=text id="log_email_recipien" name="log_email_recipien" size=30 maxlength=128 value="<!--# echo log_email_recipien -->">
						</td>
                      </tr>
                      <tr>
                        <td class="duple"><script>show_words(te_SMTPSv)</script> :</td>
                        <td width="340">&nbsp;
	                        <input type=text id="log_email_server" name="log_email_server" size=30 maxlength=99 value="<!--# echo log_email_server -->">
			</td>
                      </tr>
			<tr>
                        <td class="duple"><script>show_words(te_SMTPSv_Port)</script> :</td>
                        <td width="340">&nbsp;
                        <input type=text id="log_email_server_port" name="log_email_server_port" size=30 maxlength=99 value="<!--# echo log_email_server_port -->"></td>
                        </td>
                      </tr>

                      <tr>
                        <td class="duple"><script>show_words(te_EnAuth)</script> :</td>
                        <td width="340">&nbsp;<input type="Checkbox" id="email_auth" name="email_auth" value="1" onClick="disable_emai_auth();"></td>
                        <input type="hidden" id="log_email_auth" name="log_email_auth" value="<!--# echo log_email_auth -->">
                      </tr>
                      <tr>
                        <td class="duple"><script>show_words(te_Acct)</script> :</td>
                        <td width="340">&nbsp;
	                        <input type=text id="log_email_username" name="log_email_username" size=30 maxlength=128 value="<!--# echo log_email_username -->">
						</td>
                      </tr>
                      <tr>
                        <td class="duple"><script>show_words(_password)</script> :</td>
                        <td width="340">&nbsp;
	                        <input type=password id="log_email_password" name="log_email_password" size=30 maxlength=128 value="<!--# echo log_email_password -->">
						</td>
                      </tr>
                      <tr>
                        <td class="duple"><script>show_words(_verifypw)</script> :</td>
                        <td width="340">&nbsp;
	                        <input type=password id="email_pw2" name="email_pw2" size=30 maxlength=128 value="<!--# echo log_email_password -->">
						</td>
                      </tr>
            		</table>
			  	</div>
			  	<div class="box">
                    <h2><script>show_words(te__title_EmLog)</script></h2>
            		<table cellSpacing=1 cellPadding=2 width=525 border=0>
                      <tr>
                        <td class="duple"><script>show_words(te_OnFull)</script> :</td>
                        <td width="340">&nbsp;<input type="Checkbox" id="email_sch_enable" name="email_sch_enable" value="1"></td>
                      </tr>

                      <tr>
                        <td class="duple"><script>show_words(te_OnSch)</script> :</td>
                        <td width="340">&nbsp;<input type="Checkbox" id="by_email_sch" name="by_email_sch" value="25" onClick="disable_schedule();"></td>
                      </tr>
				 
                      <tr>
                        <td class="duple"><script>show_words(_sched)</script></a> :</td>
                        <td width="340">&nbsp;
	                        <select id="email_schedule" name="email_schedule" onClick="click_schedule();">
	                        	<option value="Never"><script>show_words(_never);</script></option>
	                        	<script>
	                              	document.write(set_schedule_option());
	                            </script>
	                        </select>
						</td>
                      </tr>
                      <tr>
                        <td class="duple"><script>show_words(_aa_details);</script> :</td>
                        <td width="340">&nbsp;&nbsp;<input type="text" id="email_detail" name="email_detail" disabled size="48" maxlength="48"></td>
                      </tr>
					</table>
				</div>
			</div>
			</td>
		</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
                  <tr>
                    <td id="help_text"><strong><script>show_words(_hints);</script>&hellip;</strong>
                      <p><script>show_words(hhte_intro)</script></p>
					  <p><a href="support_tools.asp#EMail" onclick="return jump_if();"><script>show_words(_more)</script>&hellip;</a></p>
                    </td>
                  </tr>
                </table></td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
	reboot_needed(left["tools"].link[3]);
	onPageLoad();
	set_form_default_values("form1");
</script>
</html>
