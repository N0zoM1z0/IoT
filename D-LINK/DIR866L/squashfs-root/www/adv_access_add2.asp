<html>
<head>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | Advanced / Access control</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<link rel="STYLESHEET" type="text/css" href="/css_router.css">
<script type="text/javascript" src="/lang_<!--# echo language -->.js"></script>
<script type="text/javascript" src="/lang.js"></script>
<script language="JavaScript" src="public.js"></script>

<script language="JavaScript">
	function onPageLoad(){
		if(get_by_id("asp_temp_14").value != "-1"){
			get_by_id("schedule").value = get_by_id("asp_temp_01").value;
			
		  	//2009/4/20 Tina modify:Fixed schedule can't selected.

			for (var i = 0; i < 13; i++){
				var temp_acc;
			
				if (i > 9){
					temp_acc = (get_by_id("access_control_" + i).value).split("/");
				}else{
					temp_acc = (get_by_id("access_control_0" + i).value).split("/");				
				}
				if (temp_acc.length > 1){
			    	if((temp_acc[5] == "Always") || (temp_acc[5] == "Never") || (temp_acc[5] == "")){
   						set_selectIndex(temp_acc[5], get_by_id("schedule"));
   					}else{
				  		var temp_index = get_schedule_index(temp_acc[5]);
		   		    	get_by_id("schedule").selectedIndex=temp_index+2;
     				}
	   			}					
			}

		}			
	
	}

	function show_save_button(){
		get_by_id("save").disabled = !(get_by_id("asp_temp_14").value != "-1");
	}
	
	function click_schedule(){
		var schedule = get_by_id("schedule");
		if(schedule.value == "-1"){
			if (confirm(aa_sched_conf_1)){
				window.location.href = "tools_schedules.asp";
			}
			get_by_id("next").disabled = true;
			get_by_id("save").disabled = true;
		}else if(schedule.selectedIndex < 2){
			get_by_id("detail").value = schedule.value;
			if (schedule.value == "Always"){
				get_by_id("detail").value = _always;
			}else if (schedule.value == "Never"){
				get_by_id("detail").value = _never;
			}
			get_by_id("next").disabled = false;
			show_save_button();
		}else if(schedule.selectedIndex > 1){
			var idx = parseInt(schedule.selectedIndex) - 2;
			get_by_id("detail").value = show_schedule_detail(idx);
			get_by_id("next").disabled = false;
			show_save_button();
		}
	}

	function save_info(){
		if(get_by_id("asp_temp_00").value == ""){
			alert(TEXT034);
			return false;
		}
		
		//2009/4/20 Tina modify:Fixed can't save space char.
		var tmp_schedule_index = get_by_id("schedule").selectedIndex;
		var schedule;
		if (tmp_schedule_index > 1){
			schedule = get_by_id("schedule_rule_" + (tmp_schedule_index-2)).value;
		}else if (tmp_schedule_index == 0){
			schedule = _always;
		}else if (tmp_schedule_index == 1){
			schedule = _never;
		}
		get_by_id("asp_temp_01").value = schedule;
		//get_by_id("asp_temp_01").value = get_by_id("schedule").value;
	}

	function send_previous(){
		save_info();
		get_by_id("html_response_page").value = "adv_access_add1.asp";
		get_by_id("html_response_return_page").value = "adv_access_add1.asp";
		send_submit("form1");
	}
			
	function send_next(){
		save_info();
		send_submit("form1");
	}

	function send_request(){
		save_info();
		get_by_id("html_response_page").value = "adv_access_save.asp";
		get_by_id("html_response_return_page").value = "adv_access_save.asp";
		send_submit("form1");
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(TA2)</script>: <a href="http://support.dlink.com.tw/"><!--# echo model_number --></a></td>
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
			<td height="29"><img src="/short_modnum.gif" width="125" height="25"></td>
<script>show_top("adv");</script>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table cellSpacing=0 cellPadding=0 border=0>
                  <tbody>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
                            <script>show_left("Advance", 5);</script>
                          </UL>
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

			<input type="hidden" id="access_control_00" name="access_control_00" value="<!--# echo access_control_00 -->">
			<input type="hidden" id="access_control_01" name="access_control_01" value="<!--# echo access_control_01 -->">
			<input type="hidden" id="access_control_02" name="access_control_02" value="<!--# echo access_control_02 -->">
			<input type="hidden" id="access_control_03" name="access_control_03" value="<!--# echo access_control_03 -->">
			<input type="hidden" id="access_control_04" name="access_control_04" value="<!--# echo access_control_04 -->">
			<input type="hidden" id="access_control_05" name="access_control_05" value="<!--# echo access_control_05 -->">
			<input type="hidden" id="access_control_06" name="access_control_06" value="<!--# echo access_control_06 -->">
			<input type="hidden" id="access_control_07" name="access_control_07" value="<!--# echo access_control_07 -->">
			<input type="hidden" id="access_control_08" name="access_control_08" value="<!--# echo access_control_08 -->">
			<input type="hidden" id="access_control_09" name="access_control_09" value="<!--# echo access_control_09 -->">
			<input type="hidden" id="access_control_10" name="access_control_10" value="<!--# echo access_control_10 -->">
			<input type="hidden" id="access_control_11" name="access_control_11" value="<!--# echo access_control_11 -->">
			<input type="hidden" id="access_control_12" name="access_control_12" value="<!--# echo access_control_12 -->">
			<input type="hidden" id="access_control_13" name="access_control_13" value="<!--# echo access_control_13 -->">
			<input type="hidden" id="access_control_14" name="access_control_14" value="<!--# echo access_control_14 -->">
			<input type="hidden" id="access_control_15" name="access_control_15" value="<!--# echo access_control_15 -->">
			<input type="hidden" id="access_control_16" name="access_control_16" value="<!--# echo access_control_16 -->">
			<input type="hidden" id="access_control_17" name="access_control_17" value="<!--# echo access_control_17 -->">
			<input type="hidden" id="access_control_18" name="access_control_18" value="<!--# echo access_control_18 -->">
			<input type="hidden" id="access_control_19" name="access_control_19" value="<!--# echo access_control_19 -->">
			<input type="hidden" id="access_control_20" name="access_control_20" value="<!--# echo access_control_20 -->">
			<input type="hidden" id="access_control_21" name="access_control_21" value="<!--# echo access_control_21 -->">
			<input type="hidden" id="access_control_22" name="access_control_22" value="<!--# echo access_control_22 -->">
			<input type="hidden" id="access_control_23" name="access_control_23" value="<!--# echo access_control_23 -->">
			<input type="hidden" id="access_control_24" name="access_control_24" value="<!--# echo access_control_24 -->">

			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="adv_access_add3.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_add3.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="action" name="action" value="response_page">

			<input type="hidden" id="asp_temp_00" name="asp_temp_00" value="<!--# echo asp_temp_00 -->">	<!-- Policy Name -->
			<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="<!--# echo asp_temp_01 -->">	<!-- schedule -->
			<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="<!--# echo asp_temp_02 -->">	<!-- Machine -->
			<input type="hidden" id="asp_temp_03" name="asp_temp_03" value="<!--# echo asp_temp_03 -->">	<!-- filter method -->
			<input type="hidden" id="asp_temp_04" name="asp_temp_04" value="<!--# echo asp_temp_04 -->">	<!-- firewall rule 1 -->
			<input type="hidden" id="asp_temp_05" name="asp_temp_05" value="<!--# echo asp_temp_05 -->">	<!-- firewall rule 2 -->
			<input type="hidden" id="asp_temp_06" name="asp_temp_06" value="<!--# echo asp_temp_06 -->">	<!-- firewall rule 3 -->
			<input type="hidden" id="asp_temp_07" name="asp_temp_07" value="<!--# echo asp_temp_07 -->">	<!-- firewall rule 4 -->
			<input type="hidden" id="asp_temp_08" name="asp_temp_08" value="<!--# echo asp_temp_08 -->">	<!-- firewall rule 5 -->
			<input type="hidden" id="asp_temp_09" name="asp_temp_09" value="<!--# echo asp_temp_09 -->">	<!-- firewall rule 6 -->
			<input type="hidden" id="asp_temp_10" name="asp_temp_10" value="<!--# echo asp_temp_10 -->">	<!-- firewall rule 7 -->
			<input type="hidden" id="asp_temp_11" name="asp_temp_11" value="<!--# echo asp_temp_11 -->">	<!-- firewall rule 8 -->
			<input type="hidden" id="asp_temp_12" name="asp_temp_12" value="<!--# echo asp_temp_12 -->">	<!-- logging -->
			<input type="hidden" id="asp_temp_13" name="asp_temp_13" value="<!--# echo asp_temp_13 -->">	<!-- Policy Name list -->
			<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="<!--# echo asp_temp_14 -->">	<!-- edit_row -->
			<input type="hidden" id="asp_temp_15" name="asp_temp_15" value="<!--# echo asp_temp_15 -->">	<!-- prev_page -->
			<input type="hidden" id="asp_temp_16" name="asp_temp_16" value="<!--# echo asp_temp_16 -->">	<!-- max_row -->
			
			<td valign="top" id="maincontent_container">
			<div id=maincontent>
            <div class=box>
			 <h2><script>show_words(_aa_wiz_s3_title);</script></h2>
		 	 <P class="box_msg"><script>show_words(_aa_wiz_s3_msg);</script></P>
				<table width="525" class=formarea>
				  <tbody>
					  <tr>
					  	<td class="duple">&nbsp;</td>
						<td width="485">&nbsp;
						<select width="30" id="schedule" name="schedule" onChange="click_schedule();">
							<option value="Always" selected><script>show_words(_always);</script></option>
							<option value="Never"><script>show_words(_never);</script></option>
							<script>
							document.write(set_schedule_option());
							</script>
							<option value="-1"><script>show_words(aa_sched_new);</script></option>
						</select>
						</td>
					  </tr>
					  <tr>
					  	<td class="duple"><script>show_words(_aa_details);</script> :</td>
						<td width="485">&nbsp;&nbsp;<input type="text" id="detail" name="detail" disabled size="48" maxlength="48"></td>
					  </tr>
				  </tbody>
				</table><hr>
				<table width="362" align="center">
				  <td> <div align="center"> 
						<input name="prev" type="button" id="prev" value="" onClick="return send_previous();">
								<script>get_by_id("prev").value= _prev;</script>
						&nbsp; 
						<input name="next" type="button" id="next" value="" onClick="return send_next();">
								<script>get_by_id("next").value= _next;</script>
						&nbsp;
						<input name="save" type="button" id="save" value="Save" onClick="return send_request();">                  
								<script>get_by_id("save").value= _save;</script>
						&nbsp; 
						<input name="cancel" type="button" id="cancel" value="Cancel" onClick="exit_access()">
								<script>get_by_id("cancel").value= _cancel;</script>
					</div>
				  </td>
				</table>
            </div>
			</div>
	  		</td>
	  		</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
                      <td id=help_text><b><script>show_words(_hints);</script>&hellip;</b>
                          <p><script>show_words(hhac_en);</script></p>
						  <p><script>show_words(hhac_add);</script></p>
						  <p><script>show_words(hhac_edit);</script></p>
						  <p><script>show_words(hhac_delete);</script></p>
						  <p><a href="support_adv.asp#Access_Control" onclick="return jump_if()"><script>show_words(_more);</script>&hellip;</a></p>
                      </td>
                    </tr>
                </table>
			</td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="/wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright"><script>show_words(_copyright);</script></div>
<br>
</body>
<script>
	onPageLoad();
	show_save_button();
	click_schedule();
</script>
</html>
